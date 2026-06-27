import 'package:hive/hive.dart';

part 'user_profile.g.dart';

@HiveType(typeId: 0)
class UserProfile {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String birthDate;

  @HiveField(3)
  final String birthTime;

  @HiveField(4)
  final bool isMale;

  UserProfile({
    required this.id,
    required this.name,
    required this.birthDate,
    required this.birthTime,
    this.isMale = true,
  });

  UserProfile copyWith({
    String? id,
    String? name,
    String? birthDate,
    String? birthTime,
    bool? isMale,
  }) {
    return UserProfile(
      id: id ?? this.id,
      name: name ?? this.name,
      birthDate: birthDate ?? this.birthDate,
      birthTime: birthTime ?? this.birthTime,
      isMale: isMale ?? this.isMale,
    );
  }

  String get normalizedName =>
      name.trim().toLowerCase().replaceAll(RegExp(r'\s+'), ' ');

  String get profileKey =>
      '$normalizedName|${birthDate.trim()}|${birthTime.trim()}|${isMale ? 'male' : 'female'}';
}
