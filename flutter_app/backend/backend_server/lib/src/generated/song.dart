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

abstract class Song
    implements _i1.TableRow<_i1.UuidValue>, _i1.ProtocolSerialization {
  Song._({
    _i1.UuidValue? id,
    required this.title,
    required this.artistId,
    this.albumId,
    required this.durationSec,
    this.genre,
    this.audioUrl,
    this.coverUrl,
    required this.streams,
    required this.createdAt,
  }) : id = id ?? _i1.Uuid().v4obj();

  factory Song({
    _i1.UuidValue? id,
    required String title,
    required _i1.UuidValue artistId,
    _i1.UuidValue? albumId,
    required int durationSec,
    String? genre,
    String? audioUrl,
    String? coverUrl,
    required int streams,
    required DateTime createdAt,
  }) = _SongImpl;

  factory Song.fromJson(Map<String, dynamic> jsonSerialization) {
    return Song(
      id: _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      title: jsonSerialization['title'] as String,
      artistId: _i1.UuidValueJsonExtension.fromJson(
        jsonSerialization['artistId'],
      ),
      albumId: jsonSerialization['albumId'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['albumId']),
      durationSec: jsonSerialization['durationSec'] as int,
      genre: jsonSerialization['genre'] as String?,
      audioUrl: jsonSerialization['audioUrl'] as String?,
      coverUrl: jsonSerialization['coverUrl'] as String?,
      streams: jsonSerialization['streams'] as int,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  static final t = SongTable();

  static const db = SongRepository._();

  @override
  _i1.UuidValue id;

  String title;

  _i1.UuidValue artistId;

  _i1.UuidValue? albumId;

  int durationSec;

  String? genre;

  String? audioUrl;

  String? coverUrl;

  int streams;

  DateTime createdAt;

  @override
  _i1.Table<_i1.UuidValue> get table => t;

  /// Returns a shallow copy of this [Song]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Song copyWith({
    _i1.UuidValue? id,
    String? title,
    _i1.UuidValue? artistId,
    _i1.UuidValue? albumId,
    int? durationSec,
    String? genre,
    String? audioUrl,
    String? coverUrl,
    int? streams,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Song',
      'id': id.toJson(),
      'title': title,
      'artistId': artistId.toJson(),
      if (albumId != null) 'albumId': albumId?.toJson(),
      'durationSec': durationSec,
      if (genre != null) 'genre': genre,
      if (audioUrl != null) 'audioUrl': audioUrl,
      if (coverUrl != null) 'coverUrl': coverUrl,
      'streams': streams,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Song',
      'id': id.toJson(),
      'title': title,
      'artistId': artistId.toJson(),
      if (albumId != null) 'albumId': albumId?.toJson(),
      'durationSec': durationSec,
      if (genre != null) 'genre': genre,
      if (audioUrl != null) 'audioUrl': audioUrl,
      if (coverUrl != null) 'coverUrl': coverUrl,
      'streams': streams,
      'createdAt': createdAt.toJson(),
    };
  }

  static SongInclude include() {
    return SongInclude._();
  }

  static SongIncludeList includeList({
    _i1.WhereExpressionBuilder<SongTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SongTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SongTable>? orderByList,
    SongInclude? include,
  }) {
    return SongIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Song.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Song.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SongImpl extends Song {
  _SongImpl({
    _i1.UuidValue? id,
    required String title,
    required _i1.UuidValue artistId,
    _i1.UuidValue? albumId,
    required int durationSec,
    String? genre,
    String? audioUrl,
    String? coverUrl,
    required int streams,
    required DateTime createdAt,
  }) : super._(
         id: id,
         title: title,
         artistId: artistId,
         albumId: albumId,
         durationSec: durationSec,
         genre: genre,
         audioUrl: audioUrl,
         coverUrl: coverUrl,
         streams: streams,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [Song]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Song copyWith({
    _i1.UuidValue? id,
    String? title,
    _i1.UuidValue? artistId,
    Object? albumId = _Undefined,
    int? durationSec,
    Object? genre = _Undefined,
    Object? audioUrl = _Undefined,
    Object? coverUrl = _Undefined,
    int? streams,
    DateTime? createdAt,
  }) {
    return Song(
      id: id ?? this.id,
      title: title ?? this.title,
      artistId: artistId ?? this.artistId,
      albumId: albumId is _i1.UuidValue? ? albumId : this.albumId,
      durationSec: durationSec ?? this.durationSec,
      genre: genre is String? ? genre : this.genre,
      audioUrl: audioUrl is String? ? audioUrl : this.audioUrl,
      coverUrl: coverUrl is String? ? coverUrl : this.coverUrl,
      streams: streams ?? this.streams,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class SongUpdateTable extends _i1.UpdateTable<SongTable> {
  SongUpdateTable(super.table);

  _i1.ColumnValue<String, String> title(String value) => _i1.ColumnValue(
    table.title,
    value,
  );

  _i1.ColumnValue<_i1.UuidValue, _i1.UuidValue> artistId(_i1.UuidValue value) =>
      _i1.ColumnValue(
        table.artistId,
        value,
      );

  _i1.ColumnValue<_i1.UuidValue, _i1.UuidValue> albumId(_i1.UuidValue? value) =>
      _i1.ColumnValue(
        table.albumId,
        value,
      );

  _i1.ColumnValue<int, int> durationSec(int value) => _i1.ColumnValue(
    table.durationSec,
    value,
  );

  _i1.ColumnValue<String, String> genre(String? value) => _i1.ColumnValue(
    table.genre,
    value,
  );

  _i1.ColumnValue<String, String> audioUrl(String? value) => _i1.ColumnValue(
    table.audioUrl,
    value,
  );

  _i1.ColumnValue<String, String> coverUrl(String? value) => _i1.ColumnValue(
    table.coverUrl,
    value,
  );

  _i1.ColumnValue<int, int> streams(int value) => _i1.ColumnValue(
    table.streams,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _i1.ColumnValue(
        table.createdAt,
        value,
      );
}

class SongTable extends _i1.Table<_i1.UuidValue> {
  SongTable({super.tableRelation}) : super(tableName: 'songs') {
    updateTable = SongUpdateTable(this);
    title = _i1.ColumnString(
      'title',
      this,
    );
    artistId = _i1.ColumnUuid(
      'artistId',
      this,
    );
    albumId = _i1.ColumnUuid(
      'albumId',
      this,
    );
    durationSec = _i1.ColumnInt(
      'durationSec',
      this,
    );
    genre = _i1.ColumnString(
      'genre',
      this,
    );
    audioUrl = _i1.ColumnString(
      'audioUrl',
      this,
    );
    coverUrl = _i1.ColumnString(
      'coverUrl',
      this,
    );
    streams = _i1.ColumnInt(
      'streams',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
    );
  }

  late final SongUpdateTable updateTable;

  late final _i1.ColumnString title;

  late final _i1.ColumnUuid artistId;

  late final _i1.ColumnUuid albumId;

  late final _i1.ColumnInt durationSec;

  late final _i1.ColumnString genre;

  late final _i1.ColumnString audioUrl;

  late final _i1.ColumnString coverUrl;

  late final _i1.ColumnInt streams;

  late final _i1.ColumnDateTime createdAt;

  @override
  List<_i1.Column> get columns => [
    id,
    title,
    artistId,
    albumId,
    durationSec,
    genre,
    audioUrl,
    coverUrl,
    streams,
    createdAt,
  ];
}

class SongInclude extends _i1.IncludeObject {
  SongInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<_i1.UuidValue> get table => Song.t;
}

class SongIncludeList extends _i1.IncludeList {
  SongIncludeList._({
    _i1.WhereExpressionBuilder<SongTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Song.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<_i1.UuidValue> get table => Song.t;
}

class SongRepository {
  const SongRepository._();

  /// Returns a list of [Song]s matching the given query parameters.
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
  Future<List<Song>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SongTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SongTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SongTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<Song>(
      where: where?.call(Song.t),
      orderBy: orderBy?.call(Song.t),
      orderByList: orderByList?.call(Song.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [Song] matching the given query parameters.
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
  Future<Song?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SongTable>? where,
    int? offset,
    _i1.OrderByBuilder<SongTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SongTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<Song>(
      where: where?.call(Song.t),
      orderBy: orderBy?.call(Song.t),
      orderByList: orderByList?.call(Song.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [Song] by its [id] or null if no such row exists.
  Future<Song?> findById(
    _i1.Session session,
    _i1.UuidValue id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<Song>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [Song]s in the list and returns the inserted rows.
  ///
  /// The returned [Song]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<Song>> insert(
    _i1.Session session,
    List<Song> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<Song>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [Song] and returns the inserted row.
  ///
  /// The returned [Song] will have its `id` field set.
  Future<Song> insertRow(
    _i1.Session session,
    Song row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Song>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Song]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Song>> update(
    _i1.Session session,
    List<Song> rows, {
    _i1.ColumnSelections<SongTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Song>(
      rows,
      columns: columns?.call(Song.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Song]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Song> updateRow(
    _i1.Session session,
    Song row, {
    _i1.ColumnSelections<SongTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Song>(
      row,
      columns: columns?.call(Song.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Song] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Song?> updateById(
    _i1.Session session,
    _i1.UuidValue id, {
    required _i1.ColumnValueListBuilder<SongUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<Song>(
      id,
      columnValues: columnValues(Song.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Song]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<Song>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<SongUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<SongTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SongTable>? orderBy,
    _i1.OrderByListBuilder<SongTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<Song>(
      columnValues: columnValues(Song.t.updateTable),
      where: where(Song.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Song.t),
      orderByList: orderByList?.call(Song.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [Song]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Song>> delete(
    _i1.Session session,
    List<Song> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Song>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Song].
  Future<Song> deleteRow(
    _i1.Session session,
    Song row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Song>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Song>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<SongTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Song>(
      where: where(Song.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SongTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Song>(
      where: where?.call(Song.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
