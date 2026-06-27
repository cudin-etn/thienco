import 'core_engine.dart';

class TimeEngine {
  static const int _maxSupportedAge = 100;
  static const Map<String, int> _cucWordToNumber = {
    'Nhất': 1,
    'Nhị': 2,
    'Tam': 3,
    'Tứ': 4,
    'Ngũ': 5,
    'Lục': 6,
  };

  static const Set<String> _duongCan = {'Giáp', 'Bính', 'Mậu', 'Canh', 'Nhâm'};

  static const List<List<String>> _tamHopGroups = [
    ['Dần', 'Ngọ', 'Tuất'],
    ['Thân', 'Tý', 'Thìn'],
    ['Tỵ', 'Dậu', 'Sửu'],
    ['Hợi', 'Mão', 'Mùi'],
  ];

  static const Map<int, String> _tamHopKhoiCung = {
    0: 'Thìn',
    1: 'Tuất',
    2: 'Mùi',
    3: 'Sửu',
  };

  static Map<String, int> tinhDaiHan(
    String cucString,
    String canNam,
    String chiMenh, {
    bool isMale = true,
  }) {
    final Map<String, int> mapDaiHan = {};
    final int cucSo = _parseCucSo(cucString);
    final bool diThuan = _isDiThuan(canNam: canNam, isMale: isMale);
    final int menhIdx = CoreEngine.chiChuan.indexOf(chiMenh);
    final int startIdx = menhIdx >= 0
        ? menhIdx
        : CoreEngine.chiChuan.indexOf('Tỵ');

    for (int i = 0; i < 12; i++) {
      final int viTri = _moveIndex(startIdx, i, diThuan);
      mapDaiHan[CoreEngine.chiChuan[viTri]] = cucSo + (i * 10);
    }
    return mapDaiHan;
  }

  static Map<String, String> tinhTieuHan(
    String chiNamSinh, {
    bool isMale = true,
  }) {
    final Map<String, String> mapTieuHan = {};
    final List<String> chi = CoreEngine.chiChuan;
    final int khoiIdx = _timKhoiTieuHanIndex(chiNamSinh);

    for (int i = 0; i < 12; i++) {
      final int viTri = _moveIndex(khoiIdx, i, isMale);
      mapTieuHan[chi[viTri]] = chi[i];
    }
    return mapTieuHan;
  }

  static List<Map<String, dynamic>> lapBangDaiHan(
    String cucString,
    String canNam,
    String chiMenh, {
    bool isMale = true,
  }) {
    final Map<String, int> raw = tinhDaiHan(
      cucString,
      canNam,
      chiMenh,
      isMale: isMale,
    );

    return CoreEngine.chiChuan
        .where((chi) => raw.containsKey(chi))
        .map((chi) {
          final int tuoiBatDau = raw[chi]!;
          final int tuoiKetThuc = tuoiBatDau + 9;
          return {
            'cungChi': chi,
            'tuoiBatDau': tuoiBatDau,
            'tuoiKetThuc': tuoiKetThuc > _maxSupportedAge
                ? _maxSupportedAge
                : tuoiKetThuc,
          };
        })
        .where((item) => (item['tuoiBatDau'] as int) <= _maxSupportedAge)
        .toList();
  }

  static List<Map<String, dynamic>> lapBangTieuHan(
    String chiNamSinh, {
    bool isMale = true,
  }) {
    final Map<String, String> raw = tinhTieuHan(chiNamSinh, isMale: isMale);

    return CoreEngine.chiChuan
        .where((chi) => raw.containsKey(chi))
        .map((chi) => {'cungChi': chi, 'chiNamUng': raw[chi]!})
        .toList();
  }

  static int _parseCucSo(String cucString) {
    final String normalized = cucString.trim();

    final RegExp numberRegex = RegExp(r'(\d+)');
    final Match? directNumber = numberRegex.firstMatch(normalized);
    if (directNumber != null) {
      return int.tryParse(directNumber.group(1) ?? '') ?? 2;
    }

    for (final entry in _cucWordToNumber.entries) {
      if (normalized.contains(entry.key)) {
        return entry.value;
      }
    }

    return 2;
  }

  static bool _isDiThuan({required String canNam, required bool isMale}) {
    final bool isDuongCan = _duongCan.contains(canNam);
    return (isDuongCan && isMale) || (!isDuongCan && !isMale);
  }

  static int _timKhoiTieuHanIndex(String chiNamSinh) {
    final int groupIndex = _tamHopGroups.indexWhere(
      (group) => group.contains(chiNamSinh),
    );

    final String khoiChi =
        _tamHopKhoiCung[groupIndex >= 0 ? groupIndex : 3] ?? 'Sửu';
    final int idx = CoreEngine.chiChuan.indexOf(khoiChi);
    return idx >= 0 ? idx : CoreEngine.chiChuan.indexOf('Sửu');
  }

  static int _moveIndex(int startIdx, int offset, bool diThuan) {
    final int delta = diThuan ? offset : -offset;
    int viTri = (startIdx + delta) % 12;
    if (viTri < 0) viTri += 12;
    return viTri;
  }

