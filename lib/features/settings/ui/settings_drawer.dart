import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/database/settings_service.dart';
import '../../../core/database/hive_service.dart';
import '../../../core/models/user_profile.dart';

class SettingsDrawer extends StatefulWidget {
  const SettingsDrawer({super.key});

  @override
  State<SettingsDrawer> createState() => _SettingsDrawerState();
}

class _SettingsDrawerState extends State<SettingsDrawer> {
  late String _themeMode;
  late String _defaultGender;
  late bool _showDaiHan;
  late bool _showPhuTinh;
  late String _binhGiaiLevel;
  late bool _luuNienAutoYear;
  late String _fontSize;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  void _loadSettings() {
    _themeMode = SettingsService.getThemeMode();
    _defaultGender = SettingsService.getDefaultGender();
    _showDaiHan = SettingsService.getShowDaiHan();
    _showPhuTinh = SettingsService.getShowPhuTinh();
    _binhGiaiLevel = SettingsService.getBinhGiaiLevel();
    _luuNienAutoYear = SettingsService.getLuuNienAutoYear();
    _fontSize = SettingsService.getFontSize();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final Color bgColor = isDark
        ? AppColors.darkScaffold
        : AppColors.lightSurface;
    final Color textColor = isDark ? AppColors.darkText : AppColors.lightText;
    final Color subtleColor = isDark
        ? Colors.white60
        : AppColors.lightSubtleText;
    final Color cardColor = isDark
        ? Colors.white.withValues(alpha: 0.04)
        : Colors.grey.withValues(alpha: 0.06);
    final Color borderColor = isDark
        ? Colors.white.withValues(alpha: 0.08)
        : Colors.black.withValues(alpha: 0.06);

    return Drawer(
      backgroundColor: bgColor,
      child: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 12, 8),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      gradient: AppColors.primaryGradient(),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Icon(
                      Icons.settings_rounded,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Cài Đặt',
                      style: TextStyle(
                        color: textColor,
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.close_rounded, color: subtleColor),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),

            // Settings list
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  // === GIAO DIỆN ===
                  _buildSectionTitle('GIAO DIỆN', isDark),
                  _buildCard(cardColor, borderColor, [
                    _buildThemeSelector(textColor, subtleColor, isDark),
                    _buildDivider(borderColor),
                    _buildFontSizeSelector(textColor, subtleColor, isDark),
                  ]),

                  const SizedBox(height: 20),

                  // === LÁ SỐ ===
                  _buildSectionTitle('LÁ SỐ TỬ VI', isDark),
                  _buildCard(cardColor, borderColor, [
                    _buildSwitchTile(
                      icon: Icons.timeline_rounded,
                      title: 'Hiện Đại Hạn trên lá số',
                      value: _showDaiHan,
                      textColor: textColor,
                      onChanged: (v) async {
                        await SettingsService.setShowDaiHan(v);
                        setState(() => _showDaiHan = v);
                      },
                    ),
                    _buildDivider(borderColor),
                    _buildSwitchTile(
                      icon: Icons.blur_on_rounded,
                      title: 'Hiện Phụ Tinh trên lá số',
                      value: _showPhuTinh,
                      textColor: textColor,
                      onChanged: (v) async {
                        await SettingsService.setShowPhuTinh(v);
                        setState(() => _showPhuTinh = v);
                      },
                    ),
                    _buildDivider(borderColor),
                    _buildSwitchTile(
                      icon: Icons.calendar_today_rounded,
                      title: 'Tự động luận vận năm hiện tại',
                      value: _luuNienAutoYear,
                      textColor: textColor,
                      onChanged: (v) async {
                        await SettingsService.setLuuNienAutoYear(v);
                        setState(() => _luuNienAutoYear = v);
                      },
                    ),
                    _buildDivider(borderColor),
                    _buildGenderSelector(textColor, subtleColor, isDark),
                    _buildDivider(borderColor),
                    _buildBinhGiaiSelector(textColor, subtleColor, isDark),
                  ]),

                  const SizedBox(height: 20),

                  // === DỮ LIỆU ===
                  _buildSectionTitle('DỮ LIỆU', isDark),
                  _buildCard(cardColor, borderColor, [
                    _buildActionTile(
                      icon: Icons.delete_sweep_rounded,
                      title: 'Xóa toàn bộ hồ sơ đã lưu',
                      subtitle: '${HiveService.getAllProfiles().length} hồ sơ',
                      textColor: textColor,
                      subtleColor: subtleColor,
                      onTap: () => _confirmDeleteProfiles(context, isDark),
                    ),
                    _buildDivider(borderColor),
                    _buildActionTile(
                      icon: Icons.restart_alt_rounded,
                      title: 'Đặt lại cài đặt mặc định',
                      subtitle: 'Khôi phục tất cả về ban đầu',
                      textColor: textColor,
                      subtleColor: subtleColor,
                      onTap: () => _confirmResetSettings(context, isDark),
                    ),
                  ]),

                  const SizedBox(height: 20),

                  // === THÔNG TIN ===
                  _buildSectionTitle('THÔNG TIN', isDark),
                  _buildCard(cardColor, borderColor, [
                    _buildInfoTile(
                      icon: Icons.info_outline_rounded,
                      title: 'Phiên bản',
                      trailing: 'v1.0.0',
                      textColor: textColor,
                      subtleColor: subtleColor,
                    ),
                    _buildDivider(borderColor),
                    _buildInfoTile(
                      icon: Icons.code_rounded,
                      title: 'Phát triển bởi',
                      trailing: 'TDEV Studio',
                      textColor: textColor,
                      subtleColor: subtleColor,
                    ),
                    _buildDivider(borderColor),
                    _buildInfoTile(
                      icon: Icons.auto_awesome_rounded,
                      title: 'Engine',
                      trailing: 'Thiên Cơ v2',
                      textColor: textColor,
                      subtleColor: subtleColor,
                    ),
                  ]),

                  const SizedBox(height: 32),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // === BUILDERS ===

  Widget _buildSectionTitle(String title, bool isDark) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 10),
      child: Text(
        title,
        style: TextStyle(
          color: AppColors.primary,
          fontSize: 11.5,
          fontWeight: FontWeight.w800,
          letterSpacing: 1.0,
        ),
      ),
    );
  }

  Widget _buildCard(Color cardColor, Color borderColor, List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: borderColor),
      ),
      child: Column(children: children),
    );
  }

  Widget _buildDivider(Color color) {
    return Divider(
      height: 1,
      thickness: 1,
      color: color,
      indent: 52,
      endIndent: 16,
    );
  }

  // --- Theme Selector ---
  Widget _buildThemeSelector(Color textColor, Color subtleColor, bool isDark) {
    final Map<String, String> options = {
      'system': 'Theo hệ thống',
      'light': 'Sáng',
      'dark': 'Tối',
    };

    return ListTile(
      leading: Icon(
        Icons.palette_outlined,
        color: textColor.withValues(alpha: 0.7),
        size: 22,
      ),
      title: Text(
        'Giao diện',
        style: TextStyle(
          color: textColor,
          fontSize: 14.5,
          fontWeight: FontWeight.w600,
        ),
      ),
      trailing: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: AppColors.primary.withValues(alpha: isDark ? 0.15 : 0.08),
          borderRadius: BorderRadius.circular(10),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: _themeMode,
            isDense: true,
            dropdownColor: isDark
                ? AppColors.darkScaffold
                : AppColors.lightSurface,
            style: TextStyle(
              color: AppColors.primary,
              fontSize: 13,
              fontWeight: FontWeight.w700,
            ),
            items: options.entries
                .map(
                  (e) => DropdownMenuItem(value: e.key, child: Text(e.value)),
                )
                .toList(),
            onChanged: (v) async {
              if (v == null) return;
              await SettingsService.setThemeMode(v);
              setState(() => _themeMode = v);
            },
          ),
        ),
      ),
    );
  }

  // --- Font Size Selector ---
  Widget _buildFontSizeSelector(
    Color textColor,
    Color subtleColor,
    bool isDark,
  ) {
    final Map<String, String> options = {
      'small': 'Nhỏ',
      'medium': 'Vừa',
      'large': 'Lớn',
    };

    return ListTile(
      leading: Icon(
        Icons.text_fields_rounded,
        color: textColor.withValues(alpha: 0.7),
        size: 22,
      ),
      title: Text(
        'Cỡ chữ bình giải',
        style: TextStyle(
          color: textColor,
          fontSize: 14.5,
          fontWeight: FontWeight.w600,
        ),
      ),
      trailing: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: AppColors.primary.withValues(alpha: isDark ? 0.15 : 0.08),
          borderRadius: BorderRadius.circular(10),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: _fontSize,
            isDense: true,
            dropdownColor: isDark
                ? AppColors.darkScaffold
                : AppColors.lightSurface,
            style: TextStyle(
              color: AppColors.primary,
              fontSize: 13,
              fontWeight: FontWeight.w700,
            ),
            items: options.entries
                .map(
                  (e) => DropdownMenuItem(value: e.key, child: Text(e.value)),
                )
                .toList(),
            onChanged: (v) async {
              if (v == null) return;
              await SettingsService.setFontSize(v);
              setState(() => _fontSize = v);
            },
          ),
        ),
      ),
    );
  }

  // --- Gender Selector ---
  Widget _buildGenderSelector(Color textColor, Color subtleColor, bool isDark) {
    return ListTile(
      leading: Icon(
        Icons.wc_rounded,
        color: textColor.withValues(alpha: 0.7),
        size: 22,
      ),
      title: Text(
        'Giới tính mặc định',
        style: TextStyle(
          color: textColor,
          fontSize: 14.5,
          fontWeight: FontWeight.w600,
        ),
      ),
      trailing: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: AppColors.primary.withValues(alpha: isDark ? 0.15 : 0.08),
          borderRadius: BorderRadius.circular(10),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: _defaultGender,
            isDense: true,
            dropdownColor: isDark
                ? AppColors.darkScaffold
                : AppColors.lightSurface,
            style: TextStyle(
              color: AppColors.primary,
              fontSize: 13,
              fontWeight: FontWeight.w700,
            ),
            items: const [
              DropdownMenuItem(value: 'male', child: Text('Nam')),
              DropdownMenuItem(value: 'female', child: Text('Nữ')),
            ],
            onChanged: (v) async {
              if (v == null) return;
              await SettingsService.setDefaultGender(v);
              setState(() => _defaultGender = v);
            },
          ),
        ),
      ),
    );
  }

  // --- Bình Giải Level ---
  Widget _buildBinhGiaiSelector(
    Color textColor,
    Color subtleColor,
    bool isDark,
  ) {
    return ListTile(
      leading: Icon(
        Icons.auto_stories_rounded,
        color: textColor.withValues(alpha: 0.7),
        size: 22,
      ),
      title: Text(
        'Mức độ bình giải',
        style: TextStyle(
          color: textColor,
          fontSize: 14.5,
          fontWeight: FontWeight.w600,
        ),
      ),
      trailing: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: AppColors.primary.withValues(alpha: isDark ? 0.15 : 0.08),
          borderRadius: BorderRadius.circular(10),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: _binhGiaiLevel,
            isDense: true,
            dropdownColor: isDark
                ? AppColors.darkScaffold
                : AppColors.lightSurface,
            style: TextStyle(
              color: AppColors.primary,
              fontSize: 13,
              fontWeight: FontWeight.w700,
            ),
            items: const [
              DropdownMenuItem(value: 'full', child: Text('Đầy đủ')),
              DropdownMenuItem(value: 'compact', child: Text('Ngắn gọn')),
            ],
            onChanged: (v) async {
              if (v == null) return;
              await SettingsService.setBinhGiaiLevel(v);
              setState(() => _binhGiaiLevel = v);
            },
          ),
        ),
      ),
    );
  }

  // --- Switch Tile ---
  Widget _buildSwitchTile({
    required IconData icon,
    required String title,
    required bool value,
    required Color textColor,
    required ValueChanged<bool> onChanged,
  }) {
    return SwitchListTile(
      secondary: Icon(icon, color: textColor.withValues(alpha: 0.7), size: 22),
      title: Text(
        title,
        style: TextStyle(
          color: textColor,
          fontSize: 14.5,
          fontWeight: FontWeight.w600,
        ),
      ),
      value: value,
      activeThumbColor: AppColors.primary,
      onChanged: onChanged,
    );
  }

  // --- Action Tile ---
  Widget _buildActionTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color textColor,
    required Color subtleColor,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: AppColors.danger.withValues(alpha: 0.8),
        size: 22,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: textColor,
          fontSize: 14.5,
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(color: subtleColor, fontSize: 12),
      ),
      trailing: Icon(Icons.chevron_right_rounded, color: subtleColor, size: 20),
      onTap: onTap,
    );
  }

  // --- Info Tile ---
  Widget _buildInfoTile({
    required IconData icon,
    required String title,
    required String trailing,
    required Color textColor,
    required Color subtleColor,
  }) {
    return ListTile(
      leading: Icon(icon, color: textColor.withValues(alpha: 0.7), size: 22),
      title: Text(
        title,
        style: TextStyle(
          color: textColor,
          fontSize: 14.5,
          fontWeight: FontWeight.w600,
        ),
      ),
      trailing: Text(
        trailing,
        style: TextStyle(
          color: subtleColor,
          fontSize: 13,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  // === DIALOGS ===

  void _confirmDeleteProfiles(BuildContext context, bool isDark) {
    final count = HiveService.getAllProfiles().length;
    if (count == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Không có hồ sơ nào để xóa'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: isDark
            ? AppColors.darkScaffold
            : AppColors.lightSurface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          'Xóa toàn bộ hồ sơ?',
          style: TextStyle(
            color: isDark ? AppColors.darkText : AppColors.lightText,
          ),
        ),
        content: Text(
          'Bạn sắp xóa $count hồ sơ đã lưu. Hành động này không thể hoàn tác.',
          style: TextStyle(
            color: isDark ? Colors.white70 : AppColors.lightSubtleText,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(
              'Hủy',
              style: TextStyle(
                color: isDark ? Colors.white54 : AppColors.lightSubtleText,
              ),
            ),
          ),
          TextButton(
            onPressed: () async {
              await Hive.box<UserProfile>(HiveService.profileBoxName).clear();
              if (ctx.mounted) Navigator.pop(ctx);
              if (context.mounted) {
                setState(() {});
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Đã xóa toàn bộ hồ sơ'),
                    backgroundColor: Colors.redAccent,
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              }
            },
            child: const Text(
              'Xóa',
              style: TextStyle(
                color: AppColors.danger,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _confirmResetSettings(BuildContext context, bool isDark) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: isDark
            ? AppColors.darkScaffold
            : AppColors.lightSurface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          'Đặt lại cài đặt?',
          style: TextStyle(
            color: isDark ? AppColors.darkText : AppColors.lightText,
          ),
        ),
        content: Text(
          'Tất cả cài đặt sẽ trở về mặc định. Hồ sơ đã lưu không bị ảnh hưởng.',
          style: TextStyle(
            color: isDark ? Colors.white70 : AppColors.lightSubtleText,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(
              'Hủy',
              style: TextStyle(
                color: isDark ? Colors.white54 : AppColors.lightSubtleText,
              ),
            ),
          ),
          TextButton(
            onPressed: () async {
              await SettingsService.setThemeMode('system');
              await SettingsService.setDefaultGender('male');
              await SettingsService.setShowDaiHan(true);
              await SettingsService.setShowPhuTinh(true);
              await SettingsService.setBinhGiaiLevel('full');
              await SettingsService.setLuuNienAutoYear(true);
              await SettingsService.setFontSize('medium');
              if (ctx.mounted) Navigator.pop(ctx);
              setState(() => _loadSettings());
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Đã khôi phục cài đặt mặc định'),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              }
            },
            child: const Text(
              'Đặt lại',
              style: TextStyle(
                color: AppColors.danger,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
