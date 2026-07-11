import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/database/settings_service.dart';
import '../../../core/database/hive_service.dart';
import '../../../core/models/user_profile.dart';

/// Full-screen Settings page cho mobile (thay vì drawer bị hẹp)
class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
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

    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: textColor,
            size: 20,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Cài Đặt',
          style: TextStyle(
            color: textColor,
            fontSize: 20,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(gradient: AppColors.appBackground(isDark)),
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 40),
            children: [
              // === GIAO DIỆN ===
              _buildSectionTitle('GIAO DIỆN'),
              _buildCard(cardColor, borderColor, [
                _buildDropdownTile(
                  icon: Icons.palette_outlined,
                  title: 'Giao diện',
                  value: _themeMode,
                  options: {
                    'system': 'Theo hệ thống',
                    'light': 'Sáng',
                    'dark': 'Tối',
                  },
                  textColor: textColor,
                  isDark: isDark,
                  onChanged: (v) async {
                    await SettingsService.setThemeMode(v);
                    setState(() => _themeMode = v);
                  },
                ),
                _buildDivider(borderColor),
                _buildDropdownTile(
                  icon: Icons.text_fields_rounded,
                  title: 'Cỡ chữ bình giải',
                  value: _fontSize,
                  options: {'small': 'Nhỏ', 'medium': 'Vừa', 'large': 'Lớn'},
                  textColor: textColor,
                  isDark: isDark,
                  onChanged: (v) async {
                    await SettingsService.setFontSize(v);
                    setState(() => _fontSize = v);
                  },
                ),
              ]),

              const SizedBox(height: 24),

              // === LÁ SỐ ===
              _buildSectionTitle('LÁ SỐ TỬ VI'),
              _buildCard(cardColor, borderColor, [
                _buildSwitchTile(
                  icon: Icons.timeline_rounded,
                  title: 'Hiện Đại Hạn trên lá số',
                  subtitle: 'Hiển thị mốc tuổi đại hạn ở góc mỗi cung',
                  value: _showDaiHan,
                  textColor: textColor,
                  subtleColor: subtleColor,
                  onChanged: (v) async {
                    await SettingsService.setShowDaiHan(v);
                    setState(() => _showDaiHan = v);
                  },
                ),
                _buildDivider(borderColor),
                _buildSwitchTile(
                  icon: Icons.blur_on_rounded,
                  title: 'Hiện Phụ Tinh trên lá số',
                  subtitle: 'Ẩn phụ tinh giúp lá số gọn hơn',
                  value: _showPhuTinh,
                  textColor: textColor,
                  subtleColor: subtleColor,
                  onChanged: (v) async {
                    await SettingsService.setShowPhuTinh(v);
                    setState(() => _showPhuTinh = v);
                  },
                ),
                _buildDivider(borderColor),
                _buildSwitchTile(
                  icon: Icons.calendar_today_rounded,
                  title: 'Tự động luận vận năm hiện tại',
                  subtitle: 'Thêm mục Lưu Niên vào bình giải',
                  value: _luuNienAutoYear,
                  textColor: textColor,
                  subtleColor: subtleColor,
                  onChanged: (v) async {
                    await SettingsService.setLuuNienAutoYear(v);
                    setState(() => _luuNienAutoYear = v);
                  },
                ),
                _buildDivider(borderColor),
                _buildDropdownTile(
                  icon: Icons.wc_rounded,
                  title: 'Giới tính mặc định',
                  value: _defaultGender,
                  options: {'male': 'Nam', 'female': 'Nữ'},
                  textColor: textColor,
                  isDark: isDark,
                  onChanged: (v) async {
                    await SettingsService.setDefaultGender(v);
                    setState(() => _defaultGender = v);
                  },
                ),
                _buildDivider(borderColor),
                _buildDropdownTile(
                  icon: Icons.auto_stories_rounded,
                  title: 'Mức độ bình giải',
                  value: _binhGiaiLevel,
                  options: {'full': 'Đầy đủ', 'compact': 'Ngắn gọn'},
                  textColor: textColor,
                  isDark: isDark,
                  onChanged: (v) async {
                    await SettingsService.setBinhGiaiLevel(v);
                    setState(() => _binhGiaiLevel = v);
                  },
                ),
              ]),

              const SizedBox(height: 24),

              // === DỮ LIỆU ===
              _buildSectionTitle('DỮ LIỆU'),
              _buildCard(cardColor, borderColor, [
                _buildActionTile(
                  icon: Icons.delete_sweep_rounded,
                  title: 'Xóa toàn bộ hồ sơ đã lưu',
                  subtitle: '${HiveService.getAllProfiles().length} hồ sơ',
                  textColor: textColor,
                  subtleColor: subtleColor,
                  isDestructive: true,
                  onTap: () => _confirmDeleteProfiles(context, isDark),
                ),
                _buildDivider(borderColor),
                _buildActionTile(
                  icon: Icons.restart_alt_rounded,
                  title: 'Đặt lại cài đặt mặc định',
                  subtitle: 'Khôi phục tất cả về ban đầu',
                  textColor: textColor,
                  subtleColor: subtleColor,
                  isDestructive: false,
                  onTap: () => _confirmResetSettings(context, isDark),
                ),
              ]),

              const SizedBox(height: 24),

              // === THÔNG TIN ===
              _buildSectionTitle('THÔNG TIN'),
              _buildCard(cardColor, borderColor, [
                _buildInfoTile(
                  Icons.info_outline_rounded,
                  'Phiên bản',
                  'v1.0.0',
                  textColor,
                  subtleColor,
                ),
                _buildDivider(borderColor),
                _buildInfoTile(
                  Icons.code_rounded,
                  'Phát triển bởi',
                  'TDEV Studio',
                  textColor,
                  subtleColor,
                ),
                _buildDivider(borderColor),
                _buildInfoTile(
                  Icons.auto_awesome_rounded,
                  'Engine',
                  'Thiên Cơ v2',
                  textColor,
                  subtleColor,
                ),
              ]),
            ],
          ),
        ),
      ),
    );
  }

  // === BUILDERS ===

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 10),
      child: Text(
        title,
        style: TextStyle(
          color: AppColors.primary,
          fontSize: 12,
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
        borderRadius: BorderRadius.circular(20),
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
      indent: 56,
      endIndent: 16,
    );
  }

  Widget _buildDropdownTile({
    required IconData icon,
    required String title,
    required String value,
    required Map<String, String> options,
    required Color textColor,
    required bool isDark,
    required ValueChanged<String> onChanged,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      leading: Icon(icon, color: textColor.withValues(alpha: 0.7), size: 22),
      title: Text(
        title,
        style: TextStyle(
          color: textColor,
          fontSize: 15,
          fontWeight: FontWeight.w600,
        ),
      ),
      trailing: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
        decoration: BoxDecoration(
          color: AppColors.primary.withValues(alpha: isDark ? 0.15 : 0.08),
          borderRadius: BorderRadius.circular(12),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: value,
            isDense: true,
            dropdownColor: isDark
                ? AppColors.darkScaffold
                : AppColors.lightSurface,
            style: TextStyle(
              color: AppColors.primary,
              fontSize: 13.5,
              fontWeight: FontWeight.w700,
            ),
            items: options.entries
                .map(
                  (e) => DropdownMenuItem(value: e.key, child: Text(e.value)),
                )
                .toList(),
            onChanged: (v) {
              if (v != null) onChanged(v);
            },
          ),
        ),
      ),
    );
  }

  Widget _buildSwitchTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required Color textColor,
    required Color subtleColor,
    required ValueChanged<bool> onChanged,
  }) {
    return SwitchListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
      secondary: Icon(icon, color: textColor.withValues(alpha: 0.7), size: 22),
      title: Text(
        title,
        style: TextStyle(
          color: textColor,
          fontSize: 15,
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(color: subtleColor, fontSize: 12.5),
      ),
      value: value,
      activeThumbColor: AppColors.primary,
      onChanged: onChanged,
    );
  }

  Widget _buildActionTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color textColor,
    required Color subtleColor,
    required bool isDestructive,
    required VoidCallback onTap,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      leading: Icon(
        icon,
        color: isDestructive
            ? AppColors.danger
            : textColor.withValues(alpha: 0.7),
        size: 22,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isDestructive ? AppColors.danger : textColor,
          fontSize: 15,
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(color: subtleColor, fontSize: 12.5),
      ),
      trailing: Icon(Icons.chevron_right_rounded, color: subtleColor, size: 20),
      onTap: onTap,
    );
  }

  Widget _buildInfoTile(
    IconData icon,
    String title,
    String trailing,
    Color textColor,
    Color subtleColor,
  ) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
      leading: Icon(icon, color: textColor.withValues(alpha: 0.7), size: 22),
      title: Text(
        title,
        style: TextStyle(
          color: textColor,
          fontSize: 15,
          fontWeight: FontWeight.w600,
        ),
      ),
      trailing: Text(
        trailing,
        style: TextStyle(
          color: subtleColor,
          fontSize: 13.5,
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
