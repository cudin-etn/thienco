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
          _blob(const Color(0xFF8B5CF6), const Alignment(1.15, -0.4), 0.95),
          _blob(const Color(0xFFEC4899), const Alignment(-0.6, 1.2), 0.9),
          _blob(const Color(0xFF0EA5E9), const Alignment(1.1, 1.15), 0.85),
          MaxWidthBody(child: child),
        ],
      ),
    );
  }

  Widget _blob(Color color, Alignment alignment, double scale) {
    return Align(
      alignment: alignment,
      child: Container(
        width: 640 * scale,
        height: 640 * scale,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [
              color.withValues(alpha: isDark ? 0.55 : 0.5),
              color.withValues(alpha: isDark ? 0.3 : 0.26),
              color.withValues(alpha: 0.0),
            ],
            stops: const [0.0, 0.55, 1.0],
          ),
        ),
      ),
    );
  }
}
