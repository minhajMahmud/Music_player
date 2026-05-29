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
import 'package:serverpod/serverpod.dart' as _i1;

abstract class Playlist
    implements _i1.TableRow<_i1.UuidValue>, _i1.ProtocolSerialization {
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

  static final t = PlaylistTable();

  static const db = PlaylistRepository._();

  @override
  _i1.UuidValue id;

  String name;

  String? description;

  String? coverUrl;

  String? gradient;

  _i1.UuidValue? ownerUserId;

  bool isPublic;

  DateTime createdAt;

  @override
  _i1.Table<_i1.UuidValue> get table => t;

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
  Map<String, dynamic> toJsonForProtocol() {
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

  static PlaylistInclude include() {
    return PlaylistInclude._();
  }

  static PlaylistIncludeList includeList({
    _i1.WhereExpressionBuilder<PlaylistTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<PlaylistTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PlaylistTable>? orderByList,
    PlaylistInclude? include,
  }) {
    return PlaylistIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Playlist.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Playlist.t),
      include: include,
    );
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

class PlaylistUpdateTable extends _i1.UpdateTable<PlaylistTable> {
  PlaylistUpdateTable(super.table);

  _i1.ColumnValue<String, String> name(String value) => _i1.ColumnValue(
    table.name,
    value,
  );

  _i1.ColumnValue<String, String> description(String? value) => _i1.ColumnValue(
    table.description,
    value,
  );

  _i1.ColumnValue<String, String> coverUrl(String? value) => _i1.ColumnValue(
    table.coverUrl,
    value,
  );

  _i1.ColumnValue<String, String> gradient(String? value) => _i1.ColumnValue(
    table.gradient,
    value,
  );

  _i1.ColumnValue<_i1.UuidValue, _i1.UuidValue> ownerUserId(
    _i1.UuidValue? value,
  ) => _i1.ColumnValue(
    table.ownerUserId,
    value,
  );

  _i1.ColumnValue<bool, bool> isPublic(bool value) => _i1.ColumnValue(
    table.isPublic,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _i1.ColumnValue(
        table.createdAt,
        value,
      );
}

class PlaylistTable extends _i1.Table<_i1.UuidValue> {
  PlaylistTable({super.tableRelation}) : super(tableName: 'playlists') {
    updateTable = PlaylistUpdateTable(this);
    name = _i1.ColumnString(
      'name',
      this,
    );
    description = _i1.ColumnString(
      'description',
      this,
    );
    coverUrl = _i1.ColumnString(
      'coverUrl',
      this,
    );
    gradient = _i1.ColumnString(
      'gradient',
      this,
    );
    ownerUserId = _i1.ColumnUuid(
      'ownerUserId',
      this,
    );
    isPublic = _i1.ColumnBool(
      'isPublic',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
    );
  }

  late final PlaylistUpdateTable updateTable;

  late final _i1.ColumnString name;

  late final _i1.ColumnString description;

  late final _i1.ColumnString coverUrl;

  late final _i1.ColumnString gradient;

  late final _i1.ColumnUuid ownerUserId;

  late final _i1.ColumnBool isPublic;

  late final _i1.ColumnDateTime createdAt;

  @override
  List<_i1.Column> get columns => [
    id,
    name,
    description,
    coverUrl,
    gradient,
    ownerUserId,
    isPublic,
    createdAt,
  ];
}

class PlaylistInclude extends _i1.IncludeObject {
  PlaylistInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<_i1.UuidValue> get table => Playlist.t;
}

class PlaylistIncludeList extends _i1.IncludeList {
  PlaylistIncludeList._({
    _i1.WhereExpressionBuilder<PlaylistTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Playlist.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<_i1.UuidValue> get table => Playlist.t;
}

class PlaylistRepository {
  const PlaylistRepository._();

  /// Returns a list of [Playlist]s matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order of the items use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// The maximum number of items can be set by [limit]. If no limit is set,
  /// all items matching the query will be returned.
  ///
  /// [offset] defines how many items to skip, after which [limit] (or all)
  /// items are read from the database.
  ///
  /// ```dart
  /// var persons = await Persons.db.find(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.firstName,
  ///   limit: 100,
  /// );
  /// ```
  Future<List<Playlist>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<PlaylistTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<PlaylistTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PlaylistTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<Playlist>(
      where: where?.call(Playlist.t),
      orderBy: orderBy?.call(Playlist.t),
      orderByList: orderByList?.call(Playlist.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [Playlist] matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// [offset] defines how many items to skip, after which the next one will be picked.
  ///
  /// ```dart
  /// var youngestPerson = await Persons.db.findFirstRow(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.age,
  /// );
  /// ```
  Future<Playlist?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<PlaylistTable>? where,
    int? offset,
    _i1.OrderByBuilder<PlaylistTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PlaylistTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<Playlist>(
      where: where?.call(Playlist.t),
      orderBy: orderBy?.call(Playlist.t),
      orderByList: orderByList?.call(Playlist.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [Playlist] by its [id] or null if no such row exists.
  Future<Playlist?> findById(
    _i1.Session session,
    _i1.UuidValue id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<Playlist>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [Playlist]s in the list and returns the inserted rows.
  ///
  /// The returned [Playlist]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<Playlist>> insert(
    _i1.Session session,
    List<Playlist> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<Playlist>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [Playlist] and returns the inserted row.
  ///
  /// The returned [Playlist] will have its `id` field set.
  Future<Playlist> insertRow(
    _i1.Session session,
    Playlist row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Playlist>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Playlist]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Playlist>> update(
    _i1.Session session,
    List<Playlist> rows, {
    _i1.ColumnSelections<PlaylistTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Playlist>(
      rows,
      columns: columns?.call(Playlist.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Playlist]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Playlist> updateRow(
    _i1.Session session,
    Playlist row, {
    _i1.ColumnSelections<PlaylistTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Playlist>(
      row,
      columns: columns?.call(Playlist.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Playlist] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Playlist?> updateById(
    _i1.Session session,
    _i1.UuidValue id, {
    required _i1.ColumnValueListBuilder<PlaylistUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<Playlist>(
      id,
      columnValues: columnValues(Playlist.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Playlist]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<Playlist>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<PlaylistUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<PlaylistTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<PlaylistTable>? orderBy,
    _i1.OrderByListBuilder<PlaylistTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<Playlist>(
      columnValues: columnValues(Playlist.t.updateTable),
      where: where(Playlist.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Playlist.t),
      orderByList: orderByList?.call(Playlist.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [Playlist]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Playlist>> delete(
    _i1.Session session,
    List<Playlist> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Playlist>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Playlist].
  Future<Playlist> deleteRow(
    _i1.Session session,
    Playlist row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Playlist>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Playlist>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<PlaylistTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Playlist>(
      where: where(Playlist.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<PlaylistTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Playlist>(
      where: where?.call(Playlist.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
