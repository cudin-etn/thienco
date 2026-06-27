import 'package:hive_flutter/hive_flutter.dart';

import '../models/user_profile.dart';
import 'settings_service.dart';

class HiveService {
  static const String profileBoxName = 'user_profiles_box';

  static Future<void> init() async {
    await Hive.initFlutter();

    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(UserProfileAdapter());
    }

    await Hive.openBox<UserProfile>(profileBoxName);
    await SettingsService.init();
  }

  static Box<UserProfile> _box() => Hive.box<UserProfile>(profileBoxName);

  static int? _findIndexById(Box<UserProfile> box, String id) {
    if (id.trim().isEmpty) return null;
    for (int i = 0; i < box.length; i++) {
      final profile = box.getAt(i);
      if (profile != null && profile.id == id) {
        return i;
      }
    }
    return null;
  }

  static int? _findIndexByProfileKey(Box<UserProfile> box, String profileKey) {
    if (profileKey.trim().isEmpty) return null;
    for (int i = 0; i < box.length; i++) {
      final profile = box.getAt(i);
      if (profile != null && profile.profileKey == profileKey) {
        return i;
      }
    }
    return null;
  }

  static Future<void> addProfile(UserProfile profile) async {
    final box = _box();

    final sameIdIndex = _findIndexById(box, profile.id);
    if (sameIdIndex != null) {
      await box.putAt(sameIdIndex, profile);
      return;
    }

    final sameProfileIndex = _findIndexByProfileKey(box, profile.profileKey);
    if (sameProfileIndex != null) {
      final existing = box.getAt(sameProfileIndex);
      if (existing != null) {
        final merged = profile.copyWith(id: existing.id);
        await box.putAt(sameProfileIndex, merged);
        return;
      }
    }

    await box.add(profile);
  }

  static Future<void> updateProfile(UserProfile profile) async {
    final box = _box();

    final sameIdIndex = _findIndexById(box, profile.id);
    if (sameIdIndex != null) {
      await box.putAt(sameIdIndex, profile);
      return;
    }

    final sameProfileIndex = _findIndexByProfileKey(box, profile.profileKey);
    if (sameProfileIndex != null) {
      final existing = box.getAt(sameProfileIndex);
      if (existing != null) {
        final merged = profile.copyWith(id: existing.id);
        await box.putAt(sameProfileIndex, merged);
        return;
      }
    }

    await box.add(profile);
  }

  static List<UserProfile> getAllProfiles() {
    final box = _box();
    return box.values.toList();
  }

  static UserProfile? getProfileById(String id) {
    final box = _box();
    final index = _findIndexById(box, id);
    if (index == null) return null;
    return box.getAt(index);
  }

  static Future<void> deleteProfile(int index) async {
    final box = _box();
    await box.deleteAt(index);
  }
}
