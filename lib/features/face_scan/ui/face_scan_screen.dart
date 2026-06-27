import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart'
    show kIsWeb, defaultTargetPlatform, TargetPlatform;
import '../../../core/constants/app_colors.dart';
import '../../../shared/widgets/glass_card.dart';
import '../../../shared/widgets/gradient_button.dart';
import 'face_camera_screen.dart';
import 'face_upload_screen.dart';

class FaceScanScreen extends StatelessWidget {
  const FaceScanScreen({super.key});

  bool get _isMobilePlatform {
    if (kIsWeb) return false;
    return defaultTargetPlatform == TargetPlatform.android ||
        defaultTargetPlatform == TargetPlatform.iOS;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: BoxDecoration(gradient: AppColors.appBackground(isDark)),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 18, 20, 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    gradient: AppColors.heroGradient(isDark),
                    borderRadius: BorderRadius.circular(28),
                    border: Border.all(color: AppColors.glassBorder(isDark)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFF38BDF8), Color(0xFF6366F1)],
                              ),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: const Icon(
                              Icons.face_retouching_natural_rounded,
                              color: Colors.white,
                              size: 22,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Tướng Học AI',
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: -0.6,
                                    color: isDark
                                        ? AppColors.darkText
                                        : AppColors.lightText,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Phân tích ngũ quan theo nhân tướng học',
                                  style: TextStyle(
                                    fontSize: 13.5,
                                    color: isDark
                                        ? Colors.white70
                                        : AppColors.lightSubtleText,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 7,
                        runSpacing: 7,
                        children: [
                          _buildChip(
                            isDark,
                            Icons.visibility_rounded,
                            'Ngũ quan',
                          ),
                          _buildChip(
                            isDark,
                            Icons.auto_awesome_rounded,
                            'Tam đình',
                          ),
                          _buildChip(
                            isDark,
                            Icons.psychology_alt_rounded,
                            'AI luận giải',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 22),

                // Mô tả tính năng
                GlassCard(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Cách hoạt động',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w800,
                          color: isDark
                              ? AppColors.darkText
                              : AppColors.lightText,
                        ),
                      ),
                      const SizedBox(height: 14),
                      _buildStep(
                        isDark,
                        '1',
                        'Mở camera và đưa mặt vào khung hình',
                      ),
                      _buildStep(
                        isDark,
                        '2',
                        'AI phân tích tỷ lệ ngũ quan (trán, mắt, mũi, miệng, cằm)',
                      ),
                      _buildStep(
                        isDark,
                        '3',
                        'Nhận kết quả luận giải theo nhân tướng học truyền thống',
                      ),
                      const SizedBox(height: 16),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppColors.info.withValues(
                            alpha: isDark ? 0.12 : 0.06,
                          ),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: AppColors.info.withValues(alpha: 0.2),
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.shield_outlined,
                              color: AppColors.info,
                              size: 18,
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                'Ảnh không được lưu trữ. Chỉ phân tích tỷ lệ rồi xóa ngay.',
                                style: TextStyle(
                                  fontSize: 12.5,
                                  color: isDark
                                      ? Colors.white70
                                      : AppColors.lightText,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // Các bộ vị phân tích
                Row(
                  children: [
                    Expanded(
                      child: _buildFeatureCard(
                        isDark,
                        Icons.face_rounded,
                        'Trán',
                        'Quan Lộc\nTiền vận',
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _buildFeatureCard(
                        isDark,
                        Icons.remove_red_eye_rounded,
                        'Mắt',
                        'Trí Tuệ\nTầm nhìn',
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _buildFeatureCard(
                        isDark,
                        Icons.air_rounded,
                        'Mũi',
                        'Tài Bạch\nÝ chí',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: _buildFeatureCard(
                        isDark,
                        Icons.mood_rounded,
                        'Miệng',
                        'Phúc Đức\nGiao tiếp',
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _buildFeatureCard(
                        isDark,
                        Icons.square_rounded,
                        'Cằm',
                        'Hậu Vận\nNền tảng',
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _buildFeatureCard(
                        isDark,
                        Icons.straighten_rounded,
                        'Tam Đình',
                        'Cân bằng\n3 vận',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Nút quét
                if (_isMobilePlatform)
                  SizedBox(
                    width: double.infinity,
                    child: GradientButton(
                      text: 'Mở Camera Quét Khuôn Mặt',
                      icon: Icons.camera_alt_rounded,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const FaceCameraScreen(),
                          ),
                        );
                      },
                    ),
                  ),
                if (!_isMobilePlatform)
                  SizedBox(
                    width: double.infinity,
                    child: GradientButton(
                      text: kIsWeb
                          ? 'Tải Ảnh Lên (Web Beta)'
                          : 'Tải Ảnh Khuôn Mặt Lên',
                      icon: Icons.upload_file_rounded,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const FaceUploadScreen(),
                          ),
                        );
                      },
                    ),
                  ),
                if (_isMobilePlatform) ...[
                  const SizedBox(height: 10),
                  Center(
                    child: TextButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const FaceUploadScreen(),
                          ),
                        );
                      },
                      icon: Icon(
                        Icons.photo_library_outlined,
                        size: 18,
                        color: isDark
                            ? Colors.white54
                            : AppColors.lightSubtleText,
                      ),
                      label: Text(
                        'Hoặc chọn ảnh từ thư viện',
                        style: TextStyle(
                          fontSize: 13,
                          color: isDark
                              ? Colors.white54
                              : AppColors.lightSubtleText,
                        ),
                      ),
                    ),
                  ),
                ],

                const SizedBox(height: 16),
                Center(
                  child: Text(
                    kIsWeb
                        ? 'Bản web không cần webcam. Nếu máy không có camera, bạn có thể tải ảnh lên; phân tích trực tiếp trên web sẽ dùng engine riêng ở bản sau.'
                        : 'Đây là tham khảo dựa trên nhân tướng học truyền thống,\nkhông phải chẩn đoán y khoa.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      color: isDark ? Colors.white38 : Colors.black38,
                      height: 1.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildChip(bool isDark, IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      decoration: BoxDecoration(
        color: AppColors.chipFill(isDark),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: AppColors.chipBorder(isDark)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: AppColors.primary),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 12.2,
              fontWeight: FontWeight.w700,
              color: isDark ? Colors.white70 : AppColors.lightText,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStep(bool isDark, String number, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 26,
            height: 26,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: isDark ? 0.2 : 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                number,
                style: TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w800,
                  fontSize: 13,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 3),
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 14,
                  color: isDark ? Colors.white70 : AppColors.lightText,
                  height: 1.4,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureCard(
    bool isDark,
    IconData icon,
    String title,
    String subtitle,
  ) {
    return GlassCard(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          Icon(icon, color: AppColors.primary, size: 24),
          const SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: isDark ? AppColors.darkText : AppColors.lightText,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 10.5,
              color: isDark ? Colors.white54 : AppColors.lightSubtleText,
              height: 1.3,
            ),
          ),
        ],
      ),
    );
  }
}
