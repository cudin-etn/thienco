import 'dart:io';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import '../../../core/constants/app_colors.dart';
import '../logic/face_analyzer.dart';
import 'face_result_screen.dart';

class FaceCameraScreen extends StatefulWidget {
  const FaceCameraScreen({super.key});

  @override
  State<FaceCameraScreen> createState() => _FaceCameraScreenState();
}

class _FaceCameraScreenState extends State<FaceCameraScreen>
    with TickerProviderStateMixin {
  CameraController? _controller;
  bool _isDetecting = false;
  String _statusText = 'Đưa mặt vào khung hình';
  String _subStatusText = 'Giữ khuôn mặt ở giữa và đảm bảo đủ ánh sáng';

  late AnimationController _scanAnimController;
  late AnimationController _pulseAnimController;
  late Animation<double> _pulseAnimation;

  final FaceDetector _faceDetector = FaceDetector(
    options: FaceDetectorOptions(
      enableLandmarks: true,
      enableContours: true,
      performanceMode: FaceDetectorMode.accurate,
      minFaceSize: 0.05,
    ),
  );

  @override
  void initState() {
    super.initState();

    // Animation vòng tròn gradient xoay liên tục
    _scanAnimController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );

    // Animation pulse nhẹ cho oval
    _pulseAnimController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.02).animate(
      CurvedAnimation(parent: _pulseAnimController, curve: Curves.easeInOut),
    );
    _pulseAnimController.repeat(reverse: true);

    _initCamera();
  }

  Future<void> _initCamera() async {
    try {
      final cameras = await availableCameras();
      final frontCamera = cameras.firstWhere(
        (c) => c.lensDirection == CameraLensDirection.front,
        orElse: () => cameras.first,
      );

      _controller = CameraController(
        frontCamera,
        defaultTargetPlatform == TargetPlatform.iOS
            ? ResolutionPreset.medium
            : ResolutionPreset.high,
        enableAudio: false,
        imageFormatGroup: defaultTargetPlatform == TargetPlatform.android
            ? ImageFormatGroup.nv21
            : ImageFormatGroup.bgra8888,
      );

      await _controller!.initialize();
      if (mounted) setState(() {});
    } catch (e) {
      if (mounted) {
        setState(() => _statusText = 'Không thể mở camera');
      }
    }
  }

  Future<void> _captureAndAnalyze() async {
    if (_controller == null ||
        !_controller!.value.isInitialized ||
        _isDetecting) {
      return;
    }

    setState(() {
      _isDetecting = true;
      _statusText = 'Đang quét ngũ quan...';
      _subStatusText = 'Giữ yên, không di chuyển';
    });

    // Bắt đầu animation quét
    _scanAnimController.repeat();

    // Delay nhẹ để user thấy animation chạy (tạo cảm giác đang xử lý)
    await Future.delayed(const Duration(milliseconds: 800));

    try {
      final XFile photo = await _controller!.takePicture();

      setState(() {
        _statusText = 'Đang phân tích tướng mạo...';
        _subStatusText = 'Đối chiếu với nhân tướng học';
      });

      await Future.delayed(const Duration(milliseconds: 600));

      final InputImage inputImage = InputImage.fromFile(File(photo.path));
      final List<Face> faces = await _faceDetector.processImage(inputImage);

      if (faces.isEmpty) {
        _scanAnimController.stop();
        setState(() {
          _isDetecting = false;
          _statusText = 'Không nhận diện được khuôn mặt';
          _subStatusText = 'Đưa mặt vào giữa khung và thử lại';
        });
        return;
      }

      setState(() {
        _statusText = 'Hoàn tất phân tích!';
        _subStatusText = 'Đang tạo báo cáo tướng số...';
      });

      await Future.delayed(const Duration(milliseconds: 500));

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

      _scanAnimController.stop();

      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => FaceResultScreen(results: results)),
        );
      }
    } catch (e) {
      _scanAnimController.stop();
      setState(() {
        _isDetecting = false;
        _statusText = 'Lỗi phân tích';
        _subStatusText = 'Vui lòng thử lại';
      });
    }
  }

  @override
  void dispose() {
    _scanAnimController.dispose();
    _pulseAnimController.dispose();
    _controller?.dispose();
    _faceDetector.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFF0A0E1A),
      body: SafeArea(
        child: Column(
          children: [
            // Top bar
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                  const Expanded(
                    child: Text(
                      'Tướng Học AI',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  const SizedBox(width: 48), // Balance
                ],
              ),
            ),

            // Camera area
            Expanded(
              child: _controller != null && _controller!.value.isInitialized
                  ? Stack(
                      alignment: Alignment.center,
                      children: [
                        // Camera preview
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(28),
                            child: CameraPreview(_controller!),
                          ),
                        ),

                        // Animated oval guide with gradient arc
                        AnimatedBuilder(
                          animation: Listenable.merge([
                            _scanAnimController,
                            _pulseAnimation,
                          ]),
                          builder: (context, child) {
                            return CustomPaint(
                              size: Size(size.width - 60, size.height * 0.48),
                              painter: _AnimatedOvalPainter(
                                progress: _scanAnimController.value,
                                scale: _pulseAnimation.value,
                                isScanning: _isDetecting,
                              ),
                            );
                          },
                        ),

                        // Scanning overlay effect
                        if (_isDetecting)
                          AnimatedBuilder(
                            animation: _scanAnimController,
                            builder: (context, _) {
                              return CustomPaint(
                                size: Size(size.width - 60, size.height * 0.48),
                                painter: _ScanLinePainter(
                                  progress: _scanAnimController.value,
                                ),
                              );
                            },
                          ),
                      ],
                    )
                  : const Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircularProgressIndicator(color: AppColors.primary),
                          SizedBox(height: 16),
                          Text(
                            'Đang khởi tạo camera...',
                            style: TextStyle(color: Colors.white70),
                          ),
                        ],
                      ),
                    ),
            ),

            // Status + Button area
            Container(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    const Color(0xFF0A0E1A).withValues(alpha: 0.0),
                    const Color(0xFF0A0E1A),
                  ],
                ),
              ),
              child: Column(
                children: [
                  // Status text
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: Column(
                      key: ValueKey(_statusText),
                      children: [
                        Text(
                          _statusText,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          _subStatusText,
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.5),
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Capture button
                  GestureDetector(
                    onTap: _isDetecting ? null : _captureAndAnalyze,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      width: _isDetecting ? 64 : 72,
                      height: _isDetecting ? 64 : 72,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: _isDetecting
                              ? AppColors.primary.withValues(alpha: 0.5)
                              : Colors.white,
                          width: _isDetecting ? 2 : 4,
                        ),
                      ),
                      child: Center(
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          width: _isDetecting ? 50 : 58,
                          height: _isDetecting ? 50 : 58,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: _isDetecting
                                  ? [
                                      AppColors.primary.withValues(alpha: 0.3),
                                      AppColors.secondary.withValues(
                                        alpha: 0.3,
                                      ),
                                    ]
                                  : const [
                                      Color(0xFF38BDF8),
                                      Color(0xFF6366F1),
                                    ],
                            ),
                          ),
                          child: _isDetecting
                              ? const Padding(
                                  padding: EdgeInsets.all(12),
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2.5,
                                  ),
                                )
                              : const Icon(
                                  Icons.face_retouching_natural_rounded,
                                  color: Colors.white,
                                  size: 26,
                                ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    _isDetecting ? 'Đang xử lý...' : 'Nhấn để quét',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.4),
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Vẽ oval với gradient arc xoay khi đang quét
class _AnimatedOvalPainter extends CustomPainter {
  final double progress;
  final double scale;
  final bool isScanning;

  _AnimatedOvalPainter({
    required this.progress,
    required this.scale,
    required this.isScanning,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final double ovalWidth = size.width * 0.62 * scale;
    final double ovalHeight = size.height * 0.82 * scale;

    final rect = Rect.fromCenter(
      center: center,
      width: ovalWidth,
      height: ovalHeight,
    );

    // Base oval (luôn hiện)
    final basePaint = Paint()
      ..color = isScanning
          ? AppColors.primary.withValues(alpha: 0.3)
          : Colors.white.withValues(alpha: 0.25)
      ..style = PaintingStyle.stroke
      ..strokeWidth = isScanning ? 2.0 : 2.5;

    canvas.drawOval(rect, basePaint);

    if (isScanning) {
      // Gradient arc xoay
      final sweepAngle = pi * 0.8; // 144 degrees
      final startAngle = progress * 2 * pi;

      final gradientPaint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 4.0
        ..strokeCap = StrokeCap.round
        ..shader = SweepGradient(
          startAngle: startAngle,
          endAngle: startAngle + sweepAngle,
          colors: const [
            Color(0xFF38BDF8),
            Color(0xFF6366F1),
            Color(0xFF8B5CF6),
            Colors.transparent,
          ],
          stops: const [0.0, 0.4, 0.8, 1.0],
          transform: GradientRotation(startAngle),
        ).createShader(rect);

      canvas.drawArc(rect, startAngle, sweepAngle, false, gradientPaint);

      // Second arc (opposite side, dimmer)
      final secondArcPaint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3.0
        ..strokeCap = StrokeCap.round
        ..shader = SweepGradient(
          startAngle: startAngle + pi,
          endAngle: startAngle + pi + sweepAngle * 0.6,
          colors: [
            const Color(0xFF6366F1).withValues(alpha: 0.6),
            const Color(0xFF38BDF8).withValues(alpha: 0.3),
            Colors.transparent,
          ],
          stops: const [0.0, 0.6, 1.0],
          transform: GradientRotation(startAngle + pi),
        ).createShader(rect);

      canvas.drawArc(
        rect,
        startAngle + pi,
        sweepAngle * 0.6,
        false,
        secondArcPaint,
      );

      // Glow dots at arc ends
      final dotAngle = startAngle + sweepAngle;
      final dotX = center.dx + (ovalWidth / 2) * cos(dotAngle);
      final dotY = center.dy + (ovalHeight / 2) * sin(dotAngle);
      final dotPaint = Paint()
        ..color = const Color(0xFF38BDF8)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);
      canvas.drawCircle(Offset(dotX, dotY), 4, dotPaint);
    } else {
      // Corner markers khi chưa quét
      final markerPaint = Paint()
        ..color = AppColors.primary
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3.5
        ..strokeCap = StrokeCap.round;

      const double markerLen = 22;
      final double top = rect.top + 20;
      final double bottom = rect.bottom - 20;
      final double left = rect.left + 10;
      final double right = rect.right - 10;

      canvas.drawLine(
        Offset(left, top),
        Offset(left + markerLen, top),
        markerPaint,
      );
      canvas.drawLine(
        Offset(left, top),
        Offset(left, top + markerLen),
        markerPaint,
      );

      canvas.drawLine(
        Offset(right, top),
        Offset(right - markerLen, top),
        markerPaint,
      );
      canvas.drawLine(
        Offset(right, top),
        Offset(right, top + markerLen),
        markerPaint,
      );

      canvas.drawLine(
        Offset(left, bottom),
        Offset(left + markerLen, bottom),
        markerPaint,
      );
      canvas.drawLine(
        Offset(left, bottom),
        Offset(left, bottom - markerLen),
        markerPaint,
      );

      canvas.drawLine(
        Offset(right, bottom),
        Offset(right - markerLen, bottom),
        markerPaint,
      );
      canvas.drawLine(
        Offset(right, bottom),
        Offset(right, bottom - markerLen),
        markerPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _AnimatedOvalPainter oldDelegate) =>
      oldDelegate.progress != progress ||
      oldDelegate.scale != scale ||
      oldDelegate.isScanning != isScanning;
}

/// Vẽ scan line ngang chạy từ trên xuống
class _ScanLinePainter extends CustomPainter {
  final double progress;
  _ScanLinePainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final double ovalHeight = size.height * 0.82;
    final double ovalWidth = size.width * 0.62;

    // Scan line position (bounces up and down)
    final double yOffset = sin(progress * 2 * pi) * (ovalHeight * 0.35);
    final double lineY = center.dy + yOffset;

    // Calculate line width at this Y position (oval shape)
    final double normalizedY =
        (lineY - (center.dy - ovalHeight / 2)) / ovalHeight;
    final double lineWidth = ovalWidth * sin(normalizedY * pi) * 0.8;

    if (lineWidth <= 0) return;

    final paint = Paint()
      ..shader =
          LinearGradient(
            colors: [
              Colors.transparent,
              const Color(0xFF38BDF8).withValues(alpha: 0.4),
              const Color(0xFF6366F1).withValues(alpha: 0.6),
              const Color(0xFF38BDF8).withValues(alpha: 0.4),
              Colors.transparent,
            ],
          ).createShader(
            Rect.fromCenter(
              center: Offset(center.dx, lineY),
              width: lineWidth,
              height: 2,
            ),
          );

    canvas.drawLine(
      Offset(center.dx - lineWidth / 2, lineY),
      Offset(center.dx + lineWidth / 2, lineY),
      paint..strokeWidth = 2,
    );
  }

  @override
  bool shouldRepaint(covariant _ScanLinePainter oldDelegate) =>
      oldDelegate.progress != progress;
}
