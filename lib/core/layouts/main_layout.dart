import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

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
  int? _hoveredIndex;

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
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(gradient: AppColors.appBackground(isDark)),
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 92),
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
            ),
          ),
          Positioned(
            bottom: 12,
            left: 48,
            right: 48,
            child: Container(
              height: 64,
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
              decoration: BoxDecoration(
                color: isDark
                    ? const Color(0xFF1E293B)
                    : Colors.white,
                borderRadius: BorderRadius.circular(32),
                boxShadow: [
                  BoxShadow(
                    color: isDark
                        ? Colors.black.withValues(alpha: 0.3)
                        : Colors.black.withValues(alpha: 0.06),
                    blurRadius: 20,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
        ],
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
    final bool isHovered = _hoveredIndex == index;
    final Color unselectedColor = isDark
        ? Colors.white38
        : AppColors.lightSubtleText;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hoveredIndex = index),
      onExit: (_) => setState(() => _hoveredIndex = null),
      child: GestureDetector(
        onTap: () => setState(() => _currentIndex = index),
        behavior: HitTestBehavior.opaque,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOutCubic,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(
            color: isSelected
                ? (isDark
                      ? Colors.white.withValues(alpha: 0.10)
                      : AppColors.primary.withValues(alpha: 0.10))
                : (isHovered
                      ? (isDark
                            ? Colors.white.withValues(alpha: 0.05)
                            : Colors.black.withValues(alpha: 0.03))
                      : Colors.transparent),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedScale(
                duration: const Duration(milliseconds: 250),
                scale: isSelected ? 1.05 : (isHovered ? 1.03 : 1),
                child: Icon(
                  isSelected ? activeIcon : icon,
                  color: isSelected ? AppColors.primary : unselectedColor,
                  size: 22,
                ),
              ),
              const SizedBox(height: 3),
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeOutCubic,
                style: TextStyle(
                  color: isSelected
                      ? AppColors.primary
                      : (isHovered
                          ? (isDark ? Colors.white70 : Colors.black54)
                          : unselectedColor),
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                  fontSize: 10.5,
                  letterSpacing: 0.05,
                  height: 1,
                ),
                child: Text(label, maxLines: 1, overflow: TextOverflow.ellipsis),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
