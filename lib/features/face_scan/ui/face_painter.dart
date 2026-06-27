import 'package:flutter/material.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';

class FacePainter extends CustomPainter {
  final List<Face> faces;
  final Size absoluteImageSize;
  final InputImageRotation rotation;

  FacePainter(this.faces, this.absoluteImageSize, this.rotation);

  @override
  void paint(Canvas canvas, Size size) {
    // Cấu hình cọ vẽ: Màu xanh viễn tưởng + Hiệu ứng Glow (nhòe sáng)
    final Paint glowPaint = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.cyanAccent.withValues(alpha: 0.8)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8); // Độ tỏa sáng

    // Cấu hình cọ vẽ: Lõi trắng cho điểm neo (tạo cảm giác sắc nét)
    final Paint corePaint = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.white;

    for (final Face face in faces) {
      // Các điểm neo quan trọng trong nhân tướng học
      final landmarks = [
        FaceLandmarkType.leftEye,
        FaceLandmarkType.rightEye,
        FaceLandmarkType.noseBase,
        FaceLandmarkType.bottomMouth,
        FaceLandmarkType.leftMouth,
        FaceLandmarkType.rightMouth,
        FaceLandmarkType.leftCheek,
        FaceLandmarkType.rightCheek,
      ];

      for (final type in landmarks) {
        final landmark = face.landmarks[type];
        if (landmark != null) {
          // Tính toán tọa độ từ khung hình Camera khớp vào màn hình điện thoại
          final double x = _translateX(
            landmark.position.x.toDouble(),
            size,
            absoluteImageSize,
          );
          final double y = _translateY(
            landmark.position.y.toDouble(),
            size,
            absoluteImageSize,
          );

          final Offset position = Offset(x, y);

          // Vẽ điểm Glow tỏa sáng bên ngoài
          canvas.drawCircle(position, 8, glowPaint);
          // Vẽ điểm lõi trắng bên trong
          canvas.drawCircle(position, 3, corePaint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(FacePainter oldDelegate) {
    return oldDelegate.faces != faces ||
        oldDelegate.absoluteImageSize != absoluteImageSize ||
        oldDelegate.rotation != rotation;
  }

  // Thuật toán scale trục X (Xử lý cho cả camera trước/sau)
  double _translateX(double x, Size size, Size absoluteImageSize) {
    switch (rotation) {
      case InputImageRotation.rotation90deg:
      case InputImageRotation.rotation270deg:
        // Đảo ngược trục X nếu là camera trước (270deg) để hình không bị ngược gương
        return rotation == InputImageRotation.rotation270deg
            ? size.width - (x * size.width / absoluteImageSize.height)
            : x * size.width / absoluteImageSize.height;
      default:
        return x * size.width / absoluteImageSize.width;
    }
  }

  // Thuật toán scale trục Y
  double _translateY(double y, Size size, Size absoluteImageSize) {
    switch (rotation) {
      case InputImageRotation.rotation90deg:
      case InputImageRotation.rotation270deg:
        return y * size.height / absoluteImageSize.width;
      default:
        return y * size.height / absoluteImageSize.height;
    }
  }
}
