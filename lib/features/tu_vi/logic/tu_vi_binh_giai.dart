import 'package:flutter/material.dart';
import 'tu_vi_binh_giai_core.dart';
import 'tu_vi_binh_giai_cung_paths.dart';
import 'tu_vi_binh_giai_tong_quan.dart';
import 'tu_vi_binh_giai_chi_tiet_cung.dart';
import 'tu_vi_binh_giai_chu_de.dart';
import 'time_engine.dart';

class TuViBinhGiai {
  static List<Map<String, dynamic>> luanGiaiMaxLevel(
    dynamic tb,
    dynamic m12,
    dynamic mC,
    dynamic mP,
    dynamic mD,
    dynamic mT, {
    bool isMale = true,
  }) {
    final List<Map<String, dynamic>> segments = [];

    final String hoTen = (tb['hoTen'] ?? tb['name'] ?? tb['ten'] ?? 'Đương số')
        .toString();
    final String gioiTinh =
        (tb['gioiTinh'] ?? tb['gender'] ?? tb['amDuongNamNu'] ?? '--')
            .toString();
    final String cungMenh = (tb['cungMenh'] ?? 'Tỵ').toString();
    final String cungThan = (tb['cungThan'] ?? '--').toString();
    final String menhCuc = (tb['menhCuc'] ?? 'Cục sinh Mệnh').toString();
    final String canChiNam = (tb['canChiNam'] ?? '--').toString();
    final String ngayAm = (tb['ngayAm'] ?? tb['lunarDate'] ?? '--').toString();

    final int idxMenh = TuViBinhGiaiCore.listCung.indexOf(cungMenh);
    final String cungPhuMau = idxMenh == -1
        ? 'Ngọ'
        : TuViBinhGiaiCore.listCung[(idxMenh + 1) % 12];
    final String cungPhucDuc = idxMenh == -1
        ? 'Mùi'
        : TuViBinhGiaiCore.listCung[(idxMenh + 3) % 12];
    final String cungDienTrach = idxMenh == -1
        ? 'Thân'
        : TuViBinhGiaiCore.listCung[(idxMenh + 4) % 12];
    final String cungNoBoc = idxMenh == -1
        ? 'Dần'
        : TuViBinhGiaiCore.listCung[(idxMenh + 5) % 12];
    final String cungThienDi = idxMenh == -1
        ? 'Tý'
        : TuViBinhGiaiCore.listCung[(idxMenh + 7) % 12];
    final String cungTuTuc = idxMenh == -1
        ? 'Sửu'
        : TuViBinhGiaiCore.listCung[(idxMenh + 9) % 12];
    final String cungHuynhDe = idxMenh == -1
        ? 'Thìn'
        : TuViBinhGiaiCore.listCung[(idxMenh + 11) % 12];

    final List<String> saoMenh = TuViBinhGiaiCore.mergeStarsForCung(
      cungMenh,
      mC,
      mP,
    );
    final String cungTaiBach = TuViBinhGiaiCungPaths.cungTaiBachFromMenh(
      cungMenh,
    );
    final String cungQuanLoc = TuViBinhGiaiCungPaths.cungQuanLocFromMenh(
      cungMenh,
    );
    final String cungPhuThe = TuViBinhGiaiCungPaths.cungPhuTheFromMenh(
      cungMenh,
    );
    final String cungTatAch = TuViBinhGiaiCungPaths.cungTatAchFromMenh(
      cungMenh,
    );

    final List<String> saoThan = cungThan != '--'
        ? TuViBinhGiaiCore.mergeStarsForCung(cungThan, mC, mP)
        : <String>[];
    final List<String> saoTaiBach = TuViBinhGiaiCore.mergeStarsForCung(
      cungTaiBach,
      mC,
      mP,
    );
    final List<String> saoQuanLoc = TuViBinhGiaiCore.mergeStarsForCung(
      cungQuanLoc,
      mC,
      mP,
    );
    final List<String> saoPhuThe = TuViBinhGiaiCore.mergeStarsForCung(
      cungPhuThe,
      mC,
      mP,
    );
    final List<String> saoTatAch = TuViBinhGiaiCore.mergeStarsForCung(
      cungTatAch,
      mC,
      mP,
    );
    final List<String> saoPhuMau = TuViBinhGiaiCore.mergeStarsForCung(
      cungPhuMau,
      mC,
      mP,
    );
    final List<String> saoPhucDuc = TuViBinhGiaiCore.mergeStarsForCung(
      cungPhucDuc,
      mC,
      mP,
    );
    final List<String> saoDienTrach = TuViBinhGiaiCore.mergeStarsForCung(
      cungDienTrach,
      mC,
      mP,
    );
    final List<String> saoNoBoc = TuViBinhGiaiCore.mergeStarsForCung(
      cungNoBoc,
      mC,
      mP,
    );
    final List<String> saoThienDi = TuViBinhGiaiCore.mergeStarsForCung(
      cungThienDi,
      mC,
      mP,
    );
    final List<String> saoTuTuc = TuViBinhGiaiCore.mergeStarsForCung(
      cungTuTuc,
      mC,
      mP,
    );
    final List<String> saoHuynhDe = TuViBinhGiaiCore.mergeStarsForCung(
      cungHuynhDe,
      mC,
      mP,
    );

    final int diemMenh =
        TuViBinhGiaiCore.scoreCat(saoMenh) - TuViBinhGiaiCore.scoreSat(saoMenh);
    final int diemTai =
        TuViBinhGiaiCore.scoreCat(saoTaiBach) -
        TuViBinhGiaiCore.scoreSat(saoTaiBach);
    final int diemQuan =
        TuViBinhGiaiCore.scoreCat(saoQuanLoc) -
        TuViBinhGiaiCore.scoreSat(saoQuanLoc);
    final int diemPhuThe =
        TuViBinhGiaiCore.scoreCat(saoPhuThe) -
        TuViBinhGiaiCore.scoreSat(saoPhuThe);
    final int diemTatAch =
        TuViBinhGiaiCore.scoreCat(saoTatAch) -
        TuViBinhGiaiCore.scoreSat(saoTatAch);
    final int diemPhuMau =
        TuViBinhGiaiCore.scoreCat(saoPhuMau) -
        TuViBinhGiaiCore.scoreSat(saoPhuMau);
    final int diemPhucDuc =
        TuViBinhGiaiCore.scoreCat(saoPhucDuc) -
        TuViBinhGiaiCore.scoreSat(saoPhucDuc);
    final int diemNoBoc =
        TuViBinhGiaiCore.scoreCat(saoNoBoc) -
        TuViBinhGiaiCore.scoreSat(saoNoBoc);
    final int diemTuTuc =
        TuViBinhGiaiCore.scoreCat(saoTuTuc) -
        TuViBinhGiaiCore.scoreSat(saoTuTuc);
    final int diemHuynhDe =
        TuViBinhGiaiCore.scoreCat(saoHuynhDe) -
        TuViBinhGiaiCore.scoreSat(saoHuynhDe);

    final int? daiHanMenh = TuViBinhGiaiCore.readDaiHanAtCung(mD, cungMenh);
    final String? tieuHanMenh = TuViBinhGiaiCore.readTieuHanAtCung(
      mT,
      cungMenh,
    );

    // ─────────── 1. TỔNG QUAN ───────────
    segments.add(_seg(
      icon: Icons.auto_awesome,
      title: 'Tổng Quan Vận Mệnh',
      keyPoints: [
        _menhMoTaNhanh(diemMenh, saoMenh, cungMenh),
        _taiMoTaNhanh(diemTai, saoTaiBach),
        _quanMoTaNhanh(diemQuan, saoQuanLoc),
        'Cục $menhCuc — ${_menhCucMoTaNhanh(menhCuc)}',
      ],
      details: [
        TuViBinhGiaiTongQuan.buildTongQuan(
          hoTen: hoTen,
          gioiTinh: gioiTinh,
          cungMenh: cungMenh,
          cungThan: cungThan,
          menhCuc: menhCuc,
          canChiNam: canChiNam,
          ngayAm: ngayAm,
          saoMenh: saoMenh,
          saoThan: saoThan,
          saoTai: saoTaiBach,
          saoQuan: saoQuanLoc,
          diemMenh: diemMenh,
          diemTai: diemTai,
          diemQuan: diemQuan,
        ),
        TuViBinhGiaiTongQuan.buildHanNarrative(
          daiHan: daiHanMenh,
          tieuHan: tieuHanMenh,
          saoMenh: saoMenh,
          saoTai: saoTaiBach,
          saoQuan: saoQuanLoc,
        ),
        TuViBinhGiaiTongQuan.buildCatHungNarrative(
          saoMenh: saoMenh,
          saoTai: saoTaiBach,
          saoQuan: saoQuanLoc,
          saoTatAch: saoTatAch,
        ),
        TuViBinhGiaiTongQuan.buildTamPhuongNarrative(
          cungMenh: cungMenh,
          cungTai: cungTaiBach,
          cungQuan: cungQuanLoc,
          saoMenh: saoMenh,
          saoTai: saoTaiBach,
          saoQuan: saoQuanLoc,
        ),
      ].where((e) => e.trim().isNotEmpty).join('\n\n'),
      extra: null,
    ));

    // ─────────── 2. TÍNH CÁCH ───────────
    final tc = TuViBinhGiaiChuDe.buildTinhCachKhiChat(
      saoMenh: saoMenh,
      saoThan: saoThan,
      diemMenh: diemMenh,
    );
    segments.add(_seg(
      icon: Icons.wb_incandescent_outlined,
      title: 'Tính Cách Và Khí Chất',
      keyPoints: _extractKeyPoints(tc, 3),
      details: tc,
      extra: _tinhCachExtra(saoMenh, saoThan),
    ));

    // ─────────── 3. MỆNH - TÀI - QUAN ───────────
    final menhCt = TuViBinhGiaiChiTietCung.buildChiTietCung(
      tenCung: 'Mệnh',
      sao: saoMenh,
      daiHan: TuViBinhGiaiCore.readDaiHanAtCung(mD, cungMenh),
      tieuHan: TuViBinhGiaiCore.readTieuHanAtCung(mT, cungMenh),
      tuanTriet: TuViBinhGiaiCore.getTuanTrietAtCung(tb, cungMenh),
    );
    final taiCt = TuViBinhGiaiChiTietCung.buildChiTietCung(
      tenCung: 'Tài Bạch',
      sao: saoTaiBach,
      daiHan: TuViBinhGiaiCore.readDaiHanAtCung(mD, cungTaiBach),
      tieuHan: TuViBinhGiaiCore.readTieuHanAtCung(mT, cungTaiBach),
      tuanTriet: TuViBinhGiaiCore.getTuanTrietAtCung(tb, cungTaiBach),
    );
    final quanCt = TuViBinhGiaiChiTietCung.buildChiTietCung(
      tenCung: 'Quan Lộc',
      sao: saoQuanLoc,
      daiHan: TuViBinhGiaiCore.readDaiHanAtCung(mD, cungQuanLoc),
      tieuHan: TuViBinhGiaiCore.readTieuHanAtCung(mT, cungQuanLoc),
      tuanTriet: TuViBinhGiaiCore.getTuanTrietAtCung(tb, cungQuanLoc),
    );
    segments.add(_seg(
      icon: Icons.psychology,
      title: 'Giải Mã Mệnh - Tài - Quan',
      keyPoints: [
        diemMenh >= 2
            ? 'Mệnh vững — đây là người có nội lực tự thân, sớm biết mình muốn gì'
            : diemMenh >= 0
                ? 'Mệnh trung bình — bản thân cần môi trường đúng để bật ra hết nội lực'
                : 'Mệnh yếu — đường đời nhiều bài học từ ngoại cảnh hơn là từ ý chí thuần túy',
        diemTai >= 1
            ? 'Tài có phước — tiền bạc đến từ năng lực và sự đúng đường, không phải may rủi'
            : diemTai <= -1
                ? 'Tài có thử thách — tiền bạc cần quản trị chặt, dễ đến dễ đi nếu không cẩn'
                : 'Tài ở mức tự túc — đủ sống nếu sống có kế hoạch, khó giàu nếu không liều',
        diemQuan >= 1
            ? 'Quan có thế — sự nghiệp thăng tiến nếu chọn đúng nghề và biết nắm cơ hội'
            : diemQuan <= -1
                ? 'Quan lắm thử — đường công danh lận đận, phải tự tạo vị thế hơn chờ ai trao'
                : 'Quan tầm trung — thành công đến từ kiên trì hơn là đột phá',
      ],
      details: [menhCt, taiCt, quanCt].join('\n\n'),
      extra: null,
    ));

    // ─────────── 4. GIA ĐẠO ───────────
    final pmCt = TuViBinhGiaiChiTietCung.buildChiTietCung(
      tenCung: 'Phụ Mẫu',
      sao: saoPhuMau,
      daiHan: TuViBinhGiaiCore.readDaiHanAtCung(mD, cungPhuMau),
      tieuHan: TuViBinhGiaiCore.readTieuHanAtCung(mT, cungPhuMau),
      tuanTriet: TuViBinhGiaiCore.getTuanTrietAtCung(tb, cungPhuMau),
    );
    final pdCt = TuViBinhGiaiChiTietCung.buildChiTietCung(
      tenCung: 'Phúc Đức',
      sao: saoPhucDuc,
      daiHan: TuViBinhGiaiCore.readDaiHanAtCung(mD, cungPhucDuc),
      tieuHan: TuViBinhGiaiCore.readTieuHanAtCung(mT, cungPhucDuc),
      tuanTriet: TuViBinhGiaiCore.getTuanTrietAtCung(tb, cungPhucDuc),
    );
    final dtCt = TuViBinhGiaiChiTietCung.buildChiTietCung(
      tenCung: 'Điền Trạch',
      sao: saoDienTrach,
      daiHan: TuViBinhGiaiCore.readDaiHanAtCung(mD, cungDienTrach),
      tieuHan: TuViBinhGiaiCore.readTieuHanAtCung(mT, cungDienTrach),
      tuanTriet: TuViBinhGiaiCore.getTuanTrietAtCung(tb, cungDienTrach),
    );
    final hdCt = TuViBinhGiaiChiTietCung.buildChiTietCung(
      tenCung: 'Huynh Đệ',
      sao: saoHuynhDe,
      daiHan: TuViBinhGiaiCore.readDaiHanAtCung(mD, cungHuynhDe),
      tieuHan: TuViBinhGiaiCore.readTieuHanAtCung(mT, cungHuynhDe),
      tuanTriet: TuViBinhGiaiCore.getTuanTrietAtCung(tb, cungHuynhDe),
    );
    final taCt = TuViBinhGiaiChiTietCung.buildChiTietCung(
      tenCung: 'Tật Ách',
      sao: saoTatAch,
      daiHan: TuViBinhGiaiCore.readDaiHanAtCung(mD, cungTatAch),
      tieuHan: TuViBinhGiaiCore.readTieuHanAtCung(mT, cungTatAch),
      tuanTriet: TuViBinhGiaiCore.getTuanTrietAtCung(tb, cungTatAch),
    );
    segments.add(_seg(
      icon: Icons.account_tree_outlined,
      title: 'Cung Gia Đạo Và Nền Sống',
      keyPoints: [
        diemPhuMau >= 0
            ? 'Cha mẹ là nền tựa — gia đình gốc không tạo áp lực, dễ có điểm tựa tinh thần'
            : 'Cha mẹ có thử — tuổi thơ nhiều bài học từ gia đình, giúp trưởng thành sớm hơn bạn bè',
        diemPhucDuc >= 1
            ? 'Phúc đức dày — nền tinh thần vững, chông chênh kiểu gì cũng có lúc đứng dậy được'
            : 'Phúc đức mỏng — mọi sự đều do tự thân, đừng trông chờ may mắn hay sự đỡ của số phận',
        diemTatAch >= 0
            ? 'Sức khỏe nền tốt — biết giữ gìn là sống khỏe, không có bệnh trọng' 
            : 'Sức khỏe cần chú ý — dễ hao tổn khi áp lực kéo dài, cần nghe cơ thể nhiều hơn',
      ],
      details: [pmCt, pdCt, dtCt, hdCt, taCt].join('\n\n'),
      extra: null,
    ));

    // ─────────── 5. QUAN HỆ ───────────
    final ptCt = TuViBinhGiaiChiTietCung.buildChiTietCung(
      tenCung: 'Phu Thê',
      sao: saoPhuThe,
      daiHan: TuViBinhGiaiCore.readDaiHanAtCung(mD, cungPhuThe),
      tieuHan: TuViBinhGiaiCore.readTieuHanAtCung(mT, cungPhuThe),
      tuanTriet: TuViBinhGiaiCore.getTuanTrietAtCung(tb, cungPhuThe),
    );
    final nbCt = TuViBinhGiaiChiTietCung.buildChiTietCung(
      tenCung: 'Nô Bộc',
      sao: saoNoBoc,
      daiHan: TuViBinhGiaiCore.readDaiHanAtCung(mD, cungNoBoc),
      tieuHan: TuViBinhGiaiCore.readTieuHanAtCung(mT, cungNoBoc),
      tuanTriet: TuViBinhGiaiCore.getTuanTrietAtCung(tb, cungNoBoc),
    );
    final tdCt = TuViBinhGiaiChiTietCung.buildChiTietCung(
      tenCung: 'Thiên Di',
      sao: saoThienDi,
      daiHan: TuViBinhGiaiCore.readDaiHanAtCung(mD, cungThienDi),
      tieuHan: TuViBinhGiaiCore.readTieuHanAtCung(mT, cungThienDi),
      tuanTriet: TuViBinhGiaiCore.getTuanTrietAtCung(tb, cungThienDi),
    );
    final ttCt = TuViBinhGiaiChiTietCung.buildChiTietCung(
      tenCung: 'Tử Tức',
      sao: saoTuTuc,
      daiHan: TuViBinhGiaiCore.readDaiHanAtCung(mD, cungTuTuc),
      tieuHan: TuViBinhGiaiCore.readTieuHanAtCung(mT, cungTuTuc),
      tuanTriet: TuViBinhGiaiCore.getTuanTrietAtCung(tb, cungTuTuc),
    );
    segments.add(_seg(
      icon: Icons.travel_explore_outlined,
      title: 'Cung Quan Hệ Và Dịch Chuyển',
      keyPoints: [
        diemPhuThe >= 1
            ? 'Hôn nhân thuận — người đến với bạn là người tử tế, cùng xây chứ không cùng phá'
            : diemPhuThe <= -1
                ? 'Hôn nhân thử thách — yêu thương cần tỉnh táo, đừng để lý trí bị cảm xúc lấn át'
                : 'Hôn nhân trung tính — duyên có nhưng không tự nhiên bền, cần cả hai vun đắp',
        diemNoBoc >= 0
            ? 'Bạn bè quý — người xung quanh hỗ trợ nhiều hơn là kéo xuống'
            : 'Bạn bè cần chọn — dễ hao vì quan hệ sai, nên giữ một vòng tròn nhỏ mà chất lượng',
        saoThienDi.any((s) => s.contains('Thiên Mã'))
            ? 'Thiên Di có Mã — cuộc đời gắn với dịch chuyển, đi nhiều thì mở nhiều, ở yên thì bí'
            : 'Thiên Di tĩnh — hợp ổn định một chỗ, thành công từ chiều sâu chứ không phải chiều rộng',
      ],
      details: [ptCt, nbCt, tdCt, ttCt].join('\n\n'),
      extra: null,
    ));

    // ─────────── 6. CÔNG DANH ───────────
    final cd = TuViBinhGiaiChuDe.buildCongDanh(
      saoQuan: saoQuanLoc,
      diemQuan: diemQuan,
      daiHan: TuViBinhGiaiCore.readDaiHanAtCung(mD, cungQuanLoc),
    );
    segments.add(_seg(
      icon: Icons.work_outline,
      title: 'Công Danh Và Sự Nghiệp',
      keyPoints: [
        diemQuan >= 2
            ? 'Sự nghiệp sáng — dễ đạt vị thế nếu kiên trì, đây người sinh ra để làm việc lớn'
            : diemQuan >= 0
                ? 'Sự nghiệp ổn — không bùng nổ nhưng bền, hợp hướng chuyên môn hơn lãnh đạo'
                : 'Sự nghiệp lận đận — phải tự mở đường, càng mạo hiểm sớm càng có kết quả sớm',
        saoQuanLoc.any((s) => s.contains('Hóa Quyền'))
            ? 'Có Quyền tinh — bản lĩnh cầm trịch, dễ làm quản lý hoặc sáng lập'
            : saoQuanLoc.any((s) => s.contains('Hóa Lộc'))
                ? 'Có Lộc tinh — tiền đến từ công việc, làm ra tiền từ chính cái nghề của mình'
                : 'Đường công danh không có hóa — thành quả đến từ nỗ lực thực tế, không phải ơn trên ban',
      ],
      details: cd,
      extra: null,
    ));

    // ─────────── 7. TÀI BẠCH ───────────
    final tbText = TuViBinhGiaiChuDe.buildTaiBach(
      saoTai: saoTaiBach,
      diemTai: diemTai,
    );
    segments.add(_seg(
      icon: Icons.monetization_on_outlined,
      title: 'Tài Bạch Và Khả Năng Tích Lũy',
      keyPoints: [
        diemTai >= 2
            ? 'Tài vượng — tiền bạc đến đều và giữ được, là người có duyên với vật chất'
            : diemTai >= 0
                ? 'Tài tạm — kiếm được nhưng cần kỷ luật chi tiêu để không rỗng túi cuối tháng'
                : 'Tài yếu — đường tiền bạc gian nan, cần nhiều hơn một nguồn thu để vững',
        saoTaiBach.any((s) => s.contains('Lộc Tồn') || s.contains('Hóa Lộc'))
            ? 'Có lộc tinh hội tụ — tài chính dễ dư dả, đây là người không thiếu tiền tiêu'
            : saoTaiBach.any((s) => s.contains('Hóa Kỵ'))
                ? 'Có Kỵ tại Tài — cực kỳ thận trọng với tiền, đôi khi quá lo xa'
                : 'Không có hóa tại Tài — tiền bạc từ năng lực thực tế, không nhờ vận may',
      ],
      details: tbText,
      extra: _taiExtra(saoTaiBach, saoQuanLoc),
    ));

    // ─────────── 8. TÌNH CẢM ───────────
    final tcText = TuViBinhGiaiChuDe.buildTinhCam(
      saoPhuThe: saoPhuThe,
      diemPhuThe: diemPhuThe,
    );
    segments.add(_seg(
      icon: Icons.favorite_border,
      title: 'Tình Cảm Và Hôn Nhân',
      keyPoints: [
        diemPhuThe >= 1
            ? 'Tình duyên sáng — duyên đến đẹp, ít trắc trở, người đến với bạn là người tử tế'
            : diemPhuThe <= -1
                ? 'Tình duyên lắm sóng — yêu thương cần mạnh mẽ và tỉnh táo, đừng vội vàng cam kết'
                : 'Tình duyên trung bình — gặp được người hay không là ở cách bạn mở lòng thế nào',
        _getDaoHoaNote(saoPhuThe),
      ],
      details: tcText,
      extra: _buildGenderNote(isMale, saoPhuThe, saoMenh),
    ));

    // ─────────── 9. SỨC KHỎE ───────────
    final skText = TuViBinhGiaiChuDe.buildSucKhoe(
      saoTatAch: saoTatAch,
      diemTatAch: diemTatAch,
    );
    segments.add(_seg(
      icon: Icons.health_and_safety_outlined,
      title: 'Sức Khỏe Và Nội Tâm',
      keyPoints: [
        diemTatAch >= 0
            ? 'Cơ thể có nền — ít bệnh trọng, vấn đề thường từ tâm lý nhiều hơn thể chất'
            : 'Cơ thể dễ hao — áp lực kéo dài ảnh hưởng rõ đến sức khỏe, cần biết dừng đúng lúc',
        saoTatAch.any((s) => s.contains('Thiên Y'))
            ? 'Có Thiên Y — hợp chăm sóc sức khỏe, dễ khỏe lại sau ốm, hoặc làm nghề y'
            : 'Không Thiên Y — sức khỏe phụ thuộc vào nếp sống nhiều hơn là số phận',
      ],
      details: skText,
      extra: null,
    ));

    // ─────────── 10. CHA MẸ ───────────
    final cmText = TuViBinhGiaiChuDe.buildChaMeGiaDinhGoc(
      saoPhuMau: saoPhuMau,
      diemPhuMau: diemPhuMau,
    );
    segments.add(_seg(
      icon: Icons.family_restroom_outlined,
      title: 'Cha Mẹ Và Gia Đình Gốc',
      keyPoints: [
        diemPhuMau >= 0
            ? 'Cha mẹ là hậu thuẫn — gia đình cho bạn điểm tựa, nhờ đó dám bước xa'
            : 'Cha mẹ là bài học — những gì bạn vượt qua từ nhỏ giúp bạn cứng cáp hơn hẳn bạn bè',
      ],
      details: cmText,
      extra: null,
    ));

    // ─────────── 11. ANH EM, BẠN BÈ ───────────
    final aeText = TuViBinhGiaiChuDe.buildAnhEmBanBe(
      saoHuynhDe: saoHuynhDe,
      saoNoBoc: saoNoBoc,
      diemHuynhDe: diemHuynhDe,
      diemNoBoc: diemNoBoc,
    );
    segments.add(_seg(
      icon: Icons.groups_2_outlined,
      title: 'Anh Em, Bạn Bè Và Quan Hệ Xã Hội',
      keyPoints: [
        diemHuynhDe >= 0
            ? 'Anh em hòa — có người cùng chia sẻ gánh nặng gia đình'
            : 'Anh em phải giữ khoảng — không nên kỳ vọng quá nhiều vào tình thân ruột thịt',
        diemNoBoc >= 0
            ? 'Bạn bè là tài sản — mạng lưới quan hệ tốt, giúp được cả việc lẫn tinh thần'
            : 'Bạn bè cẩn thận — dễ kết giao sai người, mất nhiều hơn được nếu không biết chọn',
      ],
      details: aeText,
      extra: null,
    ));

    // ─────────── 12. CON CÁI ───────────
    final ccText = TuViBinhGiaiChuDe.buildConCaiHauVan(
      saoTuTuc: saoTuTuc,
      saoPhucDuc: saoPhucDuc,
      diemTuTuc: diemTuTuc,
      diemPhucDuc: diemPhucDuc,
    );
    segments.add(_seg(
      icon: Icons.child_care_outlined,
      title: 'Con Cái Và Hậu Vận',
      keyPoints: [
        diemTuTuc >= 0
            ? 'Con cái là niềm vui — có duyên với trẻ, con cái ngoan và có hiếu'
            : 'Con cái cần kiên nhẫn — mỗi đứa trẻ là một bài học, không nên áp đặt',
        diemPhucDuc >= 1
            ? 'Hậu vận tốt — cuối đời an nhàn, được chăm lo đầy đủ'
            : 'Hậu vận tùy cách sống — những gieo trồng hôm nay quyết định mùa gặt sau này',
      ],
      details: ccText,
      extra: null,
    ));

    // ─────────── 13. ĐIỂM MẠNH ───────────
    final tkText = TuViBinhGiaiChuDe.buildTongKet(
      diemMenh: diemMenh,
      diemTai: diemTai,
      diemQuan: diemQuan,
      diemPhuThe: diemPhuThe,
      diemTatAch: diemTatAch,
    );
    segments.add(_seg(
      icon: Icons.rule_folder_outlined,
      title: 'Điểm Mạnh Và Điều Cần Lưu Ý',
      keyPoints: [
        diemMenh >= 2
            ? 'Nội lực bản thân tốt — điểm tựa lớn nhất của đời bạn là chính bạn'
            : 'Nội lực trung bình — bạn mạnh nhất khi ở đúng môi trường, đừng cô lập mình',
        diemTai + diemQuan >= 3
            ? 'Tài-Quan đều sáng — cơ hội phát triển kinh tế và sự nghiệp rất tốt'
            : diemTai + diemQuan >= 0
                ? 'Tài-Quan ổn — không bùng nổ nhưng bền, hãy tập trung vào tích lũy dài hạn'
                : 'Tài-Quan yếu — con đường phải tự đi, không chờ đợi cơ hội từ bên ngoài',
      ],
      details: tkText,
      extra: null,
    ));

    // ─────────── 14. VẬN NĂM ───────────
    final int namHienTai = DateTime.now().year;
    final int namSinh = _extractNamSinh(tb);
    if (namSinh > 0) {
      final String cucStr = (tb['cuc'] ?? 'Thủy Nhị Cục').toString();
      final String canNamSinh = (tb['canNam'] ?? canChiNam.split(' ').first)
          .toString();
      final String chiNamSinhVal =
          (tb['chiNam'] ??
                  (canChiNam.split(' ').length > 1
                      ? canChiNam.split(' ')[1]
                      : 'Tý'))
              .toString();

      final luuNienData = TimeEngine.tinhLuuNien(
        namXem: namHienTai,
        namSinh: namSinh,
        chiNamSinh: chiNamSinhVal,
        cucString: cucStr,
        canNam: canNamSinh,
        chiMenh: cungMenh,
        isMale: isMale,
      );

      final String cungTH = luuNienData['cungTieuHan'] ?? '';
      final String cungDH = luuNienData['cungDaiHan'] ?? '';
      final List<String> saoCungTH = cungTH.isNotEmpty
          ? TuViBinhGiaiCore.mergeStarsForCung(cungTH, mC, mP)
          : <String>[];
      final List<String> saoCungDH = cungDH.isNotEmpty
          ? TuViBinhGiaiCore.mergeStarsForCung(cungDH, mC, mP)
          : <String>[];

      final String luanLuuNien = TimeEngine.luanLuuNien(
        luuNienData: luuNienData,
        saoCungTieuHan: saoCungTH,
        saoCungDaiHan: saoCungDH,
      );

      segments.add(_seg(
        icon: Icons.calendar_today_rounded,
        title: 'Vận Năm $namHienTai',
        keyPoints: [
          luuNienData['cungTieuHan'] != null
              ? 'Tiểu hạn tại cung ${luuNienData['cungTieuHan']} — ${_cungMoTaNhanh(luuNienData['cungTieuHan'] ?? '')}'
              : '',
          luuNienData['cungDaiHan'] != null
              ? 'Đại hạn tại cung ${luuNienData['cungDaiHan']} — ${_cungMoTaNhanh(luuNienData['cungDaiHan'] ?? '')}'
              : '',
          luuNienData['amDuong'] == 'Dương'
              ? 'Năm là năm Dương — vận động mạnh, hợp mở rộng thay vì co lại'
              : 'Năm là năm Âm — vận tĩnh tại, hợp củng cố thay vì mạo hiểm',
        ].where((k) => k.isNotEmpty).toList(),
        details: luanLuuNien,
        extra: null,
      ));
    }

    return segments;
  }

