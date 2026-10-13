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
import '../tables/alert.dart' as _ie8c3tdm;
import '../tables/check_in.dart' as _igosldlc;
import '../tables/check_in_slot.dart' as _i221d97u;
import '../tables/circle.dart' as _ivugxez0;
import '../tables/circle_event.dart' as _ipkumjjm;
import '../tables/circle_member.dart' as _isfnstpy;
import '../tables/utterance.dart' as _i5xr7ifk;

/// Everything a caregiver's dashboard shows, pushed live over a stream.
abstract class CircleSnapshot
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  CircleSnapshot._({
    required this.circle,
    required this.me,
    required this.members,
    required this.slots,
    this.activeCheckIn,
    required this.recentCheckIns,
    required this.openAlerts,
    required this.recentEvents,
    required this.recentMessages,
    required this.deviceCount,
    this.companionLastSeenAt,
    this.nextCheckInAt,
    required this.serverTime,
    required this.voiceBaseUrl,
  });

  factory CircleSnapshot({
    required _ivugxez0.Circle circle,
    required _isfnstpy.CircleMember me,
    required List<_isfnstpy.CircleMember> members,
    required List<_i221d97u.CheckInSlot> slots,
    _igosldlc.CheckIn? activeCheckIn,
    required List<_igosldlc.CheckIn> recentCheckIns,
    required List<_ie8c3tdm.Alert> openAlerts,
    required List<_ipkumjjm.CircleEvent> recentEvents,
    required List<_i5xr7ifk.Utterance> recentMessages,
    required int deviceCount,
    DateTime? companionLastSeenAt,
    DateTime? nextCheckInAt,
    required DateTime serverTime,
    required String voiceBaseUrl,
  }) = _CircleSnapshotImpl;

  factory CircleSnapshot.fromJson(Map<String, dynamic> jsonSerialization) {
    return CircleSnapshot(
      circle: _iijvse0e.Protocol().deserialize<_ivugxez0.Circle>(
        jsonSerialization['circle'],
      ),
      me: _iijvse0e.Protocol().deserialize<_isfnstpy.CircleMember>(
        jsonSerialization['me'],
      ),
      members: _iijvse0e.Protocol().deserialize<List<_isfnstpy.CircleMember>>(
        jsonSerialization['members'],
      ),
      slots: _iijvse0e.Protocol().deserialize<List<_i221d97u.CheckInSlot>>(
        jsonSerialization['slots'],
      ),
      activeCheckIn: jsonSerialization['activeCheckIn'] == null
          ? null
          : _iijvse0e.Protocol().deserialize<_igosldlc.CheckIn>(
              jsonSerialization['activeCheckIn'],
            ),
      recentCheckIns: _iijvse0e.Protocol().deserialize<List<_igosldlc.CheckIn>>(
        jsonSerialization['recentCheckIns'],
      ),
      openAlerts: _iijvse0e.Protocol().deserialize<List<_ie8c3tdm.Alert>>(
        jsonSerialization['openAlerts'],
      ),
      recentEvents: _iijvse0e.Protocol()
          .deserialize<List<_ipkumjjm.CircleEvent>>(
            jsonSerialization['recentEvents'],
          ),
      recentMessages: _iijvse0e.Protocol()
          .deserialize<List<_i5xr7ifk.Utterance>>(
            jsonSerialization['recentMessages'],
          ),
      deviceCount: jsonSerialization['deviceCount'] as int,
      companionLastSeenAt: jsonSerialization['companionLastSeenAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(
              jsonSerialization['companionLastSeenAt'],
            ),
      nextCheckInAt: jsonSerialization['nextCheckInAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(
              jsonSerialization['nextCheckInAt'],
            ),
      serverTime: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['serverTime'],
      ),
      voiceBaseUrl: jsonSerialization['voiceBaseUrl'] as String,
    );
  }

  _ivugxez0.Circle circle;

  _isfnstpy.CircleMember me;

  List<_isfnstpy.CircleMember> members;

  List<_i221d97u.CheckInSlot> slots;

  _igosldlc.CheckIn? activeCheckIn;

  /// Last 7 days of check-ins, newest first.
  List<_igosldlc.CheckIn> recentCheckIns;

  List<_ie8c3tdm.Alert> openAlerts;

  List<_ipkumjjm.CircleEvent> recentEvents;

  List<_i5xr7ifk.Utterance> recentMessages;

  int deviceCount;

  DateTime? companionLastSeenAt;

  DateTime? nextCheckInAt;

  DateTime serverTime;

  /// Base URL of the web server route that serves synthesized speech.
  String voiceBaseUrl;

  /// Returns a shallow copy of this [CircleSnapshot]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  CircleSnapshot copyWith({
    _ivugxez0.Circle? circle,
    _isfnstpy.CircleMember? me,
    List<_isfnstpy.CircleMember>? members,
    List<_i221d97u.CheckInSlot>? slots,
    _igosldlc.CheckIn? activeCheckIn,
    List<_igosldlc.CheckIn>? recentCheckIns,
    List<_ie8c3tdm.Alert>? openAlerts,
    List<_ipkumjjm.CircleEvent>? recentEvents,
    List<_i5xr7ifk.Utterance>? recentMessages,
    int? deviceCount,
    DateTime? companionLastSeenAt,
    DateTime? nextCheckInAt,
    DateTime? serverTime,
    String? voiceBaseUrl,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CircleSnapshot',
      'circle': circle.toJson(),
      'me': me.toJson(),
      'members': members.toJson(valueToJson: (v) => v.toJson()),
      'slots': slots.toJson(valueToJson: (v) => v.toJson()),
      if (activeCheckIn != null) 'activeCheckIn': activeCheckIn?.toJson(),
      'recentCheckIns': recentCheckIns.toJson(valueToJson: (v) => v.toJson()),
      'openAlerts': openAlerts.toJson(valueToJson: (v) => v.toJson()),
      'recentEvents': recentEvents.toJson(valueToJson: (v) => v.toJson()),
      'recentMessages': recentMessages.toJson(valueToJson: (v) => v.toJson()),
      'deviceCount': deviceCount,
      if (companionLastSeenAt != null)
        'companionLastSeenAt': companionLastSeenAt?.toJson(),
      if (nextCheckInAt != null) 'nextCheckInAt': nextCheckInAt?.toJson(),
      'serverTime': serverTime.toJson(),
      'voiceBaseUrl': voiceBaseUrl,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CircleSnapshot',
      'circle': circle.toJsonForProtocol(),
      'me': me.toJsonForProtocol(),
      'members': members.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'slots': slots.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      if (activeCheckIn != null)
        'activeCheckIn': activeCheckIn?.toJsonForProtocol(),
      'recentCheckIns': recentCheckIns.toJson(
        valueToJson: (v) => v.toJsonForProtocol(),
      ),
      'openAlerts': openAlerts.toJson(
        valueToJson: (v) => v.toJsonForProtocol(),
      ),
      'recentEvents': recentEvents.toJson(
        valueToJson: (v) => v.toJsonForProtocol(),
      ),
      'recentMessages': recentMessages.toJson(
        valueToJson: (v) => v.toJsonForProtocol(),
      ),
      'deviceCount': deviceCount,
      if (companionLastSeenAt != null)
        'companionLastSeenAt': companionLastSeenAt?.toJson(),
      if (nextCheckInAt != null) 'nextCheckInAt': nextCheckInAt?.toJson(),
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

