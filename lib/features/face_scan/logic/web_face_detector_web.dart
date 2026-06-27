import 'dart:js_interop';

@JS('window.__mediapipeInit')
external JSFunction? get _mediapipeInit;

@JS('window.__mediapipeDetect')
external JSFunction? get _mediapipeDetect;

/// Initialize MediaPipe on web. Returns true if successful.
Future<bool> webInit() async {
  try {
    final fn = _mediapipeInit;
    if (fn == null) return false;
    await (fn.callAsFunction(null) as JSPromise).toDart;
    return true;
  } catch (_) {
    return false;
  }
}

/// Detect face from a base64 data URL on web.
/// Returns JSON string with landmarks or error.
String webDetect(String dataUrl) {
  try {
    final fn = _mediapipeDetect;
    if (fn == null) return '{"error":"not ready"}';
    return (fn.callAsFunction(null, dataUrl.toJS) as JSString).toDart;
  } catch (e) {
    return '{"error":"$e"}';
  }
}
