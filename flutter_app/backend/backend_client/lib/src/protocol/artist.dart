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

abstract class Artist implements _i1.SerializableModel {
  Artist._({
    _i1.UuidValue? id,
    required this.name,
    this.genre,
    required this.monthlyListeners,
    required this.createdAt,
  }) : id = id ?? _i1.Uuid().v4obj();

  factory Artist({
    _i1.UuidValue? id,
    required String name,
    String? genre,
    required int monthlyListeners,
    required DateTime createdAt,
  }) = _ArtistImpl;

  factory Artist.fromJson(Map<String, dynamic> jsonSerialization) {
    return Artist(
      id: _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      name: jsonSerialization['name'] as String,
      genre: jsonSerialization['genre'] as String?,
      monthlyListeners: jsonSerialization['monthlyListeners'] as int,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  /// The id of the object.
  _i1.UuidValue id;

  String name;

  String? genre;

  int monthlyListeners;

  DateTime createdAt;

  /// Returns a shallow copy of this [Artist]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Artist copyWith({
    _i1.UuidValue? id,
    String? name,
    String? genre,
    int? monthlyListeners,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Artist',
      'id': id.toJson(),
      'name': name,
      if (genre != null) 'genre': genre,
      'monthlyListeners': monthlyListeners,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ArtistImpl extends Artist {
  _ArtistImpl({
    _i1.UuidValue? id,
    required String name,
    String? genre,
    required int monthlyListeners,
    required DateTime createdAt,
  }) : super._(
         id: id,
         name: name,
         genre: genre,
         monthlyListeners: monthlyListeners,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [Artist]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Artist copyWith({
    _i1.UuidValue? id,
    String? name,
    Object? genre = _Undefined,
    int? monthlyListeners,
    DateTime? createdAt,
  }) {
    return Artist(
      id: id ?? this.id,
      name: name ?? this.name,
      genre: genre is String? ? genre : this.genre,
      monthlyListeners: monthlyListeners ?? this.monthlyListeners,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
