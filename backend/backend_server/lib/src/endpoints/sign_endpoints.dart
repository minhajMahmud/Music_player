class ApiEndpoints {
  // =========================
  // BASE CONFIG
  // =========================
  static const String baseUrl = 'http://10.0.2.2:3000/api';
  // For real device use your LAN IP, e.g. http://192.168.1.5:3000/api

  // =========================
  // AUTH ENDPOINTS
  // =========================
  static const String signUp = '$baseUrl/auth/signup';
  static const String signIn = '$baseUrl/auth/signin';

  // Firebase → Backend sync
  static const String firebaseAuth = '$baseUrl/auth/firebase';

  // Guest login
  static const String guest = '$baseUrl/auth/guest';

  // =========================
  // USER
  // =========================
  static const String me = '$baseUrl/users/me';

  // =========================
  // MUSIC (future use)
  // =========================
  static const String artists = '$baseUrl/artists';
  static const String albums = '$baseUrl/albums';
  static const String songs = '$baseUrl/songs';
  static const String playlists = '$baseUrl/playlists';
}
