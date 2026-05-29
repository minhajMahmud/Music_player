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

abstract class AppUser implements _i1.SerializableModel {
  AppUser._({
    _i1.UuidValue? id,
    this.firebaseId,
    required this.name,
    required this.email,
    required this.role,
    required this.active,
    required this.joinedAt,
  }) : id = id ?? _i1.Uuid().v4obj();

  factory AppUser({
    _i1.UuidValue? id,
    String? firebaseId,
    required String name,
    required String email,
    required String role,
    required bool active,
    required DateTime joinedAt,
  }) = _AppUserImpl;

  factory AppUser.fromJson(Map<String, dynamic> jsonSerialization) {
    return AppUser(
      id: _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      firebaseId: jsonSerialization['firebaseId'] as String?,
      name: jsonSerialization['name'] as String,
      email: jsonSerialization['email'] as String,
      role: jsonSerialization['role'] as String,
      active: jsonSerialization['active'] as bool,
      joinedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['joinedAt'],
      ),
    );
  }

  /// The id of the object.
  _i1.UuidValue id;

  String? firebaseId;

  String name;

  String email;

  String role;

  bool active;

  DateTime joinedAt;

  /// Returns a shallow copy of this [AppUser]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AppUser copyWith({
    _i1.UuidValue? id,
    String? firebaseId,
    String? name,
    String? email,
    String? role,
    bool? active,
    DateTime? joinedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AppUser',
      'id': id.toJson(),
      if (firebaseId != null) 'firebaseId': firebaseId,
      'name': name,
      'email': email,
      'role': role,
      'active': active,
      'joinedAt': joinedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AppUserImpl extends AppUser {
  _AppUserImpl({
    _i1.UuidValue? id,
    String? firebaseId,
    required String name,
    required String email,
    required String role,
    required bool active,
    required DateTime joinedAt,
  }) : super._(
         id: id,
         firebaseId: firebaseId,
         name: name,
         email: email,
         role: role,
         active: active,
         joinedAt: joinedAt,
       );

  /// Returns a shallow copy of this [AppUser]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AppUser copyWith({
    _i1.UuidValue? id,
    Object? firebaseId = _Undefined,
    String? name,
    String? email,
    String? role,
    bool? active,
    DateTime? joinedAt,
  }) {
    return AppUser(
      id: id ?? this.id,
      firebaseId: firebaseId is String? ? firebaseId : this.firebaseId,
      name: name ?? this.name,
      email: email ?? this.email,
      role: role ?? this.role,
      active: active ?? this.active,
      joinedAt: joinedAt ?? this.joinedAt,
    );
  }
}
