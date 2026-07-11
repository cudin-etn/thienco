import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import '../../../core/constants/app_colors.dart';
import '../../../shared/utils/pdf_helper.dart';
import '../../../shared/utils/share_helper.dart';
import '../../../shared/widgets/tuong_so_share_card.dart';
import '../../../shared/widgets/glass_card.dart';

class FaceResultScreen extends StatefulWidget {
  final Map<String, dynamic> results;

  const FaceResultScreen({super.key, required this.results});

  @override
  State<FaceResultScreen> createState() => _FaceResultScreenState();
}

class _FaceResultScreenState extends State<FaceResultScreen> {
  final GlobalKey _shareKey = GlobalKey();

  void _shareResult() {
    final tongQuan =
        widget.results['tongQuan'] as Map<String, dynamic>? ?? {};
    final int diemTrungBinh = tongQuan['diemTrungBinh'] ?? 50;
    final String luanGiaiTong = tongQuan['luanGiai'] ?? '';
    final Map<String, int> diemBoVi = Map<String, int>.from(
      tongQuan['diemBoVi'] ?? {},
    );
    final String nguHanh =
        (widget.results['nguHanh'] as Map<String, dynamic>?)?['loai'] ?? '--';

    if (kIsWeb) {
      final topBoVi = diemBoVi.entries
          .map((e) => BoViScore(e.key, e.value.toDouble()))
          .toList()
        ..sort((a, b) => b.diem.compareTo(a.diem));

      final overlay = OverlayEntry(
        builder: (_) => RepaintBoundary(
          key: _shareKey,
          child: IgnorePointer(
            child: Material(
              color: Colors.transparent,
              child: TuongSoShareCard(
                diemTongQuan: diemTrungBinh.toDouble(),
                topBoVi: topBoVi,
                nguHanh: nguHanh,
                tomTat: luanGiaiTong,
              ),
            ),
          ),
        ),
      );
      Overlay.of(context).insert(overlay);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ShareHelper.captureAndShare(
          repaintKey: _shareKey,
          subject: 'Kết quả Tướng Số',
          text: 'Xem tướng số được phân tích bởi Thiên Cơ',
        );
        Future.delayed(const Duration(milliseconds: 500), overlay.remove);
      });
      return;
    }

    final Map<String, Map<String, dynamic>> phanTichChiTiet = {};
    for (final key in ['tran', 'mat', 'mui', 'mieng', 'cam', 'tamDinh', 'longMay', 'tai', 'nguHanh']) {
      final data = widget.results[key];
      if (data is Map<String, dynamic>) {
        phanTichChiTiet[key] = data;
      }
    }

    final Map<String, dynamic> moRong = {};
    for (final key in ['suNghiep', 'tinhDuyen', 'conCai', 'sucKhoe', 'tinhCach', 'phatTrien']) {
      final data = widget.results[key];
      if (data is String) {
        moRong[key] = data;
      }
    }

    PdfHelper.shareTuongSoPdf(
      diemTongQuan: diemTrungBinh.toDouble(),
      diemBoVi: diemBoVi,
      phanTichChiTiet: phanTichChiTiet,
      nguHanh: nguHanh,
      moRong: moRong,
      luanGiaiTong: luanGiaiTong,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final tongQuan = widget.results['tongQuan'] as Map<String, dynamic>? ?? {};
    final int diemTrungBinh = tongQuan['diemTrungBinh'] ?? 50;
    final String luanGiaiTong = tongQuan['luanGiai'] ?? '';
    final Map<String, int> diemBoVi = Map<String, int>.from(
      tongQuan['diemBoVi'] ?? {},
    );

    final Color scoreColor = diemTrungBinh >= 75
        ? AppColors.success
        : diemTrungBinh >= 55
        ? AppColors.warning
        : AppColors.danger;

    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: isDark ? Colors.white : AppColors.lightText,
        title: Text(
          'Kết Quả Tướng Học',
          style: TextStyle(
            fontWeight: FontWeight.w800,
            color: isDark ? AppColors.darkText : AppColors.lightText,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.share_rounded,
              color: isDark ? Colors.white60 : AppColors.lightSubtleText,
            ),
            tooltip: 'Chia sẻ kết quả',
            onPressed: _shareResult,
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(gradient: AppColors.appBackground(isDark)),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
            child: Column(
              children: [
                // Score card
                GlassCard(
                  width: double.infinity,
                  child: Column(
                    children: [
                      // Điểm tổng
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: [
                              scoreColor.withValues(alpha: 0.2),
                              scoreColor.withValues(alpha: 0.05),
                            ],
                          ),
                          border: Border.all(
                            color: scoreColor.withValues(alpha: 0.5),
                            width: 3,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            '$diemTrungBinh',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w800,
                              color: scoreColor,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        _getMucDo(diemTrungBinh),
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: isDark
                              ? AppColors.darkText
                              : AppColors.lightText,
                        ),
                      ),
                      const SizedBox(height: 12),
                      // Mini bar chart
                      _buildMiniChart(diemBoVi, isDark),
                      const SizedBox(height: 16),
                      Text(
                        luanGiaiTong,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          height: 1.6,
                          color: isDark ? Colors.white70 : AppColors.lightText,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // Chi tiết từng bộ vị
                _buildBoViCard(
                  isDark,
                  Icons.face_rounded,
                  'Trán — Quan Lộc',
                  widget.results['tran'],
                ),
                _buildBoViCard(
                  isDark,
                  Icons.remove_red_eye_rounded,
                  'Mắt — Trí Tuệ',
                  widget.results['mat'],
                ),
                _buildBoViCard(
                  isDark,
                  Icons.air_rounded,
                  'Mũi — Tài Bạch',
                  widget.results['mui'],
                ),
                _buildBoViCard(
                  isDark,
                  Icons.mood_rounded,
                  'Miệng — Phúc Đức',
                  widget.results['mieng'],
                ),
                _buildBoViCard(
                  isDark,
                  Icons.square_rounded,
                  'Cằm — Hậu Vận',
                  widget.results['cam'],
                ),
                _buildBoViCard(
                  isDark,
                  Icons.straighten_rounded,
                  'Tam Đình — Cân Bằng',
                  widget.results['tamDinh'],
                ),
                _buildBoViCard(
                  isDark,
                  Icons.face_4_rounded,
                  'Lông Mày — Bảo Thọ',
                  widget.results['longMay'],
                ),
                _buildBoViCard(
                  isDark,
                  Icons.hearing_rounded,
                  'Tai — Phúc Khí',
                  widget.results['tai'],
                ),
                _buildBoViCard(
                  isDark,
                  Icons.category_rounded,
                  'Ngũ Hành Diện Tướng',
                  widget.results['nguHanh'],
                ),

                const SizedBox(height: 20),

                // Luận mở rộng
                if (widget.results['suNghiep'] != null)
                  _buildExtendedSection(
                    isDark,
                    Icons.work_outline_rounded,
                    'Sự Nghiệp & Công Danh',
                    widget.results['suNghiep'],
                  ),
                if (widget.results['tinhDuyen'] != null)
                  _buildExtendedSection(
                    isDark,
                    Icons.favorite_outline_rounded,
                    'Tình Duyên & Hôn Nhân',
                    widget.results['tinhDuyen'],
                  ),
                if (widget.results['conCai'] != null)
                  _buildExtendedSection(
                    isDark,
                    Icons.child_care_outlined,
                    'Con Cái & Hậu Duệ',
                    widget.results['conCai'],
                  ),
                if (widget.results['sucKhoe'] != null)
                  _buildExtendedSection(
                    isDark,
                    Icons.health_and_safety_outlined,
                    'Sức Khỏe & Thể Chất',
                    widget.results['sucKhoe'],
                  ),
                if (widget.results['tinhCach'] != null)
                  _buildExtendedSection(
                    isDark,
                    Icons.psychology_outlined,
                    'Tính Cách & Con Người',
                    widget.results['tinhCach'],
                  ),
                if (widget.results['phatTrien'] != null)
                  _buildExtendedSection(
                    isDark,
                    Icons.trending_up_rounded,
                    'Hướng Phát Triển Bản Thân',
                    widget.results['phatTrien'],
                  ),

                const SizedBox(height: 20),
                // Disclaimer
                Text(
                  'Kết quả dựa trên nhân tướng học truyền thống, mang tính tham khảo.\nTướng tại tâm sinh — tâm thiện thì tướng cũng dần sáng.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    color: isDark ? Colors.white38 : Colors.black38,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _getMucDo(int diem) {
    if (diem >= 80) return 'Tướng mạo xuất sắc';
    if (diem >= 70) return 'Tướng mạo khá đẹp';
    if (diem >= 60) return 'Tướng mạo khá';
    if (diem >= 50) return 'Tướng mạo trung bình';
    return 'Cần lưu ý';
  }

  Widget _buildMiniChart(Map<String, int> diemBoVi, bool isDark) {
    final labels = {
      'tran': 'Trán',
      'mat': 'Mắt',
      'mui': 'Mũi',
      'mieng': 'Miệng',
      'cam': 'Cằm',
      'tamDinh': 'Tam Đình',
      'longMay': 'L.Mày',
      'tai': 'Tai',
    };

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: labels.entries.map((entry) {
        final int diem = diemBoVi[entry.key] ?? 50;
        final double ratio = diem / 100;
        final Color barColor = diem >= 75
            ? AppColors.success
            : diem >= 55
            ? AppColors.warning
            : AppColors.danger;

        return Column(
          children: [
            SizedBox(
              width: 8,
              height: 50,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    width: 8,
                    height: 50,
                    decoration: BoxDecoration(
                      color: isDark
                          ? Colors.white12
                          : Colors.black.withValues(alpha: 0.06),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  Container(
                    width: 8,
                    height: 50 * ratio,
                    decoration: BoxDecoration(
                      color: barColor,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 4),
            Text(
              entry.value,
              style: TextStyle(
                fontSize: 9.5,
                fontWeight: FontWeight.w600,
                color: isDark ? Colors.white54 : AppColors.lightSubtleText,
              ),
            ),
          ],
        );
      }).toList(),
    );
  }

  Widget _buildExtendedSection(
    bool isDark,
    IconData icon,
    String title,
    String content,
  ) {
    if (content.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: GlassCard(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF38BDF8), Color(0xFF6366F1)],
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon, color: Colors.white, size: 18),
                ),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: isDark ? AppColors.darkText : AppColors.lightText,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              content,
              style: TextStyle(
                fontSize: 14,
                height: 1.65,
                color: isDark ? Colors.white70 : AppColors.lightText,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBoViCard(
    bool isDark,
    IconData icon,
    String title,
    dynamic data,
  ) {
    if (data == null || data is! Map) return const SizedBox.shrink();

    final String ten = (data['ten'] ?? '').toString();
    final String moTa = (data['moTa'] ?? '').toString();
    final String luanGiai = (data['luanGiai'] ?? '').toString();
    final int diem = int.tryParse((data['diemSo'] ?? '50').toString()) ?? 50;

    final Color scoreColor = diem >= 75
        ? AppColors.success
        : diem >= 55
        ? AppColors.warning
        : AppColors.danger;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: GlassCard(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon, color: AppColors.primary, size: 18),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: isDark
                              ? AppColors.darkText
                              : AppColors.lightText,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        ten,
                        style: TextStyle(
                          fontSize: 12.5,
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: scoreColor.withValues(alpha: isDark ? 0.2 : 0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    '$diem',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      color: scoreColor,
                    ),
                  ),
                ),
              ],
            ),
            if (moTa.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(
                moTa,
                style: TextStyle(
                  fontSize: 12.5,
                  color: isDark ? Colors.white54 : AppColors.lightSubtleText,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
            if (luanGiai.isNotEmpty) ...[
              const SizedBox(height: 10),
              Text(
                luanGiai,
                style: TextStyle(
                  fontSize: 14,
                  height: 1.6,
                  color: isDark ? Colors.white70 : AppColors.lightText,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
