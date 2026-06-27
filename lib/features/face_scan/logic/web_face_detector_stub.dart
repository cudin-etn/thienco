/// Stub for native platforms. MediaPipe web is not available here.
Future<bool> webInit() async => false;

String webDetect(String dataUrl) => '{"error":"not supported"}';