  static Map<String, dynamic> _seg({
    required IconData icon,
    required String title,
    required List<String> keyPoints,
    required String details,
    String? extra,
  }) {
    return {
      'icon': icon,
      'title': title,
      'keyPoints': keyPoints,
      'content': details,
      if (extra != null && extra.trim().isNotEmpty) 'extra': extra,
    };
  }

  static List<String> _extractKeyPoints(String text, int max) {
    final lines = text
        .split(RegExp(r'(?<=[.?!])\s+'))
        .where((l) => l.trim().length > 20)
        .take(max)
        .map((l) => l.trim().replaceAll(RegExp(r'[.?!]$'), ''))
        .toList();
    return lines;
  }

  static String _menhMoTaNhanh(int diem, List<String> sao, String cung) {
    final tuPhu = sao.any((s) => s.contains('Tử Vi') || s.contains('Thiên Phủ'));
    final satPhaTham = sao.any(
      (s) => s.contains('Thất Sát') || s.contains('Phá Quân') || s.contains('Tham Lang'),
    );
    final coNguyet = sao.any(
      (s) => s.contains('Thiên Cơ') || s.contains('Thái ÂM') || s.contains('Thiên Đồng') || s.contains('Thiên Lương'),
    );
    if (tuPhu) return 'Mệnh Tử Phủ — khí chất quyền uy, sinh ra để làm người đứng mũi chịu sào';
    if (satPhaTham) return 'Mệnh Sát Phá Tham — số máu lửa, càng va đập càng bật ra bản lĩnh';
    if (coNguyet) return 'Mệnh Cơ Nguyệt — trí tuệ là vũ khí, thông minh và nhạy cảm hơn người';
    return diem >= 2
        ? 'Mệnh tại $cung — nội lực tốt, tự biết mình muốn gì và đi về đâu'
        : 'Mệnh tại $cung — bản thân cần môi trường phù hợp để phát huy hết thế mạnh';
  }

