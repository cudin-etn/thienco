import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';

class AppBackground extends StatelessWidget {
  final bool isDark;
  final Widget child;

  const AppBackground({required this.isDark, required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: AppColors.appBackground(isDark)),
      child: child,
    );
  }
}
