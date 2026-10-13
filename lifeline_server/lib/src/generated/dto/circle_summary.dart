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
import 'package:serverpod/serverpod.dart' as _is;
import '../enums/circle_status.dart' as _ipkn42zc;
import '../enums/member_role.dart' as _iw6qhlck;

abstract class CircleSummary
    implements _is.SerializableModel, _is.ProtocolSerialization {
  CircleSummary._({
    required this.circleId,
    required this.lovedOneName,
    required this.status,
    required this.myRole,
    required this.isDemo,
  });

  factory CircleSummary({
    required int circleId,
    required String lovedOneName,
    required _ipkn42zc.CircleStatus status,
    required _iw6qhlck.MemberRole myRole,
    required bool isDemo,
  }) = _CircleSummaryImpl;

  factory CircleSummary.fromJson(Map<String, dynamic> jsonSerialization) {
    return CircleSummary(
      circleId: jsonSerialization['circleId'] as int,
      lovedOneName: jsonSerialization['lovedOneName'] as String,
      status: _ipkn42zc.CircleStatus.fromJson(
        (jsonSerialization['status'] as String),
      ),
      myRole: _iw6qhlck.MemberRole.fromJson(
        (jsonSerialization['myRole'] as String),
      ),
      isDemo: _is.BoolJsonExtension.fromJson(jsonSerialization['isDemo']),
    );
  }

  int circleId;

  String lovedOneName;

  _ipkn42zc.CircleStatus status;

  _iw6qhlck.MemberRole myRole;

  bool isDemo;

  /// Returns a shallow copy of this [CircleSummary]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  CircleSummary copyWith({
    int? circleId,
    String? lovedOneName,
    _ipkn42zc.CircleStatus? status,
    _iw6qhlck.MemberRole? myRole,
    bool? isDemo,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CircleSummary',
      'circleId': circleId,
      'lovedOneName': lovedOneName,
      'status': status.toJson(),
      'myRole': myRole.toJson(),
      'isDemo': isDemo,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CircleSummary',
      'circleId': circleId,
      'lovedOneName': lovedOneName,
      'status': status.toJson(),
      'myRole': myRole.toJson(),
      'isDemo': isDemo,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _CircleSummaryImpl extends CircleSummary {
  _CircleSummaryImpl({
    required int circleId,
    required String lovedOneName,
    required _ipkn42zc.CircleStatus status,
    required _iw6qhlck.MemberRole myRole,
    required bool isDemo,
  }) : super._(
         circleId: circleId,
         lovedOneName: lovedOneName,
         status: status,
         myRole: myRole,
         isDemo: isDemo,
       );

  /// Returns a shallow copy of this [CircleSummary]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  CircleSummary copyWith({
    int? circleId,
    String? lovedOneName,
    _ipkn42zc.CircleStatus? status,
    _iw6qhlck.MemberRole? myRole,
    bool? isDemo,
  }) {
    return CircleSummary(
      circleId: circleId ?? this.circleId,
      lovedOneName: lovedOneName ?? this.lovedOneName,
      status: status ?? this.status,
      myRole: myRole ?? this.myRole,
      isDemo: isDemo ?? this.isDemo,
    );
  }
}
