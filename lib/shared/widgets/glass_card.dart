import 'dart:ui';
import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

class GlassCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final double borderRadius;
  final double? width;
  final double? height;
  final Gradient? gradient;
  final Color? backgroundColor;
  final Border? border;

  const GlassCard({
    super.key,
    required this.child,
    this.padding,
    this.borderRadius = 20.0,
    this.width,
    this.height,
    this.gradient,
    this.backgroundColor,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final Color resolvedBackground =
        backgroundColor ?? AppColors.glassFillSoft(isDark);

    final Border resolvedBorder =
        border ?? Border.all(color: AppColors.glassBorder(isDark), width: 1.2);

    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(
          width: width,
          height: height,
          padding: padding ?? const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: gradient == null ? resolvedBackground : null,
            gradient: gradient,
            borderRadius: BorderRadius.circular(borderRadius),
            border: resolvedBorder,
          ),
          child: child,
        ),
      ),
    );
  }
}
