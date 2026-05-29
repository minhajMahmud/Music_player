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

abstract class Artist
    implements _i1.TableRow<_i1.UuidValue>, _i1.ProtocolSerialization {
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

  static final t = ArtistTable();

  static const db = ArtistRepository._();

  @override
  _i1.UuidValue id;

  String name;

  String? genre;

  int monthlyListeners;

  DateTime createdAt;

  @override
  _i1.Table<_i1.UuidValue> get table => t;

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
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Artist',
      'id': id.toJson(),
      'name': name,
      if (genre != null) 'genre': genre,
      'monthlyListeners': monthlyListeners,
      'createdAt': createdAt.toJson(),
    };
  }

  static ArtistInclude include() {
    return ArtistInclude._();
  }

  static ArtistIncludeList includeList({
    _i1.WhereExpressionBuilder<ArtistTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ArtistTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ArtistTable>? orderByList,
    ArtistInclude? include,
  }) {
    return ArtistIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Artist.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Artist.t),
      include: include,
    );
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

class ArtistUpdateTable extends _i1.UpdateTable<ArtistTable> {
  ArtistUpdateTable(super.table);

  _i1.ColumnValue<String, String> name(String value) => _i1.ColumnValue(
    table.name,
    value,
  );

  _i1.ColumnValue<String, String> genre(String? value) => _i1.ColumnValue(
    table.genre,
    value,
  );

  _i1.ColumnValue<int, int> monthlyListeners(int value) => _i1.ColumnValue(
    table.monthlyListeners,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _i1.ColumnValue(
        table.createdAt,
        value,
      );
}

class ArtistTable extends _i1.Table<_i1.UuidValue> {
  ArtistTable({super.tableRelation}) : super(tableName: 'artists') {
    updateTable = ArtistUpdateTable(this);
    name = _i1.ColumnString(
      'name',
      this,
    );
    genre = _i1.ColumnString(
      'genre',
      this,
    );
    monthlyListeners = _i1.ColumnInt(
      'monthlyListeners',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
    );
  }

  late final ArtistUpdateTable updateTable;

  late final _i1.ColumnString name;

  late final _i1.ColumnString genre;

  late final _i1.ColumnInt monthlyListeners;

  late final _i1.ColumnDateTime createdAt;

  @override
  List<_i1.Column> get columns => [
    id,
    name,
    genre,
    monthlyListeners,
    createdAt,
  ];
}

class ArtistInclude extends _i1.IncludeObject {
  ArtistInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<_i1.UuidValue> get table => Artist.t;
}

class ArtistIncludeList extends _i1.IncludeList {
  ArtistIncludeList._({
    _i1.WhereExpressionBuilder<ArtistTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Artist.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<_i1.UuidValue> get table => Artist.t;
}

class ArtistRepository {
  const ArtistRepository._();

  /// Returns a list of [Artist]s matching the given query parameters.
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
  Future<List<Artist>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ArtistTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ArtistTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ArtistTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<Artist>(
      where: where?.call(Artist.t),
      orderBy: orderBy?.call(Artist.t),
      orderByList: orderByList?.call(Artist.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [Artist] matching the given query parameters.
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
  Future<Artist?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ArtistTable>? where,
    int? offset,
    _i1.OrderByBuilder<ArtistTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ArtistTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<Artist>(
      where: where?.call(Artist.t),
      orderBy: orderBy?.call(Artist.t),
      orderByList: orderByList?.call(Artist.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [Artist] by its [id] or null if no such row exists.
  Future<Artist?> findById(
    _i1.Session session,
    _i1.UuidValue id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<Artist>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [Artist]s in the list and returns the inserted rows.
  ///
  /// The returned [Artist]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<Artist>> insert(
    _i1.Session session,
    List<Artist> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<Artist>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [Artist] and returns the inserted row.
  ///
  /// The returned [Artist] will have its `id` field set.
  Future<Artist> insertRow(
    _i1.Session session,
    Artist row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Artist>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Artist]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Artist>> update(
    _i1.Session session,
    List<Artist> rows, {
    _i1.ColumnSelections<ArtistTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Artist>(
      rows,
      columns: columns?.call(Artist.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Artist]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Artist> updateRow(
    _i1.Session session,
    Artist row, {
    _i1.ColumnSelections<ArtistTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Artist>(
      row,
      columns: columns?.call(Artist.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Artist] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Artist?> updateById(
    _i1.Session session,
    _i1.UuidValue id, {
    required _i1.ColumnValueListBuilder<ArtistUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<Artist>(
      id,
      columnValues: columnValues(Artist.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Artist]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<Artist>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<ArtistUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<ArtistTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ArtistTable>? orderBy,
    _i1.OrderByListBuilder<ArtistTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<Artist>(
      columnValues: columnValues(Artist.t.updateTable),
      where: where(Artist.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Artist.t),
      orderByList: orderByList?.call(Artist.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [Artist]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Artist>> delete(
    _i1.Session session,
    List<Artist> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Artist>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Artist].
  Future<Artist> deleteRow(
    _i1.Session session,
    Artist row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Artist>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Artist>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<ArtistTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Artist>(
      where: where(Artist.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ArtistTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Artist>(
      where: where?.call(Artist.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
