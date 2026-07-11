/// Stub for native platforms. MediaPipe web is not available here.
Future<bool> webInit() async => false;

Future<String> webDetect(String dataUrl) async => '{"error":"not supported"}';
