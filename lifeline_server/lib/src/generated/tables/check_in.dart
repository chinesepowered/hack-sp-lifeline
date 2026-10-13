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
import 'package:lifeline_server/src/generated/protocol.dart' as _ituap8d4;
import 'package:serverpod/serverpod.dart' as _is;
import '../enums/check_in_kind.dart' as _in7zrdc4;
import '../enums/check_in_status.dart' as _i39c1i2q;
import '../enums/response_method.dart' as _ilp6h6zr;
import '../enums/triage_level.dart' as _i69p18mx;

/// One "How are you?" prompt and its outcome.
abstract class CheckIn
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  CheckIn._({
    this.id,
    required this.circleId,
    required this.kind,
    this.slotId,
    required this.scheduledFor,
    required this.promptedAt,
    required this.promptText,
    required this.status,
    int? escalationStage,
    this.respondedAt,
    this.responseMethod,
    this.transcript,
    this.triageLevel,
    this.triageReasons,
  }) : escalationStage = escalationStage ?? 0;

  factory CheckIn({
    int? id,
    required int circleId,
    required _in7zrdc4.CheckInKind kind,
    int? slotId,
    required DateTime scheduledFor,
    required DateTime promptedAt,
    required String promptText,
    required _i39c1i2q.CheckInStatus status,
    int? escalationStage,
    DateTime? respondedAt,
    _ilp6h6zr.ResponseMethod? responseMethod,
    String? transcript,
    _i69p18mx.TriageLevel? triageLevel,
    List<String>? triageReasons,
  }) = _CheckInImpl;

  factory CheckIn.fromJson(Map<String, dynamic> jsonSerialization) {
    return CheckIn(
      id: jsonSerialization['id'] as int?,
      circleId: jsonSerialization['circleId'] as int,
      kind: _in7zrdc4.CheckInKind.fromJson(
        (jsonSerialization['kind'] as String),
      ),
      slotId: jsonSerialization['slotId'] as int?,
      scheduledFor: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['scheduledFor'],
      ),
      promptedAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['promptedAt'],
      ),
      promptText: jsonSerialization['promptText'] as String,
      status: _i39c1i2q.CheckInStatus.fromJson(
        (jsonSerialization['status'] as String),
      ),
      escalationStage: jsonSerialization['escalationStage'] as int?,
      respondedAt: jsonSerialization['respondedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(
              jsonSerialization['respondedAt'],
            ),
      responseMethod: jsonSerialization['responseMethod'] == null
          ? null
          : _ilp6h6zr.ResponseMethod.fromJson(
              (jsonSerialization['responseMethod'] as String),
            ),
      transcript: jsonSerialization['transcript'] as String?,
      triageLevel: jsonSerialization['triageLevel'] == null
          ? null
          : _i69p18mx.TriageLevel.fromJson(
              (jsonSerialization['triageLevel'] as String),
            ),
      triageReasons: jsonSerialization['triageReasons'] == null
          ? null
          : _ituap8d4.Protocol().deserialize<List<String>>(
              jsonSerialization['triageReasons'],
            ),
    );
  }

  static final t = CheckInTable();

  static const db = CheckInRepository._();

  @override
  int? id;

  int circleId;

  _in7zrdc4.CheckInKind kind;

  int? slotId;

  /// The scheduled occurrence this check-in belongs to. Unique per circle,
  /// which makes the at-least-once scheduled future call idempotent.
  DateTime scheduledFor;

  DateTime promptedAt;

  String promptText;

  _i39c1i2q.CheckInStatus status;

  /// 0 = none, 1 = missed (warning), 2 = unresponsive (urgent).
  int escalationStage;

  DateTime? respondedAt;

  _ilp6h6zr.ResponseMethod? responseMethod;

  String? transcript;

  _i69p18mx.TriageLevel? triageLevel;

  List<String>? triageReasons;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [CheckIn]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  CheckIn copyWith({
    int? id,
    int? circleId,
    _in7zrdc4.CheckInKind? kind,
    int? slotId,
    DateTime? scheduledFor,
    DateTime? promptedAt,
    String? promptText,
    _i39c1i2q.CheckInStatus? status,
    int? escalationStage,
    DateTime? respondedAt,
    _ilp6h6zr.ResponseMethod? responseMethod,
    String? transcript,
    _i69p18mx.TriageLevel? triageLevel,
    List<String>? triageReasons,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CheckIn',
      if (id != null) 'id': id,
      'circleId': circleId,
      'kind': kind.toJson(),
      if (slotId != null) 'slotId': slotId,
      'scheduledFor': scheduledFor.toJson(),
      'promptedAt': promptedAt.toJson(),
      'promptText': promptText,
      'status': status.toJson(),
      'escalationStage': escalationStage,
      if (respondedAt != null) 'respondedAt': respondedAt?.toJson(),
      if (responseMethod != null) 'responseMethod': responseMethod?.toJson(),
      if (transcript != null) 'transcript': transcript,
      if (triageLevel != null) 'triageLevel': triageLevel?.toJson(),
      if (triageReasons != null) 'triageReasons': triageReasons?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CheckIn',
      if (id != null) 'id': id,
      'circleId': circleId,
      'kind': kind.toJson(),
      if (slotId != null) 'slotId': slotId,
      'scheduledFor': scheduledFor.toJson(),
      'promptedAt': promptedAt.toJson(),
      'promptText': promptText,
      'status': status.toJson(),
      'escalationStage': escalationStage,
      if (respondedAt != null) 'respondedAt': respondedAt?.toJson(),
      if (responseMethod != null) 'responseMethod': responseMethod?.toJson(),
      if (transcript != null) 'transcript': transcript,
      if (triageLevel != null) 'triageLevel': triageLevel?.toJson(),
      if (triageReasons != null) 'triageReasons': triageReasons?.toJson(),
    };
  }

  static CheckInInclude include() {
    return CheckInInclude._();
  }

  static CheckInIncludeList includeList({
    _is.WhereExpressionBuilder<CheckInTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<CheckInTable>? orderBy,
    _is.OrderByListBuilder<CheckInTable>? orderByList,
    CheckInInclude? include,
  }) {
    return CheckInIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(CheckIn.t),
      orderByList: orderByList?.call(CheckIn.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CheckInImpl extends CheckIn {
  _CheckInImpl({
    int? id,
    required int circleId,
    required _in7zrdc4.CheckInKind kind,
    int? slotId,
    required DateTime scheduledFor,
    required DateTime promptedAt,
    required String promptText,
    required _i39c1i2q.CheckInStatus status,
    int? escalationStage,
    DateTime? respondedAt,
    _ilp6h6zr.ResponseMethod? responseMethod,
    String? transcript,
    _i69p18mx.TriageLevel? triageLevel,
    List<String>? triageReasons,
  }) : super._(
         id: id,
         circleId: circleId,
         kind: kind,
         slotId: slotId,
         scheduledFor: scheduledFor,
         promptedAt: promptedAt,
         promptText: promptText,
         status: status,
         escalationStage: escalationStage,
         respondedAt: respondedAt,
         responseMethod: responseMethod,
         transcript: transcript,
         triageLevel: triageLevel,
         triageReasons: triageReasons,
       );

  /// Returns a shallow copy of this [CheckIn]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  CheckIn copyWith({
    Object? id = _Undefined,
    int? circleId,
    _in7zrdc4.CheckInKind? kind,
    Object? slotId = _Undefined,
    DateTime? scheduledFor,
    DateTime? promptedAt,
    String? promptText,
    _i39c1i2q.CheckInStatus? status,
    int? escalationStage,
    Object? respondedAt = _Undefined,
    Object? responseMethod = _Undefined,
    Object? transcript = _Undefined,
    Object? triageLevel = _Undefined,
    Object? triageReasons = _Undefined,
  }) {
    return CheckIn(
      id: id is int? ? id : this.id,
      circleId: circleId ?? this.circleId,
      kind: kind ?? this.kind,
      slotId: slotId is int? ? slotId : this.slotId,
      scheduledFor: scheduledFor ?? this.scheduledFor,
      promptedAt: promptedAt ?? this.promptedAt,
      promptText: promptText ?? this.promptText,
      status: status ?? this.status,
      escalationStage: escalationStage ?? this.escalationStage,
      respondedAt: respondedAt is DateTime? ? respondedAt : this.respondedAt,
      responseMethod: responseMethod is _ilp6h6zr.ResponseMethod?
          ? responseMethod
          : this.responseMethod,
      transcript: transcript is String? ? transcript : this.transcript,
      triageLevel: triageLevel is _i69p18mx.TriageLevel?
          ? triageLevel
          : this.triageLevel,
      triageReasons: triageReasons is List<String>?
          ? triageReasons
          : this.triageReasons?.map((e0) => e0).toList(),
    );
  }
}

