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
import '../enums/circle_status.dart' as _ipkn42zc;

/// A care circle: one loved one, the family who looks out for them, and
/// the companion screen(s) in their home.
abstract class Circle implements _is.TableRow<int?>, _is.ProtocolSerialization {
  Circle._({
    this.id,
    required this.lovedOneName,
    required this.voiceId,
    required this.utcOffsetMinutes,
    required this.graceSeconds,
    required this.secondGraceSeconds,
    required this.pairingCode,
    required this.inviteCode,
    _ipkn42zc.CircleStatus? status,
    DateTime? statusChangedAt,
    bool? isDemo,
    DateTime? createdAt,
  }) : status = status ?? _ipkn42zc.CircleStatus.quiet,
       statusChangedAt = statusChangedAt ?? DateTime.now(),
       isDemo = isDemo ?? false,
       createdAt = createdAt ?? DateTime.now();

  factory Circle({
    int? id,
    required String lovedOneName,
    required String voiceId,
    required int utcOffsetMinutes,
    required int graceSeconds,
    required int secondGraceSeconds,
    required String pairingCode,
    required String inviteCode,
    _ipkn42zc.CircleStatus? status,
    DateTime? statusChangedAt,
    bool? isDemo,
    DateTime? createdAt,
  }) = _CircleImpl;

