import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  bool _isLoggedIn = false;
  bool _isGuest = false;
  String? _userName;
  String? _userEmail;

  bool get isLoggedIn => _isLoggedIn;
  bool get isGuest => _isGuest;
  String? get userName => _userName;
  String? get userEmail => _userEmail;
  bool get isAuthenticated => _isLoggedIn || _isGuest;

  // Sign up with credentials
  Future<void> signUp(String name, String email, String password) async {
    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));

    _isLoggedIn = true;
    _isGuest = false;
    _userName = name;
    _userEmail = email;
    notifyListeners();
  }

  // Sign in with credentials
  Future<void> signIn(String email, String password) async {
    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));

    _isLoggedIn = true;
    _isGuest = false;
    _userName = email.split('@')[0]; // Extract name from email
    _userEmail = email;
    notifyListeners();
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
  void signOut() {
    _isLoggedIn = false;
    _isGuest = false;
    _userName = null;
    _userEmail = null;
    notifyListeners();
  }
}
