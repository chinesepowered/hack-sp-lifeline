/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member
// ignore_for_file: dead_code, unnecessary_type_check

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:lifeline_client/src/protocol/dto/circle_summary.dart'
    as _itnes0kr;
import 'package:lifeline_client/src/protocol/dto/voice_option.dart'
    as _i037yipj;
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _iacc;
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart'
    as _iaic;
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import 'dto/circle_settings.dart' as _i3ka3h96;
import 'dto/circle_snapshot.dart' as _ifhasew7;
import 'dto/circle_summary.dart' as _iu17mqvp;
import 'dto/companion_state.dart' as _iulcjp1w;
import 'dto/demo_setup.dart' as _i0j74by7;
import 'dto/pairing_result.dart' as _igma2i47;
import 'dto/voice_option.dart' as _iqedek9t;
import 'dto/voice_reply_result.dart' as _ituo13k3;
import 'enums/alert_kind.dart' as _i7t4x9tm;
import 'enums/alert_level.dart' as _iubt32n2;
import 'enums/check_in_kind.dart' as _ikmb3xjn;
import 'enums/check_in_status.dart' as _ijrvdr1p;
import 'enums/circle_status.dart' as _i6qvt1rc;
import 'enums/event_kind.dart' as _i27hojh9;
import 'enums/lifeline_error_code.dart' as _ij50bjyb;
import 'enums/member_role.dart' as _icimtxba;
import 'enums/response_method.dart' as _igp5zq1l;
import 'enums/triage_level.dart' as _istrf3zd;
import 'enums/utterance_kind.dart' as _ixwsitj3;
import 'lifeline_exception.dart' as _irswewhe;
import 'tables/alert.dart' as _ix65b5hp;
import 'tables/check_in.dart' as _i9wmztxc;
import 'tables/check_in_slot.dart' as _is1itcsv;
import 'tables/circle.dart' as _is1kwm8w;
import 'tables/circle_event.dart' as _ii1xfzkz;
import 'tables/circle_member.dart' as _isezf3zm;
import 'tables/companion_device.dart' as _i34wu1yp;
import 'tables/utterance.dart' as _ikx4o9d3;
export 'dto/circle_settings.dart';
export 'dto/circle_snapshot.dart';
export 'dto/circle_summary.dart';
export 'dto/companion_state.dart';
export 'dto/demo_setup.dart';
export 'dto/pairing_result.dart';
export 'dto/voice_option.dart';
export 'dto/voice_reply_result.dart';
export 'enums/alert_kind.dart';
export 'enums/alert_level.dart';
export 'enums/check_in_kind.dart';
export 'enums/check_in_status.dart';
export 'enums/circle_status.dart';
export 'enums/event_kind.dart';
export 'enums/lifeline_error_code.dart';
export 'enums/member_role.dart';
export 'enums/response_method.dart';
export 'enums/triage_level.dart';
export 'enums/utterance_kind.dart';
export 'lifeline_exception.dart';
export 'tables/alert.dart';
export 'tables/check_in.dart';
export 'tables/check_in_slot.dart';
export 'tables/circle.dart';
export 'tables/circle_event.dart';
export 'tables/circle_member.dart';
export 'tables/companion_device.dart';
export 'tables/utterance.dart';
export 'client.dart';

class Protocol extends _isc.SerializationManager {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._().._registerHostProtocols();

  static String? getClassNameFromObjectJson(dynamic data) {
    if (data is! Map) return null;
    final className = data['__className__'] as String?;
    return className;
  }

