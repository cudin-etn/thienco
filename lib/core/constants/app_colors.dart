import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Brand
  static const Color primary = Color(0xFF6366F1);
  static const Color secondary = Color(0xFF8B5CF6);
  static const Color primaryLight = Color(0xFFE0E7FF);
  static const Color secondaryLight = Color(0xFFEDE9FE);

  // Light theme
  static const Color lightScaffold = Color(0xFFF8FAFC);
  static const Color lightScaffoldAlt = Color(0xFFF3F4F6);
  static const Color lightScaffoldAccent = Color(0xFFEEF2FF);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightSurfaceSoft = Color(0xFFF4F6FB);
  static const Color lightText = Color(0xFF111827);
  static const Color lightSubtleText = Color(0xFF667085);
  static const Color lightBorder = Color(0xFFE5E7EB);
  static const Color lightBorderSoft = Color(0xFFD8DEEE);

  // Dark theme
  static const Color darkScaffold = Color(0xFF0B1020);
  static const Color darkScaffoldAlt = Color(0xFF172554);
  static const Color darkScaffoldAccent = Color(0xFF1E1B4B);
  static const Color darkSurface = Color(0xFF12192B);
  static const Color darkSurfaceSoft = Color(0xFF182235);
  static const Color darkText = Color(0xFFF8FAFC);
  static const Color darkSubtleText = Color(0xFF94A3B8);
  static const Color darkBorder = Color(0xFF243041);

  // Semantic
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFF59E0B);
  static const Color danger = Color(0xFFEF4444);
  static const Color info = Color(0xFF3B82F6);
  static const Color pinkAccent = Color(0xFFDB2777);
  static const Color tealAccent = Color(0xFF0F766E);

  // Shared helpers
  static Color glassFill(bool isDark) => isDark
      ? Colors.white.withValues(alpha: 0.05)
      : Colors.white.withValues(alpha: 0.72);

  static Color glassFillSoft(bool isDark) => isDark
      ? Colors.white.withValues(alpha: 0.04)
      : Colors.white.withValues(alpha: 0.60);

  static Color glassBorder(bool isDark) => isDark
      ? Colors.white.withValues(alpha: 0.08)
      : Colors.black.withValues(alpha: 0.05);

  static Color chipFill(bool isDark) => isDark
      ? Colors.white.withValues(alpha: 0.05)
      : Colors.white.withValues(alpha: 0.72);

  static Color chipBorder(bool isDark) => isDark
      ? Colors.white.withValues(alpha: 0.08)
      : Colors.black.withValues(alpha: 0.05);

  static Color topbarIcon(bool isDark) =>
      isDark ? const Color(0xFF93C5FD) : const Color(0xFF4F46E5);

  static LinearGradient appBackground(bool isDark) => LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    stops: const [0.0, 0.3, 0.55, 0.8, 1.0],
    colors: isDark
        ? const [
            Color(0xFF0B1020),
            Color(0xFF1E1B4B),
            Color(0xFF0D1B3E),
            Color(0xFF172554),
            Color(0xFF0B1020),
          ]
        : const [
            Color(0xFFFDF2F8),
            Color(0xFFF5F3FF),
            Color(0xFFEFF6FF),
            Color(0xFFF0FDF4),
            Color(0xFFFDF4FF),
          ],
  );

  static LinearGradient heroGradient(bool isDark) => LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: isDark
        ? [
            Colors.white.withValues(alpha: 0.08),
            const Color(0xFF1D2840).withValues(alpha: 0.72),
          ]
        : [
            Colors.white.withValues(alpha: 0.94),
            const Color(0xFFF3F0FF).withValues(alpha: 0.84),
          ],
  );

  static LinearGradient primaryGradient() => const LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primary, secondary],
  );
}
