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
import '../enums/alert_kind.dart' as _iyqx97dx;
import '../enums/alert_level.dart' as _ivb9ap8q;

/// Something a caregiver should act on. Acknowledging tells the loved one
/// that help is coming.
abstract class Alert implements _is.TableRow<int?>, _is.ProtocolSerialization {
  Alert._({
    this.id,
    required this.circleId,
    this.checkInId,
    required this.kind,
    required this.level,
    required this.title,
    required this.detail,
    DateTime? createdAt,
    this.acknowledgedAt,
    this.acknowledgedByName,
    this.resolvedAt,
    this.resolvedByName,
  }) : createdAt = createdAt ?? DateTime.now();

  factory Alert({
    int? id,
    required int circleId,
    int? checkInId,
    required _iyqx97dx.AlertKind kind,
    required _ivb9ap8q.AlertLevel level,
    required String title,
    required String detail,
    DateTime? createdAt,
    DateTime? acknowledgedAt,
    String? acknowledgedByName,
    DateTime? resolvedAt,
    String? resolvedByName,
  }) = _AlertImpl;

  factory Alert.fromJson(Map<String, dynamic> jsonSerialization) {
    return Alert(
      id: jsonSerialization['id'] as int?,
      circleId: jsonSerialization['circleId'] as int,
      checkInId: jsonSerialization['checkInId'] as int?,
      kind: _iyqx97dx.AlertKind.fromJson((jsonSerialization['kind'] as String)),
      level: _ivb9ap8q.AlertLevel.fromJson(
        (jsonSerialization['level'] as String),
      ),
      title: jsonSerialization['title'] as String,
      detail: jsonSerialization['detail'] as String,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      acknowledgedAt: jsonSerialization['acknowledgedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(
              jsonSerialization['acknowledgedAt'],
            ),
      acknowledgedByName: jsonSerialization['acknowledgedByName'] as String?,
      resolvedAt: jsonSerialization['resolvedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['resolvedAt']),
      resolvedByName: jsonSerialization['resolvedByName'] as String?,
    );
  }

  static final t = AlertTable();

  static const db = AlertRepository._();

  @override
  int? id;

  int circleId;

  int? checkInId;

  _iyqx97dx.AlertKind kind;

  _ivb9ap8q.AlertLevel level;

  String title;

  String detail;

  DateTime createdAt;

  DateTime? acknowledgedAt;

  String? acknowledgedByName;

  DateTime? resolvedAt;

  String? resolvedByName;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [Alert]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  Alert copyWith({
    int? id,
    int? circleId,
    int? checkInId,
    _iyqx97dx.AlertKind? kind,
    _ivb9ap8q.AlertLevel? level,
    String? title,
    String? detail,
    DateTime? createdAt,
    DateTime? acknowledgedAt,
    String? acknowledgedByName,
    DateTime? resolvedAt,
    String? resolvedByName,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Alert',
      if (id != null) 'id': id,
      'circleId': circleId,
      if (checkInId != null) 'checkInId': checkInId,
      'kind': kind.toJson(),
      'level': level.toJson(),
      'title': title,
      'detail': detail,
      'createdAt': createdAt.toJson(),
      if (acknowledgedAt != null) 'acknowledgedAt': acknowledgedAt?.toJson(),
      if (acknowledgedByName != null) 'acknowledgedByName': acknowledgedByName,
      if (resolvedAt != null) 'resolvedAt': resolvedAt?.toJson(),
      if (resolvedByName != null) 'resolvedByName': resolvedByName,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Alert',
      if (id != null) 'id': id,
      'circleId': circleId,
      if (checkInId != null) 'checkInId': checkInId,
      'kind': kind.toJson(),
      'level': level.toJson(),
      'title': title,
      'detail': detail,
      'createdAt': createdAt.toJson(),
      if (acknowledgedAt != null) 'acknowledgedAt': acknowledgedAt?.toJson(),
      if (acknowledgedByName != null) 'acknowledgedByName': acknowledgedByName,
      if (resolvedAt != null) 'resolvedAt': resolvedAt?.toJson(),
      if (resolvedByName != null) 'resolvedByName': resolvedByName,
    };
  }

  static AlertInclude include() {
    return AlertInclude._();
  }

  static AlertIncludeList includeList({
    _is.WhereExpressionBuilder<AlertTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<AlertTable>? orderBy,
    _is.OrderByListBuilder<AlertTable>? orderByList,
    AlertInclude? include,
  }) {
    return AlertIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Alert.t),
      orderByList: orderByList?.call(Alert.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AlertImpl extends Alert {
  _AlertImpl({
    int? id,
    required int circleId,
    int? checkInId,
    required _iyqx97dx.AlertKind kind,
    required _ivb9ap8q.AlertLevel level,
    required String title,
    required String detail,
    DateTime? createdAt,
    DateTime? acknowledgedAt,
    String? acknowledgedByName,
    DateTime? resolvedAt,
    String? resolvedByName,
  }) : super._(
         id: id,
         circleId: circleId,
         checkInId: checkInId,
         kind: kind,
         level: level,
         title: title,
         detail: detail,
         createdAt: createdAt,
         acknowledgedAt: acknowledgedAt,
         acknowledgedByName: acknowledgedByName,
         resolvedAt: resolvedAt,
         resolvedByName: resolvedByName,
       );

  /// Returns a shallow copy of this [Alert]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  Alert copyWith({
    Object? id = _Undefined,
    int? circleId,
    Object? checkInId = _Undefined,
    _iyqx97dx.AlertKind? kind,
    _ivb9ap8q.AlertLevel? level,
    String? title,
    String? detail,
    DateTime? createdAt,
    Object? acknowledgedAt = _Undefined,
    Object? acknowledgedByName = _Undefined,
    Object? resolvedAt = _Undefined,
    Object? resolvedByName = _Undefined,
  }) {
    return Alert(
      id: id is int? ? id : this.id,
      circleId: circleId ?? this.circleId,
      checkInId: checkInId is int? ? checkInId : this.checkInId,
      kind: kind ?? this.kind,
      level: level ?? this.level,
      title: title ?? this.title,
      detail: detail ?? this.detail,
      createdAt: createdAt ?? this.createdAt,
      acknowledgedAt: acknowledgedAt is DateTime?
          ? acknowledgedAt
          : this.acknowledgedAt,
      acknowledgedByName: acknowledgedByName is String?
          ? acknowledgedByName
          : this.acknowledgedByName,
      resolvedAt: resolvedAt is DateTime? ? resolvedAt : this.resolvedAt,
      resolvedByName: resolvedByName is String?
          ? resolvedByName
          : this.resolvedByName,
    );
  }
}

class AlertUpdateTable extends _is.UpdateTable<AlertTable> {
  AlertUpdateTable(super.table);

