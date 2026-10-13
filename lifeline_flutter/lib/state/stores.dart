import 'dart:convert';

import '../platform/browser.dart';

/// The token that identifies this browser as a paired companion screen.
abstract final class CompanionStore {
  static const _tokenKey = 'lifeline.companion.token';
  static const _nameKey = 'lifeline.companion.name';

  static String? get token => LocalStore.read(_tokenKey);
  static String? get lovedOneName => LocalStore.read(_nameKey);

  static void save(String token, String lovedOneName) {
    LocalStore.write(_tokenKey, token);
    LocalStore.write(_nameKey, lovedOneName);
  }

  static void clear() {
    LocalStore.write(_tokenKey, null);
    LocalStore.write(_nameKey, null);
  }
}

/// The live demo this browser created, so a reload resumes the same demo.
class DemoSession {
  final int circleId;
  final String deviceToken;
  final DateTime createdAt;

  const DemoSession(this.circleId, this.deviceToken, this.createdAt);

  static const _key = 'lifeline.demo';

  /// Demo circles expire on the server after 12 hours.
  static DemoSession? load() {
    final raw = LocalStore.read(_key);
    if (raw == null) return null;
    try {
      final json = jsonDecode(raw) as Map<String, dynamic>;
      final session = DemoSession(
        json['circleId'] as int,
        json['deviceToken'] as String,
        DateTime.parse(json['createdAt'] as String),
      );
      final age = DateTime.now().toUtc().difference(session.createdAt);
      return age.inHours < 11 ? session : null;
    } catch (_) {
      return null;
    }
  }

  void save() => LocalStore.write(
    _key,
    jsonEncode({
      'circleId': circleId,
      'deviceToken': deviceToken,
      'createdAt': createdAt.toIso8601String(),
    }),
  );

  static void clear() => LocalStore.write(_key, null);
}
