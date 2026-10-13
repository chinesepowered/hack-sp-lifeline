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
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import '../enums/alert_kind.dart' as _iyqx97dx;
import '../enums/alert_level.dart' as _ivb9ap8q;

/// Something a caregiver should act on. Acknowledging tells the loved one
/// that help is coming.
abstract class Alert
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
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
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      acknowledgedAt: jsonSerialization['acknowledgedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(
              jsonSerialization['acknowledgedAt'],
            ),
      acknowledgedByName: jsonSerialization['acknowledgedByName'] as String?,
      resolvedAt: jsonSerialization['resolvedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(
              jsonSerialization['resolvedAt'],
            ),
      resolvedByName: jsonSerialization['resolvedByName'] as String?,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
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

  /// Returns a shallow copy of this [Alert]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
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

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
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
  @_isc.useResult
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
