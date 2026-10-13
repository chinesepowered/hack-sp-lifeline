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

/// A tablet paired to a circle. It authenticates with a long random token;
/// only its SHA-256 hash is stored.
abstract class CompanionDevice
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  CompanionDevice._({
    this.id,
    required this.circleId,
    this.tokenHash,
    required this.label,
    DateTime? pairedAt,
    this.lastSeenAt,
  }) : pairedAt = pairedAt ?? DateTime.now();

  factory CompanionDevice({
    int? id,
    required int circleId,
    String? tokenHash,
    required String label,
    DateTime? pairedAt,
    DateTime? lastSeenAt,
  }) = _CompanionDeviceImpl;

  factory CompanionDevice.fromJson(Map<String, dynamic> jsonSerialization) {
    return CompanionDevice(
      id: jsonSerialization['id'] as int?,
      circleId: jsonSerialization['circleId'] as int,
      tokenHash: jsonSerialization['tokenHash'] as String?,
      label: jsonSerialization['label'] as String,
      pairedAt: jsonSerialization['pairedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['pairedAt']),
      lastSeenAt: jsonSerialization['lastSeenAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['lastSeenAt']),
    );
  }

  static final t = CompanionDeviceTable();

  static const db = CompanionDeviceRepository._();

  @override
  int? id;

  int circleId;

  String? tokenHash;

  String label;

  DateTime pairedAt;

  DateTime? lastSeenAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [CompanionDevice]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  CompanionDevice copyWith({
    int? id,
    int? circleId,
    String? tokenHash,
    String? label,
    DateTime? pairedAt,
    DateTime? lastSeenAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CompanionDevice',
      if (id != null) 'id': id,
      'circleId': circleId,
      if (tokenHash != null) 'tokenHash': tokenHash,
      'label': label,
      'pairedAt': pairedAt.toJson(),
      if (lastSeenAt != null) 'lastSeenAt': lastSeenAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CompanionDevice',
      if (id != null) 'id': id,
      'circleId': circleId,
      'label': label,
      'pairedAt': pairedAt.toJson(),
      if (lastSeenAt != null) 'lastSeenAt': lastSeenAt?.toJson(),
    };
  }

  static CompanionDeviceInclude include() {
    return CompanionDeviceInclude._();
  }

  static CompanionDeviceIncludeList includeList({
    _is.WhereExpressionBuilder<CompanionDeviceTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<CompanionDeviceTable>? orderBy,
    _is.OrderByListBuilder<CompanionDeviceTable>? orderByList,
    CompanionDeviceInclude? include,
  }) {
    return CompanionDeviceIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(CompanionDevice.t),
      orderByList: orderByList?.call(CompanionDevice.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CompanionDeviceImpl extends CompanionDevice {
  _CompanionDeviceImpl({
    int? id,
    required int circleId,
    String? tokenHash,
    required String label,
    DateTime? pairedAt,
    DateTime? lastSeenAt,
  }) : super._(
         id: id,
         circleId: circleId,
         tokenHash: tokenHash,
         label: label,
         pairedAt: pairedAt,
         lastSeenAt: lastSeenAt,
       );

  /// Returns a shallow copy of this [CompanionDevice]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  CompanionDevice copyWith({
    Object? id = _Undefined,
    int? circleId,
    Object? tokenHash = _Undefined,
    String? label,
    DateTime? pairedAt,
    Object? lastSeenAt = _Undefined,
  }) {
    return CompanionDevice(
      id: id is int? ? id : this.id,
      circleId: circleId ?? this.circleId,
      tokenHash: tokenHash is String? ? tokenHash : this.tokenHash,
      label: label ?? this.label,
      pairedAt: pairedAt ?? this.pairedAt,
      lastSeenAt: lastSeenAt is DateTime? ? lastSeenAt : this.lastSeenAt,
    );
  }
}

class CompanionDeviceUpdateTable extends _is.UpdateTable<CompanionDeviceTable> {
  CompanionDeviceUpdateTable(super.table);

  _is.ColumnValue<int, int> circleId(int value) => _is.ColumnValue(
    table.circleId,
    value,
  );

  _is.ColumnValue<String, String> tokenHash(String? value) => _is.ColumnValue(
    table.tokenHash,
    value,
  );

  _is.ColumnValue<String, String> label(String value) => _is.ColumnValue(
    table.label,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> pairedAt(DateTime value) =>
      _is.ColumnValue(
        table.pairedAt,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> lastSeenAt(DateTime? value) =>
      _is.ColumnValue(
        table.lastSeenAt,
        value,
      );
}

class CompanionDeviceTable extends _is.Table<int?> {
  CompanionDeviceTable({super.tableRelation})
    : super(tableName: 'companion_device') {
    updateTable = CompanionDeviceUpdateTable(this);
    circleId = _is.ColumnInt(
      'circleId',
      this,
    );
    tokenHash = _is.ColumnString(
      'tokenHash',
      this,
    );
    label = _is.ColumnString(
      'label',
      this,
    );
    pairedAt = _is.ColumnDateTime(
      'pairedAt',
      this,
      hasDefault: true,
    );
    lastSeenAt = _is.ColumnDateTime(
      'lastSeenAt',
      this,
    );
  }

  late final CompanionDeviceUpdateTable updateTable;

  late final _is.ColumnInt circleId;

  late final _is.ColumnString tokenHash;

  late final _is.ColumnString label;

  late final _is.ColumnDateTime pairedAt;

  late final _is.ColumnDateTime lastSeenAt;

  @override
  List<_is.Column> get columns => [
    id,
    circleId,
    tokenHash,
    label,
    pairedAt,
    lastSeenAt,
  ];
}

class CompanionDeviceInclude extends _is.IncludeObject {
  CompanionDeviceInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => CompanionDevice.t;
}

class CompanionDeviceIncludeList extends _is.IncludeList {
  CompanionDeviceIncludeList._({
    _is.WhereExpressionBuilder<CompanionDeviceTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(CompanionDevice.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => CompanionDevice.t;
}

class CompanionDeviceRepository {
  const CompanionDeviceRepository._();

  /// Returns a list of [CompanionDevice]s matching the given query parameters.
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
  Future<List<CompanionDevice>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<CompanionDeviceTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<CompanionDeviceTable>? orderBy,
    _is.OrderByListBuilder<CompanionDeviceTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<CompanionDevice>(
      where: where?.call(CompanionDevice.t),
      orderBy: orderBy?.call(CompanionDevice.t),
      orderByList: orderByList?.call(CompanionDevice.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [CompanionDevice] matching the given query parameters.
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
  Future<CompanionDevice?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<CompanionDeviceTable>? where,
    int? offset,
    _is.OrderByBuilder<CompanionDeviceTable>? orderBy,
    _is.OrderByListBuilder<CompanionDeviceTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<CompanionDevice>(
      where: where?.call(CompanionDevice.t),
      orderBy: orderBy?.call(CompanionDevice.t),
      orderByList: orderByList?.call(CompanionDevice.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [CompanionDevice] by its [id] or null if no such row exists.
  Future<CompanionDevice?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<CompanionDevice>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [CompanionDevice]s in the list and returns the inserted rows.
  ///
  /// The returned [CompanionDevice]s will have their `id` fields set.
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
  Future<List<CompanionDevice>> insert(
    _is.DatabaseSession session,
    List<CompanionDevice> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<CompanionDevice>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [CompanionDevice] and returns the inserted row.
  ///
  /// The returned [CompanionDevice] will have its `id` field set.
  Future<CompanionDevice> insertRow(
    _is.DatabaseSession session,
    CompanionDevice row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<CompanionDevice>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [CompanionDevice]s in the list and returns the resulting rows.
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
  /// The returned [CompanionDevice]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<CompanionDevice>> upsert(
    _is.DatabaseSession session,
    List<CompanionDevice> rows, {
    required _is.ColumnSelections<CompanionDeviceTable> conflictColumns,
    _is.ColumnSelections<CompanionDeviceTable>? updateColumns,
    _is.WhereExpressionBuilder<CompanionDeviceTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<CompanionDevice>(
      rows,
      conflictColumns: conflictColumns(CompanionDevice.t),
      updateColumns: updateColumns?.call(CompanionDevice.t),
      updateWhere: updateWhere?.call(CompanionDevice.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [CompanionDevice] and returns the resulting row.
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
  /// The returned [CompanionDevice] will have its `id` field set.
  Future<CompanionDevice?> upsertRow(
    _is.DatabaseSession session,
    CompanionDevice row, {
    required _is.ColumnSelections<CompanionDeviceTable> conflictColumns,
    _is.ColumnSelections<CompanionDeviceTable>? updateColumns,
    _is.WhereExpressionBuilder<CompanionDeviceTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<CompanionDevice>(
      row,
      conflictColumns: conflictColumns(CompanionDevice.t),
      updateColumns: updateColumns?.call(CompanionDevice.t),
      updateWhere: updateWhere?.call(CompanionDevice.t),
      transaction: transaction,
    );
  }

  /// Updates all [CompanionDevice]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<CompanionDevice>> update(
    _is.DatabaseSession session,
    List<CompanionDevice> rows, {
    _is.ColumnSelections<CompanionDeviceTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<CompanionDevice>(
      rows,
      columns: columns?.call(CompanionDevice.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [CompanionDevice]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<CompanionDevice> updateRow(
    _is.DatabaseSession session,
    CompanionDevice row, {
    _is.ColumnSelections<CompanionDeviceTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<CompanionDevice>(
      row,
      columns: columns?.call(CompanionDevice.t),
      transaction: transaction,
    );
  }

  /// Updates a single [CompanionDevice] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<CompanionDevice?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<CompanionDeviceUpdateTable>
    columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<CompanionDevice>(
      id,
      columnValues: columnValues(CompanionDevice.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [CompanionDevice]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<CompanionDevice>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<CompanionDeviceUpdateTable>
    columnValues,
    required _is.WhereExpressionBuilder<CompanionDeviceTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<CompanionDeviceTable>? orderBy,
    _is.OrderByListBuilder<CompanionDeviceTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<CompanionDevice>(
      columnValues: columnValues(CompanionDevice.t.updateTable),
      where: where(CompanionDevice.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(CompanionDevice.t),
      orderByList: orderByList?.call(CompanionDevice.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [CompanionDevice]s in the list and returns the deleted rows.
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
  Future<List<CompanionDevice>> delete(
    _is.DatabaseSession session,
    List<CompanionDevice> rows, {
    _is.OrderByBuilder<CompanionDeviceTable>? orderBy,
    _is.OrderByListBuilder<CompanionDeviceTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<CompanionDevice>(
      rows,
      orderBy: orderBy?.call(CompanionDevice.t),
      orderByList: orderByList?.call(CompanionDevice.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [CompanionDevice].
  Future<CompanionDevice> deleteRow(
    _is.DatabaseSession session,
    CompanionDevice row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<CompanionDevice>(
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
  Future<List<CompanionDevice>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<CompanionDeviceTable> where,
    _is.OrderByBuilder<CompanionDeviceTable>? orderBy,
    _is.OrderByListBuilder<CompanionDeviceTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<CompanionDevice>(
      where: where(CompanionDevice.t),
      orderBy: orderBy?.call(CompanionDevice.t),
      orderByList: orderByList?.call(CompanionDevice.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<CompanionDeviceTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<CompanionDevice>(
      where: where?.call(CompanionDevice.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [CompanionDevice] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<CompanionDeviceTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<CompanionDevice>(
      where: where(CompanionDevice.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