  static String _taiMoTaNhanh(int diem, List<String> sao) {
    if (sao.any((s) => s.contains('Lộc Tồn') || s.contains('Hóa Lộc'))) {
      return 'Tài có Lộc — tiền đến đường nào cũng chảy về tay, đời không lo đói';
    }
    if (diem >= 2) return 'Tài vững — biết kiếm tiền, biết giữ tiền, tài chính là thế mạnh';
    if (diem <= -1) return 'Tài thử thách — tiền bạc dễ đến dễ đi, cần kỷ luật chi tiêu gắt';
    return 'Tài trung bình — đủ sống nếu biết quản lý, khó giàu nếu chỉ dựa vào một nguồn';
  }

  static String _quanMoTaNhanh(int diem, List<String> sao) {
    if (sao.any((s) => s.contains('Hóa Quyền'))) {
      return 'Quan có Quyền — làm gì cũng lên nhanh, có khả năng dẫn dắt người khác';
    }
    if (diem >= 2) return 'Quan sáng — hợp đường công danh, dễ đạt vị thế trong xã hội';
    if (diem <= -1) return 'Quan lận đận — không hợp làm thuê, phải tự làm chủ mới vững';
    return 'Quan ổn — thành công từ chất lượng hơn là tốc độ, kiên trì là chìa khóa';
  }

