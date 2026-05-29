import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../services/serverpod_client.dart';

class AuthProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool _isLoggedIn = false;
  bool _isGuest = false;

  String? _userName;
  String? _userEmail;

  // Backend token (JWT from your API)
  String? _appToken;

  bool _loading = false;
  String? _error;

  bool get isLoggedIn => _isLoggedIn;
  bool get isGuest => _isGuest;
  bool get isAuthenticated => _isLoggedIn || _isGuest;

  String? get userName => _userName;
  String? get userEmail => _userEmail;

  String? get appToken => _appToken;

  bool get loading => _loading;
  String? get error => _error;

  AuthProvider() {
    _auth.authStateChanges().listen((User? user) async {
      if (user != null) {
        _isLoggedIn = true;
        _isGuest = false;
        _userName = user.displayName ?? user.email?.split('@')[0];
        _userEmail = user.email;

        // Optional: auto-sync with backend when auth changes
        try {
          await _syncFirebaseToBackend(user);
        } catch (_) {
          // keep logged-in even if backend sync fails
        }
      } else {
        if (_isLoggedIn) {
          _isLoggedIn = false;
          _userName = null;
          _userEmail = null;
          _appToken = null;
        }
      }
      notifyListeners();
    });
  }

  // -------------------------
  // Firebase Sign Up -> Backend sync
  // -------------------------
  Future<void> signUp(String name, String email, String password) async {
    _setLoading(true);
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await userCredential.user?.updateDisplayName(name);
      await userCredential.user?.reload();

      final user = _auth.currentUser;
      if (user != null) {
        _isLoggedIn = true;
        _isGuest = false;
        _userName = name;
        _userEmail = email;

        await _syncFirebaseToBackend(user);
      }
    } on FirebaseAuthException catch (e) {
      _setError(e.message ?? 'Sign up failed');
      rethrow;
    } catch (e) {
      _setError('An error occurred: $e');
      rethrow;
    } finally {
      _setLoading(false);
    }
  }

  // -------------------------
  // Firebase Sign In -> Backend sync
  // -------------------------
  Future<void> signIn(String email, String password) async {
    _setLoading(true);
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = userCredential.user;
      if (user != null) {
        _isLoggedIn = true;
        _isGuest = false;
        _userName = user.displayName ?? email.split('@')[0];
        _userEmail = email;

        await _syncFirebaseToBackend(user);
      }
    } on FirebaseAuthException catch (e) {
      _setError(e.message ?? 'Sign in failed');
      rethrow;
    } catch (e) {
      _setError('An error occurred: $e');
      rethrow;
    } finally {
      _setLoading(false);
    }
  }

  // -------------------------
  // Google Sign In -> Backend sync
  // -------------------------
  Future<void> signInWithGoogle() async {
    _setLoading(true);
    try {
      UserCredential userCredential;

      if (kIsWeb) {
        final provider = GoogleAuthProvider();
        userCredential = await _auth.signInWithPopup(provider);
      } else {
        final googleSignIn = GoogleSignIn();
        final googleUser = await googleSignIn.signIn();
        if (googleUser == null) {
          _setLoading(false);
          return; // user cancelled
        }

        final googleAuth = await googleUser.authentication;
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        userCredential = await _auth.signInWithCredential(credential);
      }

      final user = userCredential.user;
      if (user != null) {
        _isLoggedIn = true;
        _isGuest = false;
        _userName = user.displayName ?? user.email?.split('@')[0];
        _userEmail = user.email;

        await _syncFirebaseToBackend(user);
      }
    } on FirebaseAuthException catch (e) {
      _setError(e.message ?? 'Google sign in failed');
      rethrow;
    } catch (e) {
      _setError('An error occurred: $e');
      rethrow;
    } finally {
      _setLoading(false);
    }
  }

  // -------------------------
  // Guest -> backend guest endpoint
  // -------------------------
  Future<void> continueAsGuest() async {
    _setLoading(true);
    try {
      _isGuest = true;
      _isLoggedIn = false;
      _userName = 'Guest';
      _userEmail = null;

      // Call backend guest endpoint using generated Serverpod client
      try {
        final result = await client.sign.guestLogin();
        _appToken = result.token;
        _applyBackendUser(result.user);
      } catch (e) {
        // if backend doesn't support guest token, it's fine
        _appToken = null;
      }
      notifyListeners();
    } finally {
      _setLoading(false);
    }
  }

  // -------------------------
  // Sign out (firebase + local)
  // -------------------------
  Future<void> signOut() async {
    await _auth.signOut();
    _isLoggedIn = false;
    _isGuest = false;
    _userName = null;
    _userEmail = null;
    _appToken = null;
    _error = null;
    notifyListeners();
  }

  // -------------------------
  // Sync Firebase user -> Backend
  // Uses generated Serverpod client
  // -------------------------
  Future<void> _syncFirebaseToBackend(User user) async {
    final idToken = await user.getIdToken();
    if (idToken == null) {
      throw Exception('Unable to retrieve Firebase ID token');
    }

    // Call backend using generated Serverpod client
    final result = await client.sign.firebaseLogin(
      idToken,
      user.uid,
      user.displayName,
      user.email,
    );

    _appToken = result.token;

    // optional: overwrite name/email from backend user if meaningful
    _applyBackendUser(result.user);

    notifyListeners();
  }

  void _setLoading(bool v) {
    _loading = v;
    notifyListeners();
  }

  void _setError(String? msg) {
    _error = msg;
    notifyListeners();
  }

  void _applyBackendUser(dynamic backendUser) {
    if (backendUser == null) return;
    final name = backendUser.name as String?;
    final email = backendUser.email as String?;

    if (_isMeaningfulName(name)) {
      _userName = name;
    }

    if (_isMeaningfulEmail(email)) {
      _userEmail = email;
    }
  }

  bool _isMeaningfulName(String? name) {
    if (name == null) return false;
    final normalized = name.trim().toLowerCase();
    if (normalized.isEmpty) return false;
    return normalized != 'firebase user' && normalized != 'guest';
  }

  bool _isMeaningfulEmail(String? email) {
    if (email == null) return false;
    final normalized = email.trim().toLowerCase();
    if (normalized.isEmpty) return false;
    return normalized != 'guest@tuneflow.local';
  }
}
