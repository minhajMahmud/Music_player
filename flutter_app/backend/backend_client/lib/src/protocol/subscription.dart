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

abstract class Subscription implements _i1.SerializableModel {
  Subscription._({
    _i1.UuidValue? id,
    required this.userId,
    required this.plan,
    required this.status,
    required this.renewsOn,
    required this.startedAt,
    this.canceledAt,
  }) : id = id ?? _i1.Uuid().v4obj();

  factory Subscription({
    _i1.UuidValue? id,
    required _i1.UuidValue userId,
    required String plan,
    required String status,
    required DateTime renewsOn,
    required DateTime startedAt,
    DateTime? canceledAt,
  }) = _SubscriptionImpl;

  factory Subscription.fromJson(Map<String, dynamic> jsonSerialization) {
    return Subscription(
      id: _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      userId: _i1.UuidValueJsonExtension.fromJson(jsonSerialization['userId']),
      plan: jsonSerialization['plan'] as String,
      status: jsonSerialization['status'] as String,
      renewsOn: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['renewsOn'],
      ),
      startedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['startedAt'],
      ),
      canceledAt: jsonSerialization['canceledAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['canceledAt']),
    );
  }

  /// The id of the object.
  _i1.UuidValue id;

  _i1.UuidValue userId;

  String plan;

  String status;

  DateTime renewsOn;

  DateTime startedAt;

  DateTime? canceledAt;

  /// Returns a shallow copy of this [Subscription]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Subscription copyWith({
    _i1.UuidValue? id,
    _i1.UuidValue? userId,
    String? plan,
    String? status,
    DateTime? renewsOn,
    DateTime? startedAt,
    DateTime? canceledAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Subscription',
      'id': id.toJson(),
      'userId': userId.toJson(),
      'plan': plan,
      'status': status,
      'renewsOn': renewsOn.toJson(),
      'startedAt': startedAt.toJson(),
      if (canceledAt != null) 'canceledAt': canceledAt?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SubscriptionImpl extends Subscription {
  _SubscriptionImpl({
    _i1.UuidValue? id,
    required _i1.UuidValue userId,
    required String plan,
    required String status,
    required DateTime renewsOn,
    required DateTime startedAt,
    DateTime? canceledAt,
  }) : super._(
         id: id,
         userId: userId,
         plan: plan,
         status: status,
         renewsOn: renewsOn,
         startedAt: startedAt,
         canceledAt: canceledAt,
       );

  /// Returns a shallow copy of this [Subscription]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Subscription copyWith({
    _i1.UuidValue? id,
    _i1.UuidValue? userId,
    String? plan,
    String? status,
    DateTime? renewsOn,
    DateTime? startedAt,
    Object? canceledAt = _Undefined,
  }) {
    return Subscription(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      plan: plan ?? this.plan,
      status: status ?? this.status,
      renewsOn: renewsOn ?? this.renewsOn,
      startedAt: startedAt ?? this.startedAt,
      canceledAt: canceledAt is DateTime? ? canceledAt : this.canceledAt,
    );
  }
}