  static String _menhCucMoTaNhanh(String menhCuc) {
    if (menhCuc.contains('Cục sinh Mệnh')) return 'môi trường nâng đỡ bản thân';
    if (menhCuc.contains('Mệnh sinh Cục')) return 'bản thân phải nuôi hoàn cảnh';
    if (menhCuc.contains('Mệnh khắc Cục')) return 'ý chí phải lớn hơn nghịch cảnh';
    if (menhCuc.contains('Cục khắc Mệnh')) return 'hoàn cảnh tạo áp lực, rèn bản lĩnh';
    return 'thế hòa, không kỵ không sinh';
  }

  static String _getDaoHoaNote(List<String> sao) {
    final hop = sao.any((s) => s.contains('Hồng Loan'));
    final dao = sao.any((s) => s.contains('Đào Hoa'));
    if (hop && dao) return 'Hồng Loan + Đào Hoa — duyên đến sớm, đời sống tình cảm phong phú';
    if (hop) return 'Có Hồng Loan — duyên chính đẹp, dễ gặp đúng người đúng thời điểm';
    if (dao) return 'Có Đào Hoa — hấp dẫn tự nhiên, dễ được lòng người khác phái';
    if (sao.any((s) => s.contains('Cô Thần') || s.contains('Quả Tú'))) {
      return 'Cô Quả — sống nội tâm, hợp kết hôn muộn hoặc chọn người cùng tần số';
    }
    return '';
  }

