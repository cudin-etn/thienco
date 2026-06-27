import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

/// Service quản lý cài đặt ứng dụng, lưu trữ bằng Hive
class SettingsService {
  static const String _boxName = 'app_settings_box';

  // Keys
  static const String keyThemeMode = 'theme_mode'; // 'system', 'light', 'dark'
  static const String keyDefaultGender = 'default_gender'; // 'male', 'female'
  static const String keyShowDaiHan = 'show_dai_han'; // bool
  static const String keyShowPhuTinh = 'show_phu_tinh'; // bool
  static const String keyBinhGiaiLevel = 'binh_giai_level'; // 'full', 'compact'
  static const String keyLuuNienAutoYear = 'luu_nien_auto_year'; // bool
  static const String keyFontSize = 'font_size'; // 'small', 'medium', 'large'

  static Future<void> init() async {
    await Hive.openBox(_boxName);
  }

  static Box _box() => Hive.box(_boxName);

  // --- Theme ---
  static String getThemeMode() =>
      _box().get(keyThemeMode, defaultValue: 'system');
  static Future<void> setThemeMode(String mode) =>
      _box().put(keyThemeMode, mode);

  // --- Default Gender ---
  static String getDefaultGender() =>
      _box().get(keyDefaultGender, defaultValue: 'male');
  static Future<void> setDefaultGender(String gender) =>
      _box().put(keyDefaultGender, gender);

  // --- Show Đại Hạn on chart ---
  static bool getShowDaiHan() => _box().get(keyShowDaiHan, defaultValue: true);
  static Future<void> setShowDaiHan(bool value) =>
      _box().put(keyShowDaiHan, value);

  // --- Show Phụ Tinh on chart ---
  static bool getShowPhuTinh() =>
      _box().get(keyShowPhuTinh, defaultValue: true);
  static Future<void> setShowPhuTinh(bool value) =>
      _box().put(keyShowPhuTinh, value);

  // --- Bình Giải Level ---
  static String getBinhGiaiLevel() =>
      _box().get(keyBinhGiaiLevel, defaultValue: 'full');
  static Future<void> setBinhGiaiLevel(String level) =>
      _box().put(keyBinhGiaiLevel, level);

  // --- Lưu Niên auto year ---
  static bool getLuuNienAutoYear() =>
      _box().get(keyLuuNienAutoYear, defaultValue: true);
  static Future<void> setLuuNienAutoYear(bool value) =>
      _box().put(keyLuuNienAutoYear, value);

  // --- Font Size ---
  static String getFontSize() =>
      _box().get(keyFontSize, defaultValue: 'medium');
  static Future<void> setFontSize(String size) => _box().put(keyFontSize, size);

  // --- Xóa toàn bộ dữ liệu ---
  static Future<void> clearAllData() async {
    await _box().clear();
    await Hive.box<dynamic>('user_profiles_box').clear();
  }

  /// Listenable cho reactive UI (khi settings thay đổi, rebuild UI)
  static ValueListenable<Box> get listenable => _box().listenable();
}
