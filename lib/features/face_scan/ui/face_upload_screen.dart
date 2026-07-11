import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:image_picker/image_picker.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import '../../../core/constants/app_colors.dart';
import '../../../shared/widgets/app_background.dart';
import '../../../shared/widgets/glass_card.dart';
import '../../../shared/widgets/gradient_button.dart';
import '../logic/face_analyzer.dart';
import '../logic/web_face_detector.dart';
import 'face_result_screen.dart';

/// Màn hình upload ảnh để phân tích tướng mạo.
/// Mobile dùng ML Kit native; web dùng MediaPipe WASM.
class FaceUploadScreen extends StatefulWidget {
  const FaceUploadScreen({super.key});

  @override
  State<FaceUploadScreen> createState() => _FaceUploadScreenState();
}

class _FaceUploadScreenState extends State<FaceUploadScreen> {
  bool _isAnalyzing = false;
  String _statusText = '';
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? image = await _picker.pickImage(
        source: source,
        maxWidth: 1200,
        maxHeight: 1200,
        imageQuality: 90,
      );

      if (image == null) return;

      if (kIsWeb) {
        setState(() {
          _isAnalyzing = true;
          _statusText = 'Đang tải mô hình nhận diện...';
        });

        final ready = await WebFaceDetector.init();
        if (!ready) {
          setState(() {
            _isAnalyzing = false;
            _statusText = 'Trình duyệt không hỗ trợ nhận diện khuôn mặt qua web.';
          });
          return;
        }

        setState(() { _statusText = 'Đang phân tích ngũ quan...'; });

        final bytes = await image.readAsBytes();
        final result = await WebFaceDetector.detect(
          imageBytes: bytes,
          mimeType: image.mimeType ?? 'image/jpeg',
        );

        if (result == null) {
          setState(() {
            _isAnalyzing = false;
            _statusText = 'Không nhận diện được khuôn mặt trong ảnh.\nVui lòng chọn ảnh chụp thẳng mặt, rõ nét.';
          });
          return;
        }

        final faceData = WebFaceDetector.toFaceData(result);
        final results = FaceAnalyzer.analyzeFullFaceFromData(faceData);

        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => FaceResultScreen(results: results)),
          );
        }
        return;
      }

      setState(() {
        _isAnalyzing = true;
        _statusText = 'Đang phân tích ngũ quan...';
      });

      await _analyzeImage(image.path);
    } catch (e) {
      setState(() {
        _isAnalyzing = false;
        _statusText = 'Không thể chọn ảnh: $e';
      });
    }
  }

  Future<void> _analyzeImage(String path) async {
    try {
      final inputImage = InputImage.fromFile(File(path));
      final faceDetector = FaceDetector(
        options: FaceDetectorOptions(
          enableLandmarks: true,
          enableContours: true,
          performanceMode: FaceDetectorMode.accurate,
          minFaceSize: 0.05,
        ),
      );

      final List<Face> faces = await faceDetector.processImage(inputImage);
      faceDetector.close();

      if (faces.isEmpty) {
        setState(() {
          _isAnalyzing = false;
          _statusText =
              'Không nhận diện được khuôn mặt trong ảnh.\nVui lòng chọn ảnh chụp thẳng mặt, rõ nét.';
        });
        return;
      }

      final Face mainFace = faces.reduce(
        (a, b) =>
            a.boundingBox.width * a.boundingBox.height >
                b.boundingBox.width * b.boundingBox.height
            ? a
            : b,
      );

      final Map<String, dynamic> results = FaceAnalyzer.analyzeFullFace(
        mainFace,
      );

      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => FaceResultScreen(results: results)),
        );
      }
    } catch (e) {
      setState(() {
        _isAnalyzing = false;
        _statusText = 'Lỗi phân tích: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: isDark ? Colors.white : AppColors.lightText,
        title: Text(
          'Phân Tích Từ Ảnh',
          style: TextStyle(
            fontWeight: FontWeight.w800,
            color: isDark ? AppColors.darkText : AppColors.lightText,
          ),
        ),
      ),
      body: AppBackground(
   isDark: isDark,
   child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Upload area
                  GlassCard(
                    width: double.infinity,
                    padding: const EdgeInsets.all(32),
                    child: Column(
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFF38BDF8), Color(0xFF6366F1)],
                            ),
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: const Icon(
                            Icons.add_a_photo_rounded,
                            color: Colors.white,
                            size: 36,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Tải ảnh khuôn mặt',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            color: isDark
                                ? AppColors.darkText
                                : AppColors.lightText,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Chọn ảnh chụp thẳng mặt, rõ nét\nđể AI phân tích ngũ quan chính xác nhất',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            height: 1.5,
                            color: isDark
                                ? Colors.white60
                                : AppColors.lightSubtleText,
                          ),
                        ),
                        const SizedBox(height: 24),
                        SizedBox(
                          width: double.infinity,
                          child: GradientButton(
                            text: kIsWeb
                                ? 'Chọn Ảnh Từ Máy Tính'
                                : 'Chọn Ảnh Từ Thư Viện',
                            icon: Icons.photo_library_rounded,
                            onPressed: _isAnalyzing
                                ? () {}
                                : () => _pickImage(ImageSource.gallery),
                          ),
                        ),
                        if (_statusText.isNotEmpty) ...[
                          const SizedBox(height: 16),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: AppColors.warning.withValues(
                                alpha: isDark ? 0.12 : 0.06,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              _statusText,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 13,
                                height: 1.5,
                                color: isDark
                                    ? Colors.white70
                                    : AppColors.lightText,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Tips
                  GlassCard(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.tips_and_updates_rounded,
                              color: AppColors.warning,
                              size: 20,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              'Mẹo để kết quả chính xác',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                color: isDark
                                    ? AppColors.darkText
                                    : AppColors.lightText,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        _buildTip(
                          isDark,
                          'Ảnh chụp thẳng mặt, nhìn thẳng vào camera',
                        ),
                        _buildTip(
                          isDark,
                          'Ánh sáng đều, không bị bóng đổ một bên',
                        ),
                        _buildTip(isDark, 'Không đeo kính, mũ hoặc khẩu trang'),
                        _buildTip(
                          isDark,
                          'Biểu cảm tự nhiên, không cười quá rộng',
                        ),
                        _buildTip(
                          isDark,
                          'Ảnh gốc, không qua filter hay chỉnh sửa',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTip(bool isDark, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 6,
            height: 6,
            margin: const EdgeInsets.only(top: 6),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.6),
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 13.5,
                height: 1.4,
                color: isDark ? Colors.white70 : AppColors.lightText,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
