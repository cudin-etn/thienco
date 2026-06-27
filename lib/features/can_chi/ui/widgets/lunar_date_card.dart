import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../shared/widgets/glass_card.dart';

class LunarDateCard extends StatelessWidget {
  final DateTime currentTime;
  final Map<String, dynamic> lunarData;

  const LunarDateCard({
    super.key,
    required this.currentTime,
    required this.lunarData,
  });

  String _formatTime(DateTime time) {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final String lunarDay = (lunarData['dayString'] ?? '--').toString();
    final String lunarMonth = (lunarData['month'] ?? '--').toString();
    final String canChiYear = (lunarData['canChiYear'] ?? '--').toString();

    return GlassCard(
      width: double.infinity,
      borderRadius: 24,
      padding: const EdgeInsets.all(14),
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: isDark
            ? [
                Colors.white.withValues(alpha: 0.04),
                AppColors.darkScaffoldAlt.withValues(alpha: 0.22),
              ]
            : [
                Colors.white.withValues(alpha: 0.72),
                const Color(0xFFF5F3FF).withValues(alpha: 0.68),
              ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Ngày Âm Hôm Nay',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: isDark
                            ? Colors.white60
                            : AppColors.lightSubtleText,
                        letterSpacing: 0.1,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '$lunarDay Tháng $lunarMonth',
                      style: TextStyle(
                        fontSize: 24,
                        height: 1.0,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.6,
                        color: isDark
                            ? AppColors.darkText
                            : AppColors.lightText,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  gradient: isDark
                      ? const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            AppColors.darkScaffoldAccent,
                            AppColors.info,
                          ],
                        )
                      : const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [AppColors.primaryLight, Color(0xFFDBEAFE)],
                        ),
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: isDark
                        ? Colors.white.withValues(alpha: 0.08)
                        : Colors.white.withValues(alpha: 0.75),
                  ),
                ),
                child: Column(
                  children: [
                    Text(
                      _formatTime(currentTime),
                      style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.4,
                        color: isDark ? Colors.white : AppColors.info,
                      ),
                    ),
                    const SizedBox(height: 1),
                    Text(
                      'Hiện tại',
                      style: TextStyle(
                        fontSize: 10.5,
                        fontWeight: FontWeight.w700,
                        color: isDark ? Colors.white70 : AppColors.primary,
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
              _buildInfoChip(
                isDark: isDark,
                icon: Icons.auto_awesome_outlined,
                label: 'Năm $canChiYear',
              ),
              if ((lunarData['canChiDay'] ?? '').toString().isNotEmpty)
                _buildInfoChip(
                  isDark: isDark,
                  icon: Icons.today_rounded,
                  label: 'Ngày ${lunarData['canChiDay']}',
                ),
              if ((lunarData['canChiHour'] ?? '').toString().isNotEmpty)
                _buildInfoChip(
                  isDark: isDark,
                  icon: Icons.schedule_rounded,
                  label: 'Giờ ${lunarData['canChiHour']}',
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoChip({
    required bool isDark,
    required IconData icon,
    required String label,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 7),
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
              fontSize: 12.1,
              fontWeight: FontWeight.w700,
              color: isDark ? Colors.white70 : AppColors.lightText,
            ),
          ),
        ],
      ),
    );
  }
}