  factory Circle.fromJson(Map<String, dynamic> jsonSerialization) {
    return Circle(
      id: jsonSerialization['id'] as int?,
      lovedOneName: jsonSerialization['lovedOneName'] as String,
      voiceId: jsonSerialization['voiceId'] as String,
      utcOffsetMinutes: jsonSerialization['utcOffsetMinutes'] as int,
      graceSeconds: jsonSerialization['graceSeconds'] as int,
      secondGraceSeconds: jsonSerialization['secondGraceSeconds'] as int,
      pairingCode: jsonSerialization['pairingCode'] as String,
      inviteCode: jsonSerialization['inviteCode'] as String,
      status: jsonSerialization['status'] == null
          ? null
          : _ipkn42zc.CircleStatus.fromJson(
              (jsonSerialization['status'] as String),
            ),
      statusChangedAt: jsonSerialization['statusChangedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(
              jsonSerialization['statusChangedAt'],
            ),
      isDemo: jsonSerialization['isDemo'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(jsonSerialization['isDemo']),
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  static final t = CircleTable();

  static const db = CircleRepository._();

  @override
  int? id;

  /// First name the companion uses when speaking, e.g. "Rose".
  String lovedOneName;

  /// ElevenLabs voice used on the companion screen.
  String voiceId;

  /// Offset of the loved one's local time from UTC, in minutes.
  int utcOffsetMinutes;

  /// Seconds to wait for an answer before a check-in counts as missed.
  int graceSeconds;

  /// Further seconds before a missed check-in escalates to urgent.
  int secondGraceSeconds;

  /// 6-digit code used once to pair the loved one's tablet.
  String pairingCode;

  /// Code family members use to join the circle.
  String inviteCode;

  _ipkn42zc.CircleStatus status;

  DateTime statusChangedAt;

  /// Demo circles are cleaned up automatically by a future call.
  bool isDemo;

  DateTime createdAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [Circle]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  Circle copyWith({
    int? id,
    String? lovedOneName,
    String? voiceId,
    int? utcOffsetMinutes,
    int? graceSeconds,
    int? secondGraceSeconds,
    String? pairingCode,
    String? inviteCode,
    _ipkn42zc.CircleStatus? status,
    DateTime? statusChangedAt,
    bool? isDemo,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Circle',
      if (id != null) 'id': id,
      'lovedOneName': lovedOneName,
      'voiceId': voiceId,
      'utcOffsetMinutes': utcOffsetMinutes,
      'graceSeconds': graceSeconds,
      'secondGraceSeconds': secondGraceSeconds,
      'pairingCode': pairingCode,
      'inviteCode': inviteCode,
      'status': status.toJson(),
      'statusChangedAt': statusChangedAt.toJson(),
      'isDemo': isDemo,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Circle',
      if (id != null) 'id': id,
      'lovedOneName': lovedOneName,
      'voiceId': voiceId,
      'utcOffsetMinutes': utcOffsetMinutes,
      'graceSeconds': graceSeconds,
      'secondGraceSeconds': secondGraceSeconds,
      'pairingCode': pairingCode,
      'inviteCode': inviteCode,
      'status': status.toJson(),
      'statusChangedAt': statusChangedAt.toJson(),
      'isDemo': isDemo,
      'createdAt': createdAt.toJson(),
    };
  }

  static CircleInclude include() {
    return CircleInclude._();
  }

  static CircleIncludeList includeList({
    _is.WhereExpressionBuilder<CircleTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<CircleTable>? orderBy,
    _is.OrderByListBuilder<CircleTable>? orderByList,
    CircleInclude? include,
  }) {
    return CircleIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Circle.t),
      orderByList: orderByList?.call(Circle.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CircleImpl extends Circle {
  _CircleImpl({
    int? id,
    required String lovedOneName,
    required String voiceId,
    required int utcOffsetMinutes,
    required int graceSeconds,
    required int secondGraceSeconds,
    required String pairingCode,
    required String inviteCode,
    _ipkn42zc.CircleStatus? status,
    DateTime? statusChangedAt,
    bool? isDemo,
    DateTime? createdAt,
  }) : super._(
         id: id,
         lovedOneName: lovedOneName,
         voiceId: voiceId,
         utcOffsetMinutes: utcOffsetMinutes,
         graceSeconds: graceSeconds,
         secondGraceSeconds: secondGraceSeconds,
         pairingCode: pairingCode,
         inviteCode: inviteCode,
         status: status,
         statusChangedAt: statusChangedAt,
         isDemo: isDemo,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [Circle]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  Circle copyWith({
    Object? id = _Undefined,
    String? lovedOneName,
    String? voiceId,
    int? utcOffsetMinutes,
    int? graceSeconds,
    int? secondGraceSeconds,
    String? pairingCode,
    String? inviteCode,
    _ipkn42zc.CircleStatus? status,
    DateTime? statusChangedAt,
    bool? isDemo,
    DateTime? createdAt,
  }) {
    return Circle(
      id: id is int? ? id : this.id,
      lovedOneName: lovedOneName ?? this.lovedOneName,
      voiceId: voiceId ?? this.voiceId,
      utcOffsetMinutes: utcOffsetMinutes ?? this.utcOffsetMinutes,
      graceSeconds: graceSeconds ?? this.graceSeconds,
      secondGraceSeconds: secondGraceSeconds ?? this.secondGraceSeconds,
      pairingCode: pairingCode ?? this.pairingCode,
      inviteCode: inviteCode ?? this.inviteCode,
      status: status ?? this.status,
      statusChangedAt: statusChangedAt ?? this.statusChangedAt,
      isDemo: isDemo ?? this.isDemo,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class CircleUpdateTable extends _is.UpdateTable<CircleTable> {
  CircleUpdateTable(super.table);

  _is.ColumnValue<String, String> lovedOneName(String value) => _is.ColumnValue(
    table.lovedOneName,
    value,
  );

  _is.ColumnValue<String, String> voiceId(String value) => _is.ColumnValue(
    table.voiceId,
    value,
  );

  _is.ColumnValue<int, int> utcOffsetMinutes(int value) => _is.ColumnValue(
    table.utcOffsetMinutes,
    value,
  );

  _is.ColumnValue<int, int> graceSeconds(int value) => _is.ColumnValue(
    table.graceSeconds,
    value,
  );

  _is.ColumnValue<int, int> secondGraceSeconds(int value) => _is.ColumnValue(
    table.secondGraceSeconds,
    value,
  );

  _is.ColumnValue<String, String> pairingCode(String value) => _is.ColumnValue(
    table.pairingCode,
    value,
  );

  _is.ColumnValue<String, String> inviteCode(String value) => _is.ColumnValue(
    table.inviteCode,
    value,
  );

  _is.ColumnValue<_ipkn42zc.CircleStatus, _ipkn42zc.CircleStatus> status(
    _ipkn42zc.CircleStatus value,
  ) => _is.ColumnValue(
    table.status,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> statusChangedAt(DateTime value) =>
      _is.ColumnValue(
        table.statusChangedAt,
        value,
      );

  _is.ColumnValue<bool, bool> isDemo(bool value) => _is.ColumnValue(
    table.isDemo,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );
}

class CircleTable extends _is.Table<int?> {
  CircleTable({super.tableRelation}) : super(tableName: 'circle') {
    updateTable = CircleUpdateTable(this);
    lovedOneName = _is.ColumnString(
      'lovedOneName',
      this,
    );
    voiceId = _is.ColumnString(
      'voiceId',
      this,
    );
    utcOffsetMinutes = _is.ColumnInt(
      'utcOffsetMinutes',
      this,
    );
    graceSeconds = _is.ColumnInt(
      'graceSeconds',
      this,
    );
    secondGraceSeconds = _is.ColumnInt(
      'secondGraceSeconds',
      this,
    );
    pairingCode = _is.ColumnString(
      'pairingCode',
      this,
    );
    inviteCode = _is.ColumnString(
      'inviteCode',
      this,
    );
    status = _is.ColumnEnum(
      'status',
      this,
      _is.EnumSerialization.byName,
      hasDefault: true,
    );
    statusChangedAt = _is.ColumnDateTime(
      'statusChangedAt',
      this,
      hasDefault: true,
    );
    isDemo = _is.ColumnBool(
      'isDemo',
      this,
      hasDefault: true,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
  }

  late final CircleUpdateTable updateTable;

  /// First name the companion uses when speaking, e.g. "Rose".
  late final _is.ColumnString lovedOneName;

  /// ElevenLabs voice used on the companion screen.
  late final _is.ColumnString voiceId;

  /// Offset of the loved one's local time from UTC, in minutes.
  late final _is.ColumnInt utcOffsetMinutes;

  /// Seconds to wait for an answer before a check-in counts as missed.
  late final _is.ColumnInt graceSeconds;

  /// Further seconds before a missed check-in escalates to urgent.
  late final _is.ColumnInt secondGraceSeconds;

  /// 6-digit code used once to pair the loved one's tablet.
  late final _is.ColumnString pairingCode;

  /// Code family members use to join the circle.
  late final _is.ColumnString inviteCode;

  late final _is.ColumnEnum<_ipkn42zc.CircleStatus> status;

  late final _is.ColumnDateTime statusChangedAt;

  /// Demo circles are cleaned up automatically by a future call.
  late final _is.ColumnBool isDemo;

  late final _is.ColumnDateTime createdAt;

  @override
  List<_is.Column> get columns => [
    id,
    lovedOneName,
    voiceId,
    utcOffsetMinutes,
    graceSeconds,
    secondGraceSeconds,
    pairingCode,
    inviteCode,
    status,
    statusChangedAt,
    isDemo,
    createdAt,
  ];
}

class CircleInclude extends _is.IncludeObject {
  CircleInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => Circle.t;
}

class CircleIncludeList extends _is.IncludeList {
  CircleIncludeList._({
    _is.WhereExpressionBuilder<CircleTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Circle.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => Circle.t;
}

class CircleRepository {
  const CircleRepository._();

  /// Returns a list of [Circle]s matching the given query parameters.
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
  Future<List<Circle>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<CircleTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<CircleTable>? orderBy,
    _is.OrderByListBuilder<CircleTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Circle>(
      where: where?.call(Circle.t),
      orderBy: orderBy?.call(Circle.t),
      orderByList: orderByList?.call(Circle.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Circle] matching the given query parameters.
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
  Future<Circle?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<CircleTable>? where,
    int? offset,
    _is.OrderByBuilder<CircleTable>? orderBy,
    _is.OrderByListBuilder<CircleTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Circle>(
      where: where?.call(Circle.t),
      orderBy: orderBy?.call(Circle.t),
      orderByList: orderByList?.call(Circle.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Circle] by its [id] or null if no such row exists.
  Future<Circle?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Circle>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Circle]s in the list and returns the inserted rows.
  ///
  /// The returned [Circle]s will have their `id` fields set.
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
  Future<List<Circle>> insert(
    _is.DatabaseSession session,
    List<Circle> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<Circle>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [Circle] and returns the inserted row.
  ///
  /// The returned [Circle] will have its `id` field set.
  Future<Circle> insertRow(
    _is.DatabaseSession session,
    Circle row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<Circle>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [Circle]s in the list and returns the resulting rows.
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
  /// The returned [Circle]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Circle>> upsert(
    _is.DatabaseSession session,
    List<Circle> rows, {
    required _is.ColumnSelections<CircleTable> conflictColumns,
    _is.ColumnSelections<CircleTable>? updateColumns,
    _is.WhereExpressionBuilder<CircleTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<Circle>(
      rows,
      conflictColumns: conflictColumns(Circle.t),
      updateColumns: updateColumns?.call(Circle.t),
      updateWhere: updateWhere?.call(Circle.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [Circle] and returns the resulting row.
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
  /// The returned [Circle] will have its `id` field set.
  Future<Circle?> upsertRow(
    _is.DatabaseSession session,
    Circle row, {
    required _is.ColumnSelections<CircleTable> conflictColumns,
    _is.ColumnSelections<CircleTable>? updateColumns,
    _is.WhereExpressionBuilder<CircleTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<Circle>(
      row,
      conflictColumns: conflictColumns(Circle.t),
      updateColumns: updateColumns?.call(Circle.t),
      updateWhere: updateWhere?.call(Circle.t),
      transaction: transaction,
    );
  }

  /// Updates all [Circle]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Circle>> update(
    _is.DatabaseSession session,
    List<Circle> rows, {
    _is.ColumnSelections<CircleTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<Circle>(
      rows,
      columns: columns?.call(Circle.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [Circle]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Circle> updateRow(
    _is.DatabaseSession session,
    Circle row, {
    _is.ColumnSelections<CircleTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<Circle>(
      row,
      columns: columns?.call(Circle.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Circle] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Circle?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<CircleUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<Circle>(
      id,
      columnValues: columnValues(Circle.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Circle]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Circle>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<CircleUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<CircleTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<CircleTable>? orderBy,
    _is.OrderByListBuilder<CircleTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<Circle>(
      columnValues: columnValues(Circle.t.updateTable),
      where: where(Circle.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Circle.t),
      orderByList: orderByList?.call(Circle.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [Circle]s in the list and returns the deleted rows.
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
  Future<List<Circle>> delete(
    _is.DatabaseSession session,
    List<Circle> rows, {
    _is.OrderByBuilder<CircleTable>? orderBy,
    _is.OrderByListBuilder<CircleTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<Circle>(
      rows,
      orderBy: orderBy?.call(Circle.t),
      orderByList: orderByList?.call(Circle.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [Circle].
  Future<Circle> deleteRow(
    _is.DatabaseSession session,
    Circle row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Circle>(
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
  Future<List<Circle>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<CircleTable> where,
    _is.OrderByBuilder<CircleTable>? orderBy,
    _is.OrderByListBuilder<CircleTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<Circle>(
      where: where(Circle.t),
      orderBy: orderBy?.call(Circle.t),
      orderByList: orderByList?.call(Circle.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<CircleTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<Circle>(
      where: where?.call(Circle.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Circle] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<CircleTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Circle>(
      where: where(Circle.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
