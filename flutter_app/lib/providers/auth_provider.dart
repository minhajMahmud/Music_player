import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool _isLoggedIn = false;
  bool _isGuest = false;
  String? _userName;
  String? _userEmail;

  bool get isLoggedIn => _isLoggedIn;
  bool get isGuest => _isGuest;
  String? get userName => _userName;
  String? get userEmail => _userEmail;
  bool get isAuthenticated => _isLoggedIn || _isGuest;

  AuthProvider() {
    // Listen to Firebase auth state changes
    _auth.authStateChanges().listen((User? user) {
      if (user != null) {
        _isLoggedIn = true;
        _isGuest = false;
        _userName = user.displayName ?? user.email?.split('@')[0];
        _userEmail = user.email;
      } else {
        // If logged out from Firebase, we are effectively logged out here too
        // unless we are in guest mode which is a local state.
        // However, standard flow is: logout = fully out.
        if (_isLoggedIn) {
          _isLoggedIn = false;
          _userName = null;
          _userEmail = null;
        }
      }
      notifyListeners();
    });
  }

  // Sign up with credentials
  Future<void> signUp(String name, String email, String password) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Update display name
      await userCredential.user?.updateDisplayName(name);
      await userCredential.user?.reload();

      // Update local state explicitly to ensure UI updates immediately
      // The listener will also trigger, but this ensures name is available
      _isLoggedIn = true;
      _isGuest = false;
      _userName = name;
      _userEmail = email;
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      throw e.message ?? 'An error occurred during sign up';
    } catch (e) {
      throw 'An error occurred: $e';
    }
  }

  // Sign in with credentials
  Future<void> signIn(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      _isLoggedIn = true;
      _isGuest = false;
      _userName = userCredential.user?.displayName ?? email.split('@')[0];
      _userEmail = email;
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      throw e.message ?? 'An error occurred during sign in';
    } catch (e) {
      throw 'An error occurred: $e';
    }
  }

  // Continue as guest
  void continueAsGuest() {
    _isGuest = true;
    _isLoggedIn = false;
    _userName = 'Guest';
    _userEmail = null;
    notifyListeners();
  }

  // Sign out
  Future<void> signOut() async {
    await _auth.signOut();
    _isLoggedIn = false;
    _isGuest = false;
    _userName = null;
    _userEmail = null;
    notifyListeners();
  }
}
