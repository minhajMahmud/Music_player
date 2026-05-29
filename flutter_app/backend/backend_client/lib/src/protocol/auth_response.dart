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
import 'app_user.dart' as _i2;
import 'package:backend_client/src/protocol/protocol.dart' as _i3;

abstract class AuthResponse implements _i1.SerializableModel {
  AuthResponse._({
    required this.token,
    this.user,
  });

  factory AuthResponse({
    required String token,
    _i2.AppUser? user,
  }) = _AuthResponseImpl;

  factory AuthResponse.fromJson(Map<String, dynamic> jsonSerialization) {
    return AuthResponse(
      token: jsonSerialization['token'] as String,
      user: jsonSerialization['user'] == null
          ? null
          : _i3.Protocol().deserialize<_i2.AppUser>(jsonSerialization['user']),
    );
  }

  String token;

  _i2.AppUser? user;

  /// Returns a shallow copy of this [AuthResponse]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AuthResponse copyWith({
    String? token,
    _i2.AppUser? user,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AuthResponse',
      'token': token,
      if (user != null) 'user': user?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AuthResponseImpl extends AuthResponse {
  _AuthResponseImpl({
    required String token,
    _i2.AppUser? user,
  }) : super._(
         token: token,
         user: user,
       );

  /// Returns a shallow copy of this [AuthResponse]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AuthResponse copyWith({
    String? token,
    Object? user = _Undefined,
  }) {
    return AuthResponse(
      token: token ?? this.token,
      user: user is _i2.AppUser? ? user : this.user?.copyWith(),
    );
  }
}
