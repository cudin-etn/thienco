import 'dart:convert';
import 'dart:typed_data';
import 'web_face_detector_stub.dart'
    if (dart.library.js_interop) 'web_face_detector_web.dart';
import 'face_data.dart';

typedef MediaPipeResult = ({List<MediaPipeLandmark> landmarks, double imgWidth, double imgHeight});
typedef MediaPipeLandmark = ({double x, double y, double z});

class WebFaceDetector {
  static bool _initialized = false;
  static bool _initStarted = false;

  static Future<bool> init() async {
    if (_initialized) return true;
    if (_initStarted) {
      for (int i = 0; i < 40 && !_initialized; i++) {
        await Future.delayed(const Duration(milliseconds: 100));
      }
      return _initialized;
    }
    _initStarted = true;
    for (int i = 0; i < 40; i++) {
      if (await webInit()) {
        _initialized = true;
        return true;
      }
      await Future.delayed(const Duration(milliseconds: 100));
    }
    return false;
  }

  static Future<MediaPipeResult?> detect({required Uint8List imageBytes, required String mimeType}) async {
    if (!_initialized) return null;

    try {
      final dataUrl = 'data:$mimeType;base64,${base64Encode(imageBytes)}';
      final resultJson = await webDetect(dataUrl);
      final decoded = jsonDecode(resultJson) as Map<String, dynamic>;

      if (decoded.containsKey('error')) return null;

      final raw = decoded['landmarks'] as List;
      final imgWidth = (decoded['imgWidth'] as num).toDouble();
      final imgHeight = (decoded['imgHeight'] as num).toDouble();

      final landmarks = raw.map((l) => (
        x: (l['x'] as num).toDouble(),
        y: (l['y'] as num).toDouble(),
        z: (l['z'] as num).toDouble(),
      )).toList();

      return (landmarks: landmarks, imgWidth: imgWidth, imgHeight: imgHeight);
    } catch (_) {
      return null;
    }
  }

  static FaceData toFaceData(MediaPipeResult result) {
    final landmarks = result.landmarks;
    final w = result.imgWidth;
    final h = result.imgHeight;

    FacePoint? getPoint(int index) {
      if (index >= landmarks.length) return null;
      final l = landmarks[index];
      return FacePoint(l.x * w, l.y * h);
    }

    final leftEye = getPoint(468);
    final rightEye = getPoint(473);
    final noseBase = getPoint(2);
    final leftCheek = getPoint(234);
    final rightCheek = getPoint(454);
    final leftMouth = getPoint(61);
    final rightMouth = getPoint(291);
    final bottomMouth = getPoint(17);

    double minX = double.infinity, minY = double.infinity;
    double maxX = double.negativeInfinity, maxY = double.negativeInfinity;
    for (final l in landmarks) {
      final px = l.x * w;
      final py = l.y * h;
      if (px < minX) minX = px;
      if (py < minY) minY = py;
      if (px > maxX) maxX = px;
      if (py > maxY) maxY = py;
    }

    return FaceData(
      leftEye: leftEye,
      rightEye: rightEye,
      noseBase: noseBase,
      leftCheek: leftCheek,
      rightCheek: rightCheek,
      leftMouth: leftMouth,
      rightMouth: rightMouth,
      bottomMouth: bottomMouth,
      boundingTop: minY,
      boundingBottom: maxY,
      boundingWidth: maxX - minX,
      boundingHeight: maxY - minY,
    );
  }
}
