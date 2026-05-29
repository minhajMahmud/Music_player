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

abstract class Album implements _i1.SerializableModel {
  Album._({
    _i1.UuidValue? id,
    required this.title,
    required this.artistId,
    this.releaseYear,
    this.coverUrl,
    required this.trackCount,
    required this.createdAt,
  }) : id = id ?? _i1.Uuid().v4obj();

  factory Album({
    _i1.UuidValue? id,
    required String title,
    required _i1.UuidValue artistId,
    int? releaseYear,
    String? coverUrl,
    required int trackCount,
    required DateTime createdAt,
  }) = _AlbumImpl;

  factory Album.fromJson(Map<String, dynamic> jsonSerialization) {
    return Album(
      id: _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      title: jsonSerialization['title'] as String,
      artistId: _i1.UuidValueJsonExtension.fromJson(
        jsonSerialization['artistId'],
      ),
      releaseYear: jsonSerialization['releaseYear'] as int?,
      coverUrl: jsonSerialization['coverUrl'] as String?,
      trackCount: jsonSerialization['trackCount'] as int,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  /// The id of the object.
  _i1.UuidValue id;

  String title;

  _i1.UuidValue artistId;

  int? releaseYear;

  String? coverUrl;

  int trackCount;

  DateTime createdAt;

  /// Returns a shallow copy of this [Album]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Album copyWith({
    _i1.UuidValue? id,
    String? title,
    _i1.UuidValue? artistId,
    int? releaseYear,
    String? coverUrl,
    int? trackCount,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Album',
      'id': id.toJson(),
      'title': title,
      'artistId': artistId.toJson(),
      if (releaseYear != null) 'releaseYear': releaseYear,
      if (coverUrl != null) 'coverUrl': coverUrl,
      'trackCount': trackCount,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AlbumImpl extends Album {
  _AlbumImpl({
    _i1.UuidValue? id,
    required String title,
    required _i1.UuidValue artistId,
    int? releaseYear,
    String? coverUrl,
    required int trackCount,
    required DateTime createdAt,
  }) : super._(
         id: id,
         title: title,
         artistId: artistId,
         releaseYear: releaseYear,
         coverUrl: coverUrl,
         trackCount: trackCount,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [Album]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Album copyWith({
    _i1.UuidValue? id,
    String? title,
    _i1.UuidValue? artistId,
    Object? releaseYear = _Undefined,
    Object? coverUrl = _Undefined,
    int? trackCount,
    DateTime? createdAt,
  }) {
    return Album(
      id: id ?? this.id,
      title: title ?? this.title,
      artistId: artistId ?? this.artistId,
      releaseYear: releaseYear is int? ? releaseYear : this.releaseYear,
      coverUrl: coverUrl is String? ? coverUrl : this.coverUrl,
      trackCount: trackCount ?? this.trackCount,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
