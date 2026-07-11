import 'dart:ui';
import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../../shared/widgets/max_width_body.dart';

import '../../features/can_chi/ui/can_chi_screen.dart';
import '../../features/face_scan/ui/face_scan_screen.dart';
import '../../features/hop_tuoi/ui/hop_tuoi_screen.dart';
import '../../features/profile/ui/profile_screen.dart';
import '../../features/tu_vi/ui/tu_vi_screen.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    CanChiScreen(),
    TuViScreen(),
    FaceScanScreen(),
    HopTuoiScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark
          ? AppColors.darkScaffold
          : AppColors.lightScaffold,
      extendBody: true,
      body: Container(
        decoration: BoxDecoration(gradient: AppColors.appBackground(isDark)),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          switchInCurve: Curves.easeOutCubic,
          switchOutCurve: Curves.easeInCubic,
          transitionBuilder: (child, animation) {
            final slide = Tween<Offset>(
              begin: const Offset(0.035, 0),
              end: Offset.zero,
            ).animate(animation);

            return FadeTransition(
              opacity: animation,
              child: SlideTransition(position: slide, child: child),
            );
          },
          child: KeyedSubtree(
            key: ValueKey(_currentIndex),
            child: _screens[_currentIndex],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.only(bottom: 26),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: MaxWidthBody(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
                child: Container(
                  height: 80,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.glassFill(isDark),
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      color: AppColors.glassBorder(isDark),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: _buildNavItem(
                          index: 0,
                          icon: Icons.calendar_today_outlined,
                          activeIcon: Icons.calendar_month_rounded,
                          label: 'Hôm Nay',
                          isDark: isDark,
                        ),
                      ),
                      Expanded(
                        child: _buildNavItem(
                          index: 1,
                          icon: Icons.auto_awesome_outlined,
                          activeIcon: Icons.auto_awesome_rounded,
                          label: 'Tử Vi',
                          isDark: isDark,
                        ),
                      ),
                      Expanded(
                        child: _buildNavItem(
                          index: 2,
                          icon: Icons.face_retouching_natural_outlined,
                          activeIcon: Icons.face_retouching_natural_rounded,
                          label: 'Tướng',
                          isDark: isDark,
                        ),
                      ),
                      Expanded(
                        child: _buildNavItem(
                          index: 3,
                          icon: Icons.favorite_outline_rounded,
                          activeIcon: Icons.favorite_rounded,
                          label: 'Hợp Tuổi',
                          isDark: isDark,
                        ),
                      ),
                      Expanded(
                        child: _buildNavItem(
                          index: 4,
                          icon: Icons.badge_outlined,
                          activeIcon: Icons.badge_rounded,
                          label: 'Hồ Sơ',
                          isDark: isDark,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required int index,
    required IconData icon,
    required IconData activeIcon,
    required String label,
    required bool isDark,
  }) {
    final bool isSelected = _currentIndex == index;
    final Color unselectedColor = isDark
        ? Colors.white54
        : AppColors.lightSubtleText;

    return GestureDetector(
      onTap: () => setState(() => _currentIndex = index),
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOutCubic,
        height: double.infinity,
        alignment: Alignment.center,
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected
              ? (isDark
                    ? Colors.white.withValues(alpha: 0.08)
                    : AppColors.lightSurfaceSoft)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(
            color: isSelected
                ? (isDark
                      ? Colors.white.withValues(alpha: 0.10)
                      : AppColors.lightBorderSoft)
                : Colors.transparent,
            width: 1,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedScale(
              duration: const Duration(milliseconds: 220),
              scale: isSelected ? 1.04 : 1,
              child: Icon(
                isSelected ? activeIcon : icon,
                color: isSelected ? AppColors.primary : unselectedColor,
                size: isSelected ? 24 : 23,
              ),
            ),
            const SizedBox(height: 4),
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 220),
              curve: Curves.easeOutCubic,
              style: TextStyle(
                color: isSelected ? AppColors.primary : unselectedColor,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                fontSize: isSelected ? 11.8 : 11.6,
                letterSpacing: 0.06,
                height: 1,
              ),
              child: Text(label, maxLines: 1, overflow: TextOverflow.ellipsis),
            ),
          ],
        ),
      ),
    );
  }
}
