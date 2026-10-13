import 'dart:typed_data';

/// A finished microphone recording.
class RecordedAudio {
  final Uint8List bytes;
  final String mimeType;

  const RecordedAudio(this.bytes, this.mimeType);
}
