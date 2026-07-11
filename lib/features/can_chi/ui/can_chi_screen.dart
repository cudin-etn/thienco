import 'dart:async';
import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../logic/can_chi_calculator.dart';
import 'widgets/lunar_date_card.dart';
import '../../settings/ui/settings_drawer.dart';
import '../../settings/ui/settings_page.dart';
import 'widgets/cat_hung_widgets.dart';

class CanChiScreen extends StatefulWidget {
  const CanChiScreen({super.key});

  @override
  State<CanChiScreen> createState() => _CanChiScreenState();
}

class _CanChiScreenState extends State<CanChiScreen> {
  late DateTime _currentTime;
  late Map<String, dynamic> _lunarData;
  Timer? _timer;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _updateTime();
    _timer = Timer.periodic(const Duration(minutes: 1), (_) => _updateTime());
  }

  void _updateTime() {
    setState(() {
      _currentTime = DateTime.now();
      _lunarData = CanChiCalculator.getLunarDate(_currentTime);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final weekdayNames = [
      'Thứ Hai',
      'Thứ Ba',
      'Thứ Tư',
      'Thứ Năm',
      'Thứ Sáu',
      'Thứ Bảy',
      'Chủ Nhật',
    ];
    final monthNames = [
      'tháng 1',
      'tháng 2',
      'tháng 3',
      'tháng 4',
      'tháng 5',
      'tháng 6',
      'tháng 7',
      'tháng 8',
      'tháng 9',
      'tháng 10',
      'tháng 11',
      'tháng 12',
    ];

    final String weekdayText = weekdayNames[_currentTime.weekday - 1];
    final String dateText =
        '$weekdayText, ${_currentTime.day} ${monthNames[_currentTime.month - 1]} ${_currentTime.year}';
    final String canChiDay = (_lunarData['canChiDay'] ?? '').toString();
    final String subtitle = canChiDay.isNotEmpty
        ? '$dateText • Ngày $canChiDay'
        : dateText;

    return Scaffold(
      key: _scaffoldKey,
      endDrawer: const SettingsDrawer(),
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: BoxDecoration(gradient: AppColors.appBackground(isDark)),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(
                              gradient: AppColors.primaryGradient(),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Icon(
                              Icons.calendar_month_rounded,
                              color: Colors.white,
                              size: 21,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Hôm Nay',
                                  style: TextStyle(
                                    fontSize: 26,
                                    height: 1.0,
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: -0.6,
                                    color: isDark
                                        ? AppColors.darkText
                                        : AppColors.lightText,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  subtitle,
                                  style: TextStyle(
                                    fontSize: 13.2,
                                    height: 1.35,
                                    color: isDark
                                        ? Colors.white70
                                        : AppColors.lightSubtleText,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                final width = MediaQuery.of(context).size.width;
                                if (width >= 600) {
                                  _scaffoldKey.currentState?.openEndDrawer();
                                } else {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => const SettingsPage(),
                                    ),
                                  );
                                }
                              },
                              borderRadius: BorderRadius.circular(16),
                              child: Container(
                                width: 42,
                                height: 42,
                                decoration: BoxDecoration(
                                  color: isDark
                                      ? AppColors.glassFill(isDark)
                                      : AppColors.lightSurfaceSoft,
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                    color: AppColors.glassBorder(isDark),
                                  ),
                                ),
                                child: Icon(
                                  Icons.tune_rounded,
                                  color: AppColors.topbarIcon(isDark),
                                  size: 20,
                                ),
                              ),
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
                            icon: Icons.today_rounded,
                            label: 'Can chi hằng ngày',
                          ),
                          _buildInfoChip(
                            isDark: isDark,
                            icon: Icons.light_mode_outlined,
                            label: 'Giờ tốt xấu',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 18),
                LunarDateCard(currentTime: _currentTime, lunarData: _lunarData),
                const SizedBox(height: 18),
                const CatHungDashboard(),
              ],
            ),
          ),
        ),
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
