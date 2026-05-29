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

abstract class PlayEvent
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
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

  static final t = PlayEventTable();

  static const db = PlayEventRepository._();

  @override
  int? id;

  _i1.UuidValue? userId;

  _i1.UuidValue songId;

  DateTime playedAt;

  int secondsListened;

  String? device;

  @override
  _i1.Table<int?> get table => t;

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
  Map<String, dynamic> toJsonForProtocol() {
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

  static PlayEventInclude include() {
    return PlayEventInclude._();
  }

  static PlayEventIncludeList includeList({
    _i1.WhereExpressionBuilder<PlayEventTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<PlayEventTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PlayEventTable>? orderByList,
    PlayEventInclude? include,
  }) {
    return PlayEventIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(PlayEvent.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(PlayEvent.t),
      include: include,
    );
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

class PlayEventUpdateTable extends _i1.UpdateTable<PlayEventTable> {
  PlayEventUpdateTable(super.table);

  _i1.ColumnValue<_i1.UuidValue, _i1.UuidValue> userId(_i1.UuidValue? value) =>
      _i1.ColumnValue(
        table.userId,
        value,
      );

  _i1.ColumnValue<_i1.UuidValue, _i1.UuidValue> songId(_i1.UuidValue value) =>
      _i1.ColumnValue(
        table.songId,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> playedAt(DateTime value) =>
      _i1.ColumnValue(
        table.playedAt,
        value,
      );

  _i1.ColumnValue<int, int> secondsListened(int value) => _i1.ColumnValue(
    table.secondsListened,
    value,
  );

  _i1.ColumnValue<String, String> device(String? value) => _i1.ColumnValue(
    table.device,
    value,
  );
}

class PlayEventTable extends _i1.Table<int?> {
  PlayEventTable({super.tableRelation}) : super(tableName: 'play_events') {
    updateTable = PlayEventUpdateTable(this);
    userId = _i1.ColumnUuid(
      'userId',
      this,
    );
    songId = _i1.ColumnUuid(
      'songId',
      this,
    );
    playedAt = _i1.ColumnDateTime(
      'playedAt',
      this,
    );
    secondsListened = _i1.ColumnInt(
      'secondsListened',
      this,
    );
    device = _i1.ColumnString(
      'device',
      this,
    );
  }

  late final PlayEventUpdateTable updateTable;

  late final _i1.ColumnUuid userId;

  late final _i1.ColumnUuid songId;

  late final _i1.ColumnDateTime playedAt;

  late final _i1.ColumnInt secondsListened;

  late final _i1.ColumnString device;

  @override
  List<_i1.Column> get columns => [
    id,
    userId,
    songId,
    playedAt,
    secondsListened,
    device,
  ];
}

class PlayEventInclude extends _i1.IncludeObject {
  PlayEventInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => PlayEvent.t;
}

class PlayEventIncludeList extends _i1.IncludeList {
  PlayEventIncludeList._({
    _i1.WhereExpressionBuilder<PlayEventTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(PlayEvent.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => PlayEvent.t;
}

class PlayEventRepository {
  const PlayEventRepository._();

  /// Returns a list of [PlayEvent]s matching the given query parameters.
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
  Future<List<PlayEvent>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<PlayEventTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<PlayEventTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PlayEventTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<PlayEvent>(
      where: where?.call(PlayEvent.t),
      orderBy: orderBy?.call(PlayEvent.t),
      orderByList: orderByList?.call(PlayEvent.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [PlayEvent] matching the given query parameters.
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
  Future<PlayEvent?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<PlayEventTable>? where,
    int? offset,
    _i1.OrderByBuilder<PlayEventTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PlayEventTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<PlayEvent>(
      where: where?.call(PlayEvent.t),
      orderBy: orderBy?.call(PlayEvent.t),
      orderByList: orderByList?.call(PlayEvent.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [PlayEvent] by its [id] or null if no such row exists.
  Future<PlayEvent?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<PlayEvent>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [PlayEvent]s in the list and returns the inserted rows.
  ///
  /// The returned [PlayEvent]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<PlayEvent>> insert(
    _i1.Session session,
    List<PlayEvent> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<PlayEvent>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [PlayEvent] and returns the inserted row.
  ///
  /// The returned [PlayEvent] will have its `id` field set.
  Future<PlayEvent> insertRow(
    _i1.Session session,
    PlayEvent row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<PlayEvent>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [PlayEvent]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<PlayEvent>> update(
    _i1.Session session,
    List<PlayEvent> rows, {
    _i1.ColumnSelections<PlayEventTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<PlayEvent>(
      rows,
      columns: columns?.call(PlayEvent.t),
      transaction: transaction,
    );
  }

  /// Updates a single [PlayEvent]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<PlayEvent> updateRow(
    _i1.Session session,
    PlayEvent row, {
    _i1.ColumnSelections<PlayEventTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<PlayEvent>(
      row,
      columns: columns?.call(PlayEvent.t),
      transaction: transaction,
    );
  }

  /// Updates a single [PlayEvent] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<PlayEvent?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<PlayEventUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<PlayEvent>(
      id,
      columnValues: columnValues(PlayEvent.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [PlayEvent]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<PlayEvent>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<PlayEventUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<PlayEventTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<PlayEventTable>? orderBy,
    _i1.OrderByListBuilder<PlayEventTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<PlayEvent>(
      columnValues: columnValues(PlayEvent.t.updateTable),
      where: where(PlayEvent.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(PlayEvent.t),
      orderByList: orderByList?.call(PlayEvent.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [PlayEvent]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<PlayEvent>> delete(
    _i1.Session session,
    List<PlayEvent> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<PlayEvent>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [PlayEvent].
  Future<PlayEvent> deleteRow(
    _i1.Session session,
    PlayEvent row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<PlayEvent>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<PlayEvent>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<PlayEventTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<PlayEvent>(
      where: where(PlayEvent.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<PlayEventTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<PlayEvent>(
      where: where?.call(PlayEvent.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
