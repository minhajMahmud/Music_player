
import 'dart:math';
import 'package:flutter/foundation.dart';

/// Simple in-memory store (no backend). You can later replace this with
/// Firebase/REST and keep the UI the same.
///
/// Features:
/// - CRUD for Songs, Artists, Albums, Users, Subscriptions
/// - Search across entities
/// - Basic analytics derived from the current data
class AdminStore extends ChangeNotifier {
  final _rnd = Random();

  // ===== Models =====
  // Keeping models in this file for simplicity.

  // Song
  final List<Song> _songs = [];
  // Artist
  final List<Artist> _artists = [];
  // Album
  final List<Album> _albums = [];
  // User
  final List<AppUser> _users = [];
  // Subscription
  final List<Subscription> _subs = [];

  AdminStore() {
    _seed();
  }

  // ===== Public getters (unmodifiable views) =====
  List<Song> get songs => List.unmodifiable(_songs);
  List<Artist> get artists => List.unmodifiable(_artists);
  List<Album> get albums => List.unmodifiable(_albums);
  List<AppUser> get users => List.unmodifiable(_users);
  List<Subscription> get subscriptions => List.unmodifiable(_subs);

  // ===== Search helpers =====
  List<Song> searchSongs(String q) {
    final query = q.trim().toLowerCase();
    if (query.isEmpty) return songs;
    return songs.where((s) =>
        s.title.toLowerCase().contains(query) ||
        s.artistName.toLowerCase().contains(query) ||
        s.albumTitle.toLowerCase().contains(query)).toList();
  }

  List<Artist> searchArtists(String q) {
    final query = q.trim().toLowerCase();
    if (query.isEmpty) return artists;
    return artists.where((a) =>
        a.name.toLowerCase().contains(query) ||
        a.genre.toLowerCase().contains(query)).toList();
  }

  List<Album> searchAlbums(String q) {
    final query = q.trim().toLowerCase();
    if (query.isEmpty) return albums;
    return albums.where((a) =>
        a.title.toLowerCase().contains(query) ||
        a.artistName.toLowerCase().contains(query)).toList();
  }

  List<AppUser> searchUsers(String q) {
    final query = q.trim().toLowerCase();
    if (query.isEmpty) return users;
    return users.where((u) =>
        u.name.toLowerCase().contains(query) ||
        u.email.toLowerCase().contains(query) ||
        u.role.toLowerCase().contains(query)).toList();
  }

  List<Subscription> searchSubscriptions(String q) {
    final query = q.trim().toLowerCase();
    if (query.isEmpty) return subscriptions;
    return subscriptions.where((s) =>
        s.userEmail.toLowerCase().contains(query) ||
        s.plan.toLowerCase().contains(query) ||
        s.status.toLowerCase().contains(query)).toList();
  }

  // ===== CRUD: Songs =====
  void addSong(Song song) {
    _songs.insert(0, song.copyWith(id: _newId()));
    notifyListeners();
  }

  void updateSong(String id, Song updated) {
    final idx = _songs.indexWhere((s) => s.id == id);
    if (idx == -1) return;
    _songs[idx] = updated.copyWith(id: id);
    notifyListeners();
  }

  void deleteSong(String id) {
    _songs.removeWhere((s) => s.id == id);
    notifyListeners();
  }

  // ===== CRUD: Artists =====
  void addArtist(Artist artist) {
    _artists.insert(0, artist.copyWith(id: _newId()));
    notifyListeners();
  }

  void updateArtist(String id, Artist updated) {
    final idx = _artists.indexWhere((a) => a.id == id);
    if (idx == -1) return;
    _artists[idx] = updated.copyWith(id: id);
    notifyListeners();
  }

  void deleteArtist(String id) {
    // Also unlink songs/albums for safety
    _artists.removeWhere((a) => a.id == id);
    notifyListeners();
  }

  // ===== CRUD: Albums =====
  void addAlbum(Album album) {
    _albums.insert(0, album.copyWith(id: _newId()));
    notifyListeners();
  }

  void updateAlbum(String id, Album updated) {
    final idx = _albums.indexWhere((a) => a.id == id);
    if (idx == -1) return;
    _albums[idx] = updated.copyWith(id: id);
    notifyListeners();
  }

  void deleteAlbum(String id) {
    _albums.removeWhere((a) => a.id == id);
    notifyListeners();
  }

