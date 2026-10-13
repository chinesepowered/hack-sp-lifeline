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
import 'package:serverpod/serverpod.dart' as _is;
import '../enums/event_kind.dart' as _ie2bfe8q;

/// An entry in the circle's activity timeline.
abstract class CircleEvent
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  CircleEvent._({
    this.id,
    required this.circleId,
    required this.kind,
    required this.title,
    this.detail,
    this.actorName,
    this.checkInId,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory CircleEvent({
    int? id,
    required int circleId,
    required _ie2bfe8q.EventKind kind,
    required String title,
    String? detail,
    String? actorName,
    int? checkInId,
    DateTime? createdAt,
  }) = _CircleEventImpl;

  factory CircleEvent.fromJson(Map<String, dynamic> jsonSerialization) {
    return CircleEvent(
      id: jsonSerialization['id'] as int?,
      circleId: jsonSerialization['circleId'] as int,
      kind: _ie2bfe8q.EventKind.fromJson((jsonSerialization['kind'] as String)),
      title: jsonSerialization['title'] as String,
      detail: jsonSerialization['detail'] as String?,
      actorName: jsonSerialization['actorName'] as String?,
      checkInId: jsonSerialization['checkInId'] as int?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  static final t = CircleEventTable();

  static const db = CircleEventRepository._();

  @override
  int? id;

  int circleId;

  _ie2bfe8q.EventKind kind;

  String title;

  String? detail;

  String? actorName;

  int? checkInId;

  DateTime createdAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [CircleEvent]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  CircleEvent copyWith({
    int? id,
    int? circleId,
    _ie2bfe8q.EventKind? kind,
    String? title,
    String? detail,
    String? actorName,
    int? checkInId,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CircleEvent',
      if (id != null) 'id': id,
      'circleId': circleId,
      'kind': kind.toJson(),
      'title': title,
      if (detail != null) 'detail': detail,
      if (actorName != null) 'actorName': actorName,
      if (checkInId != null) 'checkInId': checkInId,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CircleEvent',
      if (id != null) 'id': id,
      'circleId': circleId,
      'kind': kind.toJson(),
      'title': title,
      if (detail != null) 'detail': detail,
      if (actorName != null) 'actorName': actorName,
      if (checkInId != null) 'checkInId': checkInId,
      'createdAt': createdAt.toJson(),
    };
  }

  static CircleEventInclude include() {
    return CircleEventInclude._();
  }

  static CircleEventIncludeList includeList({
    _is.WhereExpressionBuilder<CircleEventTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<CircleEventTable>? orderBy,
    _is.OrderByListBuilder<CircleEventTable>? orderByList,
    CircleEventInclude? include,
  }) {
    return CircleEventIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(CircleEvent.t),
      orderByList: orderByList?.call(CircleEvent.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CircleEventImpl extends CircleEvent {
  _CircleEventImpl({
    int? id,
    required int circleId,
    required _ie2bfe8q.EventKind kind,
    required String title,
    String? detail,
    String? actorName,
    int? checkInId,
    DateTime? createdAt,
  }) : super._(
         id: id,
         circleId: circleId,
         kind: kind,
         title: title,
         detail: detail,
         actorName: actorName,
         checkInId: checkInId,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [CircleEvent]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  CircleEvent copyWith({
    Object? id = _Undefined,
    int? circleId,
    _ie2bfe8q.EventKind? kind,
    String? title,
    Object? detail = _Undefined,
    Object? actorName = _Undefined,
    Object? checkInId = _Undefined,
    DateTime? createdAt,
  }) {
    return CircleEvent(
      id: id is int? ? id : this.id,
      circleId: circleId ?? this.circleId,
      kind: kind ?? this.kind,
      title: title ?? this.title,
      detail: detail is String? ? detail : this.detail,
      actorName: actorName is String? ? actorName : this.actorName,
      checkInId: checkInId is int? ? checkInId : this.checkInId,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class CircleEventUpdateTable extends _is.UpdateTable<CircleEventTable> {
  CircleEventUpdateTable(super.table);

  _is.ColumnValue<int, int> circleId(int value) => _is.ColumnValue(
    table.circleId,
    value,
  );

  _is.ColumnValue<_ie2bfe8q.EventKind, _ie2bfe8q.EventKind> kind(
    _ie2bfe8q.EventKind value,
  ) => _is.ColumnValue(
    table.kind,
    value,
  );

  _is.ColumnValue<String, String> title(String value) => _is.ColumnValue(
    table.title,
    value,
  );

  _is.ColumnValue<String, String> detail(String? value) => _is.ColumnValue(
    table.detail,
    value,
  );

  _is.ColumnValue<String, String> actorName(String? value) => _is.ColumnValue(
    table.actorName,
    value,
  );

  _is.ColumnValue<int, int> checkInId(int? value) => _is.ColumnValue(
    table.checkInId,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );
}

class CircleEventTable extends _is.Table<int?> {
  CircleEventTable({super.tableRelation}) : super(tableName: 'circle_event') {
    updateTable = CircleEventUpdateTable(this);
    circleId = _is.ColumnInt(
      'circleId',
      this,
    );
    kind = _is.ColumnEnum(
      'kind',
      this,
      _is.EnumSerialization.byName,
    );
    title = _is.ColumnString(
      'title',
      this,
    );
    detail = _is.ColumnString(
      'detail',
      this,
    );
    actorName = _is.ColumnString(
      'actorName',
      this,
    );
    checkInId = _is.ColumnInt(
      'checkInId',
      this,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
  }

  late final CircleEventUpdateTable updateTable;

  late final _is.ColumnInt circleId;

  late final _is.ColumnEnum<_ie2bfe8q.EventKind> kind;

  late final _is.ColumnString title;

  late final _is.ColumnString detail;

  late final _is.ColumnString actorName;

  late final _is.ColumnInt checkInId;

  late final _is.ColumnDateTime createdAt;

  @override
  List<_is.Column> get columns => [
    id,
    circleId,
    kind,
    title,
    detail,
    actorName,
    checkInId,
    createdAt,
  ];
}

class CircleEventInclude extends _is.IncludeObject {
  CircleEventInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => CircleEvent.t;
}

class CircleEventIncludeList extends _is.IncludeList {
  CircleEventIncludeList._({
    _is.WhereExpressionBuilder<CircleEventTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(CircleEvent.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => CircleEvent.t;
}

class CircleEventRepository {
  const CircleEventRepository._();

  /// Returns a list of [CircleEvent]s matching the given query parameters.
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
  Future<List<CircleEvent>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<CircleEventTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<CircleEventTable>? orderBy,
    _is.OrderByListBuilder<CircleEventTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<CircleEvent>(
      where: where?.call(CircleEvent.t),
      orderBy: orderBy?.call(CircleEvent.t),
      orderByList: orderByList?.call(CircleEvent.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [CircleEvent] matching the given query parameters.
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
  Future<CircleEvent?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<CircleEventTable>? where,
    int? offset,
    _is.OrderByBuilder<CircleEventTable>? orderBy,
    _is.OrderByListBuilder<CircleEventTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<CircleEvent>(
      where: where?.call(CircleEvent.t),
      orderBy: orderBy?.call(CircleEvent.t),
      orderByList: orderByList?.call(CircleEvent.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [CircleEvent] by its [id] or null if no such row exists.
  Future<CircleEvent?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<CircleEvent>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [CircleEvent]s in the list and returns the inserted rows.
  ///
  /// The returned [CircleEvent]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  ///
  /// If [noReturn] is set to `true`, the inserted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<CircleEvent>> insert(
    _is.DatabaseSession session,
    List<CircleEvent> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<CircleEvent>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [CircleEvent] and returns the inserted row.
  ///
  /// The returned [CircleEvent] will have its `id` field set.
  Future<CircleEvent> insertRow(
    _is.DatabaseSession session,
    CircleEvent row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<CircleEvent>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [CircleEvent]s in the list and returns the resulting rows.
  ///
  /// If a row conflicts on the given [conflictColumns], the existing row is
  /// updated with the new values. Otherwise, a new row is inserted.
  ///
  /// If [updateColumns] is provided, only those columns will be updated on
  /// conflict. If null, all non-conflict, non-id columns are updated.
  ///
  /// If [updateWhere] is provided, the update only applies to rows matching the
  /// given expression. Conflicting rows that don't match are skipped and not
  /// returned, so the resulting list may be shorter than [rows].
  ///
  /// The returned [CircleEvent]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<CircleEvent>> upsert(
    _is.DatabaseSession session,
    List<CircleEvent> rows, {
    required _is.ColumnSelections<CircleEventTable> conflictColumns,
    _is.ColumnSelections<CircleEventTable>? updateColumns,
    _is.WhereExpressionBuilder<CircleEventTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<CircleEvent>(
      rows,
      conflictColumns: conflictColumns(CircleEvent.t),
      updateColumns: updateColumns?.call(CircleEvent.t),
      updateWhere: updateWhere?.call(CircleEvent.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [CircleEvent] and returns the resulting row.
  ///
  /// If the row conflicts on the given [conflictColumns], the existing row is
  /// updated. Otherwise, a new row is inserted.
  ///
  /// If [updateColumns] is provided, only those columns will be updated on
  /// conflict. If null, all non-conflict, non-id columns are updated.
  ///
  /// If [updateWhere] is provided, the update only applies when the existing
  /// row matches the expression. Returns `null` if no row was affected — for
  /// example when [updateWhere] does not match the conflicting row.
  ///
  /// The returned [CircleEvent] will have its `id` field set.
  Future<CircleEvent?> upsertRow(
    _is.DatabaseSession session,
    CircleEvent row, {
    required _is.ColumnSelections<CircleEventTable> conflictColumns,
    _is.ColumnSelections<CircleEventTable>? updateColumns,
    _is.WhereExpressionBuilder<CircleEventTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<CircleEvent>(
      row,
      conflictColumns: conflictColumns(CircleEvent.t),
      updateColumns: updateColumns?.call(CircleEvent.t),
      updateWhere: updateWhere?.call(CircleEvent.t),
      transaction: transaction,
    );
  }

  /// Updates all [CircleEvent]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<CircleEvent>> update(
    _is.DatabaseSession session,
    List<CircleEvent> rows, {
    _is.ColumnSelections<CircleEventTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<CircleEvent>(
      rows,
      columns: columns?.call(CircleEvent.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [CircleEvent]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<CircleEvent> updateRow(
    _is.DatabaseSession session,
    CircleEvent row, {
    _is.ColumnSelections<CircleEventTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<CircleEvent>(
      row,
      columns: columns?.call(CircleEvent.t),
      transaction: transaction,
    );
  }

  /// Updates a single [CircleEvent] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<CircleEvent?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<CircleEventUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<CircleEvent>(
      id,
      columnValues: columnValues(CircleEvent.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [CircleEvent]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<CircleEvent>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<CircleEventUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<CircleEventTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<CircleEventTable>? orderBy,
    _is.OrderByListBuilder<CircleEventTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<CircleEvent>(
      columnValues: columnValues(CircleEvent.t.updateTable),
      where: where(CircleEvent.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(CircleEvent.t),
      orderByList: orderByList?.call(CircleEvent.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [CircleEvent]s in the list and returns the deleted rows.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<CircleEvent>> delete(
    _is.DatabaseSession session,
    List<CircleEvent> rows, {
    _is.OrderByBuilder<CircleEventTable>? orderBy,
    _is.OrderByListBuilder<CircleEventTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<CircleEvent>(
      rows,
      orderBy: orderBy?.call(CircleEvent.t),
      orderByList: orderByList?.call(CircleEvent.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [CircleEvent].
  Future<CircleEvent> deleteRow(
    _is.DatabaseSession session,
    CircleEvent row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<CircleEvent>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<CircleEvent>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<CircleEventTable> where,
    _is.OrderByBuilder<CircleEventTable>? orderBy,
    _is.OrderByListBuilder<CircleEventTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<CircleEvent>(
      where: where(CircleEvent.t),
      orderBy: orderBy?.call(CircleEvent.t),
      orderByList: orderByList?.call(CircleEvent.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<CircleEventTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<CircleEvent>(
      where: where?.call(CircleEvent.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [CircleEvent] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<CircleEventTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<CircleEvent>(
      where: where(CircleEvent.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
