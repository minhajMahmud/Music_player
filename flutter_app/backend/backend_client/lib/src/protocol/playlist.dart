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

abstract class Playlist implements _i1.SerializableModel {
  Playlist._({
    _i1.UuidValue? id,
    required this.name,
    this.description,
    this.coverUrl,
    this.gradient,
    this.ownerUserId,
    required this.isPublic,
    required this.createdAt,
  }) : id = id ?? _i1.Uuid().v4obj();

  factory Playlist({
    _i1.UuidValue? id,
    required String name,
    String? description,
    String? coverUrl,
    String? gradient,
    _i1.UuidValue? ownerUserId,
    required bool isPublic,
    required DateTime createdAt,
  }) = _PlaylistImpl;

  factory Playlist.fromJson(Map<String, dynamic> jsonSerialization) {
    return Playlist(
      id: _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      name: jsonSerialization['name'] as String,
      description: jsonSerialization['description'] as String?,
      coverUrl: jsonSerialization['coverUrl'] as String?,
      gradient: jsonSerialization['gradient'] as String?,
      ownerUserId: jsonSerialization['ownerUserId'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(
              jsonSerialization['ownerUserId'],
            ),
      isPublic: jsonSerialization['isPublic'] as bool,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  /// The id of the object.
  _i1.UuidValue id;

  String name;

  String? description;

  String? coverUrl;

  String? gradient;

  _i1.UuidValue? ownerUserId;

  bool isPublic;

  DateTime createdAt;

  /// Returns a shallow copy of this [Playlist]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Playlist copyWith({
    _i1.UuidValue? id,
    String? name,
    String? description,
    String? coverUrl,
    String? gradient,
    _i1.UuidValue? ownerUserId,
    bool? isPublic,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Playlist',
      'id': id.toJson(),
      'name': name,
      if (description != null) 'description': description,
      if (coverUrl != null) 'coverUrl': coverUrl,
      if (gradient != null) 'gradient': gradient,
      if (ownerUserId != null) 'ownerUserId': ownerUserId?.toJson(),
      'isPublic': isPublic,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PlaylistImpl extends Playlist {
  _PlaylistImpl({
    _i1.UuidValue? id,
    required String name,
    String? description,
    String? coverUrl,
    String? gradient,
    _i1.UuidValue? ownerUserId,
    required bool isPublic,
    required DateTime createdAt,
  }) : super._(
         id: id,
         name: name,
         description: description,
         coverUrl: coverUrl,
         gradient: gradient,
         ownerUserId: ownerUserId,
         isPublic: isPublic,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [Playlist]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Playlist copyWith({
    _i1.UuidValue? id,
    String? name,
    Object? description = _Undefined,
    Object? coverUrl = _Undefined,
    Object? gradient = _Undefined,
    Object? ownerUserId = _Undefined,
    bool? isPublic,
    DateTime? createdAt,
  }) {
    return Playlist(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description is String? ? description : this.description,
      coverUrl: coverUrl is String? ? coverUrl : this.coverUrl,
      gradient: gradient is String? ? gradient : this.gradient,
      ownerUserId: ownerUserId is _i1.UuidValue?
          ? ownerUserId
          : this.ownerUserId,
      isPublic: isPublic ?? this.isPublic,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
