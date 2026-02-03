import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/music_data.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Collection References
  CollectionReference get _songsCollection => _db.collection('songs');
  CollectionReference get _playlistsCollection => _db.collection('playlists');
  CollectionReference get _usersCollection => _db.collection('users');

  // --- Seed Data ---
  Future<void> seedDatabase() async {
    // 1. Upload Songs
    // We use the ID from the local data as the document ID to avoid duplicates if run multiple times
    for (var song in sampleSongs) {
      await _songsCollection.doc(song.id).set(song.toMap());
    }

    // 2. Upload Playlists
    // Note: We are embedding songs in the playlist document for simplicity based on the current model
    for (var playlist in featuredPlaylists) {
      await _playlistsCollection.doc(playlist.id).set(playlist.toMap());
    }

    for (var playlist in madeForYou) {
      await _playlistsCollection.doc(playlist.id).set(playlist.toMap());
    }
  }

  // --- Read Data ---

  Stream<List<Song>> getSongs() {
    return _songsCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Song.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
    });
  }

  Stream<List<Playlist>> getPlaylists() {
    return _playlistsCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Playlist.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
    });
  }

  // Create User Profile in Firestore
  Future<void> createUserProfile(
      String uid, String email, String username) async {
    await _usersCollection.doc(uid).set({
      'email': email,
      'username': username,
      'createdAt': FieldValue.serverTimestamp(),
      'favorites': [], // List of Song IDs
    });
  }

  // Get User Profile
  Future<Map<String, dynamic>?> getUserProfile(String uid) async {
    DocumentSnapshot doc = await _usersCollection.doc(uid).get();
    if (doc.exists) {
      return doc.data() as Map<String, dynamic>;
    }
    return null;
  }
}
