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

abstract class PlayEvent implements _i1.SerializableModel {
  PlayEvent._({
    this.id,
    this.userId,
    required this.songId,
    required this.playedAt,
    required this.secondsListened,
    this.device,
  });

  factory PlayEvent({
    int? id,
    _i1.UuidValue? userId,
    required _i1.UuidValue songId,
    required DateTime playedAt,
    required int secondsListened,
    String? device,
  }) = _PlayEventImpl;

  factory PlayEvent.fromJson(Map<String, dynamic> jsonSerialization) {
    return PlayEvent(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['userId']),
      songId: _i1.UuidValueJsonExtension.fromJson(jsonSerialization['songId']),
      playedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['playedAt'],
      ),
      secondsListened: jsonSerialization['secondsListened'] as int,
      device: jsonSerialization['device'] as String?,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  _i1.UuidValue? userId;

  _i1.UuidValue songId;

  DateTime playedAt;

  int secondsListened;

  String? device;

  /// Returns a shallow copy of this [PlayEvent]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  PlayEvent copyWith({
    int? id,
    _i1.UuidValue? userId,
    _i1.UuidValue? songId,
    DateTime? playedAt,
    int? secondsListened,
    String? device,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'PlayEvent',
      if (id != null) 'id': id,
      if (userId != null) 'userId': userId?.toJson(),
      'songId': songId.toJson(),
      'playedAt': playedAt.toJson(),
      'secondsListened': secondsListened,
      if (device != null) 'device': device,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PlayEventImpl extends PlayEvent {
  _PlayEventImpl({
    int? id,
    _i1.UuidValue? userId,
    required _i1.UuidValue songId,
    required DateTime playedAt,
    required int secondsListened,
    String? device,
  }) : super._(
         id: id,
         userId: userId,
         songId: songId,
         playedAt: playedAt,
         secondsListened: secondsListened,
         device: device,
       );

  /// Returns a shallow copy of this [PlayEvent]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  PlayEvent copyWith({
    Object? id = _Undefined,
    Object? userId = _Undefined,
    _i1.UuidValue? songId,
    DateTime? playedAt,
    int? secondsListened,
    Object? device = _Undefined,
  }) {
    return PlayEvent(
      id: id is int? ? id : this.id,
      userId: userId is _i1.UuidValue? ? userId : this.userId,
      songId: songId ?? this.songId,
      playedAt: playedAt ?? this.playedAt,
      secondsListened: secondsListened ?? this.secondsListened,
      device: device is String? ? device : this.device,
    );
  }
}
