import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/rendering.dart';

import '../../../core/models/user_profile.dart';
import '../../../core/constants/app_colors.dart';
import '../../../shared/widgets/app_background.dart';
import '../../../core/database/settings_service.dart';
import '../../../shared/utils/pdf_helper.dart';
import '../../../shared/utils/share_helper.dart';
import '../../../shared/widgets/tu_vi_share_card.dart';
import '../logic/tu_vi_engine.dart';
import '../logic/tu_vi_binh_giai.dart';
import 'widgets/cung_widget.dart';
import 'widgets/thien_ban_widget.dart';

class LaSoScreen extends StatefulWidget {
  final UserProfile profile;
  const LaSoScreen({super.key, required this.profile});

  @override
  State<LaSoScreen> createState() => _LaSoScreenState();
}

class _LaSoScreenState extends State<LaSoScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;
  bool _isReady = false;
  final GlobalKey _shareKey = GlobalKey();

  // Computed data
  late Map<String, dynamic> tbData;
  late Map<String, String> m12C;
  late Map<String, List<String>> mCT;
  late Map<String, List<String>> mPT;
  late Map<String, int> mDH;
  late Map<String, String> mTH;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeOutCubic,
    );

    // Compute on next frame to show loading briefly
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _computeData();
    });
  }

  void _computeData() {
    final profile = widget.profile;
    tbData = TuViEngine.lapThienBan(profile.birthDate, profile.birthTime);
    final String chiMenh = tbData['cungMenh'] ?? 'Tỵ';
    m12C = TuViEngine.an12Cung(chiMenh);
    mCT = TuViEngine.an14ChinhTinh(
      tbData['lunarDay'] ?? 1,
      tbData['cuc'] ?? 'Thủy Nhị Cục',
    );
    mPT = TuViEngine.anPhuTinh(
      tbData,
      profile.birthTime,
      isMale: profile.isMale,
    );

    // An Tứ Hóa
    final String canNam =
        tbData['canNam'] ?? (tbData['canChiNam'] ?? ' ').split(' ')[0];
    TuViEngine.applyTuHoa(mCT, mPT, canNam);

    mDH = TuViEngine.tinhDaiHan(
      tbData['cuc'] ?? 'Thủy Nhị Cục',
      canNam,
      chiMenh,
      isMale: profile.isMale,
    );

    final String chiNamSinh =
        tbData['chiNam'] ?? (tbData['canChiNam'] ?? ' ').split(' ')[1];
    mTH = TuViEngine.tinhTieuHan(chiNamSinh, isMale: profile.isMale);

    setState(() => _isReady = true);
    _fadeController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final profile = widget.profile;
    final String gioiTinh = profile.isMale ? 'Nam' : 'Nữ';

    if (!_isReady) {
      return Scaffold(
        backgroundColor: Colors.transparent,
        body: AppBackground(
          isDark: isDark,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    gradient: AppColors.primaryGradient(),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Icon(
                    Icons.blur_on_rounded,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Đang an sao lập số...',
                  style: TextStyle(
                    color: isDark ? Colors.white70 : AppColors.lightSubtleText,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: 120,
                  child: LinearProgressIndicator(
                    backgroundColor: isDark ? Colors.white12 : Colors.black12,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      AppColors.primary,
                    ),
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    final String ngayAm =
        '${tbData['lunarDay'] ?? '--'}/${tbData['lunarMonth'] ?? '--'}/${tbData['lunarYear'] ?? '----'}';

    return FadeTransition(
      opacity: _fadeAnimation,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          scrolledUnderElevation: 0,
          iconTheme: IconThemeData(
            color: isDark ? AppColors.darkText : AppColors.lightText,
          ),
          titleSpacing: 0,
          title: Row(
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient(),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.blur_on_rounded,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Lá Số Tử Vi',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: isDark
                            ? AppColors.darkText
                            : AppColors.lightText,
                        fontWeight: FontWeight.w800,
                        fontSize: 22,
                        letterSpacing: -0.3,
                      ),
                    ),
                    const SizedBox(height: 1),
                    Text(
                      '$gioiTinh • Âm lịch $ngayAm',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: isDark
                            ? Colors.white60
                            : AppColors.lightSubtleText,
                        fontSize: 12.5,
                        height: 1.2,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        body: AppBackground(
          isDark: isDark,
          child: SafeArea(
            top: false,
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                8,
                MediaQuery.of(context).padding.top + kToolbarHeight + 10,
                8,
                8,
              ),
              child: Column(
                children: [
                  _buildRow(
                    ['Tỵ', 'Ngọ', 'Mùi', 'Thân'],
                    m12C,
                    mCT,
                    mPT,
                    mDH,
                    tbData,
                  ),
                  Expanded(
                    flex: 2,
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              _buildCung('Thìn', m12C, mCT, mPT, mDH, tbData),
                              _buildCung('Mão', m12C, mCT, mPT, mDH, tbData),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: ThienBanWidget(
                            profile: profile,
                            onKhaiGiai: () => _showBinhGiai(
                              context,
                              profile,
                              tbData,
                              m12C,
                              mCT,
                              mPT,
                              mDH,
                              mTH,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              _buildCung('Dậu', m12C, mCT, mPT, mDH, tbData),
                              _buildCung('Tuất', m12C, mCT, mPT, mDH, tbData),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  _buildRow(
                    ['Dần', 'Sửu', 'Tý', 'Hợi'],
                    m12C,
                    mCT,
                    mPT,
                    mDH,
                    tbData,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRow(
    List<String> ks,
    dynamic m12,
    dynamic mC,
    dynamic mP,
    dynamic mD,
    dynamic tb,
  ) => Expanded(
    child: Row(
      children: ks.map((k) => _buildCung(k, m12, mC, mP, mD, tb)).toList(),
    ),
  );

  Widget _buildCung(
    String k,
    dynamic m12,
    dynamic mC,
    dynamic mP,
    dynamic mD,
    dynamic tb,
  ) {
    String tt = '';
    if ((tb['tuan'] ?? []).contains(k) && (tb['triet'] ?? []).contains(k)) {
      tt = 'TUẦN - TRIỆT';
    } else if ((tb['tuan'] ?? []).contains(k)) {
      tt = 'TUẦN';
    } else if ((tb['triet'] ?? []).contains(k)) {
      tt = 'TRIỆT';
    }
    return CungWidget(
      chi: k.toUpperCase(),
      tenCung: m12[k] ?? '',
      chinhTinh: mC[k] ?? [],
      phuTinh: mP[k] ?? [],
      tuanTriet: tt,
      isThan: tb['cungThan'] == k,
      daiHan: mD[k] ?? 0,
    );
  }

  void _showBinhGiai(
    BuildContext context,
    UserProfile profile,
    dynamic tb,
    dynamic m12,
    dynamic mC,
    dynamic mP,
    dynamic mD,
    dynamic mT,
  ) {
    final segments = TuViBinhGiai.luanGiaiMaxLevel(
      tb,
      m12,
      mC,
      mP,
      mD,
      mT,
      isMale: profile.isMale,
    );
    final String hoTen = profile.name.trim().isEmpty
        ? 'Đương số'
        : profile.name;
    final String gioiTinh = profile.isMale ? 'Nam' : 'Nữ';
    final String cungMenh = tb['cungMenh'] ?? 'Tỵ';
    final String cungThan = tb['cungThan'] ?? '--';
    final String menhCuc = tb['menhCuc'] ?? (tb['cuc'] ?? '--');
    final String canChiNam = tb['canChiNam'] ?? '--';
    final String ngayAm =
        '${tb['lunarDay'] ?? '--'}/${tb['lunarMonth'] ?? '--'}/${tb['lunarYear'] ?? '----'}';
    final int? birthYear = _extractBirthYear(profile.birthDate);
    final int tuoiMu = birthYear == null
        ? 0
        : DateTime.now().year - birthYear + 1;

    bool isCollapsed = true;
    int? activeSectionIndex;
    MapEntry<String, int>? selectedDaiHan;
    final Map<int, bool> expandedSections = <int, bool>{};
    final List<GlobalKey> sectionKeys = List.generate(
      segments.length,
      (_) => GlobalKey(),
    );
    final List<Map<String, dynamic>> quickSections = [
      {
        'label': 'Tổng Mệnh',
        'match': ['Tổng Quan', 'Tính Cách'],
      },
      {
        'label': 'Công Danh',
        'match': ['Công Danh', 'Sự Nghiệp'],
      },
      {
        'label': 'Tài Lộc',
        'match': ['Tài Bạch'],
      },
      {
        'label': 'Nhân Duyên',
        'match': ['Tình Cảm', 'Hôn Nhân'],
      },
      {
        'label': 'Gia Đạo',
        'match': ['Gia Đạo', 'Cha Mẹ', 'Phúc Đức', 'Điền Trạch', 'Huynh Đệ'],
      },
      {
        'label': 'Thân Tâm',
        'match': ['Sức Khỏe', 'Tật Ách'],
      },
      {
        'label': 'Hậu Vận',
        'match': ['Hậu Vận', 'Con Cái', 'Tử Tức'],
      },
    ];

    int findSectionIndex(List<String> matches) {
      for (int i = 0; i < segments.length; i++) {
        final title = (segments[i]['title'] ?? '').toString();
        if (matches.any((m) => title.contains(m))) {
          return i;
        }
      }
      return -1;
    }

    Future<void> jumpToSection(
      int targetIndex,
      ScrollController controller,
      StateSetter setSheetState,
    ) async {
      if (targetIndex == -1 || !controller.hasClients) return;

      setSheetState(() {
        expandedSections[targetIndex] = true;
        activeSectionIndex = targetIndex;
      });

      await Future<void>.delayed(const Duration(milliseconds: 32));
      if (!context.mounted) return;

      final targetContext = sectionKeys[targetIndex].currentContext;
      if (targetContext == null) return;

      final renderObject = targetContext.findRenderObject();
      if (renderObject == null) return;

      final viewport = RenderAbstractViewport.of(renderObject);

      final revealed = viewport.getOffsetToReveal(renderObject, 0.0);
      final targetOffset = (revealed.offset - 8).clamp(
        controller.position.minScrollExtent,
        controller.position.maxScrollExtent,
      );

      controller.jumpTo(targetOffset.toDouble());
    }

    Future<void> selectDaiHan(
      MapEntry<String, int> entry,
      ScrollController controller,
      StateSetter setSheetState,
    ) async {
      setSheetState(() => selectedDaiHan = entry);
      final targetIndex = findSectionIndex(['Vận Năm', 'Đại Hạn', 'Điểm Mạnh']);
      if (targetIndex != -1) {
        await jumpToSection(targetIndex, controller, setSheetState);
      }
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setSheetState) {
            final isDarkPopup = Theme.of(context).brightness == Brightness.dark;

            return DraggableScrollableSheet(
              initialChildSize: 0.9,
              minChildSize: 0.6,
              maxChildSize: 0.97,
              builder: (context, ctrl) => Container(
                decoration: BoxDecoration(
                  color: isDarkPopup
                      ? AppColors.darkScaffold
                      : AppColors.lightSurface,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(30),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
                  child: Column(
                    children: [
                      Container(
                        width: 44,
                        height: 4,
                        decoration: BoxDecoration(
                          color: isDarkPopup
                              ? Colors.white24
                              : AppColors.lightBorder,
                          borderRadius: BorderRadius.circular(999),
                        ),
                      ),
                      const SizedBox(height: 18),
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 220),
                        curve: Curves.easeOutCubic,
                        width: double.infinity,
                        padding: EdgeInsets.fromLTRB(
                          isCollapsed ? 14 : 18,
                          isCollapsed ? 12 : 18,
                          isCollapsed ? 14 : 18,
                          isCollapsed ? 12 : 18,
                        ),
                        decoration: BoxDecoration(
                          gradient: isDarkPopup
                              ? const LinearGradient(
                                  colors: [
                                    AppColors.darkScaffoldAccent,
                                    AppColors.darkScaffoldAlt,
                                  ],
                                )
                              : const LinearGradient(
                                  colors: [
                                    AppColors.lightScaffoldAccent,
                                    Color(0xFFF5F3FF),
                                  ],
                                ),
                          borderRadius: BorderRadius.circular(
                            isCollapsed ? 20 : 24,
                          ),
                          border: Border.all(
                            color: isDarkPopup
                                ? Colors.white.withValues(alpha: 0.08)
                                : AppColors.lightBorderSoft,
                          ),
                        ),
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 180),
                          switchInCurve: Curves.easeOut,
                          switchOutCurve: Curves.easeIn,
                          child: isCollapsed
                              ? Row(
                                  key: const ValueKey('collapsed-header'),
                                  children: [
                                    Container(
                                      width: 38,
                                      height: 38,
                                      decoration: BoxDecoration(
                                        color: AppColors.primary.withValues(
                                          alpha: 0.14,
                                        ),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: const Icon(
                                        Icons.auto_stories_rounded,
                                        color: AppColors.primary,
                                        size: 20,
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Thiên Cơ Toàn Thư',
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold,
                                              color: isDarkPopup
                                                  ? AppColors.darkText
                                                  : AppColors.lightText,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            '$gioiTinh • Mệnh $cungMenh • Âm lịch $ngayAm',
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontSize: 12.5,
                                              color: isDarkPopup
                                                  ? Colors.white70
                                                  : AppColors.lightSubtleText,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    _buildCompactMetaChip(
                                      isDarkPopup,
                                      Icons.explore_outlined,
                                      cungThan,
                                    ),
                                  ],
                                )
                              : Column(
                                  key: const ValueKey('expanded-header'),
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          width: 42,
                                          height: 42,
                                          decoration: BoxDecoration(
                                            color: AppColors.primary.withValues(
                                              alpha: 0.14,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              14,
                                            ),
                                          ),
                                          child: const Icon(
                                            Icons.auto_stories_rounded,
                                            color: AppColors.primary,
                                          ),
                                        ),
                                        const SizedBox(width: 12),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Thiên Cơ Toàn Thư',
                                                style: TextStyle(
                                                  fontSize: 22,
                                                  fontWeight: FontWeight.bold,
                                                  color: isDarkPopup
                                                      ? AppColors.darkText
                                                      : AppColors.lightText,
                                                ),
                                              ),
                                              const SizedBox(height: 4),
                                              Text(
                                                'Khai giải chuyên sâu theo lá số đã lập',
                                                style: TextStyle(
                                                  fontSize: 13,
                                                  color: isDarkPopup
                                                      ? Colors.white70
                                                      : AppColors
                                                            .lightSubtleText,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        IconButton(
                                          icon: Icon(
                                            Icons.share_rounded,
                                            color: isDarkPopup
                                                ? Colors.white60
                                                : AppColors.lightSubtleText,
                                            size: 22,
                                          ),
                                          tooltip: 'Chia sẻ kết quả',
                                          onPressed: () => _shareTuViResult(
                                            context,
                                            hoTen,
                                            gioiTinh,
                                            tb,
                                            mC,
                                            birthYear,
                                            tuoiMu,
                                            ngayAm,
                                            cungMenh,
                                            cungThan,
                                            menhCuc,
                                            canChiNam,
                                            segments,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 16),
                                    Wrap(
                                      spacing: 8,
                                      runSpacing: 8,
                                      children: [
                                        _buildMetaChip(
                                          isDarkPopup,
                                          Icons.person_outline,
                                          hoTen,
                                        ),
                                        _buildMetaChip(
                                          isDarkPopup,
                                          Icons.wc_outlined,
                                          gioiTinh,
                                        ),
                                        _buildMetaChip(
                                          isDarkPopup,
                                          Icons.calendar_month_outlined,
                                          'Âm lịch $ngayAm',
                                        ),
                                        _buildMetaChip(
                                          isDarkPopup,
                                          Icons.stars_rounded,
                                          'Mệnh $cungMenh',
                                        ),
                                        _buildMetaChip(
                                          isDarkPopup,
                                          Icons.explore_outlined,
                                          'Thân $cungThan',
                                        ),
                                        _buildMetaChip(
                                          isDarkPopup,
                                          Icons.account_tree_outlined,
                                          menhCuc,
                                        ),
                                        _buildMetaChip(
                                          isDarkPopup,
                                          Icons.auto_awesome_motion_outlined,
                                          canChiNam,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                        ),
                      ),
                      _BinhGiaiNavBar(
                        isDark: isDarkPopup,
                        quickSections: quickSections,
                        rawDaiHan: mD,
                        tuoiMu: tuoiMu,
                        activeSectionIndex: activeSectionIndex,
                        selectedDaiHan: selectedDaiHan,
                        findSectionIndex: findSectionIndex,
                        onJumpQuick: (targetIndex) =>
                            jumpToSection(targetIndex, ctrl, setSheetState),
                        onSelectDaiHan: (entry) =>
                            selectDaiHan(entry, ctrl, setSheetState),
                      ),
                      Expanded(
                        child: NotificationListener<ScrollNotification>(
                          onNotification: (notification) {
                            if (notification.metrics.axis != Axis.vertical) {
                              return false;
                            }
                            final bool nextCollapsed =
                                notification.metrics.pixels > 28;
                            if (nextCollapsed != isCollapsed) {
                              setSheetState(() => isCollapsed = nextCollapsed);
                            }
                            return false;
                          },
                          child: SingleChildScrollView(
                            controller: ctrl,
                            padding: const EdgeInsets.only(bottom: 28),
                            child: Column(
                              children: List.generate(segments.length, (idx) {
                                final item = segments[idx];
                                final String title = (item['title'] ?? '')
                                    .toString();
                                final List<String> keyPoints =
                                    List<String>.from(item['keyPoints'] ?? [])
                                        .where((k) => k.trim().isNotEmpty)
                                        .toList();
                                final String details = (item['content'] ?? '')
                                    .toString()
                                    .trim();
                                final String? extraText = item['extra']
                                    ?.toString()
                                    .trim();
                                final bool isExpanded =
                                    expandedSections[idx] ?? false;
                                final bool isLong = details.length > 300;
                                final String preview = isLong
                                    ? '${details.substring(0, 300).trim()}…'
                                    : details;

                                return Container(
                                  key: sectionKeys[idx],
                                  margin: const EdgeInsets.only(bottom: 16),
                                  decoration: BoxDecoration(
                                    color: isDarkPopup
                                        ? Colors.white.withValues(alpha: 0.035)
                                        : AppColors.lightSurface.withValues(
                                            alpha: 0.9,
                                          ),
                                    borderRadius: BorderRadius.circular(22),
                                    border: Border.all(
                                      color: isDarkPopup
                                          ? Colors.white.withValues(alpha: 0.08)
                                          : AppColors.lightBorder,
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // ── Header row ──
                                      InkWell(
                                        borderRadius:
                                            const BorderRadius.vertical(
                                              top: Radius.circular(22),
                                              bottom: Radius.circular(22),
                                            ),
                                        onTap: () {
                                          setSheetState(() {
                                            expandedSections[idx] = !isExpanded;
                                            activeSectionIndex = idx;
                                          });
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                            18,
                                            18,
                                            18,
                                            14,
                                          ),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: 34,
                                                height: 34,
                                                decoration: BoxDecoration(
                                                  color: AppColors.primary
                                                      .withValues(alpha: 0.12),
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                ),
                                                child: Icon(
                                                  item['icon'],
                                                  color: AppColors.primary,
                                                  size: 18,
                                                ),
                                              ),
                                              const SizedBox(width: 12),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      title,
                                                      style: TextStyle(
                                                        color: isDarkPopup
                                                            ? AppColors.darkText
                                                            : AppColors
                                                                  .lightText,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 16,
                                                        height: 1.35,
                                                      ),
                                                    ),
                                                    const SizedBox(height: 8),
                                                    Container(
                                                      padding:
                                                          const EdgeInsets.symmetric(
                                                            horizontal: 10,
                                                            vertical: 6,
                                                          ),
                                                      decoration: BoxDecoration(
                                                        color: isExpanded
                                                            ? AppColors.primary
                                                                  .withValues(
                                                                    alpha:
                                                                        isDarkPopup
                                                                        ? 0.20
                                                                        : 0.12,
                                                                  )
                                                            : AppColors.chipFill(
                                                                isDarkPopup,
                                                              ),
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              999,
                                                            ),
                                                        border: Border.all(
                                                          color: isExpanded
                                                              ? AppColors
                                                                    .primary
                                                                    .withValues(
                                                                      alpha:
                                                                          0.35,
                                                                    )
                                                              : AppColors.chipBorder(
                                                                  isDarkPopup,
                                                                ),
                                                        ),
                                                      ),
                                                      child: Text(
                                                        isExpanded
                                                            ? 'Thu gọn'
                                                            : 'Mở để xem chi tiết',
                                                        style: TextStyle(
                                                          color: isExpanded
                                                              ? AppColors
                                                                    .primary
                                                              : (isDarkPopup
                                                                    ? Colors
                                                                          .white60
                                                                    : AppColors
                                                                          .lightSubtleText),
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          height: 1.1,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(width: 8),
                                              Container(
                                                width: 30,
                                                height: 30,
                                                decoration: BoxDecoration(
                                                  color: AppColors.chipFill(
                                                    isDarkPopup,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                        999,
                                                      ),
                                                  border: Border.all(
                                                    color: AppColors.chipBorder(
                                                      isDarkPopup,
                                                    ),
                                                  ),
                                                ),
                                                child: Icon(
                                                  isExpanded
                                                      ? Icons
                                                            .keyboard_arrow_up_rounded
                                                      : Icons
                                                            .keyboard_arrow_down_rounded,
                                                  color: isDarkPopup
                                                      ? Colors.white60
                                                      : AppColors
                                                            .lightSubtleText,
                                                  size: 18,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),

                                      // ── Tier 1: Key points (always visible) ──
                                      if (keyPoints.isNotEmpty)
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                            18,
                                            0,
                                            18,
                                            14,
                                          ),
                                          child: Column(
                                            children: List.generate(
                                              keyPoints.length,
                                              (ki) {
                                                return Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                        bottom: 8,
                                                      ),
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Container(
                                                        margin:
                                                            const EdgeInsets.only(
                                                              top: 4,
                                                            ),
                                                        width: 7,
                                                        height: 7,
                                                        decoration:
                                                            BoxDecoration(
                                                              color: AppColors
                                                                  .primary,
                                                              shape: BoxShape
                                                                  .circle,
                                                            ),
                                                      ),
                                                      const SizedBox(width: 10),
                                                      Expanded(
                                                        child: Text(
                                                          keyPoints[ki],
                                                          style: TextStyle(
                                                            color: isDarkPopup
                                                                ? Colors.white
                                                                : AppColors
                                                                      .lightText,
                                                            fontSize: 13.5,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            height: 1.45,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        ),

                                      // ── Tier 2: Details ──
                                      if (isExpanded && details.isNotEmpty)
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                            18,
                                            0,
                                            18,
                                            18,
                                          ),
                                          child: SelectableText.rich(
                                            _buildHighlightedText(
                                              details,
                                              isDarkPopup,
                                            ),
                                            style: TextStyle(
                                              color: isDarkPopup
                                                  ? Colors.white70
                                                  : AppColors.lightText,
                                              fontSize: _getBinhGiaiFontSize(),
                                              height: 1.72,
                                            ),
                                          ),
                                        ),

                                      // ── Tier 3: Extra (collapsed deeper) ──
                                      if (extraText != null && isExpanded) ...[
                                        const SizedBox(height: 4),
                                        _buildExtraSection(
                                          isDarkPopup,
                                          extraText,
                                        ),
                                        const SizedBox(height: 18),
                                      ],

                                      // Fallback: preview when collapsed
                                      if (!isExpanded && details.isNotEmpty)
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                            18,
                                            0,
                                            18,
                                            18,
                                          ),
                                          child: Text(
                                            preview,
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              color: isDarkPopup
                                                  ? Colors.white54
                                                  : AppColors.lightSubtleText,
                                              fontSize: 12.5,
                                              height: 1.55,
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                );
                              }),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _shareTuViResult(
    BuildContext context,
    String hoTen,
    String gioiTinh,
    dynamic tb,
    dynamic mC,
    int? birthYear,
    int tuoiMu,
    String ngayAm,
    String cungMenh,
    String cungThan,
    String menhCuc,
    String canChiNam,
    List<Map<String, dynamic>> segments,
  ) {
    final menhChinhTinh = (mC[cungMenh] as List?)?.join(', ') ?? '--';

    if (kIsWeb) {
      final overlay = OverlayEntry(
        builder: (_) => RepaintBoundary(
          key: _shareKey,
          child: IgnorePointer(
            child: TuViShareCard(
              hoTen: hoTen,
              namSinh: birthYear?.toString() ?? '--',
              gioiTinh: gioiTinh,
              ngaySinhAmLich: ngayAm,
              gioSinh: widget.profile.birthTime,
              tuoiMu: tuoiMu,
              menhChinhTinh: menhChinhTinh,
              menhCung: cungMenh,
              tomTat: '',
              diemSo: 0,
            ),
          ),
        ),
      );
      Overlay.of(context).insert(overlay);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ShareHelper.captureAndShare(
          repaintKey: _shareKey,
          subject: 'Lá số Tử Vi - $hoTen',
          text: 'Xem lá số Tử Vi của $hoTen được lập bởi Thiên Cơ',
        );
        Future.delayed(const Duration(milliseconds: 500), overlay.remove);
      });
      return;
    }

    PdfHelper.shareTuViPdf(
      hoTen: hoTen,
      gioiTinh: gioiTinh,
      ngaySinhAmLich: ngayAm,
      gioSinh: widget.profile.birthTime,
      tuoiMu: tuoiMu,
      cungMenh: cungMenh,
      menhChinhTinh: menhChinhTinh,
      menhCuc: menhCuc,
      cungThan: cungThan,
      canChiNam: canChiNam,
      segments: segments,
    );
  }

  int? _extractBirthYear(String birthDate) {
    final parts = birthDate.split('/');
    if (parts.length != 3) return null;
    final year = int.tryParse(parts[2]);
    if (year == null || year < 1900) return null;
    return year;
  }

  static Widget _buildActionChip(
    bool isDark, {
    required String label,
    required bool isActive,
    IconData? icon,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(999),
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOutCubic,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8.5),
          decoration: BoxDecoration(
            color: isActive
                ? AppColors.primary.withValues(alpha: isDark ? 0.22 : 0.14)
                : AppColors.chipFill(isDark),
            borderRadius: BorderRadius.circular(999),
            border: Border.all(
              color: isActive
                  ? AppColors.primary.withValues(alpha: 0.45)
                  : AppColors.chipBorder(isDark),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[
                Icon(
                  icon,
                  size: 14,
                  color: isActive
                      ? AppColors.primary
                      : (isDark ? Colors.white60 : AppColors.lightSubtleText),
                ),
                const SizedBox(width: 6),
              ],
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: isActive
                      ? AppColors.primary
                      : (isDark ? Colors.white70 : AppColors.lightText),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMetaChip(bool isDark, IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
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
              fontSize: 12.5,
              fontWeight: FontWeight.w600,
              color: isDark ? Colors.white70 : AppColors.lightText,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExtraSection(bool isDark, String extraText) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.primary.withValues(alpha: isDark ? 0.08 : 0.05),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.primary.withValues(alpha: 0.2)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.psychology_alt_outlined,
                  size: 14,
                  color: AppColors.primary,
                ),
                const SizedBox(width: 6),
                Text(
                  'Đọc thêm',
                  style: TextStyle(
                    fontSize: 11.5,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primary,
                    letterSpacing: 0.3,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            SelectableText.rich(
              _buildHighlightedText(extraText, isDark),
              style: TextStyle(
                color: isDark ? Colors.white70 : AppColors.lightText,
                fontSize: 13,
                height: 1.6,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCompactMetaChip(bool isDark, IconData icon, String label) {
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
          Icon(icon, size: 13, color: AppColors.primary),
          const SizedBox(width: 5),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: isDark ? Colors.white70 : AppColors.lightText,
            ),
          ),
        ],
      ),
    );
  }

  /// Lấy font size bình giải từ Settings
  double _getBinhGiaiFontSize() {
    final String size = SettingsService.getFontSize();
    switch (size) {
      case 'small':
        return 13.5;
      case 'large':
        return 17.0;
      default:
        return 15.0;
    }
  }

  /// Highlight tên sao và thuật ngữ quan trọng trong bình giải
  TextSpan _buildHighlightedText(String text, bool isDark) {
    // Danh sách sao cần highlight
    const List<String> starNames = [
      'Tử Vi',
      'Thiên Cơ',
      'Thái Dương',
      'Vũ Khúc',
      'Thiên Đồng',
      'Liêm Trinh',
      'Thiên Phủ',
      'Thái Âm',
      'Tham Lang',
      'Cự Môn',
      'Thiên Tướng',
      'Thiên Lương',
      'Thất Sát',
      'Phá Quân',
      'Tả Phù',
      'Hữu Bật',
      'Văn Xương',
      'Văn Khúc',
      'Thiên Khôi',
      'Thiên Việt',
      'Lộc Tồn',
      'Kình Dương',
      'Đà La',
      'Hỏa Tinh',
      'Linh Tinh',
      'Địa Không',
      'Địa Kiếp',
      'Thiên Mã',
      'Đào Hoa',
      'Hồng Loan',
      'Thiên Hỷ',
      'Hóa Lộc',
      'Hóa Quyền',
      'Hóa Khoa',
      'Hóa Kỵ',
      'Thiên Hình',
      'Cô Thần',
      'Quả Tú',
      'Long Trì',
      'Phượng Các',
      'Thiên Đức',
      'Nguyệt Đức',
      'Thiên Y',
    ];

    // Thuật ngữ quan trọng
    const List<String> keywords = [
      'Tam Hợp',
      'Lục Hợp',
      'Tam Phương',
      'Tứ Chính',
      'Tuần',
      'Triệt',
      'Đại Hạn',
      'Tiểu Hạn',
      'Cung Mệnh',
      'Cung Thân',
      'Cung Tài Bạch',
      'Cung Quan Lộc',
      'Cung Phu Thê',
      'Cung Tật Ách',
      'Cung Thiên Di',
      'Cung Phúc Đức',
    ];

    final Color starColor = isDark
        ? const Color(0xFFFFD700)
        : const Color(0xFFB45309);
    final Color keywordColor = isDark
        ? const Color(0xFF93C5FD)
        : const Color(0xFF1D4ED8);

    // Build regex pattern
    final allTerms = [...starNames, ...keywords];
    allTerms.sort((a, b) => b.length.compareTo(a.length)); // Longest first
    final String pattern = allTerms.map((t) => RegExp.escape(t)).join('|');
    final RegExp regex = RegExp('($pattern)');

    final List<TextSpan> spans = [];
    int lastEnd = 0;

    for (final match in regex.allMatches(text)) {
      // Add normal text before match
      if (match.start > lastEnd) {
        spans.add(TextSpan(text: text.substring(lastEnd, match.start)));
      }

      // Determine color
      final String matched = match.group(0)!;
      final bool isStar = starNames.contains(matched);
      final Color color = isStar ? starColor : keywordColor;

      spans.add(
        TextSpan(
          text: matched,
          style: TextStyle(color: color, fontWeight: FontWeight.w700),
        ),
      );

      lastEnd = match.end;
    }

    // Add remaining text
    if (lastEnd < text.length) {
      spans.add(TextSpan(text: text.substring(lastEnd)));
    }

    return TextSpan(children: spans);
  }
}

class _BinhGiaiNavBar extends StatefulWidget {
  final bool isDark;
  final List<Map<String, dynamic>> quickSections;
  final dynamic rawDaiHan;
  final int tuoiMu;
  final int? activeSectionIndex;
  final MapEntry<String, int>? selectedDaiHan;
  final int Function(List<String> matches) findSectionIndex;
  final void Function(int targetIndex) onJumpQuick;
  final void Function(MapEntry<String, int>) onSelectDaiHan;

  const _BinhGiaiNavBar({
    required this.isDark,
    required this.quickSections,
    required this.rawDaiHan,
    required this.tuoiMu,
    required this.activeSectionIndex,
    required this.selectedDaiHan,
    required this.findSectionIndex,
    required this.onJumpQuick,
    required this.onSelectDaiHan,
  });

  @override
  State<_BinhGiaiNavBar> createState() => _BinhGiaiNavBarState();
}

class _BinhGiaiNavBarState extends State<_BinhGiaiNavBar> {
  late final List<MapEntry<String, int>> _daiHanItems;
  late final List<GlobalKey> _dhKeys;
  final ScrollController _dhScroll = ScrollController();

  @override
  void initState() {
    super.initState();
    _daiHanItems = _computeDaiHan(widget.rawDaiHan);
    _dhKeys = List.generate(_daiHanItems.length, (_) => GlobalKey());
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToCurrent());
  }

  List<MapEntry<String, int>> _computeDaiHan(dynamic raw) {
    if (raw is! Map) return [];
    final items =
        raw.entries
            .where((e) => e.value is int && (e.value as int) <= 90)
            .map((e) => MapEntry(e.key.toString(), e.value as int))
            .toList()
          ..sort((a, b) => a.value.compareTo(b.value));
    return items;
  }

  void _scrollToCurrent() {
    if (!_dhScroll.hasClients) return;
    final idx = _daiHanItems.indexWhere(
      (e) => widget.tuoiMu >= e.value && widget.tuoiMu <= e.value + 9,
    );
    if (idx < 0) return;
    final ctx = _dhKeys[idx].currentContext;
    if (ctx != null) {
      Scrollable.ensureVisible(
        ctx,
        alignment: 0.5,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  void dispose() {
    _dhScroll.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = widget.isDark;
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDark
            ? Colors.white.withValues(alpha: 0.035)
            : AppColors.lightSurface.withValues(alpha: 0.92),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: isDark
              ? Colors.white.withValues(alpha: 0.08)
              : AppColors.lightBorder,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Mục lục nhanh',
            style: TextStyle(
              color: isDark ? AppColors.darkText : AppColors.lightText,
              fontWeight: FontWeight.w800,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 36,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 2),
              itemCount: widget.quickSections.length,
              separatorBuilder: (_, _) => const SizedBox(width: 8),
              itemBuilder: (context, i) {
                final item = widget.quickSections[i];
                final matches = (item['match'] as List).cast<String>();
                final targetIndex = widget.findSectionIndex(matches);
                final isActive =
                    widget.activeSectionIndex != null &&
                    targetIndex != -1 &&
                    widget.activeSectionIndex == targetIndex;
                return Center(
                  child: _LaSoScreenState._buildActionChip(
                    isDark,
                    label: item['label'] as String,
                    isActive: isActive,
                    onTap: () => widget.onJumpQuick(targetIndex),
                  ),
                );
              },
            ),
          ),
          if (_daiHanItems.isNotEmpty) ...[
            const SizedBox(height: 10),
            Text(
              'Đại hạn theo tuổi',
              style: TextStyle(
                color: isDark ? AppColors.darkText : AppColors.lightText,
                fontWeight: FontWeight.w800,
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 36,
              child: ListView.separated(
                controller: _dhScroll,
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 2),
                itemCount: _daiHanItems.length,
                separatorBuilder: (_, _) => const SizedBox(width: 8),
                itemBuilder: (context, i) {
                  final entry = _daiHanItems[i];
                  final start = entry.value;
                  final end = start + 9;
                  final isCurrent =
                      widget.tuoiMu >= start && widget.tuoiMu <= end;
                  final isSelected = widget.selectedDaiHan?.key == entry.key;
                  return Container(
                    key: _dhKeys[i],
                    child: _LaSoScreenState._buildActionChip(
                      isDark,
                      label: '${entry.key} $start-$end',
                      isActive: isCurrent || isSelected,
                      icon: isCurrent
                          ? Icons.my_location_rounded
                          : Icons.timeline_rounded,
                      onTap: () => widget.onSelectDaiHan(entry),
                    ),
                  );
                },
              ),
            ),
          ],
        ],
      ),
    );
  }
}
