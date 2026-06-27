import 'package:flutter/material.dart';
import '../../../../core/models/user_profile.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../shared/widgets/gradient_button.dart';
import '../../logic/tu_vi_engine.dart';

class ThienBanWidget extends StatelessWidget {
  final UserProfile profile;
  final VoidCallback? onKhaiGiai;

  const ThienBanWidget({super.key, required this.profile, this.onKhaiGiai});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final data = TuViEngine.lapThienBan(profile.birthDate, profile.birthTime);

    final String ten = profile.name.trim().isEmpty
        ? 'Đương số'
        : profile.name.trim();
    final String canChiNam = (data['canChiNam'] ?? '').toString();
    final String amDuong = profile.isMale ? 'Dương Nam' : 'Âm Nữ';
    final String banMenh = (data['menh'] ?? data['banMenh'] ?? '').toString();
    final String cuc = (data['cuc'] ?? '').toString();
    final String chuMenh = (data['chuMenh'] ?? '').toString();
    final String menhAnTai = (data['cungMenh'] ?? '').toString();

    final bool hasChuMenh = chuMenh.trim().isNotEmpty && chuMenh.trim() != '--';

    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 14),
      decoration: BoxDecoration(
        color: AppColors.glassFillSoft(isDark),
        borderRadius: BorderRadius.circular(26),
        border: Border.all(
          color: AppColors.info.withValues(alpha: isDark ? 0.32 : 0.22),
          width: 1.4,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              gradient: AppColors.primaryGradient(),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(Icons.blur_on_rounded, color: Colors.white, size: 19),
          ),
          const SizedBox(height: 8),
          Text(
            ten,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isDark ? AppColors.darkText : AppColors.lightText,
              fontWeight: FontWeight.w800,
              fontSize: 14.5,
              height: 1.1,
              letterSpacing: -0.1,
            ),
          ),
          const SizedBox(height: 6),
          if (canChiNam.isNotEmpty)
            Text(
              canChiNam,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.info,
                fontSize: 12.5,
                fontWeight: FontWeight.w800,
              ),
            ),
          const SizedBox(height: 6),
          _buildInfoLine(isDark: isDark, label: 'Âm dương', value: amDuong),
          _buildInfoLine(
            isDark: isDark,
            label: 'Bản mệnh',
            value: banMenh,
            valueColor: AppColors.warning,
            valueWeight: FontWeight.w700,
          ),
          _buildInfoLine(
            isDark: isDark,
            label: 'Cục',
            value: cuc,
            valueColor: AppColors.warning,
          ),
          _buildInfoLine(
            isDark: isDark,
            label: hasChuMenh ? 'Chủ mệnh' : 'Mệnh tại',
            value: hasChuMenh ? chuMenh : menhAnTai,
            valueColor: hasChuMenh ? null : AppColors.success,
            valueWeight: FontWeight.w700,
          ),
          const Spacer(),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: Theme(
              data: Theme.of(context).copyWith(
                elevatedButtonTheme: ElevatedButtonThemeData(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(48),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                ),
              ),
              child: GradientButton(
                text: 'Khai Giải',
                icon: Icons.blur_on_rounded,
                onPressed: onKhaiGiai ?? () {},
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoLine({
    required bool isDark,
    required String label,
    required String value,
    Color? valueColor,
    FontWeight valueWeight = FontWeight.w600,
  }) {
    final String normalized = value.trim().isEmpty ? '--' : value.trim();

    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 60,
            child: Text(
              '$label:',
              style: TextStyle(
                color: isDark ? Colors.white60 : AppColors.lightSubtleText,
                fontSize: 10.8,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Expanded(
            child: Text(
              normalized,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color:
                    valueColor ??
                    (isDark ? AppColors.darkText : AppColors.lightText),
                fontSize: 11.0,
                fontWeight: valueWeight,
                height: 1.1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
