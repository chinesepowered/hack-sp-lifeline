import 'dart:typed_data';

import 'package:serverpod/serverpod.dart';

import 'voice_service.dart';

/// Serves synthesized speech at `/voice/<sha256>.mp3`.
///
/// Clips are content-addressed, so they never change: they are sent with
/// `immutable` cache headers and are cached by the browser and by the
/// Serverpod Cloud CDN at the edge.
class VoiceRoute extends Route {
  static final _fileName = RegExp(r'^[a-f0-9]{64}\.mp3$');

  @override
  Future<Result> handleCall(Session session, Request request) async {
    final fileName = request.pathParameters.raw[#file];
    if (fileName == null || !_fileName.hasMatch(fileName)) {
      return Response.notFound();
    }

    final data = await VoiceService.load(session, fileName);
    if (data == null) return Response.notFound();

    return Response.ok(
      body: Body.fromData(
        Uint8List.sublistView(data),
        mimeType: const MimeType('audio', 'mpeg'),
      ),
      headers: Headers.build((h) {
        h.cacheControl = CacheControlHeader(
          publicCache: true,
          maxAge: 31536000,
          immutable: true,
        );
      }),
    );
  }
}
