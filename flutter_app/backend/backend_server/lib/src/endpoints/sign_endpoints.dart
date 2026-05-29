import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';

/// Authentication endpoint for custom sign-in methods (Firebase, Guest)
class SignEndpoint extends Endpoint {
  /// Authenticate with Firebase ID token
  ///
  /// Takes a Firebase ID token and basic profile data (uid, name, email).
  /// In production you'd verify the ID token with Firebase Admin SDK.
  /// Creates or updates the user in the database and returns a JWT token.
  Future<AuthResponse> firebaseLogin(
    Session session,
    String idToken,
    String firebaseUid,
    String? name,
    String? email,
  ) async {
    try {
      // TODO: In production, verify the Firebase ID token using firebase_admin
      // For now, we'll assume the token is valid and extract mock data
      //
      // final firebaseAuth = FirebaseAuth.instance;
      // final decodedToken = await firebaseAuth.verifyIdToken(idToken);
      // final firebaseUid = decodedToken['uid'];
      // final email = decodedToken['email'];
      // final name = decodedToken['name'] ?? email?.split('@')[0];

      // Mock implementation - replace with actual Firebase token verification
      session.log(
        'Firebase login attempt with token: ${idToken.substring(0, 20)}...',
      );

      final resolvedEmail = (email?.trim().isNotEmpty ?? false)
          ? email!.trim()
          : 'firebase-user@example.com';
      final resolvedName = (name?.trim().isNotEmpty ?? false)
          ? name!.trim()
          : (resolvedEmail.split('@').first);

      // Check if user already exists
      var existingUser = await AppUser.db.findFirstRow(
        session,
        where: (t) => t.firebaseId.equals(firebaseUid),
      );

      AppUser user;
      if (existingUser == null) {
        // Create new user
        user = AppUser(
          firebaseId: firebaseUid,
          name: resolvedName,
          email: resolvedEmail,
          role: 'user',
          active: true,
          joinedAt: DateTime.now(),
        );
        await AppUser.db.insertRow(session, user);
      } else {
        final needsUpdate =
            existingUser.name != resolvedName ||
            existingUser.email != resolvedEmail;
        if (needsUpdate) {
          user = existingUser.copyWith(
            name: resolvedName,
            email: resolvedEmail,
          );
          user = await AppUser.db.updateRow(session, user);
        } else {
          user = existingUser;
        }
      }

      // Generate JWT token using Serverpod's auth system
      // Note: You may need to integrate with Serverpod's auth more deeply
      final token = await _generateJwtToken(session, user);

      return AuthResponse(
        token: token,
        user: user,
      );
    } catch (e) {
      session.log('Firebase login error: $e', level: LogLevel.error);
      throw Exception('Firebase authentication failed: $e');
    }
  }

  /// Continue as guest without authentication
  ///
  /// Creates a temporary guest session and returns a token
  Future<AuthResponse> guestLogin(Session session) async {
    try {
      final guestId = 'guest_${DateTime.now().millisecondsSinceEpoch}';

      // Create a guest user record (optional - you might want to skip database for guests)
      final guestUser = AppUser(
        firebaseId: guestId,
        name: 'Guest',
        email: 'guest@tuneflow.local',
        role: 'guest',
        active: true,
        joinedAt: DateTime.now(),
      );

      // Optionally save guest to database or just generate token
      // await AppUser.db.insertRow(session, guestUser);

      final token = await _generateJwtToken(session, guestUser, isGuest: true);

      return AuthResponse(
        token: token,
        user: guestUser,
      );
    } catch (e) {
      session.log('Guest login error: $e', level: LogLevel.error);
      throw Exception('Guest authentication failed: $e');
    }
  }

  /// Helper method to generate JWT token
  ///
  /// In production, integrate with Serverpod's auth token system
  Future<String> _generateJwtToken(
    Session session,
    AppUser user, {
    bool isGuest = false,
  }) async {
    // TODO: Use Serverpod's proper JWT generation
    // For now, return a mock token
    //
    // In production, you would use:
    // final authKey = await session.auth.signInUser(userId, 'firebase');
    // return authKey.key;

    final mockToken =
        'jwt_${user.firebaseId}_${DateTime.now().millisecondsSinceEpoch}';
    session.log('Generated token for user: ${user.name} (${user.email})');

    return mockToken;
  }
}
