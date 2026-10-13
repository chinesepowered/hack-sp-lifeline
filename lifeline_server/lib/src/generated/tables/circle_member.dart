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
import '../enums/member_role.dart' as _iw6qhlck;

/// A family member or friend in a care circle, linked to a Serverpod auth user.
abstract class CircleMember
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  CircleMember._({
    this.id,
    required this.circleId,
    this.userIdentifier,
    required this.displayName,
    this.relationship,
    required this.role,
    DateTime? joinedAt,
  }) : joinedAt = joinedAt ?? DateTime.now();

  factory CircleMember({
    int? id,
    required int circleId,
    String? userIdentifier,
    required String displayName,
    String? relationship,
    required _iw6qhlck.MemberRole role,
    DateTime? joinedAt,
  }) = _CircleMemberImpl;

  factory CircleMember.fromJson(Map<String, dynamic> jsonSerialization) {
    return CircleMember(
      id: jsonSerialization['id'] as int?,
      circleId: jsonSerialization['circleId'] as int,
      userIdentifier: jsonSerialization['userIdentifier'] as String?,
      displayName: jsonSerialization['displayName'] as String,
      relationship: jsonSerialization['relationship'] as String?,
      role: _iw6qhlck.MemberRole.fromJson(
        (jsonSerialization['role'] as String),
      ),
      joinedAt: jsonSerialization['joinedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['joinedAt']),
    );
  }

  static final t = CircleMemberTable();

  static const db = CircleMemberRepository._();

  @override
  int? id;

  int circleId;

  /// The Serverpod auth user identifier (UUID) of this member.
  String? userIdentifier;

  String displayName;

  String? relationship;

  _iw6qhlck.MemberRole role;

  DateTime joinedAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [CircleMember]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  CircleMember copyWith({
    int? id,
    int? circleId,
    String? userIdentifier,
    String? displayName,
    String? relationship,
    _iw6qhlck.MemberRole? role,
    DateTime? joinedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CircleMember',
      if (id != null) 'id': id,
      'circleId': circleId,
      if (userIdentifier != null) 'userIdentifier': userIdentifier,
      'displayName': displayName,
      if (relationship != null) 'relationship': relationship,
      'role': role.toJson(),
      'joinedAt': joinedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CircleMember',
      if (id != null) 'id': id,
      'circleId': circleId,
      'displayName': displayName,
      if (relationship != null) 'relationship': relationship,
      'role': role.toJson(),
      'joinedAt': joinedAt.toJson(),
    };
  }

  static CircleMemberInclude include() {
    return CircleMemberInclude._();
  }

  static CircleMemberIncludeList includeList({
    _is.WhereExpressionBuilder<CircleMemberTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<CircleMemberTable>? orderBy,
    _is.OrderByListBuilder<CircleMemberTable>? orderByList,
    CircleMemberInclude? include,
  }) {
    return CircleMemberIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(CircleMember.t),
      orderByList: orderByList?.call(CircleMember.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CircleMemberImpl extends CircleMember {
  _CircleMemberImpl({
    int? id,
    required int circleId,
    String? userIdentifier,
    required String displayName,
    String? relationship,
    required _iw6qhlck.MemberRole role,
    DateTime? joinedAt,
  }) : super._(
         id: id,
         circleId: circleId,
         userIdentifier: userIdentifier,
         displayName: displayName,
         relationship: relationship,
         role: role,
         joinedAt: joinedAt,
       );

  /// Returns a shallow copy of this [CircleMember]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  CircleMember copyWith({
    Object? id = _Undefined,
    int? circleId,
    Object? userIdentifier = _Undefined,
    String? displayName,
    Object? relationship = _Undefined,
    _iw6qhlck.MemberRole? role,
    DateTime? joinedAt,
  }) {
    return CircleMember(
      id: id is int? ? id : this.id,
      circleId: circleId ?? this.circleId,
      userIdentifier: userIdentifier is String?
          ? userIdentifier
          : this.userIdentifier,
      displayName: displayName ?? this.displayName,
      relationship: relationship is String? ? relationship : this.relationship,
      role: role ?? this.role,
      joinedAt: joinedAt ?? this.joinedAt,
    );
  }
}

class CircleMemberUpdateTable extends _is.UpdateTable<CircleMemberTable> {
  CircleMemberUpdateTable(super.table);

  _is.ColumnValue<int, int> circleId(int value) => _is.ColumnValue(
    table.circleId,
    value,
  );

  _is.ColumnValue<String, String> userIdentifier(String? value) =>
      _is.ColumnValue(
        table.userIdentifier,
        value,
      );

  _is.ColumnValue<String, String> displayName(String value) => _is.ColumnValue(
    table.displayName,
    value,
  );

  _is.ColumnValue<String, String> relationship(String? value) =>
      _is.ColumnValue(
        table.relationship,
        value,
      );

  _is.ColumnValue<_iw6qhlck.MemberRole, _iw6qhlck.MemberRole> role(
    _iw6qhlck.MemberRole value,
  ) => _is.ColumnValue(
    table.role,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> joinedAt(DateTime value) =>
      _is.ColumnValue(
        table.joinedAt,
        value,
      );
}

class CircleMemberTable extends _is.Table<int?> {
  CircleMemberTable({super.tableRelation}) : super(tableName: 'circle_member') {
    updateTable = CircleMemberUpdateTable(this);
    circleId = _is.ColumnInt(
      'circleId',
      this,
    );
    userIdentifier = _is.ColumnString(
      'userIdentifier',
      this,
    );
    displayName = _is.ColumnString(
      'displayName',
      this,
    );
    relationship = _is.ColumnString(
      'relationship',
      this,
    );
    role = _is.ColumnEnum(
      'role',
      this,
      _is.EnumSerialization.byName,
    );
    joinedAt = _is.ColumnDateTime(
      'joinedAt',
      this,
      hasDefault: true,
    );
  }

  late final CircleMemberUpdateTable updateTable;

  late final _is.ColumnInt circleId;

  /// The Serverpod auth user identifier (UUID) of this member.
  late final _is.ColumnString userIdentifier;

  late final _is.ColumnString displayName;

  late final _is.ColumnString relationship;

  late final _is.ColumnEnum<_iw6qhlck.MemberRole> role;

  late final _is.ColumnDateTime joinedAt;

  @override
  List<_is.Column> get columns => [
    id,
    circleId,
    userIdentifier,
    displayName,
    relationship,
    role,
    joinedAt,
  ];
}

class CircleMemberInclude extends _is.IncludeObject {
  CircleMemberInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => CircleMember.t;
}

class CircleMemberIncludeList extends _is.IncludeList {
  CircleMemberIncludeList._({
    _is.WhereExpressionBuilder<CircleMemberTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(CircleMember.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => CircleMember.t;
}

class CircleMemberRepository {
  const CircleMemberRepository._();

  /// Returns a list of [CircleMember]s matching the given query parameters.
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
  Future<List<CircleMember>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<CircleMemberTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<CircleMemberTable>? orderBy,
    _is.OrderByListBuilder<CircleMemberTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<CircleMember>(
      where: where?.call(CircleMember.t),
      orderBy: orderBy?.call(CircleMember.t),
      orderByList: orderByList?.call(CircleMember.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [CircleMember] matching the given query parameters.
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
  Future<CircleMember?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<CircleMemberTable>? where,
    int? offset,
    _is.OrderByBuilder<CircleMemberTable>? orderBy,
    _is.OrderByListBuilder<CircleMemberTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<CircleMember>(
      where: where?.call(CircleMember.t),
      orderBy: orderBy?.call(CircleMember.t),
      orderByList: orderByList?.call(CircleMember.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [CircleMember] by its [id] or null if no such row exists.
  Future<CircleMember?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<CircleMember>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [CircleMember]s in the list and returns the inserted rows.
  ///
  /// The returned [CircleMember]s will have their `id` fields set.
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
  Future<List<CircleMember>> insert(
    _is.DatabaseSession session,
    List<CircleMember> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<CircleMember>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [CircleMember] and returns the inserted row.
  ///
  /// The returned [CircleMember] will have its `id` field set.
  Future<CircleMember> insertRow(
    _is.DatabaseSession session,
    CircleMember row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<CircleMember>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [CircleMember]s in the list and returns the resulting rows.
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
  /// The returned [CircleMember]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<CircleMember>> upsert(
    _is.DatabaseSession session,
    List<CircleMember> rows, {
    required _is.ColumnSelections<CircleMemberTable> conflictColumns,
    _is.ColumnSelections<CircleMemberTable>? updateColumns,
    _is.WhereExpressionBuilder<CircleMemberTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<CircleMember>(
      rows,
      conflictColumns: conflictColumns(CircleMember.t),
      updateColumns: updateColumns?.call(CircleMember.t),
      updateWhere: updateWhere?.call(CircleMember.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [CircleMember] and returns the resulting row.
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
  /// The returned [CircleMember] will have its `id` field set.
  Future<CircleMember?> upsertRow(
    _is.DatabaseSession session,
    CircleMember row, {
    required _is.ColumnSelections<CircleMemberTable> conflictColumns,
    _is.ColumnSelections<CircleMemberTable>? updateColumns,
    _is.WhereExpressionBuilder<CircleMemberTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<CircleMember>(
      row,
      conflictColumns: conflictColumns(CircleMember.t),
      updateColumns: updateColumns?.call(CircleMember.t),
      updateWhere: updateWhere?.call(CircleMember.t),
      transaction: transaction,
    );
  }

  /// Updates all [CircleMember]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<CircleMember>> update(
    _is.DatabaseSession session,
    List<CircleMember> rows, {
    _is.ColumnSelections<CircleMemberTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<CircleMember>(
      rows,
      columns: columns?.call(CircleMember.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [CircleMember]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<CircleMember> updateRow(
    _is.DatabaseSession session,
    CircleMember row, {
    _is.ColumnSelections<CircleMemberTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<CircleMember>(
      row,
      columns: columns?.call(CircleMember.t),
      transaction: transaction,
    );
  }

  /// Updates a single [CircleMember] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<CircleMember?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<CircleMemberUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<CircleMember>(
      id,
      columnValues: columnValues(CircleMember.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [CircleMember]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<CircleMember>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<CircleMemberUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<CircleMemberTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<CircleMemberTable>? orderBy,
    _is.OrderByListBuilder<CircleMemberTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<CircleMember>(
      columnValues: columnValues(CircleMember.t.updateTable),
      where: where(CircleMember.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(CircleMember.t),
      orderByList: orderByList?.call(CircleMember.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [CircleMember]s in the list and returns the deleted rows.
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
  Future<List<CircleMember>> delete(
    _is.DatabaseSession session,
    List<CircleMember> rows, {
    _is.OrderByBuilder<CircleMemberTable>? orderBy,
    _is.OrderByListBuilder<CircleMemberTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<CircleMember>(
      rows,
      orderBy: orderBy?.call(CircleMember.t),
      orderByList: orderByList?.call(CircleMember.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [CircleMember].
  Future<CircleMember> deleteRow(
    _is.DatabaseSession session,
    CircleMember row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<CircleMember>(
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
  Future<List<CircleMember>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<CircleMemberTable> where,
    _is.OrderByBuilder<CircleMemberTable>? orderBy,
    _is.OrderByListBuilder<CircleMemberTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<CircleMember>(
      where: where(CircleMember.t),
      orderBy: orderBy?.call(CircleMember.t),
      orderByList: orderByList?.call(CircleMember.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<CircleMemberTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<CircleMember>(
      where: where?.call(CircleMember.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [CircleMember] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<CircleMemberTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<CircleMember>(
      where: where(CircleMember.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
