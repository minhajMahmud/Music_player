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

abstract class Album
    implements _i1.TableRow<_i1.UuidValue>, _i1.ProtocolSerialization {
  Album._({
    _i1.UuidValue? id,
    required this.title,
    required this.artistId,
    this.releaseYear,
    this.coverUrl,
    required this.trackCount,
    required this.createdAt,
  }) : id = id ?? _i1.Uuid().v4obj();

  factory Album({
    _i1.UuidValue? id,
    required String title,
    required _i1.UuidValue artistId,
    int? releaseYear,
    String? coverUrl,
    required int trackCount,
    required DateTime createdAt,
  }) = _AlbumImpl;

  factory Album.fromJson(Map<String, dynamic> jsonSerialization) {
    return Album(
      id: _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      title: jsonSerialization['title'] as String,
      artistId: _i1.UuidValueJsonExtension.fromJson(
        jsonSerialization['artistId'],
      ),
      releaseYear: jsonSerialization['releaseYear'] as int?,
      coverUrl: jsonSerialization['coverUrl'] as String?,
      trackCount: jsonSerialization['trackCount'] as int,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  static final t = AlbumTable();

  static const db = AlbumRepository._();

  @override
  _i1.UuidValue id;

  String title;

  _i1.UuidValue artistId;

  int? releaseYear;

  String? coverUrl;

  int trackCount;

  DateTime createdAt;

  @override
  _i1.Table<_i1.UuidValue> get table => t;

  /// Returns a shallow copy of this [Album]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Album copyWith({
    _i1.UuidValue? id,
    String? title,
    _i1.UuidValue? artistId,
    int? releaseYear,
    String? coverUrl,
    int? trackCount,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Album',
      'id': id.toJson(),
      'title': title,
      'artistId': artistId.toJson(),
      if (releaseYear != null) 'releaseYear': releaseYear,
      if (coverUrl != null) 'coverUrl': coverUrl,
      'trackCount': trackCount,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Album',
      'id': id.toJson(),
      'title': title,
      'artistId': artistId.toJson(),
      if (releaseYear != null) 'releaseYear': releaseYear,
      if (coverUrl != null) 'coverUrl': coverUrl,
      'trackCount': trackCount,
      'createdAt': createdAt.toJson(),
    };
  }

  static AlbumInclude include() {
    return AlbumInclude._();
  }

  static AlbumIncludeList includeList({
    _i1.WhereExpressionBuilder<AlbumTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AlbumTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AlbumTable>? orderByList,
    AlbumInclude? include,
  }) {
    return AlbumIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Album.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Album.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AlbumImpl extends Album {
  _AlbumImpl({
    _i1.UuidValue? id,
    required String title,
    required _i1.UuidValue artistId,
    int? releaseYear,
    String? coverUrl,
    required int trackCount,
    required DateTime createdAt,
  }) : super._(
         id: id,
         title: title,
         artistId: artistId,
         releaseYear: releaseYear,
         coverUrl: coverUrl,
         trackCount: trackCount,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [Album]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Album copyWith({
    _i1.UuidValue? id,
    String? title,
    _i1.UuidValue? artistId,
    Object? releaseYear = _Undefined,
    Object? coverUrl = _Undefined,
    int? trackCount,
    DateTime? createdAt,
  }) {
    return Album(
      id: id ?? this.id,
      title: title ?? this.title,
      artistId: artistId ?? this.artistId,
      releaseYear: releaseYear is int? ? releaseYear : this.releaseYear,
      coverUrl: coverUrl is String? ? coverUrl : this.coverUrl,
      trackCount: trackCount ?? this.trackCount,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class AlbumUpdateTable extends _i1.UpdateTable<AlbumTable> {
  AlbumUpdateTable(super.table);

  _i1.ColumnValue<String, String> title(String value) => _i1.ColumnValue(
    table.title,
    value,
  );

  _i1.ColumnValue<_i1.UuidValue, _i1.UuidValue> artistId(_i1.UuidValue value) =>
      _i1.ColumnValue(
        table.artistId,
        value,
      );

  _i1.ColumnValue<int, int> releaseYear(int? value) => _i1.ColumnValue(
    table.releaseYear,
    value,
  );

  _i1.ColumnValue<String, String> coverUrl(String? value) => _i1.ColumnValue(
    table.coverUrl,
    value,
  );

  _i1.ColumnValue<int, int> trackCount(int value) => _i1.ColumnValue(
    table.trackCount,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _i1.ColumnValue(
        table.createdAt,
        value,
      );
}

class AlbumTable extends _i1.Table<_i1.UuidValue> {
  AlbumTable({super.tableRelation}) : super(tableName: 'albums') {
    updateTable = AlbumUpdateTable(this);
    title = _i1.ColumnString(
      'title',
      this,
    );
    artistId = _i1.ColumnUuid(
      'artistId',
      this,
    );
    releaseYear = _i1.ColumnInt(
      'releaseYear',
      this,
    );
    coverUrl = _i1.ColumnString(
      'coverUrl',
      this,
    );
    trackCount = _i1.ColumnInt(
      'trackCount',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
    );
  }

  late final AlbumUpdateTable updateTable;

  late final _i1.ColumnString title;

  late final _i1.ColumnUuid artistId;

  late final _i1.ColumnInt releaseYear;

  late final _i1.ColumnString coverUrl;

  late final _i1.ColumnInt trackCount;

  late final _i1.ColumnDateTime createdAt;

  @override
  List<_i1.Column> get columns => [
    id,
    title,
    artistId,
    releaseYear,
    coverUrl,
    trackCount,
    createdAt,
  ];
}

class AlbumInclude extends _i1.IncludeObject {
  AlbumInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<_i1.UuidValue> get table => Album.t;
}

class AlbumIncludeList extends _i1.IncludeList {
  AlbumIncludeList._({
    _i1.WhereExpressionBuilder<AlbumTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Album.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<_i1.UuidValue> get table => Album.t;
}

class AlbumRepository {
  const AlbumRepository._();

  /// Returns a list of [Album]s matching the given query parameters.
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
  Future<List<Album>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<AlbumTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AlbumTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AlbumTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<Album>(
      where: where?.call(Album.t),
      orderBy: orderBy?.call(Album.t),
      orderByList: orderByList?.call(Album.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [Album] matching the given query parameters.
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
  Future<Album?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<AlbumTable>? where,
    int? offset,
    _i1.OrderByBuilder<AlbumTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AlbumTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<Album>(
      where: where?.call(Album.t),
      orderBy: orderBy?.call(Album.t),
      orderByList: orderByList?.call(Album.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [Album] by its [id] or null if no such row exists.
  Future<Album?> findById(
    _i1.Session session,
    _i1.UuidValue id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<Album>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [Album]s in the list and returns the inserted rows.
  ///
  /// The returned [Album]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<Album>> insert(
    _i1.Session session,
    List<Album> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<Album>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [Album] and returns the inserted row.
  ///
  /// The returned [Album] will have its `id` field set.
  Future<Album> insertRow(
    _i1.Session session,
    Album row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Album>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Album]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Album>> update(
    _i1.Session session,
    List<Album> rows, {
    _i1.ColumnSelections<AlbumTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Album>(
      rows,
      columns: columns?.call(Album.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Album]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Album> updateRow(
    _i1.Session session,
    Album row, {
    _i1.ColumnSelections<AlbumTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Album>(
      row,
      columns: columns?.call(Album.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Album] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Album?> updateById(
    _i1.Session session,
    _i1.UuidValue id, {
    required _i1.ColumnValueListBuilder<AlbumUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<Album>(
      id,
      columnValues: columnValues(Album.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Album]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<Album>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<AlbumUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<AlbumTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AlbumTable>? orderBy,
    _i1.OrderByListBuilder<AlbumTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<Album>(
      columnValues: columnValues(Album.t.updateTable),
      where: where(Album.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Album.t),
      orderByList: orderByList?.call(Album.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [Album]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Album>> delete(
    _i1.Session session,
    List<Album> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Album>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Album].
  Future<Album> deleteRow(
    _i1.Session session,
    Album row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Album>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Album>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<AlbumTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Album>(
      where: where(Album.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<AlbumTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Album>(
      where: where?.call(Album.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
