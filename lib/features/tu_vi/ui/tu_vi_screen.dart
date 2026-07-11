import 'dart:math';

import 'package:flutter/material.dart';
import '../../../shared/widgets/glass_card.dart';
import '../../../shared/widgets/gradient_button.dart';
import '../../../shared/widgets/glass_text_field.dart';
import 'la_so_screen.dart';
import '../../../core/models/user_profile.dart';
import '../../../core/database/hive_service.dart';
import '../../../core/constants/app_colors.dart';
import '../../../shared/widgets/app_background.dart';

class TuViScreen extends StatefulWidget {
  const TuViScreen({super.key});

  @override
  State<TuViScreen> createState() => _TuViScreenState();
}

class _TuViScreenState extends State<TuViScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  bool _isMale = true;
  bool _isLoading = false;
  UserProfile? _selectedProfile;

  @override
  void dispose() {
    _nameController.dispose();
    _dateController.dispose();
    _timeController.dispose();
    super.dispose();
  }

  String _generateProfileId() {
    final now = DateTime.now().microsecondsSinceEpoch;
    final random = Random().nextInt(1 << 20);
    return 'profile_${now}_$random';
  }

  void _clearSelectedProfileIfIdentityChanged() {
    if (_selectedProfile == null) return;

    final sameIdentity =
        _selectedProfile!.name.trim() == _nameController.text.trim() &&
        _selectedProfile!.birthDate.trim() == _dateController.text.trim() &&
        _selectedProfile!.birthTime.trim() == _timeController.text.trim() &&
        _selectedProfile!.isMale == _isMale;

    if (!sameIdentity) {
      _selectedProfile = null;
    }
  }

  // Hàm gọi Lịch chọn Ngày (Đã bỏ theme cứng, tự ăn theo hệ thống)
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(1990, 1, 1),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      helpText: 'Chọn ngày sinh',
      cancelText: 'Hủy',
      confirmText: 'Xác nhận',
      fieldHintText: 'dd/mm/yyyy',
      fieldLabelText: 'Ngày sinh',
    );

    if (picked != null) {
      setState(() {
        _dateController.text =
            "${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}";
      });
    }
  }

  // Danh sách 12 Chi giờ với khoảng giờ tương ứng
  static const List<Map<String, String>> _danhSachGio = [
    {'chi': 'Tý', 'range': '23:00 - 01:00'},
    {'chi': 'Sửu', 'range': '01:00 - 03:00'},
    {'chi': 'Dần', 'range': '03:00 - 05:00'},
    {'chi': 'Mão', 'range': '05:00 - 07:00'},
    {'chi': 'Thìn', 'range': '07:00 - 09:00'},
    {'chi': 'Tỵ', 'range': '09:00 - 11:00'},
    {'chi': 'Ngọ', 'range': '11:00 - 13:00'},
    {'chi': 'Mùi', 'range': '13:00 - 15:00'},
    {'chi': 'Thân', 'range': '15:00 - 17:00'},
    {'chi': 'Dậu', 'range': '17:00 - 19:00'},
    {'chi': 'Tuất', 'range': '19:00 - 21:00'},
    {'chi': 'Hợi', 'range': '21:00 - 23:00'},
  ];

  // Hàm chọn giờ sinh theo 12 Chi
  void _selectTime(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      enableDrag: false,
      backgroundColor: isDark ? const Color(0xFF0F172A) : Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 44,
              height: 4,
              decoration: BoxDecoration(
                color: isDark ? Colors.white24 : Colors.black12,
                borderRadius: BorderRadius.circular(999),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Chọn giờ sinh (12 Chi)',
              style: TextStyle(
                color: isDark ? Colors.white : Colors.black87,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'Nếu không biết chính xác, chọn khoảng giờ gần nhất',
              style: TextStyle(
                color: isDark ? Colors.white54 : Colors.black54,
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 16),
            Flexible(
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 2.2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: _danhSachGio.length,
                itemBuilder: (context, index) {
                  final item = _danhSachGio[index];
                  final bool isSelected =
                      _timeController.text == 'Giờ ${item['chi']}';

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _timeController.text = 'Giờ ${item['chi']}';
                      });
                      Navigator.pop(context);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        color: isSelected
                            ? AppColors.primary.withValues(
                                alpha: isDark ? 0.25 : 0.12,
                              )
                            : (isDark
                                  ? Colors.white.withValues(alpha: 0.05)
                                  : Colors.grey.withValues(alpha: 0.08)),
                        border: Border.all(
                          color: isSelected
                              ? AppColors.primary.withValues(alpha: 0.5)
                              : (isDark
                                    ? Colors.white.withValues(alpha: 0.08)
                                    : Colors.black12),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Giờ ${item['chi']}',
                            style: TextStyle(
                              color: isSelected
                                  ? AppColors.primary
                                  : (isDark ? Colors.white : Colors.black87),
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            item['range']!,
                            style: TextStyle(
                              color: isDark ? Colors.white54 : Colors.black45,
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showProfilePicker() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final profiles = HiveService.getAllProfiles();

    if (profiles.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Danh sách hồ sơ trống!'),
          backgroundColor: Colors.orangeAccent,
        ),
      );
      return;
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      enableDrag: false,
      backgroundColor: isDark ? const Color(0xFF0F172A) : Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Chọn hồ sơ đã lưu',
              style: TextStyle(
                color: isDark ? Colors.white : Colors.black87,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Flexible(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: profiles.length,
                itemBuilder: (context, index) {
                  final p = profiles[index];
                  return ListTile(
                    leading: Icon(
                      Icons.person,
                      color: isDark ? Colors.cyanAccent : Colors.blueAccent,
                    ),
                    title: Text(
                      p.name,
                      style: TextStyle(
                        color: isDark ? Colors.white : Colors.black87,
                      ),
                    ),
                    subtitle: Text(
                      '${p.birthDate} • ${p.isMale ? 'Nam' : 'Nữ'}',
                      style: TextStyle(
                        color: isDark ? Colors.white54 : Colors.black54,
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        _selectedProfile = p;
                        _nameController.text = p.name;
                        _dateController.text = p.birthDate;
                        _timeController.text = p.birthTime;
                        _isMale = p.isMale;
                      });
                      Navigator.pop(context);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool _validateInput(String name, String date, String time) {
    if (name.isEmpty || date.isEmpty || time.isEmpty) {
      _showSnackBar('Vui lòng nhập đầy đủ họ tên, ngày và giờ sinh!');
      return false;
    }
    final parts = date.split('/');
    if (parts.length != 3) {
      _showSnackBar('Ngày sinh phải đúng định dạng DD/MM/YYYY!');
      return false;
    }
    final day = int.tryParse(parts[0]);
    final month = int.tryParse(parts[1]);
    final year = int.tryParse(parts[2]);
    if (year == null || year < 1900 || year > DateTime.now().year) {
      _showSnackBar('Năm sinh phải từ 1900 đến ${DateTime.now().year}!');
      return false;
    }
    if (month == null || month < 1 || month > 12) {
      _showSnackBar('Tháng sinh không hợp lệ!');
      return false;
    }
    if (day == null || day < 1 || day > 31) {
      _showSnackBar('Ngày sinh không hợp lệ!');
      return false;
    }
    if (!_danhSachGio.any((g) => 'Giờ ${g['chi']}' == time)) {
      _showSnackBar('Giờ sinh không hợp lệ! Hãy chọn giờ theo 12 Chi.');
      return false;
    }
    return true;
  }

  void _showSnackBar(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: Colors.redAccent,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _onSubmit() async {
    final name = _nameController.text.trim();
    final date = _dateController.text.trim();
    final time = _timeController.text.trim();

    if (!_validateInput(name, date, time)) return;

    setState(() => _isLoading = true);

    _clearSelectedProfileIfIdentityChanged();

    final profileToSave = UserProfile(
      id: _selectedProfile?.id ?? _generateProfileId(),
      name: name,
      birthDate: date,
      birthTime: time,
      isMale: _isMale,
    );

    if (_selectedProfile != null) {
      await HiveService.updateProfile(profileToSave);
    } else {
      await HiveService.addProfile(profileToSave);
    }

    _selectedProfile =
        HiveService.getProfileById(profileToSave.id) ?? profileToSave;

    if (!mounted) return;

    setState(() => _isLoading = false);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LaSoScreen(profile: _selectedProfile!),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: AppBackground(
   isDark: isDark,
   child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 18, 20, 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    gradient: AppColors.heroGradient(isDark),
                    borderRadius: BorderRadius.circular(28),
                    border: Border.all(color: AppColors.glassBorder(isDark)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(
                              gradient: AppColors.primaryGradient(),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Icon(
                              Icons.blur_on_rounded,
                              color: Colors.white,
                              size: 22,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Lập Lá Số Tử Vi',
                                  style: TextStyle(
                                    fontSize: 22,
                                    height: 1.0,
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: -0.6,
                                    color: isDark
                                        ? AppColors.darkText
                                        : AppColors.lightText,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Nhập thông tin để an sao, lập số, khai giải.',
                                  style: TextStyle(
                                    fontSize: 13.5,
                                    height: 1.4,
                                    color: isDark
                                        ? Colors.white70
                                        : AppColors.lightSubtleText,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 7,
                        runSpacing: 7,
                        children: [
                          _buildInfoChip(
                            isDark: isDark,
                            icon: Icons.stars_rounded,
                            label: 'Tử vi truyền thống',
                          ),
                          _buildInfoChip(
                            isDark: isDark,
                            icon: Icons.psychology_alt_outlined,
                            label: 'Khai giải đa tầng',
                          ),
                          _buildInfoChip(
                            isDark: isDark,
                            icon: Icons.account_tree_outlined,
                            label: 'Lá số cá nhân hóa',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 22),
                GlassCard(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: isDark
                                  ? Colors.white.withValues(alpha: 0.06)
                                  : const Color(0xFFF4F6FB),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: Icon(
                              Icons.edit_note_rounded,
                              color: isDark
                                  ? Colors.white70
                                  : const Color(0xFF4B5563),
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Thông tin lá số',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w800,
                                    color: isDark
                                        ? Colors.white
                                        : const Color(0xFF111827),
                                  ),
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  'Điền chính xác ngày giờ sinh để cho ra kết quả chuẩn hơn.',
                                  style: TextStyle(
                                    fontSize: 13.5,
                                    color: isDark
                                        ? Colors.white60
                                        : const Color(0xFF6B7280),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          _buildProfileQuickButton(isDark),
                        ],
                      ),
                      const SizedBox(height: 18),
                      GlassTextField(
                        controller: _nameController,
                        hintText: 'Họ và tên',
                        icon: Icons.badge_outlined,
                      ),
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.only(bottom: 15),
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: AppColors.glassFillSoft(isDark),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: AppColors.glassBorder(isDark),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Giới tính lá số',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: isDark
                                    ? Colors.white70
                                    : AppColors.lightText,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Expanded(
                                  child: _buildGenderOption(
                                    label: 'Nam',
                                    icon: Icons.male_rounded,
                                    selected: _isMale,
                                    isDark: isDark,
                                    onTap: () => setState(() => _isMale = true),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: _buildGenderOption(
                                    label: 'Nữ',
                                    icon: Icons.female_rounded,
                                    selected: !_isMale,
                                    isDark: isDark,
                                    onTap: () =>
                                        setState(() => _isMale = false),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      GlassTextField(
                        controller: _dateController,
                        hintText: 'Ngày tháng năm sinh (DL)',
                        icon: Icons.calendar_month_rounded,
                        readOnly: true,
                        onTap: () => _selectDate(context),
                      ),
                      GlassTextField(
                        controller: _timeController,
                        hintText: 'Giờ sinh',
                        icon: Icons.schedule_rounded,
                        readOnly: true,
                        onTap: () => _selectTime(context),
                      ),
                      const SizedBox(height: 4),
                      SizedBox(
                        width: double.infinity,
                        child: Theme(
                          data: Theme.of(context).copyWith(
                            elevatedButtonTheme: ElevatedButtonThemeData(
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size.fromHeight(54),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 18,
                                  vertical: 14,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18),
                                ),
                              ),
                            ),
                          ),
                          child: GradientButton(
                            text: _isLoading ? 'Đang xử lý...' : 'An Sao Lập Số',
                            icon: _isLoading ? Icons.hourglass_top_rounded : Icons.blur_on_rounded,
                            isLoading: _isLoading,
                            onPressed: _isLoading ? null : _onSubmit,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileQuickButton(bool isDark) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: _showProfilePicker,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          width: 46,
          height: 46,
          decoration: BoxDecoration(
            color: isDark
                ? AppColors.glassFill(isDark)
                : AppColors.lightSurfaceSoft,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.glassBorder(isDark)),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Icon(
                Icons.contacts_rounded,
                color: AppColors.topbarIcon(isDark),
                size: 22,
              ),
              if (_selectedProfile != null)
                Positioned(
                  top: 10,
                  right: 10,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoChip({
    required bool isDark,
    required IconData icon,
    required String label,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      decoration: BoxDecoration(
        color: AppColors.chipFill(isDark),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: AppColors.chipBorder(isDark)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: AppColors.primary),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 12.2,
              fontWeight: FontWeight.w700,
              color: isDark ? Colors.white70 : AppColors.lightText,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGenderOption({
    required String label,
    required IconData icon,
    required bool selected,
    required bool isDark,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          onTap();
          _clearSelectedProfileIfIdentityChanged();
        },
        borderRadius: BorderRadius.circular(16),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: selected
                ? (isDark
                      ? const LinearGradient(
                          colors: [Color(0xFF2563EB), AppColors.secondary],
                        )
                      : const LinearGradient(
                          colors: [Color(0xFFDBEAFE), AppColors.secondaryLight],
                        ))
                : null,
            color: selected
                ? null
                : (isDark
                      ? Colors.white.withValues(alpha: 0.03)
                      : AppColors.lightSurfaceSoft),
            border: Border.all(
              color: selected
                  ? (isDark
                        ? Colors.white.withValues(alpha: 0.18)
                        : AppColors.secondaryLight)
                  : AppColors.glassBorder(isDark),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 18,
                color: selected
                    ? (isDark ? Colors.white : const Color(0xFF4C1D95))
                    : (isDark ? Colors.white70 : const Color(0xFF4B5563)),
              ),
              const SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: selected
                      ? (isDark ? Colors.white : const Color(0xFF4C1D95))
                      : (isDark ? Colors.white70 : const Color(0xFF374151)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
