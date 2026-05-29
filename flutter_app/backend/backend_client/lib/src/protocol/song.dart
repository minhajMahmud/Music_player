/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;

abstract class Song implements _i1.SerializableModel {
  Song._({
    _i1.UuidValue? id,
    required this.title,
    required this.artistId,
    this.albumId,
    required this.durationSec,
    this.genre,
    this.audioUrl,
    this.coverUrl,
    required this.streams,
    required this.createdAt,
  }) : id = id ?? _i1.Uuid().v4obj();

  factory Song({
    _i1.UuidValue? id,
    required String title,
    required _i1.UuidValue artistId,
    _i1.UuidValue? albumId,
    required int durationSec,
    String? genre,
    String? audioUrl,
    String? coverUrl,
    required int streams,
    required DateTime createdAt,
  }) = _SongImpl;

  factory Song.fromJson(Map<String, dynamic> jsonSerialization) {
    return Song(
      id: _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      title: jsonSerialization['title'] as String,
      artistId: _i1.UuidValueJsonExtension.fromJson(
        jsonSerialization['artistId'],
      ),
      albumId: jsonSerialization['albumId'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['albumId']),
      durationSec: jsonSerialization['durationSec'] as int,
      genre: jsonSerialization['genre'] as String?,
      audioUrl: jsonSerialization['audioUrl'] as String?,
      coverUrl: jsonSerialization['coverUrl'] as String?,
      streams: jsonSerialization['streams'] as int,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  /// The id of the object.
  _i1.UuidValue id;

  String title;

  _i1.UuidValue artistId;

  _i1.UuidValue? albumId;

  int durationSec;

  String? genre;

  String? audioUrl;

  String? coverUrl;

  int streams;

  DateTime createdAt;

  /// Returns a shallow copy of this [Song]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Song copyWith({
    _i1.UuidValue? id,
    String? title,
    _i1.UuidValue? artistId,
    _i1.UuidValue? albumId,
    int? durationSec,
    String? genre,
    String? audioUrl,
    String? coverUrl,
    int? streams,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Song',
      'id': id.toJson(),
      'title': title,
      'artistId': artistId.toJson(),
      if (albumId != null) 'albumId': albumId?.toJson(),
      'durationSec': durationSec,
      if (genre != null) 'genre': genre,
      if (audioUrl != null) 'audioUrl': audioUrl,
      if (coverUrl != null) 'coverUrl': coverUrl,
      'streams': streams,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SongImpl extends Song {
  _SongImpl({
    _i1.UuidValue? id,
    required String title,
    required _i1.UuidValue artistId,
    _i1.UuidValue? albumId,
    required int durationSec,
    String? genre,
    String? audioUrl,
    String? coverUrl,
    required int streams,
    required DateTime createdAt,
  }) : super._(
         id: id,
         title: title,
         artistId: artistId,
         albumId: albumId,
         durationSec: durationSec,
         genre: genre,
         audioUrl: audioUrl,
         coverUrl: coverUrl,
         streams: streams,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [Song]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Song copyWith({
    _i1.UuidValue? id,
    String? title,
    _i1.UuidValue? artistId,
    Object? albumId = _Undefined,
    int? durationSec,
    Object? genre = _Undefined,
    Object? audioUrl = _Undefined,
    Object? coverUrl = _Undefined,
    int? streams,
    DateTime? createdAt,
  }) {
    return Song(
      id: id ?? this.id,
      title: title ?? this.title,
      artistId: artistId ?? this.artistId,
      albumId: albumId is _i1.UuidValue? ? albumId : this.albumId,
      durationSec: durationSec ?? this.durationSec,
      genre: genre is String? ? genre : this.genre,
      audioUrl: audioUrl is String? ? audioUrl : this.audioUrl,
      coverUrl: coverUrl is String? ? coverUrl : this.coverUrl,
      streams: streams ?? this.streams,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
