import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';

/// Random codes and secrets used for pairing tablets and inviting family.
abstract final class Codes {
  static final _random = Random.secure();

  /// A 6-digit numeric code that is easy to read out loud over the phone.
  static String pairingCode() =>
      List.generate(6, (_) => _random.nextInt(10)).join();

  /// An invite code without ambiguous characters (no 0/O, 1/I/L).
  static String inviteCode() {
    const alphabet = 'ABCDEFGHJKMNPQRSTUVWXYZ23456789';
    return List.generate(
      6,
      (_) => alphabet[_random.nextInt(alphabet.length)],
    ).join();
  }

  /// A long random secret identifying a paired companion device.
  static String deviceToken() {
    final bytes = List<int>.generate(32, (_) => _random.nextInt(256));
    return base64Url.encode(bytes).replaceAll('=', '');
  }

  /// Hash of a device token. Only hashes are stored in the database.
  static String hashToken(String token) =>
      sha256.convert(utf8.encode(token)).toString();

  /// Content hash used to address cached voice clips.
  static String contentHash(List<String> parts) =>
      sha256.convert(utf8.encode(parts.join('\u0000'))).toString();
}
