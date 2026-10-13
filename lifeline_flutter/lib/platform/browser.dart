/// Browser capabilities (audio, microphone, storage) behind one API. The web
/// implementation uses `package:web`; other platforms get safe no-ops.
library;

export 'browser_stub.dart' if (dart.library.js_interop) 'browser_web.dart';
export 'recorded_audio.dart';
