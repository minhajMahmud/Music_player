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

abstract class PlaylistSong implements _i1.SerializableModel {
  PlaylistSong._({
    this.id,
    required this.playlistId,
    required this.songId,
    required this.position,
    required this.addedAt,
  });

  factory PlaylistSong({
    int? id,
    required _i1.UuidValue playlistId,
    required _i1.UuidValue songId,
    required int position,
    required DateTime addedAt,
  }) = _PlaylistSongImpl;

  factory PlaylistSong.fromJson(Map<String, dynamic> jsonSerialization) {
    return PlaylistSong(
      id: jsonSerialization['id'] as int?,
      playlistId: _i1.UuidValueJsonExtension.fromJson(
        jsonSerialization['playlistId'],
      ),
      songId: _i1.UuidValueJsonExtension.fromJson(jsonSerialization['songId']),
      position: jsonSerialization['position'] as int,
      addedAt: _i1.DateTimeJsonExtension.fromJson(jsonSerialization['addedAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  _i1.UuidValue playlistId;

  _i1.UuidValue songId;

  int position;

  DateTime addedAt;

  /// Returns a shallow copy of this [PlaylistSong]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  PlaylistSong copyWith({
    int? id,
    _i1.UuidValue? playlistId,
    _i1.UuidValue? songId,
    int? position,
    DateTime? addedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'PlaylistSong',
      if (id != null) 'id': id,
      'playlistId': playlistId.toJson(),
      'songId': songId.toJson(),
      'position': position,
      'addedAt': addedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PlaylistSongImpl extends PlaylistSong {
  _PlaylistSongImpl({
    int? id,
    required _i1.UuidValue playlistId,
    required _i1.UuidValue songId,
    required int position,
    required DateTime addedAt,
  }) : super._(
         id: id,
         playlistId: playlistId,
         songId: songId,
         position: position,
         addedAt: addedAt,
       );

  /// Returns a shallow copy of this [PlaylistSong]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  PlaylistSong copyWith({
    Object? id = _Undefined,
    _i1.UuidValue? playlistId,
    _i1.UuidValue? songId,
    int? position,
    DateTime? addedAt,
  }) {
    return PlaylistSong(
      id: id is int? ? id : this.id,
      playlistId: playlistId ?? this.playlistId,
      songId: songId ?? this.songId,
      position: position ?? this.position,
      addedAt: addedAt ?? this.addedAt,
    );
  }
}