  _is.ColumnValue<int, int> circleId(int value) => _is.ColumnValue(
    table.circleId,
    value,
  );

  _is.ColumnValue<int, int> checkInId(int? value) => _is.ColumnValue(
    table.checkInId,
    value,
  );

  _is.ColumnValue<_iyqx97dx.AlertKind, _iyqx97dx.AlertKind> kind(
    _iyqx97dx.AlertKind value,
  ) => _is.ColumnValue(
    table.kind,
    value,
  );

  _is.ColumnValue<_ivb9ap8q.AlertLevel, _ivb9ap8q.AlertLevel> level(
    _ivb9ap8q.AlertLevel value,
  ) => _is.ColumnValue(
    table.level,
    value,
  );

  _is.ColumnValue<String, String> title(String value) => _is.ColumnValue(
    table.title,
    value,
  );

  _is.ColumnValue<String, String> detail(String value) => _is.ColumnValue(
    table.detail,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> acknowledgedAt(DateTime? value) =>
      _is.ColumnValue(
        table.acknowledgedAt,
        value,
      );

  _is.ColumnValue<String, String> acknowledgedByName(String? value) =>
      _is.ColumnValue(
        table.acknowledgedByName,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> resolvedAt(DateTime? value) =>
      _is.ColumnValue(
        table.resolvedAt,
        value,
      );

  _is.ColumnValue<String, String> resolvedByName(String? value) =>
      _is.ColumnValue(
        table.resolvedByName,
        value,
      );
}

class AlertTable extends _is.Table<int?> {
  AlertTable({super.tableRelation}) : super(tableName: 'alert') {
    updateTable = AlertUpdateTable(this);
    circleId = _is.ColumnInt(
      'circleId',
      this,
    );
    checkInId = _is.ColumnInt(
      'checkInId',
      this,
    );
    kind = _is.ColumnEnum(
      'kind',
      this,
      _is.EnumSerialization.byName,
    );
    level = _is.ColumnEnum(
      'level',
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
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
    acknowledgedAt = _is.ColumnDateTime(
      'acknowledgedAt',
      this,
    );
    acknowledgedByName = _is.ColumnString(
      'acknowledgedByName',
      this,
    );
    resolvedAt = _is.ColumnDateTime(
      'resolvedAt',
      this,
    );
    resolvedByName = _is.ColumnString(
      'resolvedByName',
      this,
    );
  }

  late final AlertUpdateTable updateTable;

  late final _is.ColumnInt circleId;

  late final _is.ColumnInt checkInId;

  late final _is.ColumnEnum<_iyqx97dx.AlertKind> kind;

  late final _is.ColumnEnum<_ivb9ap8q.AlertLevel> level;

  late final _is.ColumnString title;

  late final _is.ColumnString detail;

  late final _is.ColumnDateTime createdAt;

  late final _is.ColumnDateTime acknowledgedAt;

  late final _is.ColumnString acknowledgedByName;

  late final _is.ColumnDateTime resolvedAt;

  late final _is.ColumnString resolvedByName;

  @override
  List<_is.Column> get columns => [
    id,
    circleId,
    checkInId,
    kind,
    level,
    title,
    detail,
    createdAt,
    acknowledgedAt,
    acknowledgedByName,
    resolvedAt,
    resolvedByName,
  ];
}

class AlertInclude extends _is.IncludeObject {
  AlertInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => Alert.t;
}

class AlertIncludeList extends _is.IncludeList {
  AlertIncludeList._({
    _is.WhereExpressionBuilder<AlertTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Alert.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => Alert.t;
}

class AlertRepository {
  const AlertRepository._();

  /// Returns a list of [Alert]s matching the given query parameters.
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
  Future<List<Alert>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<AlertTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<AlertTable>? orderBy,
    _is.OrderByListBuilder<AlertTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Alert>(
      where: where?.call(Alert.t),
      orderBy: orderBy?.call(Alert.t),
      orderByList: orderByList?.call(Alert.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Alert] matching the given query parameters.
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
  Future<Alert?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<AlertTable>? where,
    int? offset,
    _is.OrderByBuilder<AlertTable>? orderBy,
    _is.OrderByListBuilder<AlertTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Alert>(
      where: where?.call(Alert.t),
      orderBy: orderBy?.call(Alert.t),
      orderByList: orderByList?.call(Alert.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Alert] by its [id] or null if no such row exists.
  Future<Alert?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Alert>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Alert]s in the list and returns the inserted rows.
  ///
  /// The returned [Alert]s will have their `id` fields set.
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
  Future<List<Alert>> insert(
    _is.DatabaseSession session,
    List<Alert> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<Alert>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [Alert] and returns the inserted row.
  ///
  /// The returned [Alert] will have its `id` field set.
  Future<Alert> insertRow(
    _is.DatabaseSession session,
    Alert row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<Alert>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [Alert]s in the list and returns the resulting rows.
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
  /// The returned [Alert]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Alert>> upsert(
    _is.DatabaseSession session,
    List<Alert> rows, {
    required _is.ColumnSelections<AlertTable> conflictColumns,
    _is.ColumnSelections<AlertTable>? updateColumns,
    _is.WhereExpressionBuilder<AlertTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<Alert>(
      rows,
      conflictColumns: conflictColumns(Alert.t),
      updateColumns: updateColumns?.call(Alert.t),
      updateWhere: updateWhere?.call(Alert.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [Alert] and returns the resulting row.
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
  /// The returned [Alert] will have its `id` field set.
  Future<Alert?> upsertRow(
    _is.DatabaseSession session,
    Alert row, {
    required _is.ColumnSelections<AlertTable> conflictColumns,
    _is.ColumnSelections<AlertTable>? updateColumns,
    _is.WhereExpressionBuilder<AlertTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<Alert>(
      row,
      conflictColumns: conflictColumns(Alert.t),
      updateColumns: updateColumns?.call(Alert.t),
      updateWhere: updateWhere?.call(Alert.t),
      transaction: transaction,
    );
  }

  /// Updates all [Alert]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Alert>> update(
    _is.DatabaseSession session,
    List<Alert> rows, {
    _is.ColumnSelections<AlertTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<Alert>(
      rows,
      columns: columns?.call(Alert.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [Alert]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Alert> updateRow(
    _is.DatabaseSession session,
    Alert row, {
    _is.ColumnSelections<AlertTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<Alert>(
      row,
      columns: columns?.call(Alert.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Alert] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Alert?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<AlertUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<Alert>(
      id,
      columnValues: columnValues(Alert.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Alert]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Alert>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<AlertUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<AlertTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<AlertTable>? orderBy,
    _is.OrderByListBuilder<AlertTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<Alert>(
      columnValues: columnValues(Alert.t.updateTable),
      where: where(Alert.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Alert.t),
      orderByList: orderByList?.call(Alert.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [Alert]s in the list and returns the deleted rows.
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
  Future<List<Alert>> delete(
    _is.DatabaseSession session,
    List<Alert> rows, {
    _is.OrderByBuilder<AlertTable>? orderBy,
    _is.OrderByListBuilder<AlertTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<Alert>(
      rows,
      orderBy: orderBy?.call(Alert.t),
      orderByList: orderByList?.call(Alert.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [Alert].
  Future<Alert> deleteRow(
    _is.DatabaseSession session,
    Alert row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Alert>(
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
  Future<List<Alert>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<AlertTable> where,
    _is.OrderByBuilder<AlertTable>? orderBy,
    _is.OrderByListBuilder<AlertTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<Alert>(
      where: where(Alert.t),
      orderBy: orderBy?.call(Alert.t),
      orderByList: orderByList?.call(Alert.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<AlertTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<Alert>(
      where: where?.call(Alert.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Alert] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<AlertTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Alert>(
      where: where(Alert.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
