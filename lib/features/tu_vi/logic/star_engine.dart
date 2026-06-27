import 'core_engine.dart';

class StarEngine {
  static const Map<String, int> _cucWordToNumber = {
    'Nhất': 1,
    'Nhị': 2,
    'Tam': 3,
    'Tứ': 4,
    'Ngũ': 5,
    'Lục': 6,
  };

  static const Set<String> _duongCan = {'Giáp', 'Bính', 'Mậu', 'Canh', 'Nhâm'};

  static const List<String> _vongThaiTue = [
    'Thái Tuế',
    'Thiếu Dương',
    'Tang Môn',
    'Thiếu Âm',
    'Quan Phù',
    'Tử Phù',
    'Tuế Phá',
    'Long Đức',
    'Bạch Hổ',
    'Phúc Đức',
    'Điếu Khách',
    'Trực Phù',
  ];

  static const List<String> _vongTrangSinh = [
    'Tràng Sinh',
    'Mộc Dục',
    'Quan Đới',
    'Lâm Quan',
    'Đế Vượng',
    'Suy',
    'Bệnh',
    'Tử',
    'Mộ',
    'Tuyệt',
    'Thai',
    'Dưỡng',
  ];

  static int _heSoCuc(String cucString) {
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

  static int _timTuVi(int cuc, int ngaySinh) {
    int x = 1;
    while (x * cuc < ngaySinh) {
      x++;
    }
    final int y = x * cuc - ngaySinh;
    int tuViIndex = (y % 2 == 1) ? (2 + x - 1 - y) % 12 : (2 + x - 1 + y) % 12;
    if (tuViIndex < 0) tuViIndex += 12;
    return tuViIndex;
  }

  /// Bảng độ sáng chuẩn cho 14 Chính Tinh (Miếu/Vượng/Đắc/Hãm/Bình)
  static const Map<String, Map<String, String>> _doSangChinhTinh = {
    'Tử Vi': {
      'Tý': 'Đ', 'Sửu': 'Đ', 'Dần': 'H', 'Mão': 'H',
      'Thìn': 'V', 'Tỵ': 'V', 'Ngọ': 'M', 'Mùi': 'Đ',
      'Thân': 'H', 'Dậu': 'H', 'Tuất': 'V', 'Hợi': 'V',
    },
    'Thiên Cơ': {
      'Tý': 'H', 'Sửu': 'M', 'Dần': 'V', 'Mão': 'V',
      'Thìn': 'Đ', 'Tỵ': 'H', 'Ngọ': 'H', 'Mùi': 'M',
      'Thân': 'V', 'Dậu': 'V', 'Tuất': 'Đ', 'Hợi': 'H',
    },
    'Thái Dương': {
      'Tý': 'H', 'Sửu': 'H', 'Dần': 'V', 'Mão': 'V',
      'Thìn': 'Đ', 'Tỵ': 'M', 'Ngọ': 'M', 'Mùi': 'Đ',
      'Thân': 'V', 'Dậu': 'H', 'Tuất': 'H', 'Hợi': 'H',
    },
    'Vũ Khúc': {
      'Tý': 'M', 'Sửu': 'V', 'Dần': 'Đ', 'Mão': 'H',
      'Thìn': 'H', 'Tỵ': 'V', 'Ngọ': 'M', 'Mùi': 'V',
      'Thân': 'Đ', 'Dậu': 'H', 'Tuất': 'H', 'Hợi': 'V',
    },
    'Thiên Đồng': {
      'Tý': 'V', 'Sửu': 'H', 'Dần': 'V', 'Mão': 'H',
      'Thìn': 'H', 'Tỵ': 'V', 'Ngọ': 'M', 'Mùi': 'H',
      'Thân': 'V', 'Dậu': 'H', 'Tuất': 'H', 'Hợi': 'V',
    },
    'Liêm Trinh': {
      'Tý': 'M', 'Sửu': 'H', 'Dần': 'Đ', 'Mão': 'H',
      'Thìn': 'H', 'Tỵ': 'H', 'Ngọ': 'H', 'Mùi': 'M',
      'Thân': 'Đ', 'Dậu': 'H', 'Tuất': 'H', 'Hợi': 'H',
    },
    'Thiên Phủ': {
      'Tý': 'M', 'Sửu': 'V', 'Dần': 'M', 'Mão': 'V',
      'Thìn': 'Đ', 'Tỵ': 'Đ', 'Ngọ': 'M', 'Mùi': 'V',
      'Thân': 'M', 'Dậu': 'V', 'Tuất': 'Đ', 'Hợi': 'Đ',
    },
    'Thái Âm': {
      'Tý': 'M', 'Sửu': 'V', 'Dần': 'H', 'Mão': 'H',
      'Thìn': 'H', 'Tỵ': 'H', 'Ngọ': 'H', 'Mùi': 'H',
      'Thân': 'Đ', 'Dậu': 'V', 'Tuất': 'V', 'Hợi': 'M',
    },
    'Tham Lang': {
      'Tý': 'V', 'Sửu': 'H', 'Dần': 'Đ', 'Mão': 'M',
      'Thìn': 'V', 'Tỵ': 'H', 'Ngọ': 'V', 'Mùi': 'H',
      'Thân': 'Đ', 'Dậu': 'M', 'Tuất': 'V', 'Hợi': 'H',
    },
    'Cự Môn': {
      'Tý': 'V', 'Sửu': 'H', 'Dần': 'H', 'Mão': 'V',
      'Thìn': 'Đ', 'Tỵ': 'H', 'Ngọ': 'H', 'Mùi': 'H',
      'Thân': 'Đ', 'Dậu': 'V', 'Tuất': 'H', 'Hợi': 'H',
    },
    'Thiên Tướng': {
      'Tý': 'M', 'Sửu': 'V', 'Dần': 'M', 'Mão': 'V',
      'Thìn': 'Đ', 'Tỵ': 'H', 'Ngọ': 'M', 'Mùi': 'V',
      'Thân': 'M', 'Dậu': 'V', 'Tuất': 'Đ', 'Hợi': 'H',
    },
    'Thiên Lương': {
      'Tý': 'H', 'Sửu': 'Đ', 'Dần': 'M', 'Mão': 'V',
      'Thìn': 'V', 'Tỵ': 'Đ', 'Ngọ': 'M', 'Mùi': 'Đ',
      'Thân': 'M', 'Dậu': 'V', 'Tuất': 'V', 'Hợi': 'H',
    },
    'Thất Sát': {
      'Tý': 'M', 'Sửu': 'H', 'Dần': 'M', 'Mão': 'H',
      'Thìn': 'H', 'Tỵ': 'H', 'Ngọ': 'M', 'Mùi': 'H',
      'Thân': 'M', 'Dậu': 'H', 'Tuất': 'H', 'Hợi': 'H',
    },
    'Phá Quân': {
      'Tý': 'M', 'Sửu': 'H', 'Dần': 'H', 'Mão': 'H',
      'Thìn': 'M', 'Tỵ': 'H', 'Ngọ': 'M', 'Mùi': 'H',
      'Thân': 'H', 'Dậu': 'H', 'Tuất': 'M', 'Hợi': 'H',
    },
  };

  /// Trọng số cho từng mức độ sáng
  static const Map<String, int> _doSangWeight = {
    'M': 3,  // Miếu
    'V': 2,  // Vượng
    'Đ': 1,  // Đắc
    'B': 0,  // Bình
    'H': -1, // Hãm
  };

  static String _getDoSang(String sao, String chi) {
    final map = _doSangChinhTinh[sao];
    if (map != null && map.containsKey(chi)) return map[chi]!;
    return 'B';
  }

  static int getDoSangWeight(String sao, String chi) {
    final doSang = _getDoSang(sao, chi);
    return _doSangWeight[doSang] ?? 0;
  }

  static void _addSao(
    Map<String, List<String>> mapSao,
    String tenSao,
    int viTriIndex,
  ) {
    final String chi = CoreEngine.chiChuan[viTriIndex];
    final String doSang = _getDoSang(tenSao, chi);
    mapSao[chi]!.add('$tenSao ($doSang)');
  }

  static void _addRawSao(
    Map<String, List<String>> mapSao,
    int index,
    String tenSao,
  ) {
    mapSao[CoreEngine.chiChuan[_normalizeIndex(index)]]!.add(tenSao);
  }

  static int _normalizeIndex(int index) {
    int value = index % 12;
    if (value < 0) value += 12;
    return value;
  }

  static int _findHourIndex(String birthTime) {
    for (int i = 0; i < CoreEngine.chiChuan.length; i++) {
      if (birthTime.contains(CoreEngine.chiChuan[i])) {
        return i + 1;
      }
    }
    return 1;
  }

  static List<String> _tachCanChiNam(dynamic raw) {
    final String canChiNam = (raw ?? 'Giáp Tý').toString().trim();
    final List<String> parts = canChiNam.split(RegExp(r'\s+'));
    final String can = parts.isNotEmpty ? parts.first : 'Giáp';
    final String chi = parts.length > 1 ? parts[1] : 'Tý';
    return [can, chi];
  }

  static bool _isDiThuan(String canNam, bool isMale) {
    final bool isDuongCan = _duongCan.contains(canNam);
    return (isDuongCan && isMale) || (!isDuongCan && !isMale);
  }

  static Map<String, List<String>> an14ChinhTinh(
    int ngaySinh,
    String cucString,
  ) {
    final int tv = _timTuVi(_heSoCuc(cucString), ngaySinh);
    final int tp = (16 - tv) % 12;
    final Map<String, List<String>> mapSao = {
      for (final chi in CoreEngine.chiChuan) chi: <String>[],
    };

    _addSao(mapSao, 'Tử Vi', tv);
    _addSao(mapSao, 'Thiên Cơ', _normalizeIndex(tv - 1));
    _addSao(mapSao, 'Thái Dương', _normalizeIndex(tv - 3));
    _addSao(mapSao, 'Vũ Khúc', _normalizeIndex(tv - 4));
    _addSao(mapSao, 'Thiên Đồng', _normalizeIndex(tv - 5));
    _addSao(mapSao, 'Liêm Trinh', _normalizeIndex(tv - 8));

    _addSao(mapSao, 'Thiên Phủ', tp);
    _addSao(mapSao, 'Thái Âm', _normalizeIndex(tp + 1));
    _addSao(mapSao, 'Tham Lang', _normalizeIndex(tp + 2));
    _addSao(mapSao, 'Cự Môn', _normalizeIndex(tp + 3));
    _addSao(mapSao, 'Thiên Tướng', _normalizeIndex(tp + 4));
    _addSao(mapSao, 'Thiên Lương', _normalizeIndex(tp + 5));
    _addSao(mapSao, 'Thất Sát', _normalizeIndex(tp + 6));
    _addSao(mapSao, 'Phá Quân', _normalizeIndex(tp + 10));

    return mapSao;
  }

  static Map<String, List<String>> anPhuTinh(
    Map<String, dynamic> thienBanData,
    String birthTime, {
    bool isMale = true,
  }) {
    final Map<String, List<String>> mapPhu = {
      for (final chi in CoreEngine.chiChuan) chi: <String>[],
    };

    final int lunarMonth = thienBanData['lunarMonth'] ?? 1;
    final List<String> canChi = _tachCanChiNam(thienBanData['canChiNam']);
    final String canNam = canChi[0];
    final String chiNam = canChi[1];
    final String cucString = (thienBanData['cuc'] ?? 'Thủy Nhị Cục').toString();
    final int hourIndex = _findHourIndex(birthTime);

    _anBoTaHuuXuongKhuc(mapPhu, lunarMonth, hourIndex);
    _anBoLocTonKinhDa(mapPhu, canNam);
    _anBoKhongKiep(mapPhu, hourIndex);
    _anBoHoaLinh(mapPhu, chiNam, hourIndex);
    _anVongThaiTue(mapPhu, chiNam);
    _anVongTrangSinh(mapPhu, cucString, canNam, isMale);
    _anBoThienMaDaoHong(mapPhu, chiNam);
    _anBoKhoiViet(mapPhu, canNam);
    _anBoThienHinhThienRieu(mapPhu, lunarMonth);
    _anBoCoThanQuaTu(mapPhu, chiNam);
    _anBoLongTriPhuongCac(mapPhu, lunarMonth);
    _anBoThienYThienDuc(mapPhu, lunarMonth);
    _anBoBatToaTamThai(mapPhu, lunarMonth);
    _anBoAnQuangThienQuy(mapPhu, hourIndex);

    return mapPhu;
  }

  static void _anBoTaHuuXuongKhuc(
    Map<String, List<String>> mapPhu,
    int lunarMonth,
    int hourIndex,
  ) {
    _addRawSao(mapPhu, 4 + lunarMonth - 1, 'Tả Phù');
    _addRawSao(mapPhu, 10 - (lunarMonth - 1), 'Hữu Bật');
    _addRawSao(mapPhu, 4 + hourIndex - 1, 'Văn Khúc');
    _addRawSao(mapPhu, 10 - (hourIndex - 1), 'Văn Xương');
  }

  static void _anBoLocTonKinhDa(
    Map<String, List<String>> mapPhu,
    String canNam,
  ) {
    int locTonIdx = 0;
    if (canNam == 'Giáp') {
      locTonIdx = 2;
    } else if (canNam == 'Ất') {
      locTonIdx = 3;
    } else if (['Bính', 'Mậu'].contains(canNam)) {
      locTonIdx = 5;
    } else if (['Đinh', 'Kỷ'].contains(canNam)) {
      locTonIdx = 6;
    } else if (canNam == 'Canh') {
      locTonIdx = 8;
    } else if (canNam == 'Tân') {
      locTonIdx = 9;
    } else if (canNam == 'Nhâm') {
      locTonIdx = 11;
    } else if (canNam == 'Quý') {
      locTonIdx = 0;
    }

    _addRawSao(mapPhu, locTonIdx, 'Lộc Tồn');
    _addRawSao(mapPhu, locTonIdx + 1, 'Kình Dương');
    _addRawSao(mapPhu, locTonIdx - 1, 'Đà La');
  }

  static void _anBoKhongKiep(Map<String, List<String>> mapPhu, int hourIndex) {
    _addRawSao(mapPhu, 11 - (hourIndex - 1), 'Địa Không');
    _addRawSao(mapPhu, 11 + (hourIndex - 1), 'Địa Kiếp');
  }

  static void _anBoHoaLinh(
    Map<String, List<String>> mapPhu,
    String chiNam,
    int hourIndex,
  ) {
    // Hỏa Tinh: khởi thuận theo giờ
    // Linh Tinh: khởi nghịch theo giờ
    int hoaStart = 0;
    int linhStart = 0;

    if (['Dần', 'Ngọ', 'Tuất'].contains(chiNam)) {
      hoaStart = 2;  // Dần
      linhStart = 10; // Tuất
    } else if (['Thân', 'Tý', 'Thìn'].contains(chiNam)) {
      hoaStart = 3;  // Mão
      linhStart = 11; // Hợi
    } else if (['Tỵ', 'Dậu', 'Sửu'].contains(chiNam)) {
      hoaStart = 4;  // Thìn
      linhStart = 3;  // Mão
    } else if (['Hợi', 'Mão', 'Mùi'].contains(chiNam)) {
      hoaStart = 1;  // Sửu
      linhStart = 5;  // Tỵ
    }

    _addRawSao(mapPhu, hoaStart + (hourIndex - 1), 'Hỏa Tinh');
    _addRawSao(mapPhu, linhStart - (hourIndex - 1), 'Linh Tinh');
  }

  static void _anVongThaiTue(Map<String, List<String>> mapPhu, String chiNam) {
    final int thaiTueIdx = CoreEngine.chiChuan.indexOf(chiNam);
    final int startIdx = thaiTueIdx >= 0 ? thaiTueIdx : 0;

    for (int i = 0; i < 12; i++) {
      _addRawSao(mapPhu, startIdx + i, _vongThaiTue[i]);
    }
  }

  static void _anVongTrangSinh(
    Map<String, List<String>> mapPhu,
    String cucString,
    String canNam,
    bool isMale,
  ) {
    int trangSinhIdx = 0;
    if (cucString.contains('Mộc')) {
      trangSinhIdx = 11;
    } else if (cucString.contains('Thủy') || cucString.contains('Thổ')) {
      trangSinhIdx = 8;
    } else if (cucString.contains('Kim')) {
      trangSinhIdx = 5;
    } else if (cucString.contains('Hỏa')) {
      trangSinhIdx = 2;
    }

    final bool diThuan = _isDiThuan(canNam, isMale);
    for (int i = 0; i < 12; i++) {
      final int idx = diThuan ? (trangSinhIdx + i) : (trangSinhIdx - i);
      _addRawSao(mapPhu, idx, _vongTrangSinh[i]);
    }
  }

  static void _anBoThienMaDaoHong(
    Map<String, List<String>> mapPhu,
    String chiNam,
  ) {
    int thienMaIdx = 0;
    if (['Dần', 'Ngọ', 'Tuất'].contains(chiNam)) {
      thienMaIdx = 8;
    } else if (['Thân', 'Tý', 'Thìn'].contains(chiNam)) {
      thienMaIdx = 2;
    } else if (['Tỵ', 'Dậu', 'Sửu'].contains(chiNam)) {
      thienMaIdx = 11;
    } else if (['Hợi', 'Mão', 'Mùi'].contains(chiNam)) {
      thienMaIdx = 5;
    }
    _addRawSao(mapPhu, thienMaIdx, 'Thiên Mã');

    int daoHoaIdx = 0;
    if (['Dần', 'Ngọ', 'Tuất'].contains(chiNam)) {
      daoHoaIdx = 3;
    } else if (['Thân', 'Tý', 'Thìn'].contains(chiNam)) {
      daoHoaIdx = 9;
    } else if (['Tỵ', 'Dậu', 'Sửu'].contains(chiNam)) {
      daoHoaIdx = 6;
    } else if (['Hợi', 'Mão', 'Mùi'].contains(chiNam)) {
      daoHoaIdx = 0;
    }
    _addRawSao(mapPhu, daoHoaIdx, 'Đào Hoa');

    final int chiNamIdx = CoreEngine.chiChuan.indexOf(chiNam);
    final int normalizedChiNamIdx = chiNamIdx >= 0 ? chiNamIdx : 0;
    final int hongLoanIdx = _normalizeIndex(3 - normalizedChiNamIdx);
    _addRawSao(mapPhu, hongLoanIdx, 'Hồng Loan');
    _addRawSao(mapPhu, hongLoanIdx + 6, 'Thiên Hỷ');
  }

  static void _anBoKhoiViet(Map<String, List<String>> mapPhu, String canNam) {
    int khoiIdx = 0;
    int vietIdx = 0;

    if (['Giáp', 'Mậu'].contains(canNam)) {
      khoiIdx = 1;
      vietIdx = 7;
    } else if (['Ất', 'Kỷ'].contains(canNam)) {
      khoiIdx = 0;
      vietIdx = 8;
    } else if (['Bính', 'Đinh'].contains(canNam)) {
      khoiIdx = 11;
      vietIdx = 9;
    } else if (['Nhâm', 'Quý'].contains(canNam)) {
      khoiIdx = 3;
      vietIdx = 5;
    } else if (['Canh', 'Tân'].contains(canNam)) {
      khoiIdx = 6;
      vietIdx = 2;
    }

    _addRawSao(mapPhu, khoiIdx, 'Thiên Khôi');
    _addRawSao(mapPhu, vietIdx, 'Thiên Việt');
  }

  /// An Thiên Hình, Thiên Riêu theo tháng sinh
  static void _anBoThienHinhThienRieu(
    Map<String, List<String>> mapPhu,
    int lunarMonth,
  ) {
    // Thiên Hình: khởi Dậu (index 9), thuận theo tháng
    _addRawSao(mapPhu, 9 + (lunarMonth - 1), 'Thiên Hình');
    // Thiên Riêu: khởi Sửu (index 1), thuận theo tháng
    _addRawSao(mapPhu, 1 + (lunarMonth - 1), 'Thiên Riêu');
    // Thiên Y: khởi Sửu (index 1), thuận theo tháng + 1
    // (Thiên Y = tháng + 1 kể từ Sửu)
  }

  /// An Cô Thần, Quả Tú theo Chi năm sinh
  static void _anBoCoThanQuaTu(
    Map<String, List<String>> mapPhu,
    String chiNam,
  ) {
    int coThanIdx = 0;
    int quaTuIdx = 0;

    if (['Dần', 'Mão', 'Thìn'].contains(chiNam)) {
      coThanIdx = 5; // Tỵ
      quaTuIdx = 1; // Sửu
    } else if (['Tỵ', 'Ngọ', 'Mùi'].contains(chiNam)) {
      coThanIdx = 8; // Thân
      quaTuIdx = 4; // Thìn
    } else if (['Thân', 'Dậu', 'Tuất'].contains(chiNam)) {
      coThanIdx = 11; // Hợi
      quaTuIdx = 7; // Mùi
    } else if (['Hợi', 'Tý', 'Sửu'].contains(chiNam)) {
      coThanIdx = 2; // Dần
      quaTuIdx = 10; // Tuất
    }

    _addRawSao(mapPhu, coThanIdx, 'Cô Thần');
    _addRawSao(mapPhu, quaTuIdx, 'Quả Tú');
  }

  /// An Long Trì, Phượng Các theo tháng sinh
  static void _anBoLongTriPhuongCac(
    Map<String, List<String>> mapPhu,
    int lunarMonth,
  ) {
    // Long Trì: khởi Thìn (index 4), thuận theo tháng
    _addRawSao(mapPhu, 4 + (lunarMonth - 1), 'Long Trì');
    // Phượng Các: khởi Tuất (index 10), nghịch theo tháng
    _addRawSao(mapPhu, 10 - (lunarMonth - 1), 'Phượng Các');
  }

  /// An Thiên Y, Thiên Đức, Nguyệt Đức theo tháng sinh
  static void _anBoThienYThienDuc(
    Map<String, List<String>> mapPhu,
    int lunarMonth,
  ) {
    // Thiên Y: tháng Giêng tại Sửu, thuận hành
    _addRawSao(mapPhu, 1 + (lunarMonth - 1), 'Thiên Y');
    // Thiên Đức: tháng Giêng tại Dậu (index 9), thuận hành
    _addRawSao(mapPhu, 9 + (lunarMonth - 1), 'Thiên Đức');
    // Nguyệt Đức: tháng Giêng tại Tỵ (index 5), thuận hành
    _addRawSao(mapPhu, 5 + (lunarMonth - 1), 'Nguyệt Đức');
  }

  /// An Tứ Hóa theo Can năm sinh
  /// Tứ Hóa gắn vào sao chính tinh/phụ tinh đã an sẵn
  static Map<String, String> anTuHoa(String canNam) {
    // Map: Can năm → [Hóa Lộc, Hóa Quyền, Hóa Khoa, Hóa Kỵ]
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

    final List<String> saoHoa = tuHoaTable[canNam] ?? tuHoaTable['Giáp']!;
    return {
      saoHoa[0]: 'Hóa Lộc',
      saoHoa[1]: 'Hóa Quyền',
      saoHoa[2]: 'Hóa Khoa',
      saoHoa[3]: 'Hóa Kỵ',
    };
  }

  /// An Bát Tọa (khởi Thìn, thuận tháng) và Tam Thai (khởi Thìn, thuận tháng)
  static void _anBoBatToaTamThai(
    Map<String, List<String>> mapPhu,
    int lunarMonth,
  ) {
    _addRawSao(mapPhu, 4 + (lunarMonth - 1), 'Bát Tọa');
    _addRawSao(mapPhu, 10 + (lunarMonth - 1), 'Tam Thai');
  }

  /// An Ân Quang (khởi Thìn, thuận giờ) và Thiên Quý (khởi Tuất, thuận giờ)
  static void _anBoAnQuangThienQuy(
    Map<String, List<String>> mapPhu,
    int hourIndex,
  ) {
    _addRawSao(mapPhu, 4 + (hourIndex - 1), 'Ân Quang');
    _addRawSao(mapPhu, 10 + (hourIndex - 1), 'Thiên Quý');
  }

  /// Gắn Tứ Hóa vào map sao đã an (chính tinh + phụ tinh)
  static void applyTuHoa(
    Map<String, List<String>> mapChinhTinh,
    Map<String, List<String>> mapPhuTinh,
    String canNam,
  ) {
    final Map<String, String> tuHoa = anTuHoa(canNam);

    for (final entry in tuHoa.entries) {
      final String targetStar = entry.key;
      final String hoaName = entry.value;
      bool found = false;

      // Tìm trong chính tinh
      for (final chi in CoreEngine.chiChuan) {
        final List<String> stars = mapChinhTinh[chi] ?? [];
        for (int i = 0; i < stars.length; i++) {
          if (stars[i].split(' (').first.trim() == targetStar) {
            mapChinhTinh[chi]![i] = '${stars[i]} [$hoaName]';
            found = true;
            break;
          }
        }
        if (found) break;
      }

      if (found) continue;

      // Tìm trong phụ tinh
      for (final chi in CoreEngine.chiChuan) {
        final List<String> stars = mapPhuTinh[chi] ?? [];
        for (int i = 0; i < stars.length; i++) {
          if (stars[i].split(' (').first.split(' [').first.trim() ==
              targetStar) {
            mapPhuTinh[chi]![i] = '${stars[i]} [$hoaName]';
            found = true;
            break;
          }
        }
        if (found) break;
      }

      // Nếu không tìm thấy sao (trường hợp hiếm), thêm Hóa vào cung Mệnh
      if (!found) {
        mapPhuTinh[CoreEngine.chiChuan[0]]!.add(hoaName);
      }
    }
  }
}