  /// Tính Lưu Niên cho một năm cụ thể
  /// Trả về cung mà tiểu hạn rơi vào trong năm đó + các sao lưu niên
  static Map<String, dynamic> tinhLuuNien({
    required int namXem,
    required int namSinh,
    required String chiNamSinh,
    required String cucString,
    required String canNam,
    required String chiMenh,
    bool isMale = true,
  }) {
    // 1. Xác định tuổi (tuổi mụ)
    final int tuoiMu = namXem - namSinh + 1;

    // 2. Xác định Can Chi năm xem
    final String canNamXem = CoreEngine.listCan[(namXem - 4) % 10];
    final String chiNamXem = CoreEngine.chiChuan[(namXem - 4) % 12];

    // 3. Xác định cung Tiểu Hạn năm xem
    final Map<String, String> mapTieuHan = tinhTieuHan(
      chiNamSinh,
      isMale: isMale,
    );
    String cungTieuHan = '';
    for (final entry in mapTieuHan.entries) {
      if (entry.value == chiNamXem) {
        cungTieuHan = entry.key;
        break;
      }
    }
    if (cungTieuHan.isEmpty) cungTieuHan = chiMenh;

    // 4. Xác định cung Đại Hạn hiện tại
    final Map<String, int> mapDaiHan = tinhDaiHan(
      cucString,
      canNam,
      chiMenh,
      isMale: isMale,
    );
    String cungDaiHan = '';
    int tuoiDaiHanBatDau = 0;
    for (final entry in mapDaiHan.entries) {
      final int start = entry.value;
      final int end = start + 9;
      if (tuoiMu >= start && tuoiMu <= end) {
        cungDaiHan = entry.key;
        tuoiDaiHanBatDau = start;
        break;
      }
    }

    // 5. Tính Lưu Niên Tinh (sao lưu niên theo Can năm xem)
    final Map<String, String> luuNienTinh = _tinhLuuNienTinh(canNamXem);

    // 6. Tính Thái Tuế lưu niên (vòng Thái Tuế theo Chi năm xem)
    final int thaiTueIdx = CoreEngine.chiChuan.indexOf(chiNamXem);

    return {
      'namXem': namXem,
      'tuoiMu': tuoiMu,
      'canChiNamXem': '$canNamXem $chiNamXem',
      'cungTieuHan': cungTieuHan,
      'cungDaiHan': cungDaiHan,
      'tuoiDaiHanBatDau': tuoiDaiHanBatDau,
      'luuNienTinh': luuNienTinh,
      'thaiTueLuuNien': thaiTueIdx >= 0 ? thaiTueIdx : 0,
    };
  }

  /// Tính Lưu Niên Tinh theo Can năm xem (Tứ Hóa lưu niên)
  static Map<String, String> _tinhLuuNienTinh(String canNamXem) {
    // Tứ Hóa lưu niên = Tứ Hóa theo Can năm đang xem
    const Map<String, List<String>> tuHoaTable = {
      'Giáp': ['Liêm Trinh', 'Phá Quân', 'Vũ Khúc', 'Thái Dương'],
      'Ất': ['Thiên Cơ', 'Thiên Lương', 'Tử Vi', 'Thái Âm'],
      'Bính': ['Thiên Đồng', 'Thiên Cơ', 'Văn Xương', 'Liêm Trinh'],
      'Đinh': ['Thái Âm', 'Thiên Đồng', 'Thiên Cơ', 'Cự Môn'],
      'Mậu': ['Tham Lang', 'Thái Âm', 'Hữu Bật', 'Thiên Cơ'],
      'Kỷ': ['Vũ Khúc', 'Tham Lang', 'Thiên Lương', 'Văn Khúc'],
      'Canh': ['Thái Dương', 'Vũ Khúc', 'Thái Âm', 'Thiên Đồng'],
      'Tân': ['Cự Môn', 'Thái Dương', 'Văn Khúc', 'Văn Xương'],
      'Nhâm': ['Thiên Lương', 'Tử Vi', 'Tả Phù', 'Vũ Khúc'],
      'Quý': ['Phá Quân', 'Cự Môn', 'Thái Âm', 'Tham Lang'],
    };

    final List<String> saoHoa = tuHoaTable[canNamXem] ?? tuHoaTable['Giáp']!;
    return {
      'hoaLoc': saoHoa[0],
      'hoaQuyen': saoHoa[1],
      'hoaKhoa': saoHoa[2],
      'hoaKy': saoHoa[3],
    };
  }

