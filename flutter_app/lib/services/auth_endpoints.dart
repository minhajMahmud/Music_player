/// Helper class providing authentication endpoint URLs for custom auth
/// These endpoints correspond to the SignEndpoint in the backend server
class SignInEndpoints {
  static const String _baseUrl = 'http://localhost:8080';

  /// Firebase authentication endpoint
  /// POST to sign.firebaseLogin with idToken parameter
  /// Returns: token and user object
  static String firebaseLogin() => '$_baseUrl/sign/firebaseLogin';

  /// Email/password signin endpoint (using Serverpod's built-in auth)
  /// Use the emailIdp endpoint instead
  static String emailLogin() => '$_baseUrl/emailIdp/login';

  /// Registration endpoint (using Serverpod's built-in auth)
  /// Use the emailIdp endpoint instead
  static String register() => '$_baseUrl/emailIdp/startRegistration';
}

/// Helper class for welcome/guest endpoints
class WelcomeEndpoints {
  static const String _baseUrl = 'http://localhost:8080';

  /// Guest authentication endpoint
  /// POST to sign.guestLogin
  /// Returns: token and user object
  static String guest() => '$_baseUrl/sign/guestLogin';
}
