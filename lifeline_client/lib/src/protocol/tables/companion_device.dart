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

/// A tablet paired to a circle. It authenticates with a long random token;
/// only its SHA-256 hash is stored.
abstract class CompanionDevice
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  CompanionDevice._({
    this.id,
    required this.circleId,
    required this.label,
    DateTime? pairedAt,
    this.lastSeenAt,
  }) : pairedAt = pairedAt ?? DateTime.now();

  factory CompanionDevice({
    int? id,
    required int circleId,
    required String label,
    DateTime? pairedAt,
    DateTime? lastSeenAt,
  }) = _CompanionDeviceImpl;

  factory CompanionDevice.fromJson(Map<String, dynamic> jsonSerialization) {
    return CompanionDevice(
      id: jsonSerialization['id'] as int?,
      circleId: jsonSerialization['circleId'] as int,
      label: jsonSerialization['label'] as String,
      pairedAt: jsonSerialization['pairedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['pairedAt']),
      lastSeenAt: jsonSerialization['lastSeenAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(
              jsonSerialization['lastSeenAt'],
            ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int circleId;

  String label;

  DateTime pairedAt;

  DateTime? lastSeenAt;

  /// Returns a shallow copy of this [CompanionDevice]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  CompanionDevice copyWith({
    int? id,
    int? circleId,
    String? label,
    DateTime? pairedAt,
    DateTime? lastSeenAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CompanionDevice',
      if (id != null) 'id': id,
      'circleId': circleId,
      'label': label,
      'pairedAt': pairedAt.toJson(),
      if (lastSeenAt != null) 'lastSeenAt': lastSeenAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CompanionDevice',
      if (id != null) 'id': id,
      'circleId': circleId,
      'label': label,
      'pairedAt': pairedAt.toJson(),
      if (lastSeenAt != null) 'lastSeenAt': lastSeenAt?.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CompanionDeviceImpl extends CompanionDevice {
  _CompanionDeviceImpl({
    int? id,
    required int circleId,
    required String label,
    DateTime? pairedAt,
    DateTime? lastSeenAt,
  }) : super._(
         id: id,
         circleId: circleId,
         label: label,
         pairedAt: pairedAt,
         lastSeenAt: lastSeenAt,
       );

  /// Returns a shallow copy of this [CompanionDevice]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  CompanionDevice copyWith({
    Object? id = _Undefined,
    int? circleId,
    String? label,
    DateTime? pairedAt,
    Object? lastSeenAt = _Undefined,
  }) {
    return CompanionDevice(
      id: id is int? ? id : this.id,
      circleId: circleId ?? this.circleId,
      label: label ?? this.label,
      pairedAt: pairedAt ?? this.pairedAt,
      lastSeenAt: lastSeenAt is DateTime? ? lastSeenAt : this.lastSeenAt,
    );
  }
}
