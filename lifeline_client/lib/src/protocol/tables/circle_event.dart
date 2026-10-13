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
import '../enums/event_kind.dart' as _ie2bfe8q;

/// An entry in the circle's activity timeline.
abstract class CircleEvent
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
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
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int circleId;

  _ie2bfe8q.EventKind kind;

  String title;

  String? detail;

  String? actorName;

  int? checkInId;

  DateTime createdAt;

  /// Returns a shallow copy of this [CircleEvent]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
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

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
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
  @_isc.useResult
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
