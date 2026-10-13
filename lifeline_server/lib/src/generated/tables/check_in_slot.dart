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

/// A daily check-in time, in the loved one's local time. Each slot is backed
/// by a recurring (cron) future call.
abstract class CheckInSlot
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  CheckInSlot._({
    this.id,
    required this.circleId,
    required this.minuteOfDay,
    required this.label,
  });

  factory CheckInSlot({
    int? id,
    required int circleId,
    required int minuteOfDay,
    required String label,
  }) = _CheckInSlotImpl;

  factory CheckInSlot.fromJson(Map<String, dynamic> jsonSerialization) {
    return CheckInSlot(
      id: jsonSerialization['id'] as int?,
      circleId: jsonSerialization['circleId'] as int,
      minuteOfDay: jsonSerialization['minuteOfDay'] as int,
      label: jsonSerialization['label'] as String,
    );
  }

  static final t = CheckInSlotTable();

  static const db = CheckInSlotRepository._();

  @override
  int? id;

  int circleId;

  /// Minutes after local midnight, e.g. 540 for 09:00.
  int minuteOfDay;

  String label;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [CheckInSlot]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  CheckInSlot copyWith({
    int? id,
    int? circleId,
    int? minuteOfDay,
    String? label,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CheckInSlot',
      if (id != null) 'id': id,
      'circleId': circleId,
      'minuteOfDay': minuteOfDay,
      'label': label,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CheckInSlot',
      if (id != null) 'id': id,
      'circleId': circleId,
      'minuteOfDay': minuteOfDay,
      'label': label,
    };
  }

  static CheckInSlotInclude include() {
    return CheckInSlotInclude._();
  }

  static CheckInSlotIncludeList includeList({
    _is.WhereExpressionBuilder<CheckInSlotTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<CheckInSlotTable>? orderBy,
    _is.OrderByListBuilder<CheckInSlotTable>? orderByList,
    CheckInSlotInclude? include,
  }) {
    return CheckInSlotIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(CheckInSlot.t),
      orderByList: orderByList?.call(CheckInSlot.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CheckInSlotImpl extends CheckInSlot {
  _CheckInSlotImpl({
    int? id,
    required int circleId,
    required int minuteOfDay,
    required String label,
  }) : super._(
         id: id,
         circleId: circleId,
         minuteOfDay: minuteOfDay,
         label: label,
       );

  /// Returns a shallow copy of this [CheckInSlot]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  CheckInSlot copyWith({
    Object? id = _Undefined,
    int? circleId,
    int? minuteOfDay,
    String? label,
  }) {
    return CheckInSlot(
      id: id is int? ? id : this.id,
      circleId: circleId ?? this.circleId,
      minuteOfDay: minuteOfDay ?? this.minuteOfDay,
      label: label ?? this.label,
    );
  }
}

class CheckInSlotUpdateTable extends _is.UpdateTable<CheckInSlotTable> {
  CheckInSlotUpdateTable(super.table);

  _is.ColumnValue<int, int> circleId(int value) => _is.ColumnValue(
    table.circleId,
    value,
  );

  _is.ColumnValue<int, int> minuteOfDay(int value) => _is.ColumnValue(
    table.minuteOfDay,
    value,
  );

  _is.ColumnValue<String, String> label(String value) => _is.ColumnValue(
    table.label,
    value,
  );
}

class CheckInSlotTable extends _is.Table<int?> {
  CheckInSlotTable({super.tableRelation}) : super(tableName: 'check_in_slot') {
    updateTable = CheckInSlotUpdateTable(this);
    circleId = _is.ColumnInt(
      'circleId',
      this,
    );
    minuteOfDay = _is.ColumnInt(
      'minuteOfDay',
      this,
    );
    label = _is.ColumnString(
      'label',
      this,
    );
  }

  late final CheckInSlotUpdateTable updateTable;

  late final _is.ColumnInt circleId;

  /// Minutes after local midnight, e.g. 540 for 09:00.
  late final _is.ColumnInt minuteOfDay;

  late final _is.ColumnString label;

  @override
  List<_is.Column> get columns => [
    id,
    circleId,
    minuteOfDay,
    label,
  ];
}

class CheckInSlotInclude extends _is.IncludeObject {
  CheckInSlotInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => CheckInSlot.t;
}

