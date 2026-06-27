import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class CungWidget extends StatelessWidget {
  final String chi;
  final String tenCung;
  final List<String> chinhTinh;
  final List<String> phuTinh;
  final String tuanTriet;
  final bool isThan;
  final int daiHan;

  const CungWidget({
    super.key,
    required this.chi,
    required this.tenCung,
    this.chinhTinh = const [],
    this.phuTinh = const [],
    this.tuanTriet = '',
    this.isThan = false,
    this.daiHan = 0,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final Color panelColor = isThan
        ? (isDark
              ? AppColors.glassFill(isDark).withValues(alpha: 0.92)
              : const Color(0xFFEAF2FF).withValues(alpha: 0.16))
        : AppColors.glassFill(isDark);

    final Color borderColor = isThan
        ? AppColors.info.withValues(alpha: isDark ? 0.62 : 0.30)
        : AppColors.glassBorder(isDark);

    final Color dividerColor = isThan
        ? AppColors.info.withValues(alpha: isDark ? 0.18 : 0.16)
        : AppColors.glassBorder(isDark);

    final Color bodyColor = isDark ? Colors.white70 : AppColors.lightText;
    final Color titleColor = isDark || isThan
        ? AppColors.darkText
        : AppColors.lightText;
    final Color chiColor = isDark ? AppColors.info : AppColors.tealAccent;
    final Color chinhTinhColor = AppColors.warning;
    final Color badgeColor = isDark
        ? AppColors.darkScaffold.withValues(alpha: 0.88)
        : AppColors.darkScaffold.withValues(alpha: 0.80);

    return Expanded(
      child: GestureDetector(
        onTap: () => _showCungDetail(context, isDark),
        child: Container(
          margin: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            color: panelColor,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: borderColor, width: isThan ? 1.1 : 1),
          ),
          child: Stack(
            children: [
              Positioned.fill(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8, 8, 8, 26),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (tuanTriet.isNotEmpty)
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          margin: const EdgeInsets.only(bottom: 6),
                          decoration: BoxDecoration(
                            color: AppColors.danger.withValues(
                              alpha: isDark ? 0.82 : 0.88,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            tuanTriet,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 9.5,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 0.2,
                            ),
                          ),
                        ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              chi,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: chiColor,
                                fontWeight: FontWeight.w800,
                                fontSize: 11.5,
                                letterSpacing: 0.1,
                              ),
                            ),
                          ),
                          const SizedBox(width: 6),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                tenCung.replaceAll('Cung ', ''),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: titleColor.withValues(alpha: 0.82),
                                  fontSize: 9.8,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0.1,
                                ),
                              ),
                              if (isThan)
                                Padding(
                                  padding: const EdgeInsets.only(top: 2),
                                  child: Text(
                                    '(THÂN)',
                                    style: TextStyle(
                                      color: AppColors.info,
                                      fontSize: 8.0,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 6, bottom: 8),
                        child: Divider(
                          height: 1,
                          thickness: 1,
                          color: dividerColor,
                        ),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ...chinhTinh.map(
                                (sao) => Padding(
                                  padding: const EdgeInsets.only(bottom: 3),
                                  child: Text(
                                    sao,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: chinhTinhColor,
                                      fontSize: 10.8,
                                      fontWeight: FontWeight.w800,
                                      height: 1.15,
                                    ),
                                  ),
                                ),
                              ),
                              if (chinhTinh.isNotEmpty && phuTinh.isNotEmpty)
                                const SizedBox(height: 2),
                              ...phuTinh.map(
                                (sao) => Padding(
                                  padding: const EdgeInsets.only(bottom: 2),
                                  child: Text(
                                    sao,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: bodyColor,
                                      fontSize: 10.0,
                                      height: 1.12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (daiHan > 0)
                Positioned(
                  bottom: 6,
                  right: 6,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: badgeColor,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppColors.glassBorder(isDark)),
                    ),
                    child: Text(
                      '$daiHan',
                      style: TextStyle(
                        color: isDark ? AppColors.pinkAccent : AppColors.danger,
                        fontSize: 9.5,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _showCungDetail(BuildContext context, bool isDark) {
    final allStars = [...chinhTinh, ...phuTinh];
    if (allStars.isEmpty && tenCung.isEmpty) return;

    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: isDark
            ? AppColors.darkScaffold
            : AppColors.lightSurface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Center(
                      child: Text(
                        chi,
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          tenCung.isNotEmpty ? tenCung : 'Cung $chi',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            color: isDark
                                ? AppColors.darkText
                                : AppColors.lightText,
                          ),
                        ),
                        if (isThan || tuanTriet.isNotEmpty || daiHan > 0)
                          Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: Wrap(
                              spacing: 6,
                              children: [
                                if (isThan)
                                  _buildTag('THÂN', AppColors.info, isDark),
                                if (tuanTriet.isNotEmpty)
                                  _buildTag(
                                    tuanTriet,
                                    AppColors.danger,
                                    isDark,
                                  ),
                                if (daiHan > 0)
                                  _buildTag(
                                    'ĐH: $daiHan',
                                    AppColors.pinkAccent,
                                    isDark,
                                  ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(
                      Icons.close_rounded,
                      color: isDark ? Colors.white54 : Colors.black45,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              if (chinhTinh.isNotEmpty) ...[
                Text(
                  'Chính Tinh',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: isDark ? Colors.white54 : AppColors.lightSubtleText,
                  ),
                ),
                const SizedBox(height: 6),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: chinhTinh
                      .map((s) => _buildStarChip(s, AppColors.warning, isDark))
                      .toList(),
                ),
                const SizedBox(height: 14),
              ],
              if (phuTinh.isNotEmpty) ...[
                Text(
                  'Phụ Tinh',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: isDark ? Colors.white54 : AppColors.lightSubtleText,
                  ),
                ),
                const SizedBox(height: 6),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxHeight: 200),
                  child: SingleChildScrollView(
                    child: Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: phuTinh.map((s) {
                        final bool isSat =
                            s.contains('Kình') ||
                            s.contains('Đà La') ||
                            s.contains('Hỏa Tinh') ||
                            s.contains('Linh Tinh') ||
                            s.contains('Địa Không') ||
                            s.contains('Địa Kiếp') ||
                            s.contains('Hóa Kỵ');
                        final bool isLoc =
                            s.contains('Lộc') ||
                            s.contains('Hóa Lộc') ||
                            s.contains('Hóa Quyền') ||
                            s.contains('Hóa Khoa');
                        final Color color = isSat
                            ? AppColors.danger
                            : isLoc
                            ? AppColors.success
                            : (isDark ? Colors.white70 : AppColors.lightText);
                        return _buildStarChip(s, color, isDark);
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTag(String text, Color color, bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: isDark ? 0.2 : 0.12),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w700,
          color: color,
        ),
      ),
    );
  }

  Widget _buildStarChip(String star, Color color, bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: isDark ? 0.12 : 0.08),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withValues(alpha: 0.25)),
      ),
      child: Text(
        star,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    );
  }
}
