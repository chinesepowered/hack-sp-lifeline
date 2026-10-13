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

/// A daily check-in time, in the loved one's local time. Each slot is backed
/// by a recurring (cron) future call.
abstract class CheckInSlot
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  CheckInSlot._({
    this.id,
    required this.circleId,
    required this.minuteOfDay,
    required this.label,
  });

  factory CheckInSlot({
    int? id,
    required int circleId,
    required int minuteOfDay,
    required String label,
  }) = _CheckInSlotImpl;

  factory CheckInSlot.fromJson(Map<String, dynamic> jsonSerialization) {
    return CheckInSlot(
      id: jsonSerialization['id'] as int?,
      circleId: jsonSerialization['circleId'] as int,
      minuteOfDay: jsonSerialization['minuteOfDay'] as int,
      label: jsonSerialization['label'] as String,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int circleId;

  /// Minutes after local midnight, e.g. 540 for 09:00.
  int minuteOfDay;

  String label;

  /// Returns a shallow copy of this [CheckInSlot]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  CheckInSlot copyWith({
    int? id,
    int? circleId,
    int? minuteOfDay,
    String? label,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CheckInSlot',
      if (id != null) 'id': id,
      'circleId': circleId,
      'minuteOfDay': minuteOfDay,
      'label': label,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CheckInSlot',
      if (id != null) 'id': id,
      'circleId': circleId,
      'minuteOfDay': minuteOfDay,
      'label': label,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CheckInSlotImpl extends CheckInSlot {
  _CheckInSlotImpl({
    int? id,
    required int circleId,
    required int minuteOfDay,
    required String label,
  }) : super._(
         id: id,
         circleId: circleId,
         minuteOfDay: minuteOfDay,
         label: label,
       );

  /// Returns a shallow copy of this [CheckInSlot]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  CheckInSlot copyWith({
    Object? id = _Undefined,
    int? circleId,
    int? minuteOfDay,
    String? label,
  }) {
    return CheckInSlot(
      id: id is int? ? id : this.id,
      circleId: circleId ?? this.circleId,
      minuteOfDay: minuteOfDay ?? this.minuteOfDay,
      label: label ?? this.label,
    );
  }
}
