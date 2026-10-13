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
import 'package:lifeline_client/src/protocol/protocol.dart' as _iijvse0e;
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import '../enums/check_in_kind.dart' as _in7zrdc4;
import '../enums/check_in_status.dart' as _i39c1i2q;
import '../enums/response_method.dart' as _ilp6h6zr;
import '../enums/triage_level.dart' as _i69p18mx;

/// One "How are you?" prompt and its outcome.
abstract class CheckIn
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
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
      scheduledFor: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['scheduledFor'],
      ),
      promptedAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['promptedAt'],
      ),
      promptText: jsonSerialization['promptText'] as String,
      status: _i39c1i2q.CheckInStatus.fromJson(
        (jsonSerialization['status'] as String),
      ),
      escalationStage: jsonSerialization['escalationStage'] as int?,
      respondedAt: jsonSerialization['respondedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(
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
          : _iijvse0e.Protocol().deserialize<List<String>>(
              jsonSerialization['triageReasons'],
            ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
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

  /// Returns a shallow copy of this [CheckIn]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
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

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
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
  @_isc.useResult
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