  // ===== CRUD: Users =====
  void addUser(AppUser user) {
    _users.insert(0, user.copyWith(id: _newId()));
    notifyListeners();
  }

  void updateUser(String id, AppUser updated) {
    final idx = _users.indexWhere((u) => u.id == id);
    if (idx == -1) return;
    _users[idx] = updated.copyWith(id: id);
    notifyListeners();
  }

  void deleteUser(String id) {
    _users.removeWhere((u) => u.id == id);
    _subs.removeWhere((s) => s.userId == id);
    notifyListeners();
  }

  // ===== CRUD: Subscriptions =====
  void addSubscription(Subscription sub) {
    _subs.insert(0, sub.copyWith(id: _newId()));
    notifyListeners();
  }

  void updateSubscription(String id, Subscription updated) {
    final idx = _subs.indexWhere((s) => s.id == id);
    if (idx == -1) return;
    _subs[idx] = updated.copyWith(id: id);
    notifyListeners();
  }

  void deleteSubscription(String id) {
    _subs.removeWhere((s) => s.id == id);
    notifyListeners();
  }

  // ===== Analytics (derived) =====
  int get totalSongs => _songs.length;
  int get totalArtists => _artists.length;
  int get totalAlbums => _albums.length;
  int get totalUsers => _users.length;
  int get activeSubscriptions => _subs.where((s) => s.status == 'Active').length;

  double get monthlyRevenueUsd {
    double total = 0;
    for (final s in _subs.where((x) => x.status == 'Active')) {
      total += _planPrice(s.plan);
    }
    return total;
  }

  Map<String, int> get songsByGenre {
    final m = <String, int>{};
    for (final s in _songs) {
      m[s.genre] = (m[s.genre] ?? 0) + 1;
    }
    return m;
  }

  Map<String, int> get usersByRole {
    final m = <String, int>{};
    for (final u in _users) {
      m[u.role] = (m[u.role] ?? 0) + 1;
    }
    return m;
  }

  Map<String, int> get subsByPlan {
    final m = <String, int>{};
    for (final s in _subs) {
      m[s.plan] = (m[s.plan] ?? 0) + 1;
    }
    return m;
  }

  double _planPrice(String plan) {
    switch (plan) {
      case 'Premium':
        return 9.99;
      case 'Family':
        return 14.99;
      case 'Student':
        return 4.99;
      default:
        return 0;
    }
  }

  // ===== Helpers =====
  String _newId() => '${DateTime.now().microsecondsSinceEpoch}_${_rnd.nextInt(9999)}';

  void _seed() {
    _artists.addAll([
      Artist(id: _newId(), name: 'Arafat', genre: 'Pop', monthlyListeners: 120000),
      Artist(id: _newId(), name: 'Nafis', genre: 'Rock', monthlyListeners: 85000),
      Artist(id: _newId(), name: 'Sadia', genre: 'Lo-fi', monthlyListeners: 64000),
      Artist(id: _newId(), name: 'Rafi', genre: 'Hip-hop', monthlyListeners: 98000),
    ]);

    _albums.addAll([
      Album(id: _newId(), title: 'Midnight Beats', artistName: 'Sadia', year: 2024, tracks: 12),
      Album(id: _newId(), title: 'City Lights', artistName: 'Arafat', year: 2023, tracks: 9),
      Album(id: _newId(), title: 'Live & Loud', artistName: 'Nafis', year: 2022, tracks: 14),
    ]);

    _songs.addAll([
      Song(id: _newId(), title: 'Neon Skies', artistName: 'Arafat', albumTitle: 'City Lights', durationSec: 212, genre: 'Pop', streams: 410000),
      Song(id: _newId(), title: 'Rainy Loop', artistName: 'Sadia', albumTitle: 'Midnight Beats', durationSec: 178, genre: 'Lo-fi', streams: 210000),
      Song(id: _newId(), title: 'Guitar Fire', artistName: 'Nafis', albumTitle: 'Live & Loud', durationSec: 245, genre: 'Rock', streams: 150000),
      Song(id: _newId(), title: 'Street Flow', artistName: 'Rafi', albumTitle: 'Singles', durationSec: 201, genre: 'Hip-hop', streams: 320000),
    ]);

    _users.addAll([
      AppUser(id: _newId(), name: 'Minhaj', email: 'minhaj@example.com', role: 'Admin', joined: DateTime(2024, 6, 10), active: true),
      AppUser(id: _newId(), name: 'Ritu', email: 'ritu@example.com', role: 'User', joined: DateTime(2025, 1, 12), active: true),
      AppUser(id: _newId(), name: 'Sakib', email: 'sakib@example.com', role: 'User', joined: DateTime(2025, 8, 2), active: false),
      AppUser(id: _newId(), name: 'Nila', email: 'nila@example.com', role: 'Moderator', joined: DateTime(2025, 3, 18), active: true),
    ]);

    _subs.addAll([
      Subscription(id: _newId(), userId: _users[1].id, userEmail: _users[1].email, plan: 'Premium', status: 'Active', renewsOn: DateTime.now().add(const Duration(days: 18))),
      Subscription(id: _newId(), userId: _users[2].id, userEmail: _users[2].email, plan: 'Student', status: 'Canceled', renewsOn: DateTime.now().subtract(const Duration(days: 4))),
      Subscription(id: _newId(), userId: _users[3].id, userEmail: _users[3].email, plan: 'Family', status: 'Active', renewsOn: DateTime.now().add(const Duration(days: 7))),
    ]);
  }
}

