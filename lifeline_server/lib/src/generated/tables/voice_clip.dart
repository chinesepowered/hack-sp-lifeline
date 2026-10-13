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

/// Content-addressed cache of ElevenLabs audio stored in Serverpod storage.
/// The same sentence in the same voice is only ever synthesized once.
abstract class VoiceClip
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  VoiceClip._({
    this.id,
    required this.hash,
    required this.voiceId,
    required this.modelId,
    required this.text,
    required this.storagePath,
    required this.byteLength,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory VoiceClip({
    int? id,
    required String hash,
    required String voiceId,
    required String modelId,
    required String text,
    required String storagePath,
    required int byteLength,
    DateTime? createdAt,
  }) = _VoiceClipImpl;

  factory VoiceClip.fromJson(Map<String, dynamic> jsonSerialization) {
    return VoiceClip(
      id: jsonSerialization['id'] as int?,
      hash: jsonSerialization['hash'] as String,
      voiceId: jsonSerialization['voiceId'] as String,
      modelId: jsonSerialization['modelId'] as String,
      text: jsonSerialization['text'] as String,
      storagePath: jsonSerialization['storagePath'] as String,
      byteLength: jsonSerialization['byteLength'] as int,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  static final t = VoiceClipTable();

  static const db = VoiceClipRepository._();

  @override
  int? id;

  String hash;

  String voiceId;

  String modelId;

  String text;

  String storagePath;

  int byteLength;

  DateTime createdAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [VoiceClip]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  VoiceClip copyWith({
    int? id,
    String? hash,
    String? voiceId,
    String? modelId,
    String? text,
    String? storagePath,
    int? byteLength,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'VoiceClip',
      if (id != null) 'id': id,
      'hash': hash,
      'voiceId': voiceId,
      'modelId': modelId,
      'text': text,
      'storagePath': storagePath,
      'byteLength': byteLength,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {};
  }

  static VoiceClipInclude include() {
    return VoiceClipInclude._();
  }

  static VoiceClipIncludeList includeList({
    _is.WhereExpressionBuilder<VoiceClipTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<VoiceClipTable>? orderBy,
    _is.OrderByListBuilder<VoiceClipTable>? orderByList,
    VoiceClipInclude? include,
  }) {
    return VoiceClipIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(VoiceClip.t),
      orderByList: orderByList?.call(VoiceClip.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _VoiceClipImpl extends VoiceClip {
  _VoiceClipImpl({
    int? id,
    required String hash,
    required String voiceId,
    required String modelId,
    required String text,
    required String storagePath,
    required int byteLength,
    DateTime? createdAt,
  }) : super._(
         id: id,
         hash: hash,
         voiceId: voiceId,
         modelId: modelId,
         text: text,
         storagePath: storagePath,
         byteLength: byteLength,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [VoiceClip]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  VoiceClip copyWith({
    Object? id = _Undefined,
    String? hash,
    String? voiceId,
    String? modelId,
    String? text,
    String? storagePath,
    int? byteLength,
    DateTime? createdAt,
  }) {
    return VoiceClip(
      id: id is int? ? id : this.id,
      hash: hash ?? this.hash,
      voiceId: voiceId ?? this.voiceId,
      modelId: modelId ?? this.modelId,
      text: text ?? this.text,
      storagePath: storagePath ?? this.storagePath,
      byteLength: byteLength ?? this.byteLength,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class VoiceClipUpdateTable extends _is.UpdateTable<VoiceClipTable> {
  VoiceClipUpdateTable(super.table);

  _is.ColumnValue<String, String> hash(String value) => _is.ColumnValue(
    table.hash,
    value,
  );

  _is.ColumnValue<String, String> voiceId(String value) => _is.ColumnValue(
    table.voiceId,
    value,
  );

  _is.ColumnValue<String, String> modelId(String value) => _is.ColumnValue(
    table.modelId,
    value,
  );

  _is.ColumnValue<String, String> text(String value) => _is.ColumnValue(
    table.text,
    value,
  );

  _is.ColumnValue<String, String> storagePath(String value) => _is.ColumnValue(
    table.storagePath,
    value,
  );

  _is.ColumnValue<int, int> byteLength(int value) => _is.ColumnValue(
    table.byteLength,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );
}

class VoiceClipTable extends _is.Table<int?> {
  VoiceClipTable({super.tableRelation}) : super(tableName: 'voice_clip') {
    updateTable = VoiceClipUpdateTable(this);
    hash = _is.ColumnString(
      'hash',
      this,
    );
    voiceId = _is.ColumnString(
      'voiceId',
      this,
    );
    modelId = _is.ColumnString(
      'modelId',
      this,
    );
    text = _is.ColumnString(
      'text',
      this,
    );
    storagePath = _is.ColumnString(
      'storagePath',
      this,
    );
    byteLength = _is.ColumnInt(
      'byteLength',
      this,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
  }

  late final VoiceClipUpdateTable updateTable;

  late final _is.ColumnString hash;

  late final _is.ColumnString voiceId;

  late final _is.ColumnString modelId;

  late final _is.ColumnString text;

  late final _is.ColumnString storagePath;

  late final _is.ColumnInt byteLength;

  late final _is.ColumnDateTime createdAt;

  @override
  List<_is.Column> get columns => [
    id,
    hash,
    voiceId,
    modelId,
    text,
    storagePath,
    byteLength,
    createdAt,
  ];
}

class VoiceClipInclude extends _is.IncludeObject {
  VoiceClipInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => VoiceClip.t;
}

class VoiceClipIncludeList extends _is.IncludeList {
  VoiceClipIncludeList._({
    _is.WhereExpressionBuilder<VoiceClipTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(VoiceClip.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => VoiceClip.t;
}

class VoiceClipRepository {
  const VoiceClipRepository._();

  /// Returns a list of [VoiceClip]s matching the given query parameters.
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
  Future<List<VoiceClip>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<VoiceClipTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<VoiceClipTable>? orderBy,
    _is.OrderByListBuilder<VoiceClipTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<VoiceClip>(
      where: where?.call(VoiceClip.t),
      orderBy: orderBy?.call(VoiceClip.t),
      orderByList: orderByList?.call(VoiceClip.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [VoiceClip] matching the given query parameters.
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
  Future<VoiceClip?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<VoiceClipTable>? where,
    int? offset,
    _is.OrderByBuilder<VoiceClipTable>? orderBy,
    _is.OrderByListBuilder<VoiceClipTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<VoiceClip>(
      where: where?.call(VoiceClip.t),
      orderBy: orderBy?.call(VoiceClip.t),
      orderByList: orderByList?.call(VoiceClip.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [VoiceClip] by its [id] or null if no such row exists.
  Future<VoiceClip?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<VoiceClip>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [VoiceClip]s in the list and returns the inserted rows.
  ///
  /// The returned [VoiceClip]s will have their `id` fields set.
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
  Future<List<VoiceClip>> insert(
    _is.DatabaseSession session,
    List<VoiceClip> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<VoiceClip>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [VoiceClip] and returns the inserted row.
  ///
  /// The returned [VoiceClip] will have its `id` field set.
  Future<VoiceClip> insertRow(
    _is.DatabaseSession session,
    VoiceClip row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<VoiceClip>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [VoiceClip]s in the list and returns the resulting rows.
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
  /// The returned [VoiceClip]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<VoiceClip>> upsert(
    _is.DatabaseSession session,
    List<VoiceClip> rows, {
    required _is.ColumnSelections<VoiceClipTable> conflictColumns,
    _is.ColumnSelections<VoiceClipTable>? updateColumns,
    _is.WhereExpressionBuilder<VoiceClipTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<VoiceClip>(
      rows,
      conflictColumns: conflictColumns(VoiceClip.t),
      updateColumns: updateColumns?.call(VoiceClip.t),
      updateWhere: updateWhere?.call(VoiceClip.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [VoiceClip] and returns the resulting row.
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
  /// The returned [VoiceClip] will have its `id` field set.
  Future<VoiceClip?> upsertRow(
    _is.DatabaseSession session,
    VoiceClip row, {
    required _is.ColumnSelections<VoiceClipTable> conflictColumns,
    _is.ColumnSelections<VoiceClipTable>? updateColumns,
    _is.WhereExpressionBuilder<VoiceClipTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<VoiceClip>(
      row,
      conflictColumns: conflictColumns(VoiceClip.t),
      updateColumns: updateColumns?.call(VoiceClip.t),
      updateWhere: updateWhere?.call(VoiceClip.t),
      transaction: transaction,
    );
  }

  /// Updates all [VoiceClip]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<VoiceClip>> update(
    _is.DatabaseSession session,
    List<VoiceClip> rows, {
    _is.ColumnSelections<VoiceClipTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<VoiceClip>(
      rows,
      columns: columns?.call(VoiceClip.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [VoiceClip]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<VoiceClip> updateRow(
    _is.DatabaseSession session,
    VoiceClip row, {
    _is.ColumnSelections<VoiceClipTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<VoiceClip>(
      row,
      columns: columns?.call(VoiceClip.t),
      transaction: transaction,
    );
  }

  /// Updates a single [VoiceClip] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<VoiceClip?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<VoiceClipUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<VoiceClip>(
      id,
      columnValues: columnValues(VoiceClip.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [VoiceClip]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<VoiceClip>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<VoiceClipUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<VoiceClipTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<VoiceClipTable>? orderBy,
    _is.OrderByListBuilder<VoiceClipTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<VoiceClip>(
      columnValues: columnValues(VoiceClip.t.updateTable),
      where: where(VoiceClip.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(VoiceClip.t),
      orderByList: orderByList?.call(VoiceClip.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [VoiceClip]s in the list and returns the deleted rows.
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
  Future<List<VoiceClip>> delete(
    _is.DatabaseSession session,
    List<VoiceClip> rows, {
    _is.OrderByBuilder<VoiceClipTable>? orderBy,
    _is.OrderByListBuilder<VoiceClipTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<VoiceClip>(
      rows,
      orderBy: orderBy?.call(VoiceClip.t),
      orderByList: orderByList?.call(VoiceClip.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [VoiceClip].
  Future<VoiceClip> deleteRow(
    _is.DatabaseSession session,
    VoiceClip row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<VoiceClip>(
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
  Future<List<VoiceClip>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<VoiceClipTable> where,
    _is.OrderByBuilder<VoiceClipTable>? orderBy,
    _is.OrderByListBuilder<VoiceClipTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<VoiceClip>(
      where: where(VoiceClip.t),
      orderBy: orderBy?.call(VoiceClip.t),
      orderByList: orderByList?.call(VoiceClip.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<VoiceClipTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<VoiceClip>(
      where: where?.call(VoiceClip.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [VoiceClip] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<VoiceClipTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<VoiceClip>(
      where: where(VoiceClip.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
