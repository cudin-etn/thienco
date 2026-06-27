import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../shared/widgets/glass_card.dart';
import '../../logic/can_chi_calculator.dart';
import '../../logic/daily_calculator.dart';

class CatHungDashboard extends StatelessWidget {
  const CatHungDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Tính toán dữ liệu thực
    final now = DateTime.now();
    final lunarData = CanChiCalculator.getLunarDate(now);
    final String canChiDay = (lunarData['canChiDay'] ?? '').toString();
    final int lunarMonth = lunarData['month'] ?? 1;
    final int lunarDay = lunarData['day'] ?? 1;

    final dailyData = DailyCalculator.tongHopNgay(
      canChiDay: canChiDay,
      lunarMonth: lunarMonth,
      lunarDay: lunarDay,
    );

    final List<String> gioTot = List<String>.from(
      dailyData['gioHoangDao'] ?? [],
    );
    final String truc = dailyData['truc'] ?? '--';
    final String trucMuc = dailyData['trucMuc'] ?? 'trung';
    final String viecNen = dailyData['viecNen'] ?? '--';
    final String viecKieng = dailyData['viecKieng'] ?? '--';
    final String huongHy = dailyData['huongHyThan'] ?? '--';
    final String huongTai = dailyData['huongTaiThan'] ?? '--';
    final List<String> tuoiXung = List<String>.from(
      dailyData['tuoiXung'] ?? [],
    );

    final Color trucColor = trucMuc == 'tốt'
        ? AppColors.success
        : trucMuc == 'xấu'
        ? AppColors.danger
        : AppColors.warning;

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildMetricCard(
                isDark: isDark,
                icon: Icons.wb_sunny_rounded,
                title: 'Giờ Hoàng Đạo',
                value: gioTot.take(3).join(', '),
                accent: const Color(0xFFF59E0B),
                subtitle: gioTot.skip(3).join(", "),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildMetricCard(
                isDark: isDark,
                icon: Icons.explore_rounded,
                title: 'Hướng Tốt',
                value: 'Hỷ: $huongHy',
                accent: const Color(0xFF6366F1),
                subtitle: 'Tài: $huongTai',
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        GlassCard(
          width: double.infinity,
          borderRadius: 24,
          padding: const EdgeInsets.all(14),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: isDark
                ? [
                    Colors.white.withValues(alpha: 0.035),
                    AppColors.darkScaffoldAlt.withValues(alpha: 0.18),
                  ]
                : [
                    Colors.white.withValues(alpha: 0.72),
                    const Color(0xFFF5F3FF).withValues(alpha: 0.60),
                  ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: isDark
                            ? [trucColor, trucColor.withValues(alpha: 0.7)]
                            : [
                                trucColor.withValues(alpha: 0.2),
                                trucColor.withValues(alpha: 0.1),
                              ],
                      ),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Icon(
                      Icons.auto_awesome_rounded,
                      color: isDark ? Colors.white : trucColor,
                      size: 18,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Trực $truc',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w800,
                                color: isDark
                                    ? AppColors.darkText
                                    : AppColors.lightText,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 3,
                              ),
                              decoration: BoxDecoration(
                                color: trucColor.withValues(
                                  alpha: isDark ? 0.2 : 0.12,
                                ),
                                borderRadius: BorderRadius.circular(999),
                              ),
                              child: Text(
                                trucMuc == 'tốt'
                                    ? 'Ngày tốt'
                                    : trucMuc == 'xấu'
                                    ? 'Ngày xấu'
                                    : 'Bình thường',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                  color: trucColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 3),
                        Text(
                          tuoiXung.isNotEmpty
                              ? 'Xung: ${tuoiXung.join(", ")}'
                              : 'Không có tuổi xung đặc biệt',
                          style: TextStyle(
                            fontSize: 12.1,
                            color: isDark
                                ? Colors.white60
                                : AppColors.lightSubtleText,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              _buildAdviceRow(
                isDark: isDark,
                icon: Icons.check_circle_rounded,
                accent: const Color(0xFF10B981),
                title: 'Nên',
                content: viecNen,
              ),
              const SizedBox(height: 8),
              _buildAdviceRow(
                isDark: isDark,
                icon: Icons.remove_circle_outline_rounded,
                accent: const Color(0xFFEF4444),
                title: 'Kiêng',
                content: viecKieng,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMetricCard({
    required bool isDark,
    required IconData icon,
    required String title,
    required String value,
    required Color accent,
    required String subtitle,
  }) {
    return GlassCard(
      width: double.infinity,
      borderRadius: 22,
      padding: const EdgeInsets.all(14),
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: isDark
            ? [
                Colors.white.withValues(alpha: 0.03),
                accent.withValues(alpha: 0.10),
              ]
            : [
                Colors.white.withValues(alpha: 0.75),
                accent.withValues(alpha: 0.08),
              ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: accent.withValues(alpha: isDark ? 0.18 : 0.14),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: accent, size: 18),
          ),
          const SizedBox(height: 10),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: isDark ? Colors.white60 : AppColors.lightSubtleText,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 14.5,
              height: 1.1,
              fontWeight: FontWeight.w800,
              color: isDark ? AppColors.darkText : AppColors.lightText,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 11.8,
              height: 1.3,
              color: isDark ? Colors.white60 : AppColors.lightSubtleText,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAdviceRow({
    required bool isDark,
    required IconData icon,
    required Color accent,
    required String title,
    required String content,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 34,
          height: 34,
          decoration: BoxDecoration(
            color: accent.withValues(alpha: isDark ? 0.18 : 0.12),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: accent, size: 16),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w800,
                  color: isDark ? AppColors.darkText : AppColors.lightText,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                content,
                style: TextStyle(
                  fontSize: 12.2,
                  height: 1.3,
                  color: isDark ? Colors.white70 : AppColors.lightText,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
