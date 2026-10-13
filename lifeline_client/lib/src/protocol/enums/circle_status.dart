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

/// The live, at-a-glance status of a care circle's loved one.
enum CircleStatus implements _isc.SerializableModel {
  /// No check-in has happened yet.
  quiet,

  /// The latest check-in was answered and nothing needs attention.
  ok,

  /// A check-in prompt is waiting for an answer (within the grace period).
  awaiting,

  /// The loved one answered but mentioned something worth a follow-up.
  concern,

  /// A check-in went unanswered past the grace period.
  missed,

  /// Help was requested, or the loved one is unresponsive. Act now.
  alert;

  static CircleStatus fromJson(String name) {
    switch (name) {
      case 'quiet':
        return CircleStatus.quiet;
      case 'ok':
        return CircleStatus.ok;
      case 'awaiting':
        return CircleStatus.awaiting;
      case 'concern':
        return CircleStatus.concern;
      case 'missed':
        return CircleStatus.missed;
      case 'alert':
        return CircleStatus.alert;
      default:
        throw ArgumentError(
          'Value "$name" cannot be converted to "CircleStatus"',
        );
    }
  }

  @override
  String toJson() => name;

  @override
  String toString() => name;
}
