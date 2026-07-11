import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../shared/widgets/app_background.dart';
import '../../../shared/widgets/glass_card.dart';
import '../../../shared/widgets/gradient_button.dart';
import '../logic/hop_tuoi_calculator.dart';
import '../../../features/tu_vi/logic/core_engine.dart';

class HopTuoiScreen extends StatefulWidget {
  const HopTuoiScreen({super.key});

  @override
  State<HopTuoiScreen> createState() => _HopTuoiScreenState();
}

class _HopTuoiScreenState extends State<HopTuoiScreen> {
  int? _year1;
  int? _year2;
  Map<String, dynamic>? _result;

  Future<void> _selectYear(BuildContext context, bool isFirst) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(1990, 6, 15),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      helpText: isFirst ? 'Chọn năm sinh người 1' : 'Chọn năm sinh người 2',
      cancelText: 'Hủy',
      confirmText: 'Xác nhận',
    );

    if (picked != null) {
      setState(() {
        if (isFirst) {
          _year1 = picked.year;
        } else {
          _year2 = picked.year;
        }
        _result = null;
      });
    }
  }

  String _getNapAm(int year) {
    // Gọi CoreEngine để lấy Nạp Âm từ năm dương lịch
    final tb = CoreEngine.lapThienBan('15/06/$year', 'Giờ Ngọ');
    return (tb['menh'] ?? 'Thổ').toString();
  }

  void _calculate() {
    if (_year1 == null || _year2 == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Vui lòng chọn năm sinh cả hai người!'),
          backgroundColor: Colors.orangeAccent,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    final napAm1 = _getNapAm(_year1!);
    final napAm2 = _getNapAm(_year2!);

    setState(() {
      _result = HopTuoiCalculator.phanTichHopTuoi(
        namSinh1: _year1!,
        namSinh2: _year2!,
        napAm1: napAm1,
        napAm2: napAm2,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: AppBackground(
   isDark: isDark,
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
                              gradient: AppColors.primaryGradient(),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: const Icon(
                              Icons.favorite_rounded,
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
                                  'Hợp Tuổi',
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
                                  'Xem tương hợp tuổi giữa hai người',
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
                            Icons.compare_arrows_rounded,
                            'Tam Hợp • Lục Hợp',
                          ),
                          _buildChip(
                            isDark,
                            Icons.auto_awesome_outlined,
                            'Ngũ Hành Nạp Âm',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 22),

                // Input
                GlassCard(
                  width: double.infinity,
                  child: Column(
                    children: [
                      _buildYearSelector(
                        isDark: isDark,
                        label: 'Người thứ nhất',
                        year: _year1,
                        onTap: () => _selectYear(context, true),
                      ),
                      const SizedBox(height: 12),
                      _buildYearSelector(
                        isDark: isDark,
                        label: 'Người thứ hai',
                        year: _year2,
                        onTap: () => _selectYear(context, false),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: GradientButton(
                          text: 'Xem Hợp Tuổi',
                          icon: Icons.favorite_border_rounded,
                          onPressed: _calculate,
                        ),
                      ),
                    ],
                  ),
                ),

                // Result
                if (_result != null) ...[
                  const SizedBox(height: 22),
                  _buildResult(isDark),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildYearSelector({
    required bool isDark,
    required String label,
    required int? year,
    required VoidCallback onTap,
  }) {
    final String canChi = year != null ? HopTuoiCalculator.canChiNam(year) : '';

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: AppColors.glassFillSoft(isDark),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.glassBorder(isDark)),
          ),
          child: Row(
            children: [
              Icon(
                Icons.person_outline_rounded,
                color: isDark ? Colors.white54 : AppColors.lightSubtleText,
                size: 20,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: TextStyle(
                        fontSize: 12,
                        color: isDark
                            ? Colors.white54
                            : AppColors.lightSubtleText,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      year != null ? 'Năm $year ($canChi)' : 'Chọn năm sinh...',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: year != null
                            ? FontWeight.w700
                            : FontWeight.w500,
                        color: year != null
                            ? (isDark
                                  ? AppColors.darkText
                                  : AppColors.lightText)
                            : (isDark ? Colors.white38 : Colors.black38),
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.calendar_month_rounded,
                color: AppColors.primary,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildResult(bool isDark) {
    final int diem = _result!['diem'] ?? 50;
    final String mucDo = _result!['mucDoHop'] ?? 'Bình thường';
    final List<String> nhanXet = List<String>.from(_result!['nhanXet'] ?? []);
    final List<String> diemManh = List<String>.from(_result!['diemManh'] ?? []);
    final List<String> diemYeu = List<String>.from(_result!['diemYeu'] ?? []);

    final Color scoreColor = diem >= 70
        ? AppColors.success
        : diem >= 40
        ? AppColors.warning
        : AppColors.danger;

    return GlassCard(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Score
          Row(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: scoreColor.withValues(alpha: isDark ? 0.2 : 0.12),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Center(
                  child: Text(
                    '$diem',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: scoreColor,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      mucDo,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: isDark
                            ? AppColors.darkText
                            : AppColors.lightText,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${_result!['canChi1']} • ${_result!['canChi2']}',
                      style: TextStyle(
                        fontSize: 13,
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
          const SizedBox(height: 16),

          // Nhận xét
          if (nhanXet.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Text(
                nhanXet.join('\n'),
                style: TextStyle(
                  fontSize: 14.5,
                  height: 1.6,
                  color: isDark ? Colors.white70 : AppColors.lightText,
                ),
              ),
            ),

          // Điểm mạnh
          if (diemManh.isNotEmpty) ...[
            _buildSectionTitle(
              isDark,
              Icons.thumb_up_rounded,
              'Điểm hợp',
              AppColors.success,
            ),
            const SizedBox(height: 8),
            ...diemManh.map((e) => _buildBullet(isDark, e, AppColors.success)),
            const SizedBox(height: 12),
          ],

          // Điểm yếu
          if (diemYeu.isNotEmpty) ...[
            _buildSectionTitle(
              isDark,
              Icons.warning_rounded,
              'Điểm cần lưu ý',
              AppColors.danger,
            ),
            const SizedBox(height: 8),
            ...diemYeu.map((e) => _buildBullet(isDark, e, AppColors.danger)),
          ],
        ],
      ),
    );
  }

  Widget _buildSectionTitle(
    bool isDark,
    IconData icon,
    String title,
    Color color,
  ) {
    return Row(
      children: [
        Icon(icon, size: 16, color: color),
        const SizedBox(width: 8),
        Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: isDark ? AppColors.darkText : AppColors.lightText,
          ),
        ),
      ],
    );
  }

  Widget _buildBullet(bool isDark, String text, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 6,
            height: 6,
            margin: const EdgeInsets.only(top: 6, right: 10),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.6),
              shape: BoxShape.circle,
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 13.5,
                height: 1.5,
                color: isDark ? Colors.white70 : AppColors.lightText,
              ),
            ),
          ),
        ],
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
}