class CheckInSlotIncludeList extends _is.IncludeList {
  CheckInSlotIncludeList._({
    _is.WhereExpressionBuilder<CheckInSlotTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(CheckInSlot.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => CheckInSlot.t;
}

class CheckInSlotRepository {
  const CheckInSlotRepository._();

  /// Returns a list of [CheckInSlot]s matching the given query parameters.
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
  Future<List<CheckInSlot>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<CheckInSlotTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<CheckInSlotTable>? orderBy,
    _is.OrderByListBuilder<CheckInSlotTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<CheckInSlot>(
      where: where?.call(CheckInSlot.t),
      orderBy: orderBy?.call(CheckInSlot.t),
      orderByList: orderByList?.call(CheckInSlot.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [CheckInSlot] matching the given query parameters.
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
  Future<CheckInSlot?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<CheckInSlotTable>? where,
    int? offset,
    _is.OrderByBuilder<CheckInSlotTable>? orderBy,
    _is.OrderByListBuilder<CheckInSlotTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<CheckInSlot>(
      where: where?.call(CheckInSlot.t),
      orderBy: orderBy?.call(CheckInSlot.t),
      orderByList: orderByList?.call(CheckInSlot.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [CheckInSlot] by its [id] or null if no such row exists.
  Future<CheckInSlot?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<CheckInSlot>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [CheckInSlot]s in the list and returns the inserted rows.
  ///
  /// The returned [CheckInSlot]s will have their `id` fields set.
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
  Future<List<CheckInSlot>> insert(
    _is.DatabaseSession session,
    List<CheckInSlot> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<CheckInSlot>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [CheckInSlot] and returns the inserted row.
  ///
  /// The returned [CheckInSlot] will have its `id` field set.
  Future<CheckInSlot> insertRow(
    _is.DatabaseSession session,
    CheckInSlot row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<CheckInSlot>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [CheckInSlot]s in the list and returns the resulting rows.
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
  /// The returned [CheckInSlot]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<CheckInSlot>> upsert(
    _is.DatabaseSession session,
    List<CheckInSlot> rows, {
    required _is.ColumnSelections<CheckInSlotTable> conflictColumns,
    _is.ColumnSelections<CheckInSlotTable>? updateColumns,
    _is.WhereExpressionBuilder<CheckInSlotTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<CheckInSlot>(
      rows,
      conflictColumns: conflictColumns(CheckInSlot.t),
      updateColumns: updateColumns?.call(CheckInSlot.t),
      updateWhere: updateWhere?.call(CheckInSlot.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [CheckInSlot] and returns the resulting row.
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
  /// The returned [CheckInSlot] will have its `id` field set.
  Future<CheckInSlot?> upsertRow(
    _is.DatabaseSession session,
    CheckInSlot row, {
    required _is.ColumnSelections<CheckInSlotTable> conflictColumns,
    _is.ColumnSelections<CheckInSlotTable>? updateColumns,
    _is.WhereExpressionBuilder<CheckInSlotTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<CheckInSlot>(
      row,
      conflictColumns: conflictColumns(CheckInSlot.t),
      updateColumns: updateColumns?.call(CheckInSlot.t),
      updateWhere: updateWhere?.call(CheckInSlot.t),
      transaction: transaction,
    );
  }

  /// Updates all [CheckInSlot]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<CheckInSlot>> update(
    _is.DatabaseSession session,
    List<CheckInSlot> rows, {
    _is.ColumnSelections<CheckInSlotTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<CheckInSlot>(
      rows,
      columns: columns?.call(CheckInSlot.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [CheckInSlot]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<CheckInSlot> updateRow(
    _is.DatabaseSession session,
    CheckInSlot row, {
    _is.ColumnSelections<CheckInSlotTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<CheckInSlot>(
      row,
      columns: columns?.call(CheckInSlot.t),
      transaction: transaction,
    );
  }

  /// Updates a single [CheckInSlot] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<CheckInSlot?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<CheckInSlotUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<CheckInSlot>(
      id,
      columnValues: columnValues(CheckInSlot.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [CheckInSlot]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<CheckInSlot>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<CheckInSlotUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<CheckInSlotTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<CheckInSlotTable>? orderBy,
    _is.OrderByListBuilder<CheckInSlotTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<CheckInSlot>(
      columnValues: columnValues(CheckInSlot.t.updateTable),
      where: where(CheckInSlot.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(CheckInSlot.t),
      orderByList: orderByList?.call(CheckInSlot.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [CheckInSlot]s in the list and returns the deleted rows.
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
  Future<List<CheckInSlot>> delete(
    _is.DatabaseSession session,
    List<CheckInSlot> rows, {
    _is.OrderByBuilder<CheckInSlotTable>? orderBy,
    _is.OrderByListBuilder<CheckInSlotTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<CheckInSlot>(
      rows,
      orderBy: orderBy?.call(CheckInSlot.t),
      orderByList: orderByList?.call(CheckInSlot.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [CheckInSlot].
  Future<CheckInSlot> deleteRow(
    _is.DatabaseSession session,
    CheckInSlot row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<CheckInSlot>(
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
  Future<List<CheckInSlot>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<CheckInSlotTable> where,
    _is.OrderByBuilder<CheckInSlotTable>? orderBy,
    _is.OrderByListBuilder<CheckInSlotTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<CheckInSlot>(
      where: where(CheckInSlot.t),
      orderBy: orderBy?.call(CheckInSlot.t),
      orderByList: orderByList?.call(CheckInSlot.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<CheckInSlotTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<CheckInSlot>(
      where: where?.call(CheckInSlot.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [CheckInSlot] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<CheckInSlotTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<CheckInSlot>(
      where: where(CheckInSlot.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
