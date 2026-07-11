import 'dart:ui';

import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import 'max_width_body.dart';

class AppBackground extends StatelessWidget {
  final bool isDark;
  final Widget child;

  const AppBackground({required this.isDark, required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: AppColors.appBackground(isDark)),
      child: Stack(
        fit: StackFit.expand,
        children: [
          _blob(const Color(0xFF6366F1), const Alignment(-1.1, -1.0), 1.0),
          _blob(const Color(0xFF8B5CF6), const Alignment(1.15, -0.4), 0.9),
          _blob(const Color(0xFFEC4899), const Alignment(-0.6, 1.2), 0.85),
          _blob(const Color(0xFF0EA5E9), const Alignment(1.1, 1.15), 0.8),
          MaxWidthBody(child: child),
        ],
      ),
    );
  }

  Widget _blob(Color color, Alignment alignment, double scale) {
    return Align(
      alignment: alignment,
      child: ImageFiltered(
        imageFilter: ImageFilter.blur(sigmaX: 95, sigmaY: 95),
        child: Container(
          width: 560 * scale,
          height: 560 * scale,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [
                color.withValues(alpha: isDark ? 0.5 : 0.45),
                color.withValues(alpha: 0.0),
              ],
              stops: const [0.0, 1.0],
            ),
          ),
        ),
      ),
    );
  }
}
