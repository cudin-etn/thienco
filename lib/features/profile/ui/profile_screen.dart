import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../../core/models/user_profile.dart';
import '../../../core/database/hive_service.dart';
import '../../tu_vi/ui/la_so_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Text(
          'Danh Sách Lá Số',
          style: TextStyle(
            color: isDark ? Colors.white : Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: isDark ? Colors.white : Colors.black87),
      ),
      body: ValueListenableBuilder(
        valueListenable: Hive.box<UserProfile>(
          HiveService.profileBoxName,
        ).listenable(),
        builder: (context, Box<UserProfile> box, _) {
            if (box.values.isEmpty) {
              return _buildEmptyState(context, isDark);
            }

            return ListView.builder(
              padding: const EdgeInsets.all(16),
              physics: const BouncingScrollPhysics(),
              itemCount: box.values.length,
              itemBuilder: (context, index) {
                final profile = box.getAt(index);
                if (profile == null) return const SizedBox.shrink();

                return _buildProfileCard(context, profile, index, isDark);
              },
            );
          },
        ),
    );
  }

  Widget _buildEmptyState(BuildContext context, bool isDark) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.folder_open_rounded,
            size: 80,
            color: isDark
                ? Colors.white.withValues(alpha: 0.2)
                : Colors.black12,
          ),
          const SizedBox(height: 16),
          Text(
            'Chưa có lá số nào được lưu',
            style: TextStyle(
              color: isDark ? Colors.grey : Colors.black54,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Lập lá số đầu tiên để bắt đầu\nkhám phá vận mệnh của bạn',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isDark ? Colors.white38 : Colors.black38,
              fontSize: 14,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () {
              // Navigate to TuVi tab (index 2 in MainLayout)
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
            icon: const Icon(Icons.auto_awesome_rounded, size: 18),
            label: const Text('Lập Lá Số Ngay'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF6366F1),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileCard(
    BuildContext context,
    UserProfile profile,
    int index,
    bool isDark,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Dismissible(
        key: Key(profile.name + index.toString()),
        direction: DismissDirection.endToStart,
        background: Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(right: 20),
          decoration: BoxDecoration(
            color: Colors.redAccent,
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Icon(
            Icons.delete_sweep_rounded,
            color: Colors.white,
            size: 30,
          ),
        ),
        onDismissed: (direction) {
          HiveService.deleteProfile(index);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Đã xóa lá số của ${profile.name}'),
              backgroundColor: Colors.redAccent,
              behavior: SnackBarBehavior.floating,
            ),
          );
        },
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LaSoScreen(profile: profile),
              ),
            );
          },
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isDark
                  ? Colors.white.withValues(alpha: 0.05)
                  : Colors.white.withValues(alpha: 0.7),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: isDark
                    ? Colors.white.withValues(alpha: 0.1)
                    : Colors.black12,
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: profile.isMale
                        ? Colors.blueAccent.withValues(alpha: 0.2)
                        : Colors.pinkAccent.withValues(alpha: 0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    profile.isMale ? Icons.male_rounded : Icons.female_rounded,
                    color: profile.isMale
                        ? Colors.blueAccent
                        : Colors.pinkAccent,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        profile.name,
                        style: TextStyle(
                          color: isDark ? Colors.white : Colors.black87,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Icon(
                            Icons.calendar_month_rounded,
                            color: isDark ? Colors.grey : Colors.black54,
                            size: 14,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            profile.birthDate,
                            style: TextStyle(
                              color: isDark ? Colors.grey : Colors.black54,
                              fontSize: 13,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Icon(
                            Icons.access_time_rounded,
                            color: isDark ? Colors.grey : Colors.black54,
                            size: 14,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            profile.birthTime,
                            style: TextStyle(
                              color: isDark ? Colors.grey : Colors.black54,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.chevron_right_rounded,
                  color: isDark ? Colors.grey : Colors.black54,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