@immutable
class Song {
  final String id;
  final String title;
  final String artistName;
  final String albumTitle;
  final int durationSec;
  final String genre;
  final int streams;

  const Song({
    required this.id,
    required this.title,
    required this.artistName,
    required this.albumTitle,
    required this.durationSec,
    required this.genre,
    required this.streams,
  });

  Song copyWith({
    String? id,
    String? title,
    String? artistName,
    String? albumTitle,
    int? durationSec,
    String? genre,
    int? streams,
  }) {
    return Song(
      id: id ?? this.id,
      title: title ?? this.title,
      artistName: artistName ?? this.artistName,
      albumTitle: albumTitle ?? this.albumTitle,
      durationSec: durationSec ?? this.durationSec,
      genre: genre ?? this.genre,
      streams: streams ?? this.streams,
    );
  }
}

@immutable
class Artist {
  final String id;
  final String name;
  final String genre;
  final int monthlyListeners;

  const Artist({
    required this.id,
    required this.name,
    required this.genre,
    required this.monthlyListeners,
  });

  Artist copyWith({
    String? id,
    String? name,
    String? genre,
    int? monthlyListeners,
  }) {
    return Artist(
      id: id ?? this.id,
      name: name ?? this.name,
      genre: genre ?? this.genre,
      monthlyListeners: monthlyListeners ?? this.monthlyListeners,
    );
  }
}

@immutable
class Album {
  final String id;
  final String title;
  final String artistName;
  final int year;
  final int tracks;

  const Album({
    required this.id,
    required this.title,
    required this.artistName,
    required this.year,
    required this.tracks,
  });

  Album copyWith({
    String? id,
    String? title,
    String? artistName,
    int? year,
    int? tracks,
  }) {
    return Album(
      id: id ?? this.id,
      title: title ?? this.title,
      artistName: artistName ?? this.artistName,
      year: year ?? this.year,
      tracks: tracks ?? this.tracks,
    );
  }
}

@immutable
class AppUser {
  final String id;
  final String name;
  final String email;
  final String role; // Admin, Moderator, User
  final DateTime joined;
  final bool active;

  const AppUser({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.joined,
    required this.active,
  });

  AppUser copyWith({
    String? id,
    String? name,
    String? email,
    String? role,
    DateTime? joined,
    bool? active,
  }) {
    return AppUser(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      role: role ?? this.role,
      joined: joined ?? this.joined,
      active: active ?? this.active,
    );
  }
}

@immutable
class Subscription {
  final String id;
  final String userId;
  final String userEmail;
  final String plan; // Premium, Family, Student
  final String status; // Active, Canceled, Past Due
  final DateTime renewsOn;

  const Subscription({
    required this.id,
    required this.userId,
    required this.userEmail,
    required this.plan,
    required this.status,
    required this.renewsOn,
  });

  Subscription copyWith({
    String? id,
    String? userId,
    String? userEmail,
    String? plan,
    String? status,
    DateTime? renewsOn,
  }) {
    return Subscription(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      userEmail: userEmail ?? this.userEmail,
      plan: plan ?? this.plan,
      status: status ?? this.status,
      renewsOn: renewsOn ?? this.renewsOn,
    );
  }
}