class _CircleSnapshotImpl extends CircleSnapshot {
  _CircleSnapshotImpl({
    required _ivugxez0.Circle circle,
    required _isfnstpy.CircleMember me,
    required List<_isfnstpy.CircleMember> members,
    required List<_i221d97u.CheckInSlot> slots,
    _igosldlc.CheckIn? activeCheckIn,
    required List<_igosldlc.CheckIn> recentCheckIns,
    required List<_ie8c3tdm.Alert> openAlerts,
    required List<_ipkumjjm.CircleEvent> recentEvents,
    required List<_i5xr7ifk.Utterance> recentMessages,
    required int deviceCount,
    DateTime? companionLastSeenAt,
    DateTime? nextCheckInAt,
    required DateTime serverTime,
    required String voiceBaseUrl,
  }) : super._(
         circle: circle,
         me: me,
         members: members,
         slots: slots,
         activeCheckIn: activeCheckIn,
         recentCheckIns: recentCheckIns,
         openAlerts: openAlerts,
         recentEvents: recentEvents,
         recentMessages: recentMessages,
         deviceCount: deviceCount,
         companionLastSeenAt: companionLastSeenAt,
         nextCheckInAt: nextCheckInAt,
         serverTime: serverTime,
         voiceBaseUrl: voiceBaseUrl,
       );

  /// Returns a shallow copy of this [CircleSnapshot]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  CircleSnapshot copyWith({
    _ivugxez0.Circle? circle,
    _isfnstpy.CircleMember? me,
    List<_isfnstpy.CircleMember>? members,
    List<_i221d97u.CheckInSlot>? slots,
    Object? activeCheckIn = _Undefined,
    List<_igosldlc.CheckIn>? recentCheckIns,
    List<_ie8c3tdm.Alert>? openAlerts,
    List<_ipkumjjm.CircleEvent>? recentEvents,
    List<_i5xr7ifk.Utterance>? recentMessages,
    int? deviceCount,
    Object? companionLastSeenAt = _Undefined,
    Object? nextCheckInAt = _Undefined,
    DateTime? serverTime,
    String? voiceBaseUrl,
  }) {
    return CircleSnapshot(
      circle: circle ?? this.circle.copyWith(),
      me: me ?? this.me.copyWith(),
      members: members ?? this.members.map((e0) => e0.copyWith()).toList(),
      slots: slots ?? this.slots.map((e0) => e0.copyWith()).toList(),
      activeCheckIn: activeCheckIn is _igosldlc.CheckIn?
          ? activeCheckIn
          : this.activeCheckIn?.copyWith(),
      recentCheckIns:
          recentCheckIns ??
          this.recentCheckIns.map((e0) => e0.copyWith()).toList(),
      openAlerts:
          openAlerts ?? this.openAlerts.map((e0) => e0.copyWith()).toList(),
      recentEvents:
          recentEvents ?? this.recentEvents.map((e0) => e0.copyWith()).toList(),
      recentMessages:
          recentMessages ??
          this.recentMessages.map((e0) => e0.copyWith()).toList(),
      deviceCount: deviceCount ?? this.deviceCount,
      companionLastSeenAt: companionLastSeenAt is DateTime?
          ? companionLastSeenAt
          : this.companionLastSeenAt,
      nextCheckInAt: nextCheckInAt is DateTime?
          ? nextCheckInAt
          : this.nextCheckInAt,
      serverTime: serverTime ?? this.serverTime,
      voiceBaseUrl: voiceBaseUrl ?? this.voiceBaseUrl,
    );
  }
}