  /// Luận giải lưu niên ngắn gọn
  static String luanLuuNien({
    required Map<String, dynamic> luuNienData,
    required List<String> saoCungTieuHan,
    required List<String> saoCungDaiHan,
  }) {
    final int tuoiMu = luuNienData['tuoiMu'] ?? 0;
    final String canChiNam = luuNienData['canChiNamXem'] ?? '--';
    final String cungTH = luuNienData['cungTieuHan'] ?? '--';
    final String cungDH = luuNienData['cungDaiHan'] ?? '--';
    final Map<String, String> luuNienTinh = Map<String, String>.from(
      luuNienData['luuNienTinh'] ?? {},
    );

    final List<String> parts = [];

    parts.add(
      'Năm $canChiNam (tuổi mụ $tuoiMu), tiểu hạn tại cung $cungTH, đại hạn đang ở cung $cungDH.',
    );

    // Phân tích Tứ Hóa lưu niên
    final String hoaLoc = luuNienTinh['hoaLoc'] ?? '';
    final String hoaKy = luuNienTinh['hoaKy'] ?? '';

    if (hoaLoc.isNotEmpty) {
      final bool locTrongTieuHan = saoCungTieuHan.any(
        (s) => s.contains(hoaLoc),
      );
      if (locTrongTieuHan) {
        parts.add(
          'Hóa Lộc lưu niên chiếu vào cung tiểu hạn qua sao $hoaLoc, cho thấy năm nay có cửa mở về tài lộc hoặc cơ hội phát triển nếu biết nắm đúng thời điểm.',
        );
      }
    }

    if (hoaKy.isNotEmpty) {
      final bool kyTrongTieuHan = saoCungTieuHan.any((s) => s.contains(hoaKy));
      if (kyTrongTieuHan) {
        parts.add(
          'Hóa Kỵ lưu niên rơi vào cung tiểu hạn qua sao $hoaKy, báo hiệu năm nay có nút thắt cần xử lý tỉnh táo. Tránh quyết định lớn khi cảm xúc đang cao.',
        );
      }
    }

    // Phân tích sao tại cung tiểu hạn
    final int catTH = saoCungTieuHan
        .where(
          (s) =>
              s.contains('Tả Phù') ||
              s.contains('Hữu Bật') ||
              s.contains('Thiên Khôi') ||
              s.contains('Thiên Việt') ||
              s.contains('Lộc Tồn') ||
              s.contains('Hóa Lộc') ||
              s.contains('Hóa Quyền') ||
              s.contains('Hóa Khoa'),
        )
        .length;
    final int satTH = saoCungTieuHan
        .where(
          (s) =>
              s.contains('Kình Dương') ||
              s.contains('Đà La') ||
              s.contains('Hỏa Tinh') ||
              s.contains('Linh Tinh') ||
              s.contains('Địa Không') ||
              s.contains('Địa Kiếp') ||
              s.contains('Hóa Kỵ'),
        )
        .length;

    if (catTH >= satTH + 2) {
      parts.add(
        'Nhìn tổng thể, năm nay nghiêng về chiều thuận: dễ gặp cơ hội, có quý nhân trợ lực và nếu đi đúng nhịp thì thành quả khá rõ.',
      );
    } else if (satTH >= catTH + 2) {
      parts.add(
        'Nhìn tổng thể, năm nay có nhiều thử thách hơn bình thường. Nên giữ nhịp ổn định, tránh mạo hiểm lớn và ưu tiên bảo toàn nền tảng đã có.',
      );
    } else {
      parts.add(
        'Nhìn tổng thể, năm nay cát hung đan xen, kết quả phụ thuộc nhiều vào cách chọn thời điểm và khả năng giữ bình tĩnh trước biến động.',
      );
    }

    // Gợi ý theo quý
    parts.add(_goiYTheoQuy(saoCungTieuHan, catTH, satTH));

    return parts.where((e) => e.trim().isNotEmpty).join('\n\n');
  }

  static String _goiYTheoQuy(List<String> sao, int cat, int sat) {
    final bool hasThienMa = sao.any((s) => s.contains('Thiên Mã'));
    final bool hasDaoHoa = sao.any(
      (s) => s.contains('Đào Hoa') || s.contains('Hồng Loan'),
    );
    final bool hasLoc = sao.any(
      (s) => s.contains('Lộc Tồn') || s.contains('Hóa Lộc'),
    );

    final List<String> goiY = [];

    if (hasThienMa) {
      goiY.add(
        'Năm có Thiên Mã chiếu nên hợp dịch chuyển, đổi môi trường hoặc mở rộng địa bàn hoạt động.',
      );
    }
    if (hasDaoHoa) {
      goiY.add(
        'Năm có sao đào hoa nên duyên phận dễ động, quan hệ xã hội mở rộng. Nếu đang độc thân thì đây là năm dễ gặp người mới.',
      );
    }
    if (hasLoc) {
      goiY.add(
        'Năm có lộc khí nên ưu tiên các việc liên quan tài chính, đầu tư hoặc phát triển nguồn thu nhập mới.',
      );
    }
    if (sat > cat) {
      goiY.add(
        'Quý 1-2 nên giữ ổn định, tránh thay đổi lớn. Quý 3-4 nếu đã qua giai đoạn khó thì có thể bắt đầu mở rộng dần.',
      );
    }

    return goiY.join(' ');
  }
}
