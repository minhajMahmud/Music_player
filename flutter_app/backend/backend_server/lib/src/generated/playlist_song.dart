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

abstract class PlaylistSong
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
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

  static final t = PlaylistSongTable();

  static const db = PlaylistSongRepository._();

  @override
  int? id;

  _i1.UuidValue playlistId;

  _i1.UuidValue songId;

  int position;

  DateTime addedAt;

  @override
  _i1.Table<int?> get table => t;

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
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'PlaylistSong',
      if (id != null) 'id': id,
      'playlistId': playlistId.toJson(),
      'songId': songId.toJson(),
      'position': position,
      'addedAt': addedAt.toJson(),
    };
  }

  static PlaylistSongInclude include() {
    return PlaylistSongInclude._();
  }

  static PlaylistSongIncludeList includeList({
    _i1.WhereExpressionBuilder<PlaylistSongTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<PlaylistSongTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PlaylistSongTable>? orderByList,
    PlaylistSongInclude? include,
  }) {
    return PlaylistSongIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(PlaylistSong.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(PlaylistSong.t),
      include: include,
    );
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

class PlaylistSongUpdateTable extends _i1.UpdateTable<PlaylistSongTable> {
  PlaylistSongUpdateTable(super.table);

  _i1.ColumnValue<_i1.UuidValue, _i1.UuidValue> playlistId(
    _i1.UuidValue value,
  ) => _i1.ColumnValue(
    table.playlistId,
    value,
  );

  _i1.ColumnValue<_i1.UuidValue, _i1.UuidValue> songId(_i1.UuidValue value) =>
      _i1.ColumnValue(
        table.songId,
        value,
      );

  _i1.ColumnValue<int, int> position(int value) => _i1.ColumnValue(
    table.position,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> addedAt(DateTime value) =>
      _i1.ColumnValue(
        table.addedAt,
        value,
      );
}

class PlaylistSongTable extends _i1.Table<int?> {
  PlaylistSongTable({super.tableRelation})
    : super(tableName: 'playlist_items') {
    updateTable = PlaylistSongUpdateTable(this);
    playlistId = _i1.ColumnUuid(
      'playlistId',
      this,
    );
    songId = _i1.ColumnUuid(
      'songId',
      this,
    );
    position = _i1.ColumnInt(
      'position',
      this,
    );
    addedAt = _i1.ColumnDateTime(
      'addedAt',
      this,
    );
  }

  late final PlaylistSongUpdateTable updateTable;

  late final _i1.ColumnUuid playlistId;

  late final _i1.ColumnUuid songId;

  late final _i1.ColumnInt position;

  late final _i1.ColumnDateTime addedAt;

  @override
  List<_i1.Column> get columns => [
    id,
    playlistId,
    songId,
    position,
    addedAt,
  ];
}

class PlaylistSongInclude extends _i1.IncludeObject {
  PlaylistSongInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => PlaylistSong.t;
}

class PlaylistSongIncludeList extends _i1.IncludeList {
  PlaylistSongIncludeList._({
    _i1.WhereExpressionBuilder<PlaylistSongTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(PlaylistSong.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => PlaylistSong.t;
}

class PlaylistSongRepository {
  const PlaylistSongRepository._();

  /// Returns a list of [PlaylistSong]s matching the given query parameters.
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
  Future<List<PlaylistSong>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<PlaylistSongTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<PlaylistSongTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PlaylistSongTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<PlaylistSong>(
      where: where?.call(PlaylistSong.t),
      orderBy: orderBy?.call(PlaylistSong.t),
      orderByList: orderByList?.call(PlaylistSong.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [PlaylistSong] matching the given query parameters.
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
  Future<PlaylistSong?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<PlaylistSongTable>? where,
    int? offset,
    _i1.OrderByBuilder<PlaylistSongTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PlaylistSongTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<PlaylistSong>(
      where: where?.call(PlaylistSong.t),
      orderBy: orderBy?.call(PlaylistSong.t),
      orderByList: orderByList?.call(PlaylistSong.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [PlaylistSong] by its [id] or null if no such row exists.
  Future<PlaylistSong?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<PlaylistSong>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [PlaylistSong]s in the list and returns the inserted rows.
  ///
  /// The returned [PlaylistSong]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<PlaylistSong>> insert(
    _i1.Session session,
    List<PlaylistSong> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<PlaylistSong>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [PlaylistSong] and returns the inserted row.
  ///
  /// The returned [PlaylistSong] will have its `id` field set.
  Future<PlaylistSong> insertRow(
    _i1.Session session,
    PlaylistSong row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<PlaylistSong>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [PlaylistSong]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<PlaylistSong>> update(
    _i1.Session session,
    List<PlaylistSong> rows, {
    _i1.ColumnSelections<PlaylistSongTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<PlaylistSong>(
      rows,
      columns: columns?.call(PlaylistSong.t),
      transaction: transaction,
    );
  }

  /// Updates a single [PlaylistSong]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<PlaylistSong> updateRow(
    _i1.Session session,
    PlaylistSong row, {
    _i1.ColumnSelections<PlaylistSongTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<PlaylistSong>(
      row,
      columns: columns?.call(PlaylistSong.t),
      transaction: transaction,
    );
  }

  /// Updates a single [PlaylistSong] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<PlaylistSong?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<PlaylistSongUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<PlaylistSong>(
      id,
      columnValues: columnValues(PlaylistSong.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [PlaylistSong]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<PlaylistSong>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<PlaylistSongUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<PlaylistSongTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<PlaylistSongTable>? orderBy,
    _i1.OrderByListBuilder<PlaylistSongTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<PlaylistSong>(
      columnValues: columnValues(PlaylistSong.t.updateTable),
      where: where(PlaylistSong.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(PlaylistSong.t),
      orderByList: orderByList?.call(PlaylistSong.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [PlaylistSong]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<PlaylistSong>> delete(
    _i1.Session session,
    List<PlaylistSong> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<PlaylistSong>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [PlaylistSong].
  Future<PlaylistSong> deleteRow(
    _i1.Session session,
    PlaylistSong row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<PlaylistSong>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<PlaylistSong>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<PlaylistSongTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<PlaylistSong>(
      where: where(PlaylistSong.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<PlaylistSongTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<PlaylistSong>(
      where: where?.call(PlaylistSong.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
