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
import 'dart:async' as _ida;
import 'dart:typed_data' as _idt;
import 'package:http/http.dart' as _i85jenna;
import 'package:lifeline_client/src/protocol/dto/circle_settings.dart'
    as _i76cp8lu;
import 'package:lifeline_client/src/protocol/dto/circle_snapshot.dart'
    as _ihazrzmg;
import 'package:lifeline_client/src/protocol/dto/circle_summary.dart'
    as _itnes0kr;
import 'package:lifeline_client/src/protocol/dto/companion_state.dart'
    as _izo99o3f;
import 'package:lifeline_client/src/protocol/dto/demo_setup.dart' as _i7bi1lwn;
import 'package:lifeline_client/src/protocol/dto/pairing_result.dart'
    as _ijpytd7n;
import 'package:lifeline_client/src/protocol/dto/voice_option.dart'
    as _i037yipj;
import 'package:lifeline_client/src/protocol/dto/voice_reply_result.dart'
    as _ihf2gf26;
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _iacc;
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart'
    as _iaic;
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import 'protocol.dart' as _il2as5qe;

/// Lets family members try Lifeline without creating an account
/// ("Continue without account"), alongside email sign-in.
/// {@category Endpoint}
class EndpointAnonymousIdp extends _iaic.EndpointAnonymousIdpBase {
  EndpointAnonymousIdp(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'anonymousIdp';

  /// Creates a new anonymous account and returns its session.
  ///
  /// Invokes the [AnonymousIdp.beforeAnonymousAccount] callback if configured,
  /// which may prevent account creation if the endpoint is protected.
  @override
  _ida.Future<_iacc.AuthSuccess> login({String? token}) =>
      caller.callServerEndpoint<_iacc.AuthSuccess>(
        'anonymousIdp',
        'login',
        {'token': token},
      );
}

/// By extending [EmailIdpBaseEndpoint], the email identity provider endpoints
/// are made available on the server and enable the corresponding sign-in widget
/// on the client.
/// {@category Endpoint}
class EndpointEmailIdp extends _iaic.EndpointEmailIdpBase {
  EndpointEmailIdp(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'emailIdp';

  /// Logs in the user and returns a new session.
  ///
  /// Throws an [EmailAccountLoginException] in case of errors, with reason:
  /// - [EmailAccountLoginExceptionReason.invalidCredentials] if the email or
  ///   password is incorrect.
  /// - [EmailAccountLoginExceptionReason.tooManyAttempts] if there have been
  ///   too many failed login attempts.
  ///
  /// Throws an [AuthUserBlockedException] if the auth user is blocked.
  @override
  _ida.Future<_iacc.AuthSuccess> login({
    required String email,
    required String password,
  }) => caller.callServerEndpoint<_iacc.AuthSuccess>(
    'emailIdp',
    'login',
    {
      'email': email,
      'password': password,
    },
  );

  /// Starts the registration for a new user account with an email-based login
  /// associated to it.
  ///
  /// Upon successful completion of this method, an email will have been
  /// sent to [email] with a verification link, which the user must open to
  /// complete the registration.
  ///
  /// Always returns a account request ID, which can be used to complete the
  /// registration. If the email is already registered, the returned ID will not
  /// be valid.
  @override
  _ida.Future<_isc.UuidValue> startRegistration({required String email}) =>
      caller.callServerEndpoint<_isc.UuidValue>(
        'emailIdp',
        'startRegistration',
        {'email': email},
      );

  /// Verifies an account request code and returns a token
  /// that can be used to complete the account creation.
  ///
  /// Throws an [EmailAccountRequestException] in case of errors, with reason:
  /// - [EmailAccountRequestExceptionReason.expired] if the account request has
  ///   already expired.
  /// - [EmailAccountRequestExceptionReason.policyViolation] if the password
  ///   does not comply with the password policy.
  /// - [EmailAccountRequestExceptionReason.invalid] if no request exists
  ///   for the given [accountRequestId] or [verificationCode] is invalid.
  @override
  _ida.Future<String> verifyRegistrationCode({
    required _isc.UuidValue accountRequestId,
    required String verificationCode,
  }) => caller.callServerEndpoint<String>(
    'emailIdp',
    'verifyRegistrationCode',
    {
      'accountRequestId': accountRequestId,
      'verificationCode': verificationCode,
    },
  );

  /// Completes a new account registration, creating a new auth user with a
  /// profile and attaching the given email account to it.
  ///
  /// Throws an [EmailAccountRequestException] in case of errors, with reason:
  /// - [EmailAccountRequestExceptionReason.expired] if the account request has
  ///   already expired.
  /// - [EmailAccountRequestExceptionReason.policyViolation] if the password
  ///   does not comply with the password policy.
  /// - [EmailAccountRequestExceptionReason.invalid] if the [registrationToken]
  ///   is invalid.
  ///
  /// Throws an [AuthUserBlockedException] if the auth user is blocked.
  ///
  /// Returns a session for the newly created user.
  @override
  _ida.Future<_iacc.AuthSuccess> finishRegistration({
    required String registrationToken,
    required String password,
  }) => caller.callServerEndpoint<_iacc.AuthSuccess>(
    'emailIdp',
    'finishRegistration',
    {
      'registrationToken': registrationToken,
      'password': password,
    },
  );

  /// Requests a password reset for [email].
  ///
  /// If the email address is registered, an email with reset instructions will
  /// be send out. If the email is unknown, this method will have no effect.
  ///
  /// Always returns a password reset request ID, which can be used to complete
  /// the reset. If the email is not registered, the returned ID will not be
  /// valid.
  ///
  /// Throws an [EmailAccountPasswordResetException] in case of errors, with reason:
  /// - [EmailAccountPasswordResetExceptionReason.tooManyAttempts] if the user has
  ///   made too many attempts trying to request a password reset.
  ///
  @override
  _ida.Future<_isc.UuidValue> startPasswordReset({required String email}) =>
      caller.callServerEndpoint<_isc.UuidValue>(
        'emailIdp',
        'startPasswordReset',
        {'email': email},
      );

  /// Verifies a password reset code and returns a finishPasswordResetToken
  /// that can be used to finish the password reset.
  ///
  /// Throws an [EmailAccountPasswordResetException] in case of errors, with reason:
  /// - [EmailAccountPasswordResetExceptionReason.expired] if the password reset
  ///   request has already expired.
  /// - [EmailAccountPasswordResetExceptionReason.tooManyAttempts] if the user has
  ///   made too many attempts trying to verify the password reset.
  /// - [EmailAccountPasswordResetExceptionReason.invalid] if no request exists
  ///   for the given [passwordResetRequestId] or [verificationCode] is invalid.
  ///
  /// If multiple steps are required to complete the password reset, this endpoint
  /// should be overridden to return credentials for the next step instead
  /// of the credentials for setting the password.
  @override
  _ida.Future<String> verifyPasswordResetCode({
    required _isc.UuidValue passwordResetRequestId,
    required String verificationCode,
  }) => caller.callServerEndpoint<String>(
    'emailIdp',
    'verifyPasswordResetCode',
    {
      'passwordResetRequestId': passwordResetRequestId,
      'verificationCode': verificationCode,
    },
  );

  /// Completes a password reset request by setting a new password.
  ///
  /// The [verificationCode] returned from [verifyPasswordResetCode] is used to
  /// validate the password reset request.
  ///
  /// Throws an [EmailAccountPasswordResetException] in case of errors, with reason:
  /// - [EmailAccountPasswordResetExceptionReason.expired] if the password reset
  ///   request has already expired.
  /// - [EmailAccountPasswordResetExceptionReason.policyViolation] if the new
  ///   password does not comply with the password policy.
  /// - [EmailAccountPasswordResetExceptionReason.invalid] if no request exists
  ///   for the given [passwordResetRequestId] or [verificationCode] is invalid.
  ///
  /// Throws an [AuthUserBlockedException] if the auth user is blocked.
  @override
  _ida.Future<void> finishPasswordReset({
    required String finishPasswordResetToken,
    required String newPassword,
  }) => caller.callServerEndpoint<void>(
    'emailIdp',
    'finishPasswordReset',
    {
      'finishPasswordResetToken': finishPasswordResetToken,
      'newPassword': newPassword,
    },
  );

  @override
  _ida.Future<bool> hasAccount() => caller.callServerEndpoint<bool>(
    'emailIdp',
    'hasAccount',
    {},
  );
}

/// By extending [RefreshJwtTokensEndpoint], the JWT token refresh endpoint
/// is made available on the server and enables automatic token refresh on the client.
/// {@category Endpoint}
class EndpointJwtRefresh extends _iacc.EndpointRefreshJwtTokens {
  EndpointJwtRefresh(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'jwtRefresh';

  /// Creates a new token pair for the given [refreshToken].
  ///
  /// If [refreshToken] is omitted, cookie-mode web clients fall back to the
  /// configured HttpOnly refresh cookie. When neither source is present this
  /// throws [RefreshTokenNotFoundException], the same public "no usable refresh
  /// credential" exception used for unknown refresh tokens.
  ///
  /// Can throw the following exceptions:
  /// -[RefreshTokenMalformedException]: refresh token is malformed and could
  ///   not be parsed. Not expected to happen for tokens issued by the server.
  /// -[RefreshTokenNotFoundException]: refresh token is unknown to the server.
  ///   Either the token was deleted or generated by a different server.
  /// -[RefreshTokenExpiredException]: refresh token has expired. Will happen
  ///   only if it has not been used within configured `refreshTokenLifetime`.
  /// -[RefreshTokenInvalidSecretException]: refresh token is incorrect, meaning
  ///   it does not refer to the current secret refresh token. This indicates
  ///   either a malfunctioning client or a malicious attempt by someone who has
  ///   obtained the refresh token. In this case the underlying refresh token
  ///   will be deleted, and access to it will expire fully when the last access
  ///   token is elapsed.
  ///
  /// This endpoint is unauthenticated, meaning the client won't include any
  /// authentication information with the call.
  @override
  _ida.Future<_iacc.AuthSuccess> refreshAccessToken({String? refreshToken}) =>
      caller.callServerEndpoint<_iacc.AuthSuccess>(
        'jwtRefresh',
        'refreshAccessToken',
        {'refreshToken': refreshToken},
        authenticated: false,
      );
}

/// Everything the family app does. Requires a signed-in Serverpod user, and
/// every method checks that the user belongs to the circle.
/// {@category Endpoint}
class EndpointCircle extends _isc.EndpointRef {
  EndpointCircle(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'circle';

  /// Voices the family can choose for the companion.
  _ida.Future<List<_i037yipj.VoiceOption>> voices() =>
      caller.callServerEndpoint<List<_i037yipj.VoiceOption>>(
        'circle',
        'voices',
        {},
      );

  /// A short sample of [voiceId] saying [lovedOneName], for the voice picker.
  /// Returns an absolute URL, or null when speech is unavailable.
  _ida.Future<String?> previewVoice(
    String voiceId,
    String lovedOneName,
  ) => caller.callServerEndpoint<String?>(
    'circle',
    'previewVoice',
    {
      'voiceId': voiceId,
      'lovedOneName': lovedOneName,
    },
  );

  _ida.Future<List<_itnes0kr.CircleSummary>> myCircles() =>
      caller.callServerEndpoint<List<_itnes0kr.CircleSummary>>(
        'circle',
        'myCircles',
        {},
      );

  _ida.Future<_ihazrzmg.CircleSnapshot> createCircle(
    _i76cp8lu.CircleSettings settings,
    String myName,
    String? relationship,
  ) => caller.callServerEndpoint<_ihazrzmg.CircleSnapshot>(
    'circle',
    'createCircle',
    {
      'settings': settings,
      'myName': myName,
      'relationship': relationship,
    },
  );

  _ida.Future<_ihazrzmg.CircleSnapshot> joinCircle(
    String inviteCode,
    String myName,
    String? relationship,
  ) => caller.callServerEndpoint<_ihazrzmg.CircleSnapshot>(
    'circle',
    'joinCircle',
    {
      'inviteCode': inviteCode,
      'myName': myName,
      'relationship': relationship,
    },
  );

  /// Creates a sandbox circle with a paired virtual companion screen.
  _ida.Future<_i7bi1lwn.DemoSetup> createDemo(
    String myName,
    int utcOffsetMinutes,
  ) => caller.callServerEndpoint<_i7bi1lwn.DemoSetup>(
    'circle',
    'createDemo',
    {
      'myName': myName,
      'utcOffsetMinutes': utcOffsetMinutes,
    },
  );

  _ida.Future<_ihazrzmg.CircleSnapshot> snapshot(int circleId) =>
      caller.callServerEndpoint<_ihazrzmg.CircleSnapshot>(
        'circle',
        'snapshot',
        {'circleId': circleId},
      );

  /// Live dashboard: a fresh snapshot whenever anything in the circle
  /// changes, pushed over Serverpod's managed WebSocket.
  _ida.Stream<_ihazrzmg.CircleSnapshot> watch(int circleId) =>
      caller.callStreamingServerEndpoint<
        _ida.Stream<_ihazrzmg.CircleSnapshot>,
        _ihazrzmg.CircleSnapshot
      >(
        'circle',
        'watch',
        {'circleId': circleId},
        {},
      );

  /// Starts a check-in right now, outside the daily schedule.
  _ida.Future<void> checkInNow(int circleId) => caller.callServerEndpoint<void>(
    'circle',
    'checkInNow',
    {'circleId': circleId},
  );

  /// Sends a typed message that is spoken aloud on the companion screen.
  _ida.Future<void> sendMessage(
    int circleId,
    String text,
  ) => caller.callServerEndpoint<void>(
    'circle',
    'sendMessage',
    {
      'circleId': circleId,
      'text': text,
    },
  );

  /// "I'm on it": tells the family and the loved one that someone is
  /// handling the alert.
  _ida.Future<void> acknowledgeAlert(
    int circleId,
    int alertId,
  ) => caller.callServerEndpoint<void>(
    'circle',
    'acknowledgeAlert',
    {
      'circleId': circleId,
      'alertId': alertId,
    },
  );

  _ida.Future<void> resolveAlert(
    int circleId,
    int alertId,
  ) => caller.callServerEndpoint<void>(
    'circle',
    'resolveAlert',
    {
      'circleId': circleId,
      'alertId': alertId,
    },
  );

  _ida.Future<_ihazrzmg.CircleSnapshot> updateSettings(
    int circleId,
    _i76cp8lu.CircleSettings settings,
  ) => caller.callServerEndpoint<_ihazrzmg.CircleSnapshot>(
    'circle',
    'updateSettings',
    {
      'circleId': circleId,
      'settings': settings,
    },
  );

  /// Issues a fresh one-time code for pairing another tablet.
  _ida.Future<String> newPairingCode(int circleId) =>
      caller.callServerEndpoint<String>(
        'circle',
        'newPairingCode',
        {'circleId': circleId},
      );
}

/// The loved one's companion screen. It has no user account: it is paired
/// once with a code from the family app and then authenticates every call
/// with its device token.
/// {@category Endpoint}
class EndpointCompanion extends _isc.EndpointRef {
  EndpointCompanion(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'companion';

  _ida.Future<_ijpytd7n.PairingResult> pair(
    String pairingCode,
    String label,
  ) => caller.callServerEndpoint<_ijpytd7n.PairingResult>(
    'companion',
    'pair',
    {
      'pairingCode': pairingCode,
      'label': label,
    },
  );

  /// Live state of the companion screen, including lines to speak.
  _ida.Stream<_izo99o3f.CompanionState> watch(String deviceToken) =>
      caller.callStreamingServerEndpoint<
        _ida.Stream<_izo99o3f.CompanionState>,
        _izo99o3f.CompanionState
      >(
        'companion',
        'watch',
        {'deviceToken': deviceToken},
        {},
      );

  /// The same state as [watch], for networks that block WebSockets.
  _ida.Future<_izo99o3f.CompanionState> state(String deviceToken) =>
      caller.callServerEndpoint<_izo99o3f.CompanionState>(
        'companion',
        'state',
        {'deviceToken': deviceToken},
      );

  /// The big green button.
  _ida.Future<void> imOkay(String deviceToken) =>
      caller.callServerEndpoint<void>(
        'companion',
        'imOkay',
        {'deviceToken': deviceToken},
      );

  /// The big red button.
  _ida.Future<void> needHelp(String deviceToken) =>
      caller.callServerEndpoint<void>(
        'companion',
        'needHelp',
        {'deviceToken': deviceToken},
      );

  /// A spoken answer: transcribed by ElevenLabs Scribe, then triaged.
  _ida.Future<_ihf2gf26.VoiceReplyResult> answerByVoice(
    String deviceToken,
    _idt.ByteData audio,
    String mimeType,
  ) => caller.callServerEndpoint<_ihf2gf26.VoiceReplyResult>(
    'companion',
    'answerByVoice',
    {
      'deviceToken': deviceToken,
      'audio': audio,
      'mimeType': mimeType,
    },
  );
}

class Modules {
  Modules(Client client) {
    serverpod_auth_idp = _iaic.Caller(client);
    serverpod_auth_core = _iacc.Caller(client);
  }

