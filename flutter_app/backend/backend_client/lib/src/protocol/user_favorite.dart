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

abstract class UserFavorite implements _i1.SerializableModel {
  UserFavorite._({
    this.id,
    required this.userId,
    required this.songId,
    required this.createdAt,
  });

  factory UserFavorite({
    int? id,
    required _i1.UuidValue userId,
    required _i1.UuidValue songId,
    required DateTime createdAt,
  }) = _UserFavoriteImpl;

  factory UserFavorite.fromJson(Map<String, dynamic> jsonSerialization) {
    return UserFavorite(
      id: jsonSerialization['id'] as int?,
      userId: _i1.UuidValueJsonExtension.fromJson(jsonSerialization['userId']),
      songId: _i1.UuidValueJsonExtension.fromJson(jsonSerialization['songId']),
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  _i1.UuidValue userId;

  _i1.UuidValue songId;

  DateTime createdAt;

  /// Returns a shallow copy of this [UserFavorite]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  UserFavorite copyWith({
    int? id,
    _i1.UuidValue? userId,
    _i1.UuidValue? songId,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'UserFavorite',
      if (id != null) 'id': id,
      'userId': userId.toJson(),
      'songId': songId.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _UserFavoriteImpl extends UserFavorite {
  _UserFavoriteImpl({
    int? id,
    required _i1.UuidValue userId,
    required _i1.UuidValue songId,
    required DateTime createdAt,
  }) : super._(
         id: id,
         userId: userId,
         songId: songId,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [UserFavorite]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  UserFavorite copyWith({
    Object? id = _Undefined,
    _i1.UuidValue? userId,
    _i1.UuidValue? songId,
    DateTime? createdAt,
  }) {
    return UserFavorite(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      songId: songId ?? this.songId,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
