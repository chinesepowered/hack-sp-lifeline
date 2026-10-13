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
import 'dart:typed_data' as _idt;
import 'package:lifeline_server/src/generated/dto/circle_settings.dart'
    as _ia6knq7a;
import 'package:lifeline_server/src/generated/future_calls.dart' as _irvzctxg;
import 'package:serverpod/serverpod.dart' as _is;
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as _iacs;
import 'package:serverpod_auth_idp_server/serverpod_auth_idp_server.dart'
    as _iais;
import '../auth/anonymous_idp_endpoint.dart' as _in0zita6;
import '../auth/email_idp_endpoint.dart' as _iuc1hd5t;
import '../auth/jwt_refresh_endpoint.dart' as _inwq3ztq;
import '../circles/circle_endpoint.dart' as _ixefnrd7;
import '../companion/companion_endpoint.dart' as _izr1micu;
export 'future_calls.dart' show ServerpodFutureCallsGetter;

class Endpoints extends _is.EndpointDispatch {
  @override
  void initializeEndpoints(_is.Server server) {
    var endpoints = <String, _is.Endpoint>{
      'anonymousIdp': _in0zita6.AnonymousIdpEndpoint()
        ..initialize(
          server,
          'anonymousIdp',
          null,
        ),
      'emailIdp': _iuc1hd5t.EmailIdpEndpoint()
        ..initialize(
          server,
          'emailIdp',
          null,
        ),
      'jwtRefresh': _inwq3ztq.JwtRefreshEndpoint()
        ..initialize(
          server,
          'jwtRefresh',
          null,
        ),
      'circle': _ixefnrd7.CircleEndpoint()
        ..initialize(
          server,
          'circle',
          null,
        ),
      'companion': _izr1micu.CompanionEndpoint()
        ..initialize(
          server,
          'companion',
          null,
        ),
    };
    connectors['anonymousIdp'] = _is.EndpointConnector(
      name: 'anonymousIdp',
      endpoint: endpoints['anonymousIdp']!,
      methodConnectors: {
        'login': _is.MethodConnector(
          name: 'login',
          params: {
            'token': _is.ParameterDescription(
              name: 'token',
              type: _is.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['anonymousIdp'] as _in0zita6.AnonymousIdpEndpoint)
                      .login(
                        session,
                        token: params['token'],
                      ),
        ),
      },
    );
    connectors['emailIdp'] = _is.EndpointConnector(
      name: 'emailIdp',
      endpoint: endpoints['emailIdp']!,
      methodConnectors: {
        'login': _is.MethodConnector(
          name: 'login',
          params: {
            'email': _is.ParameterDescription(
              name: 'email',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'password': _is.ParameterDescription(
              name: 'password',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint).login(
                    session,
                    email: params['email'],
                    password: params['password'],
                  ),
        ),
        'startRegistration': _is.MethodConnector(
          name: 'startRegistration',
          params: {
            'email': _is.ParameterDescription(
              name: 'email',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .startRegistration(
                    session,
                    email: params['email'],
                  ),
        ),
        'verifyRegistrationCode': _is.MethodConnector(
          name: 'verifyRegistrationCode',
          params: {
            'accountRequestId': _is.ParameterDescription(
              name: 'accountRequestId',
              type: _is.getType<_is.UuidValue>(),
              nullable: false,
            ),
            'verificationCode': _is.ParameterDescription(
              name: 'verificationCode',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .verifyRegistrationCode(
                    session,
                    accountRequestId: params['accountRequestId'],
                    verificationCode: params['verificationCode'],
                  ),
        ),
        'finishRegistration': _is.MethodConnector(
          name: 'finishRegistration',
          params: {
            'registrationToken': _is.ParameterDescription(
              name: 'registrationToken',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'password': _is.ParameterDescription(
              name: 'password',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .finishRegistration(
                    session,
                    registrationToken: params['registrationToken'],
                    password: params['password'],
                  ),
        ),
        'startPasswordReset': _is.MethodConnector(
          name: 'startPasswordReset',
          params: {
            'email': _is.ParameterDescription(
              name: 'email',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .startPasswordReset(
                    session,
                    email: params['email'],
                  ),
        ),
        'verifyPasswordResetCode': _is.MethodConnector(
          name: 'verifyPasswordResetCode',
          params: {
            'passwordResetRequestId': _is.ParameterDescription(
              name: 'passwordResetRequestId',
              type: _is.getType<_is.UuidValue>(),
              nullable: false,
            ),
            'verificationCode': _is.ParameterDescription(
              name: 'verificationCode',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .verifyPasswordResetCode(
                    session,
                    passwordResetRequestId: params['passwordResetRequestId'],
                    verificationCode: params['verificationCode'],
                  ),
        ),
        'finishPasswordReset': _is.MethodConnector(
          name: 'finishPasswordReset',
          params: {
            'finishPasswordResetToken': _is.ParameterDescription(
              name: 'finishPasswordResetToken',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'newPassword': _is.ParameterDescription(
              name: 'newPassword',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .finishPasswordReset(
                    session,
                    finishPasswordResetToken:
                        params['finishPasswordResetToken'],
                    newPassword: params['newPassword'],
                  ),
        ),
        'hasAccount': _is.MethodConnector(
          name: 'hasAccount',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .hasAccount(session),
        ),
      },
    );
    connectors['jwtRefresh'] = _is.EndpointConnector(
      name: 'jwtRefresh',
      endpoint: endpoints['jwtRefresh']!,
      methodConnectors: {
        'refreshAccessToken': _is.MethodConnector(
          name: 'refreshAccessToken',
          params: {
            'refreshToken': _is.ParameterDescription(
              name: 'refreshToken',
              type: _is.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['jwtRefresh'] as _inwq3ztq.JwtRefreshEndpoint)
                      .refreshAccessToken(
                        session,
                        refreshToken: params['refreshToken'],
                      ),
        ),
      },
    );
    connectors['circle'] = _is.EndpointConnector(
      name: 'circle',
      endpoint: endpoints['circle']!,
      methodConnectors: {
        'voices': _is.MethodConnector(
          name: 'voices',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['circle'] as _ixefnrd7.CircleEndpoint)
                  .voices(session),
        ),
        'previewVoice': _is.MethodConnector(
          name: 'previewVoice',
          params: {
            'voiceId': _is.ParameterDescription(
              name: 'voiceId',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'lovedOneName': _is.ParameterDescription(
              name: 'lovedOneName',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['circle'] as _ixefnrd7.CircleEndpoint)
                  .previewVoice(
                    session,
                    params['voiceId'],
                    params['lovedOneName'],
                  ),
        ),
        'myCircles': _is.MethodConnector(
          name: 'myCircles',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['circle'] as _ixefnrd7.CircleEndpoint)
                  .myCircles(session),
        ),
        'createCircle': _is.MethodConnector(
          name: 'createCircle',
          params: {
            'settings': _is.ParameterDescription(
              name: 'settings',
              type: _is.getType<_ia6knq7a.CircleSettings>(),
              nullable: false,
            ),
            'myName': _is.ParameterDescription(
              name: 'myName',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'relationship': _is.ParameterDescription(
              name: 'relationship',
              type: _is.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['circle'] as _ixefnrd7.CircleEndpoint)
                  .createCircle(
                    session,
                    params['settings'],
                    params['myName'],
                    params['relationship'],
                  ),
        ),
        'joinCircle': _is.MethodConnector(
          name: 'joinCircle',
          params: {
            'inviteCode': _is.ParameterDescription(
              name: 'inviteCode',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'myName': _is.ParameterDescription(
              name: 'myName',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'relationship': _is.ParameterDescription(
              name: 'relationship',
              type: _is.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['circle'] as _ixefnrd7.CircleEndpoint).joinCircle(
                    session,
                    params['inviteCode'],
                    params['myName'],
                    params['relationship'],
                  ),
        ),
        'createDemo': _is.MethodConnector(
          name: 'createDemo',
          params: {
            'myName': _is.ParameterDescription(
              name: 'myName',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'utcOffsetMinutes': _is.ParameterDescription(
              name: 'utcOffsetMinutes',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['circle'] as _ixefnrd7.CircleEndpoint).createDemo(
                    session,
                    params['myName'],
                    params['utcOffsetMinutes'],
                  ),
        ),
        'snapshot': _is.MethodConnector(
          name: 'snapshot',
          params: {
            'circleId': _is.ParameterDescription(
              name: 'circleId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['circle'] as _ixefnrd7.CircleEndpoint).snapshot(
                    session,
                    params['circleId'],
                  ),
        ),
        'checkInNow': _is.MethodConnector(
          name: 'checkInNow',
          params: {
            'circleId': _is.ParameterDescription(
              name: 'circleId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['circle'] as _ixefnrd7.CircleEndpoint).checkInNow(
                    session,
                    params['circleId'],
                  ),
        ),
        'sendMessage': _is.MethodConnector(
          name: 'sendMessage',
          params: {
            'circleId': _is.ParameterDescription(
              name: 'circleId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'text': _is.ParameterDescription(
              name: 'text',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['circle'] as _ixefnrd7.CircleEndpoint).sendMessage(
                    session,
                    params['circleId'],
                    params['text'],
                  ),
        ),
        'acknowledgeAlert': _is.MethodConnector(
          name: 'acknowledgeAlert',
          params: {
            'circleId': _is.ParameterDescription(
              name: 'circleId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'alertId': _is.ParameterDescription(
              name: 'alertId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['circle'] as _ixefnrd7.CircleEndpoint)
                  .acknowledgeAlert(
                    session,
                    params['circleId'],
                    params['alertId'],
                  ),
        ),
        'resolveAlert': _is.MethodConnector(
          name: 'resolveAlert',
          params: {
            'circleId': _is.ParameterDescription(
              name: 'circleId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'alertId': _is.ParameterDescription(
              name: 'alertId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['circle'] as _ixefnrd7.CircleEndpoint)
                  .resolveAlert(
                    session,
                    params['circleId'],
                    params['alertId'],
                  ),
        ),
        'updateSettings': _is.MethodConnector(
          name: 'updateSettings',
          params: {
            'circleId': _is.ParameterDescription(
              name: 'circleId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'settings': _is.ParameterDescription(
              name: 'settings',
              type: _is.getType<_ia6knq7a.CircleSettings>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['circle'] as _ixefnrd7.CircleEndpoint)
                  .updateSettings(
                    session,
                    params['circleId'],
                    params['settings'],
                  ),
        ),
        'newPairingCode': _is.MethodConnector(
          name: 'newPairingCode',
          params: {
            'circleId': _is.ParameterDescription(
              name: 'circleId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['circle'] as _ixefnrd7.CircleEndpoint)
                  .newPairingCode(
                    session,
                    params['circleId'],
                  ),
        ),
        'watch': _is.MethodStreamConnector(
          name: 'watch',
          params: {
            'circleId': _is.ParameterDescription(
              name: 'circleId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          streamParams: {},
          returnType: _is.MethodStreamReturnType.streamType,
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
                Map<String, Stream> streamParams,
              ) => (endpoints['circle'] as _ixefnrd7.CircleEndpoint).watch(
                session,
                params['circleId'],
              ),
        ),
      },
    );
    connectors['companion'] = _is.EndpointConnector(
      name: 'companion',
      endpoint: endpoints['companion']!,
      methodConnectors: {
        'pair': _is.MethodConnector(
          name: 'pair',
          params: {
            'pairingCode': _is.ParameterDescription(
              name: 'pairingCode',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'label': _is.ParameterDescription(
              name: 'label',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['companion'] as _izr1micu.CompanionEndpoint).pair(
                    session,
                    params['pairingCode'],
                    params['label'],
                  ),
        ),
        'imOkay': _is.MethodConnector(
          name: 'imOkay',
          params: {
            'deviceToken': _is.ParameterDescription(
              name: 'deviceToken',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['companion'] as _izr1micu.CompanionEndpoint)
                  .imOkay(
                    session,
                    params['deviceToken'],
                  ),
        ),
        'needHelp': _is.MethodConnector(
          name: 'needHelp',
          params: {
            'deviceToken': _is.ParameterDescription(
              name: 'deviceToken',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['companion'] as _izr1micu.CompanionEndpoint)
                  .needHelp(
                    session,
                    params['deviceToken'],
                  ),
        ),
        'answerByVoice': _is.MethodConnector(
          name: 'answerByVoice',
          params: {
            'deviceToken': _is.ParameterDescription(
              name: 'deviceToken',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'audio': _is.ParameterDescription(
              name: 'audio',
              type: _is.getType<_idt.ByteData>(),
              nullable: false,
            ),
            'mimeType': _is.ParameterDescription(
              name: 'mimeType',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['companion'] as _izr1micu.CompanionEndpoint)
                  .answerByVoice(
                    session,
                    params['deviceToken'],
                    params['audio'],
                    params['mimeType'],
                  ),
        ),
        'watch': _is.MethodStreamConnector(
          name: 'watch',
          params: {
            'deviceToken': _is.ParameterDescription(
              name: 'deviceToken',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          streamParams: {},
          returnType: _is.MethodStreamReturnType.streamType,
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
                Map<String, Stream> streamParams,
              ) =>
                  (endpoints['companion'] as _izr1micu.CompanionEndpoint).watch(
                    session,
                    params['deviceToken'],
                  ),
        ),
      },
    );
    modules['serverpod_auth_idp'] = _iais.Endpoints()
      ..initializeEndpoints(server);
    modules['serverpod_auth_core'] = _iacs.Endpoints()
      ..initializeEndpoints(server);
  }

  @override
  _is.FutureCallDispatch? get futureCalls {
    return _irvzctxg.FutureCalls();
  }
}