  static String _tinhCachExtra(List<String> saoMenh, List<String> saoThan) {
    final parts = <String>[];
    if (saoMenh.any((s) => s.contains('Thiên Cơ'))) {
      parts.add('Thiên Cơ thủ Mệnh: đầu óc nhanh, học đâu nhớ đó, nếu thêm Văn Xương Văn Khúc thì càng xuất sắc.');
    }
    if (saoThan.isNotEmpty && saoThan.any((s) => s.contains('Thái Dương') || s.contains('Thái Âm'))) {
      parts.add('Thân cư Nhật Nguyệt: cuộc đời về sau càng ngày càng mở, muộn mà chắc.');
    }
    return parts.isNotEmpty ? parts.join('\n') : '';
  }

  static String _taiExtra(List<String> saoTai, List<String> saoQuan) {
    final parts = <String>[];
    final hasLoc = saoTai.any((s) => s.contains('Lộc Tồn') || s.contains('Hóa Lộc'));
    final hasQuanLoc = saoQuan.any((s) => s.contains('Lộc Tồn') || s.contains('Hóa Lộc'));
    if (hasLoc && hasQuanLoc) {
      parts.add('Lộc cả Tài lẫn Quan — tiền và chức đi cùng nhau, mạnh nhất khi làm việc lớn.');
    }
    return parts.isNotEmpty ? parts.join('\n') : '';
  }

