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

abstract class UserFavorite
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  UserFavorite._({
    this.id,
    required this.userId,
    required this.songId,
    required this.createdAt,
  });

  factory UserFavorite({
    int? id,
    required _i1.UuidValue userId,
    required _i1.UuidValue songId,
    required DateTime createdAt,
  }) = _UserFavoriteImpl;

  factory UserFavorite.fromJson(Map<String, dynamic> jsonSerialization) {
    return UserFavorite(
      id: jsonSerialization['id'] as int?,
      userId: _i1.UuidValueJsonExtension.fromJson(jsonSerialization['userId']),
      songId: _i1.UuidValueJsonExtension.fromJson(jsonSerialization['songId']),
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  static final t = UserFavoriteTable();

  static const db = UserFavoriteRepository._();

  @override
  int? id;

  _i1.UuidValue userId;

  _i1.UuidValue songId;

  DateTime createdAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [UserFavorite]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  UserFavorite copyWith({
    int? id,
    _i1.UuidValue? userId,
    _i1.UuidValue? songId,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'UserFavorite',
      if (id != null) 'id': id,
      'userId': userId.toJson(),
      'songId': songId.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'UserFavorite',
      if (id != null) 'id': id,
      'userId': userId.toJson(),
      'songId': songId.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  static UserFavoriteInclude include() {
    return UserFavoriteInclude._();
  }

  static UserFavoriteIncludeList includeList({
    _i1.WhereExpressionBuilder<UserFavoriteTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<UserFavoriteTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<UserFavoriteTable>? orderByList,
    UserFavoriteInclude? include,
  }) {
    return UserFavoriteIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(UserFavorite.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(UserFavorite.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _UserFavoriteImpl extends UserFavorite {
  _UserFavoriteImpl({
    int? id,
    required _i1.UuidValue userId,
    required _i1.UuidValue songId,
    required DateTime createdAt,
  }) : super._(
         id: id,
         userId: userId,
         songId: songId,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [UserFavorite]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  UserFavorite copyWith({
    Object? id = _Undefined,
    _i1.UuidValue? userId,
    _i1.UuidValue? songId,
    DateTime? createdAt,
  }) {
    return UserFavorite(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      songId: songId ?? this.songId,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class UserFavoriteUpdateTable extends _i1.UpdateTable<UserFavoriteTable> {
  UserFavoriteUpdateTable(super.table);

  _i1.ColumnValue<_i1.UuidValue, _i1.UuidValue> userId(_i1.UuidValue value) =>
      _i1.ColumnValue(
        table.userId,
        value,
      );

  _i1.ColumnValue<_i1.UuidValue, _i1.UuidValue> songId(_i1.UuidValue value) =>
      _i1.ColumnValue(
        table.songId,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _i1.ColumnValue(
        table.createdAt,
        value,
      );
}

class UserFavoriteTable extends _i1.Table<int?> {
  UserFavoriteTable({super.tableRelation})
    : super(tableName: 'user_favorites') {
    updateTable = UserFavoriteUpdateTable(this);
    userId = _i1.ColumnUuid(
      'userId',
      this,
    );
    songId = _i1.ColumnUuid(
      'songId',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
    );
  }

  late final UserFavoriteUpdateTable updateTable;

  late final _i1.ColumnUuid userId;

  late final _i1.ColumnUuid songId;

  late final _i1.ColumnDateTime createdAt;

  @override
  List<_i1.Column> get columns => [
    id,
    userId,
    songId,
    createdAt,
  ];
}

class UserFavoriteInclude extends _i1.IncludeObject {
  UserFavoriteInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => UserFavorite.t;
}

class UserFavoriteIncludeList extends _i1.IncludeList {
  UserFavoriteIncludeList._({
    _i1.WhereExpressionBuilder<UserFavoriteTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(UserFavorite.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => UserFavorite.t;
}

class UserFavoriteRepository {
  const UserFavoriteRepository._();

  /// Returns a list of [UserFavorite]s matching the given query parameters.
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
  Future<List<UserFavorite>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<UserFavoriteTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<UserFavoriteTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<UserFavoriteTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<UserFavorite>(
      where: where?.call(UserFavorite.t),
      orderBy: orderBy?.call(UserFavorite.t),
      orderByList: orderByList?.call(UserFavorite.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [UserFavorite] matching the given query parameters.
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
  Future<UserFavorite?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<UserFavoriteTable>? where,
    int? offset,
    _i1.OrderByBuilder<UserFavoriteTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<UserFavoriteTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<UserFavorite>(
      where: where?.call(UserFavorite.t),
      orderBy: orderBy?.call(UserFavorite.t),
      orderByList: orderByList?.call(UserFavorite.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [UserFavorite] by its [id] or null if no such row exists.
  Future<UserFavorite?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<UserFavorite>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [UserFavorite]s in the list and returns the inserted rows.
  ///
  /// The returned [UserFavorite]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<UserFavorite>> insert(
    _i1.Session session,
    List<UserFavorite> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<UserFavorite>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [UserFavorite] and returns the inserted row.
  ///
  /// The returned [UserFavorite] will have its `id` field set.
  Future<UserFavorite> insertRow(
    _i1.Session session,
    UserFavorite row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<UserFavorite>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [UserFavorite]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<UserFavorite>> update(
    _i1.Session session,
    List<UserFavorite> rows, {
    _i1.ColumnSelections<UserFavoriteTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<UserFavorite>(
      rows,
      columns: columns?.call(UserFavorite.t),
      transaction: transaction,
    );
  }

  /// Updates a single [UserFavorite]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<UserFavorite> updateRow(
    _i1.Session session,
    UserFavorite row, {
    _i1.ColumnSelections<UserFavoriteTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<UserFavorite>(
      row,
      columns: columns?.call(UserFavorite.t),
      transaction: transaction,
    );
  }

  /// Updates a single [UserFavorite] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<UserFavorite?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<UserFavoriteUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<UserFavorite>(
      id,
      columnValues: columnValues(UserFavorite.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [UserFavorite]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<UserFavorite>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<UserFavoriteUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<UserFavoriteTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<UserFavoriteTable>? orderBy,
    _i1.OrderByListBuilder<UserFavoriteTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<UserFavorite>(
      columnValues: columnValues(UserFavorite.t.updateTable),
      where: where(UserFavorite.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(UserFavorite.t),
      orderByList: orderByList?.call(UserFavorite.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [UserFavorite]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<UserFavorite>> delete(
    _i1.Session session,
    List<UserFavorite> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<UserFavorite>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [UserFavorite].
  Future<UserFavorite> deleteRow(
    _i1.Session session,
    UserFavorite row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<UserFavorite>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<UserFavorite>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<UserFavoriteTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<UserFavorite>(
      where: where(UserFavorite.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<UserFavoriteTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<UserFavorite>(
      where: where?.call(UserFavorite.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
