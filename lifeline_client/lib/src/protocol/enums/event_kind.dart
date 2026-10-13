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

/// Entries in a circle's activity timeline.
enum EventKind implements _isc.SerializableModel {
  circleCreated,
  memberJoined,
  devicePaired,
  checkInSent,
  checkedInOk,
  concernReported,
  helpRequested,
  checkInMissed,
  escalated,
  alertAcknowledged,
  alertResolved,
  messageSent,
  voiceNote,
  settingsChanged;

  static EventKind fromJson(String name) {
    switch (name) {
      case 'circleCreated':
        return EventKind.circleCreated;
      case 'memberJoined':
        return EventKind.memberJoined;
      case 'devicePaired':
        return EventKind.devicePaired;
      case 'checkInSent':
        return EventKind.checkInSent;
      case 'checkedInOk':
        return EventKind.checkedInOk;
      case 'concernReported':
        return EventKind.concernReported;
      case 'helpRequested':
        return EventKind.helpRequested;
      case 'checkInMissed':
        return EventKind.checkInMissed;
      case 'escalated':
        return EventKind.escalated;
      case 'alertAcknowledged':
        return EventKind.alertAcknowledged;
      case 'alertResolved':
        return EventKind.alertResolved;
      case 'messageSent':
        return EventKind.messageSent;
      case 'voiceNote':
        return EventKind.voiceNote;
      case 'settingsChanged':
        return EventKind.settingsChanged;
      default:
        throw ArgumentError('Value "$name" cannot be converted to "EventKind"');
    }
  }

  @override
  String toJson() => name;

  @override
  String toString() => name;
}
