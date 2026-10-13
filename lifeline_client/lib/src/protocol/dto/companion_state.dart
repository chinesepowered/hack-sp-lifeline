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
import '../enums/circle_status.dart' as _ipkn42zc;
import '../tables/check_in.dart' as _igosldlc;
import '../tables/utterance.dart' as _i5xr7ifk;

/// What the loved one's companion screen shows, pushed live over a stream.
abstract class CompanionState
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  CompanionState._({
    required this.circleId,
    required this.lovedOneName,
    required this.status,
    this.activeCheckIn,
    required this.utterances,
    this.latestMessage,
    required this.helpActive,
    this.helpAcknowledgedBy,
    required this.caregiverNames,
    this.nextCheckInAt,
    required this.utcOffsetMinutes,
    required this.serverTime,
    required this.voiceBaseUrl,
  });

  factory CompanionState({
    required int circleId,
    required String lovedOneName,
    required _ipkn42zc.CircleStatus status,
    _igosldlc.CheckIn? activeCheckIn,
    required List<_i5xr7ifk.Utterance> utterances,
    _i5xr7ifk.Utterance? latestMessage,
    required bool helpActive,
    String? helpAcknowledgedBy,
    required List<String> caregiverNames,
    DateTime? nextCheckInAt,
    required int utcOffsetMinutes,
    required DateTime serverTime,
    required String voiceBaseUrl,
  }) = _CompanionStateImpl;

  factory CompanionState.fromJson(Map<String, dynamic> jsonSerialization) {
    return CompanionState(
      circleId: jsonSerialization['circleId'] as int,
      lovedOneName: jsonSerialization['lovedOneName'] as String,
      status: _ipkn42zc.CircleStatus.fromJson(
        (jsonSerialization['status'] as String),
      ),
      activeCheckIn: jsonSerialization['activeCheckIn'] == null
          ? null
          : _iijvse0e.Protocol().deserialize<_igosldlc.CheckIn>(
              jsonSerialization['activeCheckIn'],
            ),
      utterances: _iijvse0e.Protocol().deserialize<List<_i5xr7ifk.Utterance>>(
        jsonSerialization['utterances'],
      ),
      latestMessage: jsonSerialization['latestMessage'] == null
          ? null
          : _iijvse0e.Protocol().deserialize<_i5xr7ifk.Utterance>(
              jsonSerialization['latestMessage'],
            ),
      helpActive: _isc.BoolJsonExtension.fromJson(
        jsonSerialization['helpActive'],
      ),
      helpAcknowledgedBy: jsonSerialization['helpAcknowledgedBy'] as String?,
      caregiverNames: _iijvse0e.Protocol().deserialize<List<String>>(
        jsonSerialization['caregiverNames'],
      ),
      nextCheckInAt: jsonSerialization['nextCheckInAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(
              jsonSerialization['nextCheckInAt'],
            ),
      utcOffsetMinutes: jsonSerialization['utcOffsetMinutes'] as int,
      serverTime: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['serverTime'],
      ),
      voiceBaseUrl: jsonSerialization['voiceBaseUrl'] as String,
    );
  }

  int circleId;

  String lovedOneName;

  _ipkn42zc.CircleStatus status;

  _igosldlc.CheckIn? activeCheckIn;

  /// Recent spoken lines. The screen plays any it has not played yet.
  List<_i5xr7ifk.Utterance> utterances;

  /// The most recent message from the family (last 3 days).
  _i5xr7ifk.Utterance? latestMessage;

  bool helpActive;

  String? helpAcknowledgedBy;

  List<String> caregiverNames;

  DateTime? nextCheckInAt;

  int utcOffsetMinutes;

  DateTime serverTime;

  /// Base URL of the web server route that serves synthesized speech.
  String voiceBaseUrl;

  /// Returns a shallow copy of this [CompanionState]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  CompanionState copyWith({
    int? circleId,
    String? lovedOneName,
    _ipkn42zc.CircleStatus? status,
    _igosldlc.CheckIn? activeCheckIn,
    List<_i5xr7ifk.Utterance>? utterances,
    _i5xr7ifk.Utterance? latestMessage,
    bool? helpActive,
    String? helpAcknowledgedBy,
    List<String>? caregiverNames,
    DateTime? nextCheckInAt,
    int? utcOffsetMinutes,
    DateTime? serverTime,
    String? voiceBaseUrl,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CompanionState',
      'circleId': circleId,
      'lovedOneName': lovedOneName,
      'status': status.toJson(),
      if (activeCheckIn != null) 'activeCheckIn': activeCheckIn?.toJson(),
      'utterances': utterances.toJson(valueToJson: (v) => v.toJson()),
      if (latestMessage != null) 'latestMessage': latestMessage?.toJson(),
      'helpActive': helpActive,
      if (helpAcknowledgedBy != null) 'helpAcknowledgedBy': helpAcknowledgedBy,
      'caregiverNames': caregiverNames.toJson(),
      if (nextCheckInAt != null) 'nextCheckInAt': nextCheckInAt?.toJson(),
      'utcOffsetMinutes': utcOffsetMinutes,
      'serverTime': serverTime.toJson(),
      'voiceBaseUrl': voiceBaseUrl,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CompanionState',
      'circleId': circleId,
      'lovedOneName': lovedOneName,
      'status': status.toJson(),
      if (activeCheckIn != null)
        'activeCheckIn': activeCheckIn?.toJsonForProtocol(),
      'utterances': utterances.toJson(
        valueToJson: (v) => v.toJsonForProtocol(),
      ),
      if (latestMessage != null)
        'latestMessage': latestMessage?.toJsonForProtocol(),
      'helpActive': helpActive,
      if (helpAcknowledgedBy != null) 'helpAcknowledgedBy': helpAcknowledgedBy,
      'caregiverNames': caregiverNames.toJson(),
      if (nextCheckInAt != null) 'nextCheckInAt': nextCheckInAt?.toJson(),
      'utcOffsetMinutes': utcOffsetMinutes,
      'serverTime': serverTime.toJson(),
      'voiceBaseUrl': voiceBaseUrl,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CompanionStateImpl extends CompanionState {
  _CompanionStateImpl({
    required int circleId,
    required String lovedOneName,
    required _ipkn42zc.CircleStatus status,
    _igosldlc.CheckIn? activeCheckIn,
    required List<_i5xr7ifk.Utterance> utterances,
    _i5xr7ifk.Utterance? latestMessage,
    required bool helpActive,
    String? helpAcknowledgedBy,
    required List<String> caregiverNames,
    DateTime? nextCheckInAt,
    required int utcOffsetMinutes,
    required DateTime serverTime,
    required String voiceBaseUrl,
  }) : super._(
         circleId: circleId,
         lovedOneName: lovedOneName,
         status: status,
         activeCheckIn: activeCheckIn,
         utterances: utterances,
         latestMessage: latestMessage,
         helpActive: helpActive,
         helpAcknowledgedBy: helpAcknowledgedBy,
         caregiverNames: caregiverNames,
         nextCheckInAt: nextCheckInAt,
         utcOffsetMinutes: utcOffsetMinutes,
         serverTime: serverTime,
         voiceBaseUrl: voiceBaseUrl,
       );

  /// Returns a shallow copy of this [CompanionState]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  CompanionState copyWith({
    int? circleId,
    String? lovedOneName,
    _ipkn42zc.CircleStatus? status,
    Object? activeCheckIn = _Undefined,
    List<_i5xr7ifk.Utterance>? utterances,
    Object? latestMessage = _Undefined,
    bool? helpActive,
    Object? helpAcknowledgedBy = _Undefined,
    List<String>? caregiverNames,
    Object? nextCheckInAt = _Undefined,
    int? utcOffsetMinutes,
    DateTime? serverTime,
    String? voiceBaseUrl,
  }) {
    return CompanionState(
      circleId: circleId ?? this.circleId,
      lovedOneName: lovedOneName ?? this.lovedOneName,
      status: status ?? this.status,
      activeCheckIn: activeCheckIn is _igosldlc.CheckIn?
          ? activeCheckIn
          : this.activeCheckIn?.copyWith(),
      utterances:
          utterances ?? this.utterances.map((e0) => e0.copyWith()).toList(),
      latestMessage: latestMessage is _i5xr7ifk.Utterance?
          ? latestMessage
          : this.latestMessage?.copyWith(),
      helpActive: helpActive ?? this.helpActive,
      helpAcknowledgedBy: helpAcknowledgedBy is String?
          ? helpAcknowledgedBy
          : this.helpAcknowledgedBy,
      caregiverNames:
          caregiverNames ?? this.caregiverNames.map((e0) => e0).toList(),
      nextCheckInAt: nextCheckInAt is DateTime?
          ? nextCheckInAt
          : this.nextCheckInAt,
      utcOffsetMinutes: utcOffsetMinutes ?? this.utcOffsetMinutes,
      serverTime: serverTime ?? this.serverTime,
      voiceBaseUrl: voiceBaseUrl ?? this.voiceBaseUrl,
    );
  }
}
