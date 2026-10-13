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
import '../enums/circle_status.dart' as _ipkn42zc;

/// A care circle: one loved one, the family who looks out for them, and
/// the companion screen(s) in their home.
abstract class Circle
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
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
          : _isc.DateTimeJsonExtension.fromJson(
              jsonSerialization['statusChangedAt'],
            ),
      isDemo: jsonSerialization['isDemo'] == null
          ? null
          : _isc.BoolJsonExtension.fromJson(jsonSerialization['isDemo']),
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
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

  /// Returns a shallow copy of this [Circle]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
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

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
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
  @_isc.useResult
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