  late final _iaic.Caller serverpod_auth_idp;

  late final _iacc.Caller serverpod_auth_core;
}

class Client extends _isc.ServerpodClientShared {
  Client(
    String host, {
    dynamic securityContext,
    Duration? streamingConnectionTimeout,
    Duration? connectionTimeout,
    Function(
      _isc.MethodCallContext,
      Object,
      StackTrace,
    )?
    onFailedCall,
    Function(_isc.MethodCallContext)? onSucceededCall,
    bool? disconnectStreamsOnLostInternetConnection,
    _i85jenna.Client? httpClientOverride,
  }) : super(
         host,
         _il2as5qe.Protocol(),
         securityContext: securityContext,
         streamingConnectionTimeout: streamingConnectionTimeout,
         connectionTimeout: connectionTimeout,
         onFailedCall: onFailedCall,
         onSucceededCall: onSucceededCall,
         disconnectStreamsOnLostInternetConnection:
             disconnectStreamsOnLostInternetConnection,
         httpClientOverride: httpClientOverride,
       ) {
    anonymousIdp = EndpointAnonymousIdp(this);
    emailIdp = EndpointEmailIdp(this);
    jwtRefresh = EndpointJwtRefresh(this);
    circle = EndpointCircle(this);
    companion = EndpointCompanion(this);
    modules = Modules(this);
  }

  late final EndpointAnonymousIdp anonymousIdp;

  late final EndpointEmailIdp emailIdp;

  late final EndpointJwtRefresh jwtRefresh;

  late final EndpointCircle circle;

  late final EndpointCompanion companion;

  late final Modules modules;

  @override
  Map<String, _isc.EndpointRef> get endpointRefLookup => {
    'anonymousIdp': anonymousIdp,
    'emailIdp': emailIdp,
    'jwtRefresh': jwtRefresh,
    'circle': circle,
    'companion': companion,
  };

  @override
  Map<String, _isc.ModuleEndpointCaller> get moduleLookup => {
    'serverpod_auth_idp': modules.serverpod_auth_idp,
    'serverpod_auth_core': modules.serverpod_auth_core,
  };
}