  static String _cungMoTaNhanh(String cung) {
    switch (cung) {
      case 'Tý': return 'cung của khởi đầu, chuyện mới dễ nảy sinh';
      case 'Sửu': return 'cung của tích lũy, cần kiên nhẫn';
      case 'Dần': return 'cung của hành động, năng lượng dồi dào';
      case 'Mão': return 'cung của giao tiếp, dễ kết nối';
      case 'Thìn': return 'cung của uy quyền, vị thế dễ lộ';
      case 'Tỵ': return 'cung của trí tuệ, suy nghĩ sâu';
      case 'Ngọ': return 'cung của danh vọng, hào quang dễ tỏa';
      case 'Mùi': return 'cung của an nhàn, hưởng thụ';
      case 'Thân': return 'cung của dịch chuyển, cơ hội từ ngoài';
      case 'Dậu': return 'cung của tinh tế, thẩm mỹ cao';
      case 'Tuất': return 'cung của trách nhiệm, gánh nặng dễ thấy';
      case 'Hợi': return 'cung của tâm linh, chiều sâu nội tâm';
      default: return 'cung mang khí riêng';
    }
  }

  static String _buildGenderNote(
    bool isMale,
    List<String> saoPhuThe,
    List<String> saoMenh,
  ) {
    final hasDaoHoa = saoPhuThe.any(
      (s) => s.contains('Đào Hoa') || s.contains('Hồng Loan'),
    );
    final hasSat = saoPhuThe.any(
      (s) =>
          s.contains('Kình Dương') ||
          s.contains('Đà La') ||
          s.contains('Hóa Kỵ'),
    );
    final hasCoThan = saoMenh.any((s) => s.contains('Cô Thần'));
    final hasQuaTu = saoMenh.any((s) => s.contains('Quả Tú'));

    final List<String> parts = [];

    if (isMale) {
      if (hasDaoHoa) {
        parts.add(
          'Nam mệnh có Đào Hoa/Hồng Loan tại Phu Thê: duyên đến sớm, dễ có nhiều mối trước khi ổn định. Điều quan trọng là biết dừng đúng lúc.',
        );
      }
      if (hasSat) {
        parts.add(
          'Nam mệnh gặp sát tinh tại Phu Thê: tính mạnh, dễ áp đặt trong quan hệ. Muốn bền phải học cách lắng nghe, tránh biến gia đình thành nơi tranh thắng thua.',
        );
      }
      if (hasCoThan) {
        parts.add(
          'Cô Thần ở Mệnh nam: xu hướng tự lập rất cao, đôi khi độc lập đến mức khó mở lòng. Chủ động mềm hơn là điều cần tập.',
        );
      }
    } else {
      if (hasDaoHoa) {
        parts.add(
          'Nữ mệnh có Đào Hoa/Hồng Loan tại Phu Thê: duyên đẹp, dễ được để ý. Cần phân biệt người thật lòng và người chỉ bị thu hút bề ngoài.',
        );
      }
      if (hasSat) {
        parts.add(
          'Nữ mệnh gặp sát tinh tại Phu Thê: đường tình cảm không quá êm, dễ gặp người mạnh tính. Quan trọng là giữ tiêu chuẩn, không chấp nhận quan hệ bào mòn mình.',
        );
      }
      if (hasQuaTu) {
        parts.add(
          'Quả Tú ở Mệnh nữ: tính độc lập, tự chủ, khó tìm người đủ tầm đồng hành. Không phải cô đơn, mà là cần chọn đúng thời điểm.',
        );
      }
    }

    return parts.isNotEmpty ? parts.join('\n\n') : '';
  }

  /// Trích năm sinh dương lịch từ thienBan data (ưu tiên solarYear)
  static int _extractNamSinh(dynamic tb) {
    final solarYear = tb['solarYear'];
    if (solarYear is int && solarYear > 1900) return solarYear;
    final lunarYear = tb['lunarYear'];
    if (lunarYear is int && lunarYear > 1900) return lunarYear;
    return 0;
  }
}
