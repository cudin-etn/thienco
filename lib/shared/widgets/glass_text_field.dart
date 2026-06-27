import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

class GlassTextField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final TextInputType keyboardType;
  final TextEditingController? controller;
  final bool readOnly;
  final VoidCallback? onTap;

  const GlassTextField({
    super.key,
    required this.hintText,
    required this.icon,
    this.keyboardType = TextInputType.text,
    this.controller,
    this.readOnly = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppColors.glassFill(isDark),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.glassBorder(isDark), width: 1),
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        readOnly: readOnly,
        onTap: onTap,
        style: TextStyle(
          color: isDark ? AppColors.darkText : AppColors.lightText,
          fontSize: 14,
          fontWeight: FontWeight.w600,
          height: 1.2,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            color: isDark ? Colors.white54 : AppColors.lightSubtleText,
            fontSize: 13.5,
            fontWeight: FontWeight.w500,
          ),
          prefixIcon: Padding(
            padding: const EdgeInsets.only(left: 14, right: 10),
            child: Icon(icon, color: AppColors.topbarIcon(isDark), size: 18),
          ),
          prefixIconConstraints: const BoxConstraints(
            minWidth: 42,
            minHeight: 42,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 14,
          ),
        ),
      ),
    );
  }
}