  @override
  T deserialize<T>(
    dynamic data, [
    Type? t,
  ]) {
    t ??= T;

    final dataClassName = getClassNameFromObjectJson(data);
    if (dataClassName != null && dataClassName != getClassNameForType(t)) {
      try {
        return deserializeByClassName({
          'className': dataClassName,
          'data': data,
        });
      } on _isc.DeserializationClassNameNotFoundException catch (_) {
        // If the className is not recognized (e.g., older client receiving
        // data with a new subtype), fall back to deserializing without the
        // className, using the expected type T.
      }
    }

    if (t == _i3ka3h96.CircleSettings) {
      return _i3ka3h96.CircleSettings.fromJson(data) as T;
    }
    if (t == _ifhasew7.CircleSnapshot) {
      return _ifhasew7.CircleSnapshot.fromJson(data) as T;
    }
    if (t == _iu17mqvp.CircleSummary) {
      return _iu17mqvp.CircleSummary.fromJson(data) as T;
    }
    if (t == _iulcjp1w.CompanionState) {
      return _iulcjp1w.CompanionState.fromJson(data) as T;
    }
    if (t == _i0j74by7.DemoSetup) {
      return _i0j74by7.DemoSetup.fromJson(data) as T;
    }
    if (t == _igma2i47.PairingResult) {
      return _igma2i47.PairingResult.fromJson(data) as T;
    }
    if (t == _iqedek9t.VoiceOption) {
      return _iqedek9t.VoiceOption.fromJson(data) as T;
    }
    if (t == _ituo13k3.VoiceReplyResult) {
      return _ituo13k3.VoiceReplyResult.fromJson(data) as T;
    }
    if (t == _i7t4x9tm.AlertKind) {
      return _i7t4x9tm.AlertKind.fromJson(data) as T;
    }
    if (t == _iubt32n2.AlertLevel) {
      return _iubt32n2.AlertLevel.fromJson(data) as T;
    }
    if (t == _ikmb3xjn.CheckInKind) {
      return _ikmb3xjn.CheckInKind.fromJson(data) as T;
    }
    if (t == _ijrvdr1p.CheckInStatus) {
      return _ijrvdr1p.CheckInStatus.fromJson(data) as T;
    }
    if (t == _i6qvt1rc.CircleStatus) {
      return _i6qvt1rc.CircleStatus.fromJson(data) as T;
    }
    if (t == _i27hojh9.EventKind) {
      return _i27hojh9.EventKind.fromJson(data) as T;
    }
    if (t == _ij50bjyb.LifelineErrorCode) {
      return _ij50bjyb.LifelineErrorCode.fromJson(data) as T;
    }
    if (t == _icimtxba.MemberRole) {
      return _icimtxba.MemberRole.fromJson(data) as T;
    }
    if (t == _igp5zq1l.ResponseMethod) {
      return _igp5zq1l.ResponseMethod.fromJson(data) as T;
    }
    if (t == _istrf3zd.TriageLevel) {
      return _istrf3zd.TriageLevel.fromJson(data) as T;
    }
    if (t == _ixwsitj3.UtteranceKind) {
      return _ixwsitj3.UtteranceKind.fromJson(data) as T;
    }
    if (t == _irswewhe.LifelineException) {
      return _irswewhe.LifelineException.fromJson(data) as T;
    }
    if (t == _ix65b5hp.Alert) {
      return _ix65b5hp.Alert.fromJson(data) as T;
    }
    if (t == _i9wmztxc.CheckIn) {
      return _i9wmztxc.CheckIn.fromJson(data) as T;
    }
    if (t == _is1itcsv.CheckInSlot) {
      return _is1itcsv.CheckInSlot.fromJson(data) as T;
    }
    if (t == _is1kwm8w.Circle) {
      return _is1kwm8w.Circle.fromJson(data) as T;
    }
    if (t == _ii1xfzkz.CircleEvent) {
      return _ii1xfzkz.CircleEvent.fromJson(data) as T;
    }
    if (t == _isezf3zm.CircleMember) {
      return _isezf3zm.CircleMember.fromJson(data) as T;
    }
    if (t == _i34wu1yp.CompanionDevice) {
      return _i34wu1yp.CompanionDevice.fromJson(data) as T;
    }
    if (t == _ikx4o9d3.Utterance) {
      return _ikx4o9d3.Utterance.fromJson(data) as T;
    }
    if (t == _isc.getType<_i3ka3h96.CircleSettings?>()) {
      return (data != null ? _i3ka3h96.CircleSettings.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_ifhasew7.CircleSnapshot?>()) {
      return (data != null ? _ifhasew7.CircleSnapshot.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_iu17mqvp.CircleSummary?>()) {
      return (data != null ? _iu17mqvp.CircleSummary.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_iulcjp1w.CompanionState?>()) {
      return (data != null ? _iulcjp1w.CompanionState.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_i0j74by7.DemoSetup?>()) {
      return (data != null ? _i0j74by7.DemoSetup.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_igma2i47.PairingResult?>()) {
      return (data != null ? _igma2i47.PairingResult.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_iqedek9t.VoiceOption?>()) {
      return (data != null ? _iqedek9t.VoiceOption.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_ituo13k3.VoiceReplyResult?>()) {
      return (data != null ? _ituo13k3.VoiceReplyResult.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_i7t4x9tm.AlertKind?>()) {
      return (data != null ? _i7t4x9tm.AlertKind.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_iubt32n2.AlertLevel?>()) {
      return (data != null ? _iubt32n2.AlertLevel.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_ikmb3xjn.CheckInKind?>()) {
      return (data != null ? _ikmb3xjn.CheckInKind.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_ijrvdr1p.CheckInStatus?>()) {
      return (data != null ? _ijrvdr1p.CheckInStatus.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_i6qvt1rc.CircleStatus?>()) {
      return (data != null ? _i6qvt1rc.CircleStatus.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_i27hojh9.EventKind?>()) {
      return (data != null ? _i27hojh9.EventKind.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_ij50bjyb.LifelineErrorCode?>()) {
      return (data != null ? _ij50bjyb.LifelineErrorCode.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_icimtxba.MemberRole?>()) {
      return (data != null ? _icimtxba.MemberRole.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_igp5zq1l.ResponseMethod?>()) {
      return (data != null ? _igp5zq1l.ResponseMethod.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_istrf3zd.TriageLevel?>()) {
      return (data != null ? _istrf3zd.TriageLevel.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_ixwsitj3.UtteranceKind?>()) {
      return (data != null ? _ixwsitj3.UtteranceKind.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_irswewhe.LifelineException?>()) {
      return (data != null ? _irswewhe.LifelineException.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_ix65b5hp.Alert?>()) {
      return (data != null ? _ix65b5hp.Alert.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_i9wmztxc.CheckIn?>()) {
      return (data != null ? _i9wmztxc.CheckIn.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_is1itcsv.CheckInSlot?>()) {
      return (data != null ? _is1itcsv.CheckInSlot.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_is1kwm8w.Circle?>()) {
      return (data != null ? _is1kwm8w.Circle.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_ii1xfzkz.CircleEvent?>()) {
      return (data != null ? _ii1xfzkz.CircleEvent.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_isezf3zm.CircleMember?>()) {
      return (data != null ? _isezf3zm.CircleMember.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_i34wu1yp.CompanionDevice?>()) {
      return (data != null ? _i34wu1yp.CompanionDevice.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_ikx4o9d3.Utterance?>()) {
      return (data != null ? _ikx4o9d3.Utterance.fromJson(data) : null) as T;
    }
    if (t == List<int>) {
      return (data as List).map((e) => deserialize<int>(e)).toList() as T;
    }
    if (t == List<_isezf3zm.CircleMember>) {
      return (data as List)
              .map((e) => deserialize<_isezf3zm.CircleMember>(e))
              .toList()
          as T;
    }
    if (t == List<_is1itcsv.CheckInSlot>) {
      return (data as List)
              .map((e) => deserialize<_is1itcsv.CheckInSlot>(e))
              .toList()
          as T;
    }
    if (t == List<_i9wmztxc.CheckIn>) {
      return (data as List)
              .map((e) => deserialize<_i9wmztxc.CheckIn>(e))
              .toList()
          as T;
    }
    if (t == List<_ix65b5hp.Alert>) {
      return (data as List).map((e) => deserialize<_ix65b5hp.Alert>(e)).toList()
          as T;
    }
    if (t == List<_ii1xfzkz.CircleEvent>) {
      return (data as List)
              .map((e) => deserialize<_ii1xfzkz.CircleEvent>(e))
              .toList()
          as T;
    }
    if (t == List<_ikx4o9d3.Utterance>) {
      return (data as List)
              .map((e) => deserialize<_ikx4o9d3.Utterance>(e))
              .toList()
          as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == _isc.getType<List<String>?>()) {
      return (data != null
              ? (data as List).map((e) => deserialize<String>(e)).toList()
              : null)
          as T;
    }
    if (t == List<_i037yipj.VoiceOption>) {
      return (data as List)
              .map((e) => deserialize<_i037yipj.VoiceOption>(e))
              .toList()
          as T;
    }
    if (t == List<_itnes0kr.CircleSummary>) {
      return (data as List)
              .map((e) => deserialize<_itnes0kr.CircleSummary>(e))
              .toList()
          as T;
    }
    try {
      return _iaic.Protocol().deserialize<T>(data, t);
    } on _isc.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _iacc.Protocol().deserialize<T>(data, t);
    } on _isc.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _i3ka3h96.CircleSettings => 'CircleSettings',
      _ifhasew7.CircleSnapshot => 'CircleSnapshot',
      _iu17mqvp.CircleSummary => 'CircleSummary',
      _iulcjp1w.CompanionState => 'CompanionState',
      _i0j74by7.DemoSetup => 'DemoSetup',
      _igma2i47.PairingResult => 'PairingResult',
      _iqedek9t.VoiceOption => 'VoiceOption',
      _ituo13k3.VoiceReplyResult => 'VoiceReplyResult',
      _i7t4x9tm.AlertKind => 'AlertKind',
      _iubt32n2.AlertLevel => 'AlertLevel',
      _ikmb3xjn.CheckInKind => 'CheckInKind',
      _ijrvdr1p.CheckInStatus => 'CheckInStatus',
      _i6qvt1rc.CircleStatus => 'CircleStatus',
      _i27hojh9.EventKind => 'EventKind',
      _ij50bjyb.LifelineErrorCode => 'LifelineErrorCode',
      _icimtxba.MemberRole => 'MemberRole',
      _igp5zq1l.ResponseMethod => 'ResponseMethod',
      _istrf3zd.TriageLevel => 'TriageLevel',
      _ixwsitj3.UtteranceKind => 'UtteranceKind',
      _irswewhe.LifelineException => 'LifelineException',
      _ix65b5hp.Alert => 'Alert',
      _i9wmztxc.CheckIn => 'CheckIn',
      _is1itcsv.CheckInSlot => 'CheckInSlot',
      _is1kwm8w.Circle => 'Circle',
      _ii1xfzkz.CircleEvent => 'CircleEvent',
      _isezf3zm.CircleMember => 'CircleMember',
      _i34wu1yp.CompanionDevice => 'CompanionDevice',
      _ikx4o9d3.Utterance => 'Utterance',
      _ => null,
    };
  }

  @override
  String? getClassNameForObject(Object? data) {
    String? className = super.getClassNameForObject(data);
    if (className != null) return className;

    if (data is Map<String, dynamic> && data['__className__'] is String) {
      return (data['__className__'] as String).replaceFirst('lifeline.', '');
    }

    switch (data) {
      case _i3ka3h96.CircleSettings():
        return 'CircleSettings';
      case _ifhasew7.CircleSnapshot():
        return 'CircleSnapshot';
      case _iu17mqvp.CircleSummary():
        return 'CircleSummary';
      case _iulcjp1w.CompanionState():
        return 'CompanionState';
      case _i0j74by7.DemoSetup():
        return 'DemoSetup';
      case _igma2i47.PairingResult():
        return 'PairingResult';
      case _iqedek9t.VoiceOption():
        return 'VoiceOption';
      case _ituo13k3.VoiceReplyResult():
        return 'VoiceReplyResult';
      case _i7t4x9tm.AlertKind():
        return 'AlertKind';
      case _iubt32n2.AlertLevel():
        return 'AlertLevel';
      case _ikmb3xjn.CheckInKind():
        return 'CheckInKind';
      case _ijrvdr1p.CheckInStatus():
        return 'CheckInStatus';
      case _i6qvt1rc.CircleStatus():
        return 'CircleStatus';
      case _i27hojh9.EventKind():
        return 'EventKind';
      case _ij50bjyb.LifelineErrorCode():
        return 'LifelineErrorCode';
      case _icimtxba.MemberRole():
        return 'MemberRole';
      case _igp5zq1l.ResponseMethod():
        return 'ResponseMethod';
      case _istrf3zd.TriageLevel():
        return 'TriageLevel';
      case _ixwsitj3.UtteranceKind():
        return 'UtteranceKind';
      case _irswewhe.LifelineException():
        return 'LifelineException';
      case _ix65b5hp.Alert():
        return 'Alert';
      case _i9wmztxc.CheckIn():
        return 'CheckIn';
      case _is1itcsv.CheckInSlot():
        return 'CheckInSlot';
      case _is1kwm8w.Circle():
        return 'Circle';
      case _ii1xfzkz.CircleEvent():
        return 'CircleEvent';
      case _isezf3zm.CircleMember():
        return 'CircleMember';
      case _i34wu1yp.CompanionDevice():
        return 'CompanionDevice';
      case _ikx4o9d3.Utterance():
        return 'Utterance';
    }
    className = _iaic.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.')
          ? className
          : 'serverpod_auth_idp.$className';
    }
    className = _iacc.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.')
          ? className
          : 'serverpod_auth_core.$className';
    }
    return null;
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    var dataClassName = data['className'];
    if (dataClassName is! String) {
      return super.deserializeByClassName(data);
    }
    if (dataClassName == 'CircleSettings') {
      return deserialize<_i3ka3h96.CircleSettings>(data['data']);
    }
    if (dataClassName == 'CircleSnapshot') {
      return deserialize<_ifhasew7.CircleSnapshot>(data['data']);
    }
    if (dataClassName == 'CircleSummary') {
      return deserialize<_iu17mqvp.CircleSummary>(data['data']);
    }
    if (dataClassName == 'CompanionState') {
      return deserialize<_iulcjp1w.CompanionState>(data['data']);
    }
    if (dataClassName == 'DemoSetup') {
      return deserialize<_i0j74by7.DemoSetup>(data['data']);
    }
    if (dataClassName == 'PairingResult') {
      return deserialize<_igma2i47.PairingResult>(data['data']);
    }
    if (dataClassName == 'VoiceOption') {
      return deserialize<_iqedek9t.VoiceOption>(data['data']);
    }
    if (dataClassName == 'VoiceReplyResult') {
      return deserialize<_ituo13k3.VoiceReplyResult>(data['data']);
    }
    if (dataClassName == 'AlertKind') {
      return deserialize<_i7t4x9tm.AlertKind>(data['data']);
    }
    if (dataClassName == 'AlertLevel') {
      return deserialize<_iubt32n2.AlertLevel>(data['data']);
    }
    if (dataClassName == 'CheckInKind') {
      return deserialize<_ikmb3xjn.CheckInKind>(data['data']);
    }
    if (dataClassName == 'CheckInStatus') {
      return deserialize<_ijrvdr1p.CheckInStatus>(data['data']);
    }
    if (dataClassName == 'CircleStatus') {
      return deserialize<_i6qvt1rc.CircleStatus>(data['data']);
    }
    if (dataClassName == 'EventKind') {
      return deserialize<_i27hojh9.EventKind>(data['data']);
    }
    if (dataClassName == 'LifelineErrorCode') {
      return deserialize<_ij50bjyb.LifelineErrorCode>(data['data']);
    }
    if (dataClassName == 'MemberRole') {
      return deserialize<_icimtxba.MemberRole>(data['data']);
    }
    if (dataClassName == 'ResponseMethod') {
      return deserialize<_igp5zq1l.ResponseMethod>(data['data']);
    }
    if (dataClassName == 'TriageLevel') {
      return deserialize<_istrf3zd.TriageLevel>(data['data']);
    }
    if (dataClassName == 'UtteranceKind') {
      return deserialize<_ixwsitj3.UtteranceKind>(data['data']);
    }
    if (dataClassName == 'LifelineException') {
      return deserialize<_irswewhe.LifelineException>(data['data']);
    }
    if (dataClassName == 'Alert') {
      return deserialize<_ix65b5hp.Alert>(data['data']);
    }
    if (dataClassName == 'CheckIn') {
      return deserialize<_i9wmztxc.CheckIn>(data['data']);
    }
    if (dataClassName == 'CheckInSlot') {
      return deserialize<_is1itcsv.CheckInSlot>(data['data']);
    }
    if (dataClassName == 'Circle') {
      return deserialize<_is1kwm8w.Circle>(data['data']);
    }
    if (dataClassName == 'CircleEvent') {
      return deserialize<_ii1xfzkz.CircleEvent>(data['data']);
    }
    if (dataClassName == 'CircleMember') {
      return deserialize<_isezf3zm.CircleMember>(data['data']);
    }
    if (dataClassName == 'CompanionDevice') {
      return deserialize<_i34wu1yp.CompanionDevice>(data['data']);
    }
    if (dataClassName == 'Utterance') {
      return deserialize<_ikx4o9d3.Utterance>(data['data']);
    }
    if (dataClassName.startsWith('serverpod_auth_idp.')) {
      data['className'] = dataClassName.substring(19);
      return _iaic.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_core.')) {
      data['className'] = dataClassName.substring(20);
      return _iacc.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }

  void _registerHostProtocols() {
    _iaic.Protocol().registerHostProtocol('lifeline', this);
    _iacc.Protocol().registerHostProtocol('lifeline', this);
  }

  @override
  String getModuleName() => 'lifeline';

  /// Maps any `Record`s known to this [Protocol] to their JSON representation
  ///
  /// Throws in case the record type is not known.
  ///
  /// This method will return `null` (only) for `null` inputs.
  Map<String, dynamic>? mapRecordToJson(Record? record) {
    if (record == null) {
      return null;
    }
    try {
      return _iaic.Protocol().mapRecordToJson(record);
    } catch (_) {}
    try {
      return _iacc.Protocol().mapRecordToJson(record);
    } catch (_) {}
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}