class CheckInUpdateTable extends _is.UpdateTable<CheckInTable> {
  CheckInUpdateTable(super.table);

  _is.ColumnValue<int, int> circleId(int value) => _is.ColumnValue(
    table.circleId,
    value,
  );

  _is.ColumnValue<_in7zrdc4.CheckInKind, _in7zrdc4.CheckInKind> kind(
    _in7zrdc4.CheckInKind value,
  ) => _is.ColumnValue(
    table.kind,
    value,
  );

  _is.ColumnValue<int, int> slotId(int? value) => _is.ColumnValue(
    table.slotId,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> scheduledFor(DateTime value) =>
      _is.ColumnValue(
        table.scheduledFor,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> promptedAt(DateTime value) =>
      _is.ColumnValue(
        table.promptedAt,
        value,
      );

  _is.ColumnValue<String, String> promptText(String value) => _is.ColumnValue(
    table.promptText,
    value,
  );

  _is.ColumnValue<_i39c1i2q.CheckInStatus, _i39c1i2q.CheckInStatus> status(
    _i39c1i2q.CheckInStatus value,
  ) => _is.ColumnValue(
    table.status,
    value,
  );

  _is.ColumnValue<int, int> escalationStage(int value) => _is.ColumnValue(
    table.escalationStage,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> respondedAt(DateTime? value) =>
      _is.ColumnValue(
        table.respondedAt,
        value,
      );

  _is.ColumnValue<_ilp6h6zr.ResponseMethod, _ilp6h6zr.ResponseMethod>
  responseMethod(_ilp6h6zr.ResponseMethod? value) => _is.ColumnValue(
    table.responseMethod,
    value,
  );

  _is.ColumnValue<String, String> transcript(String? value) => _is.ColumnValue(
    table.transcript,
    value,
  );

  _is.ColumnValue<_i69p18mx.TriageLevel, _i69p18mx.TriageLevel> triageLevel(
    _i69p18mx.TriageLevel? value,
  ) => _is.ColumnValue(
    table.triageLevel,
    value,
  );

  _is.ColumnValue<List<String>, List<String>> triageReasons(
    List<String>? value,
  ) => _is.ColumnValue(
    table.triageReasons,
    value,
  );
}

class CheckInTable extends _is.Table<int?> {
  CheckInTable({super.tableRelation}) : super(tableName: 'check_in') {
    updateTable = CheckInUpdateTable(this);
    circleId = _is.ColumnInt(
      'circleId',
      this,
    );
    kind = _is.ColumnEnum(
      'kind',
      this,
      _is.EnumSerialization.byName,
    );
    slotId = _is.ColumnInt(
      'slotId',
      this,
    );
    scheduledFor = _is.ColumnDateTime(
      'scheduledFor',
      this,
    );
    promptedAt = _is.ColumnDateTime(
      'promptedAt',
      this,
    );
    promptText = _is.ColumnString(
      'promptText',
      this,
    );
    status = _is.ColumnEnum(
      'status',
      this,
      _is.EnumSerialization.byName,
    );
    escalationStage = _is.ColumnInt(
      'escalationStage',
      this,
      hasDefault: true,
    );
    respondedAt = _is.ColumnDateTime(
      'respondedAt',
      this,
    );
    responseMethod = _is.ColumnEnum(
      'responseMethod',
      this,
      _is.EnumSerialization.byName,
    );
    transcript = _is.ColumnString(
      'transcript',
      this,
    );
    triageLevel = _is.ColumnEnum(
      'triageLevel',
      this,
      _is.EnumSerialization.byName,
    );
    triageReasons = _is.ColumnSerializable<List<String>>(
      'triageReasons',
      this,
    );
  }

  late final CheckInUpdateTable updateTable;

  late final _is.ColumnInt circleId;

  late final _is.ColumnEnum<_in7zrdc4.CheckInKind> kind;

  late final _is.ColumnInt slotId;

  /// The scheduled occurrence this check-in belongs to. Unique per circle,
  /// which makes the at-least-once scheduled future call idempotent.
  late final _is.ColumnDateTime scheduledFor;

  late final _is.ColumnDateTime promptedAt;

  late final _is.ColumnString promptText;

  late final _is.ColumnEnum<_i39c1i2q.CheckInStatus> status;

  /// 0 = none, 1 = missed (warning), 2 = unresponsive (urgent).
  late final _is.ColumnInt escalationStage;

  late final _is.ColumnDateTime respondedAt;

  late final _is.ColumnEnum<_ilp6h6zr.ResponseMethod> responseMethod;

  late final _is.ColumnString transcript;

  late final _is.ColumnEnum<_i69p18mx.TriageLevel> triageLevel;

  late final _is.ColumnSerializable<List<String>> triageReasons;

  @override
  List<_is.Column> get columns => [
    id,
    circleId,
    kind,
    slotId,
    scheduledFor,
    promptedAt,
    promptText,
    status,
    escalationStage,
    respondedAt,
    responseMethod,
    transcript,
    triageLevel,
    triageReasons,
  ];
}

class CheckInInclude extends _is.IncludeObject {
  CheckInInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => CheckIn.t;
}

class CheckInIncludeList extends _is.IncludeList {
  CheckInIncludeList._({
    _is.WhereExpressionBuilder<CheckInTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(CheckIn.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => CheckIn.t;
}

class CheckInRepository {
  const CheckInRepository._();

  /// Returns a list of [CheckIn]s matching the given query parameters.
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
  Future<List<CheckIn>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<CheckInTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<CheckInTable>? orderBy,
    _is.OrderByListBuilder<CheckInTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<CheckIn>(
      where: where?.call(CheckIn.t),
      orderBy: orderBy?.call(CheckIn.t),
      orderByList: orderByList?.call(CheckIn.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [CheckIn] matching the given query parameters.
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
  Future<CheckIn?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<CheckInTable>? where,
    int? offset,
    _is.OrderByBuilder<CheckInTable>? orderBy,
    _is.OrderByListBuilder<CheckInTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<CheckIn>(
      where: where?.call(CheckIn.t),
      orderBy: orderBy?.call(CheckIn.t),
      orderByList: orderByList?.call(CheckIn.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [CheckIn] by its [id] or null if no such row exists.
  Future<CheckIn?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<CheckIn>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [CheckIn]s in the list and returns the inserted rows.
  ///
  /// The returned [CheckIn]s will have their `id` fields set.
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
  Future<List<CheckIn>> insert(
    _is.DatabaseSession session,
    List<CheckIn> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<CheckIn>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [CheckIn] and returns the inserted row.
  ///
  /// The returned [CheckIn] will have its `id` field set.
  Future<CheckIn> insertRow(
    _is.DatabaseSession session,
    CheckIn row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<CheckIn>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [CheckIn]s in the list and returns the resulting rows.
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
  /// The returned [CheckIn]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<CheckIn>> upsert(
    _is.DatabaseSession session,
    List<CheckIn> rows, {
    required _is.ColumnSelections<CheckInTable> conflictColumns,
    _is.ColumnSelections<CheckInTable>? updateColumns,
    _is.WhereExpressionBuilder<CheckInTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<CheckIn>(
      rows,
      conflictColumns: conflictColumns(CheckIn.t),
      updateColumns: updateColumns?.call(CheckIn.t),
      updateWhere: updateWhere?.call(CheckIn.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [CheckIn] and returns the resulting row.
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
  /// The returned [CheckIn] will have its `id` field set.
  Future<CheckIn?> upsertRow(
    _is.DatabaseSession session,
    CheckIn row, {
    required _is.ColumnSelections<CheckInTable> conflictColumns,
    _is.ColumnSelections<CheckInTable>? updateColumns,
    _is.WhereExpressionBuilder<CheckInTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<CheckIn>(
      row,
      conflictColumns: conflictColumns(CheckIn.t),
      updateColumns: updateColumns?.call(CheckIn.t),
      updateWhere: updateWhere?.call(CheckIn.t),
      transaction: transaction,
    );
  }

  /// Updates all [CheckIn]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<CheckIn>> update(
    _is.DatabaseSession session,
    List<CheckIn> rows, {
    _is.ColumnSelections<CheckInTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<CheckIn>(
      rows,
      columns: columns?.call(CheckIn.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [CheckIn]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<CheckIn> updateRow(
    _is.DatabaseSession session,
    CheckIn row, {
    _is.ColumnSelections<CheckInTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<CheckIn>(
      row,
      columns: columns?.call(CheckIn.t),
      transaction: transaction,
    );
  }

  /// Updates a single [CheckIn] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<CheckIn?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<CheckInUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<CheckIn>(
      id,
      columnValues: columnValues(CheckIn.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [CheckIn]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<CheckIn>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<CheckInUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<CheckInTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<CheckInTable>? orderBy,
    _is.OrderByListBuilder<CheckInTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<CheckIn>(
      columnValues: columnValues(CheckIn.t.updateTable),
      where: where(CheckIn.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(CheckIn.t),
      orderByList: orderByList?.call(CheckIn.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [CheckIn]s in the list and returns the deleted rows.
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
  Future<List<CheckIn>> delete(
    _is.DatabaseSession session,
    List<CheckIn> rows, {
    _is.OrderByBuilder<CheckInTable>? orderBy,
    _is.OrderByListBuilder<CheckInTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<CheckIn>(
      rows,
      orderBy: orderBy?.call(CheckIn.t),
      orderByList: orderByList?.call(CheckIn.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [CheckIn].
  Future<CheckIn> deleteRow(
    _is.DatabaseSession session,
    CheckIn row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<CheckIn>(
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
  Future<List<CheckIn>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<CheckInTable> where,
    _is.OrderByBuilder<CheckInTable>? orderBy,
    _is.OrderByListBuilder<CheckInTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<CheckIn>(
      where: where(CheckIn.t),
      orderBy: orderBy?.call(CheckIn.t),
      orderByList: orderByList?.call(CheckIn.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<CheckInTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<CheckIn>(
      where: where?.call(CheckIn.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [CheckIn] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<CheckInTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<CheckIn>(
      where: where(CheckIn.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
