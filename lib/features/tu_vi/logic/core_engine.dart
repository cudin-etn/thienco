import 'package:vnlunar/vnlunar.dart';

class CoreEngine {
  static const List<String> listCan = [
    "Giáp",
    "Ất",
    "Bính",
    "Đinh",
    "Mậu",
    "Kỷ",
    "Canh",
    "Tân",
    "Nhâm",
    "Quý",
  ];
  static const List<String> chiChuan = [
    "Tý",
    "Sửu",
    "Dần",
    "Mão",
    "Thìn",
    "Tỵ",
    "Ngọ",
    "Mùi",
    "Thân",
    "Dậu",
    "Tuất",
    "Hợi",
  ];
  static const List<String> danhSach12Cung = [
    "Cung Mệnh",
    "Cung Huynh Đệ",
    "Cung Phu Thê",
    "Cung Tử Tức",
    "Cung Tài Bạch",
    "Cung Tật Ách",
    "Cung Thiên Di",
    "Cung Nô Bộc",
    "Cung Quan Lộc",
    "Cung Điền Trạch",
    "Cung Phúc Đức",
    "Cung Phụ Mẫu",
  ];

  /// Chuyển đổi giờ sinh từ nhiều format:
  /// - "HH:mm" (14:30) → tính ra Chi tương ứng
  /// - "Giờ Tý", "Tý", "Sửu"... → nhận diện trực tiếp
  static int _getHourIndex(String birthTime) {
    // Thử nhận diện tên Chi trước
    for (int i = 0; i < chiChuan.length; i++) {
      if (birthTime.contains(chiChuan[i])) return i + 1;
    }

    // Parse HH:mm hoặc HH
    final RegExp timeRegex = RegExp(r'(\d{1,2})\s*[:\-hH]\s*(\d{0,2})');
    final Match? match = timeRegex.firstMatch(birthTime);
    int hour = -1;

    if (match != null) {
      hour = int.tryParse(match.group(1) ?? '') ?? -1;
    } else {
      // Thử parse số thuần (VD: "14" hoặc "8")
      hour = int.tryParse(birthTime.trim()) ?? -1;
    }

    if (hour >= 0) {
      return _hourToChiIndex(hour);
    }

    return 1; // Default: Tý
  }

  /// Chuyển giờ (0-23) sang index Chi (1-12)
  /// Tý: 23-1, Sửu: 1-3, Dần: 3-5, Mão: 5-7, Thìn: 7-9, Tỵ: 9-11
  /// Ngọ: 11-13, Mùi: 13-15, Thân: 15-17, Dậu: 17-19, Tuất: 19-21, Hợi: 21-23
  static int _hourToChiIndex(int hour) {
    if (hour == 23 || hour == 0) return 1; // Tý
    if (hour >= 1 && hour < 3) return 2; // Sửu
    if (hour >= 3 && hour < 5) return 3; // Dần
    if (hour >= 5 && hour < 7) return 4; // Mão
    if (hour >= 7 && hour < 9) return 5; // Thìn
    if (hour >= 9 && hour < 11) return 6; // Tỵ
    if (hour >= 11 && hour < 13) return 7; // Ngọ
    if (hour >= 13 && hour < 15) return 8; // Mùi
    if (hour >= 15 && hour < 17) return 9; // Thân
    if (hour >= 17 && hour < 19) return 10; // Dậu
    if (hour >= 19 && hour < 21) return 11; // Tuất
    if (hour >= 21 && hour < 23) return 12; // Hợi
    return 1;
  }

  static String _tinhNguHanhMenh(String can, String chi) {
    // Bảng Nạp Âm 60 Giáp Tý chuẩn
    const Map<String, String> napAmTable = {
      'Giáp Tý': 'Hải Trung Kim',
      'Ất Sửu': 'Hải Trung Kim',
      'Bính Dần': 'Lô Trung Hỏa',
      'Đinh Mão': 'Lô Trung Hỏa',
      'Mậu Thìn': 'Đại Lâm Mộc',
      'Kỷ Tỵ': 'Đại Lâm Mộc',
      'Canh Ngọ': 'Lộ Bàng Thổ',
      'Tân Mùi': 'Lộ Bàng Thổ',
      'Nhâm Thân': 'Kiếm Phong Kim',
      'Quý Dậu': 'Kiếm Phong Kim',
      'Giáp Tuất': 'Sơn Đầu Hỏa',
      'Ất Hợi': 'Sơn Đầu Hỏa',
      'Bính Tý': 'Giản Hạ Thủy',
      'Đinh Sửu': 'Giản Hạ Thủy',
      'Mậu Dần': 'Thành Đầu Thổ',
      'Kỷ Mão': 'Thành Đầu Thổ',
      'Canh Thìn': 'Bạch Lạp Kim',
      'Tân Tỵ': 'Bạch Lạp Kim',
      'Nhâm Ngọ': 'Dương Liễu Mộc',
      'Quý Mùi': 'Dương Liễu Mộc',
      'Giáp Thân': 'Tuyền Trung Thủy',
      'Ất Dậu': 'Tuyền Trung Thủy',
      'Bính Tuất': 'Ốc Thượng Thổ',
      'Đinh Hợi': 'Ốc Thượng Thổ',
      'Mậu Tý': 'Tích Lịch Hỏa',
      'Kỷ Sửu': 'Tích Lịch Hỏa',
      'Canh Dần': 'Tùng Bách Mộc',
      'Tân Mão': 'Tùng Bách Mộc',
      'Nhâm Thìn': 'Trường Lưu Thủy',
      'Quý Tỵ': 'Trường Lưu Thủy',
      'Giáp Ngọ': 'Sa Trung Kim',
      'Ất Mùi': 'Sa Trung Kim',
      'Bính Thân': 'Sơn Hạ Hỏa',
      'Đinh Dậu': 'Sơn Hạ Hỏa',
      'Mậu Tuất': 'Bình Địa Mộc',
      'Kỷ Hợi': 'Bình Địa Mộc',
      'Canh Tý': 'Bích Thượng Thổ',
      'Tân Sửu': 'Bích Thượng Thổ',
      'Nhâm Dần': 'Kim Bạc Kim',
      'Quý Mão': 'Kim Bạc Kim',
      'Giáp Thìn': 'Phú Đăng Hỏa',
      'Ất Tỵ': 'Phú Đăng Hỏa',
      'Bính Ngọ': 'Thiên Hà Thủy',
      'Đinh Mùi': 'Thiên Hà Thủy',
      'Mậu Thân': 'Đại Trạch Thổ',
      'Kỷ Dậu': 'Đại Trạch Thổ',
      'Canh Tuất': 'Thoa Xuyến Kim',
      'Tân Hợi': 'Thoa Xuyến Kim',
      'Nhâm Tý': 'Tang Đố Mộc',
      'Quý Sửu': 'Tang Đố Mộc',
      'Giáp Dần': 'Đại Khê Thủy',
      'Ất Mão': 'Đại Khê Thủy',
      'Bính Thìn': 'Sa Trung Thổ',
      'Đinh Tỵ': 'Sa Trung Thổ',
      'Mậu Ngọ': 'Thiên Thượng Hỏa',
      'Kỷ Mùi': 'Thiên Thượng Hỏa',
      'Canh Thân': 'Thạch Lựu Mộc',
      'Tân Dậu': 'Thạch Lựu Mộc',
      'Nhâm Tuất': 'Đại Hải Thủy',
      'Quý Hợi': 'Đại Hải Thủy',
    };

    final String canChi = '$can $chi';
    final String? napAm = napAmTable[canChi];
    if (napAm != null) return napAm;

    // Fallback nếu không tìm thấy (không nên xảy ra)
    int canVal = ['Giáp', 'Ất'].contains(can)
        ? 1
        : ['Bính', 'Đinh'].contains(can)
        ? 2
        : ['Mậu', 'Kỷ'].contains(can)
        ? 3
        : ['Canh', 'Tân'].contains(can)
        ? 4
        : 5;
    int chiVal = ['Tý', 'Sửu', 'Ngọ', 'Mùi'].contains(chi)
        ? 0
        : ['Dần', 'Mão', 'Thân', 'Dậu'].contains(chi)
        ? 1
        : 2;
    int tong = canVal + chiVal;
    if (tong > 5) tong -= 5;
    if (tong == 1) return 'Kim';
    if (tong == 2) return 'Thủy';
    if (tong == 3) return 'Hỏa';
    if (tong == 4) return 'Thổ';
    return 'Mộc';
  }

  /// Trích ngũ hành chính từ Nạp Âm (dùng cho tính Cục)
  static String _nguHanhFromNapAm(String napAm) {
    if (napAm.contains('Kim')) return 'Hành Kim';
    if (napAm.contains('Mộc')) return 'Hành Mộc';
    if (napAm.contains('Thủy')) return 'Hành Thủy';
    if (napAm.contains('Hỏa')) return 'Hành Hỏa';
    if (napAm.contains('Thổ')) return 'Hành Thổ';
    return 'Hành Thủy';
  }

  static String _getCanCungMenh(String canNam, String chiMenh) {
    int canDanIndex = 0;
    if (['Giáp', 'Kỷ'].contains(canNam)) {
      canDanIndex = 6;
    } else if (['Ất', 'Canh'].contains(canNam)) {
      canDanIndex = 8;
    } else if (['Bính', 'Tân'].contains(canNam)) {
      canDanIndex = 0;
    } else if (['Đinh', 'Nhâm'].contains(canNam)) {
      canDanIndex = 2;
    } else if (['Mậu', 'Quý'].contains(canNam)) {
      canDanIndex = 4;
    }

    int distance = chiChuan.indexOf(chiMenh) - 2;
    if (distance < 0) distance += 12;
    return listCan[(canDanIndex + distance) % 10];
  }

  static String _tinhCuc(String canNam, String chiMenh) {
    final String canCungMenh = _getCanCungMenh(canNam, chiMenh);
    final String napAm = _tinhNguHanhMenh(canCungMenh, chiMenh);
    final String nguHanhCuc = _nguHanhFromNapAm(napAm);
    switch (nguHanhCuc) {
      case 'Hành Thủy':
        return 'Thủy Nhị Cục';
      case 'Hành Mộc':
        return 'Mộc Tam Cục';
      case 'Hành Kim':
        return 'Kim Tứ Cục';
      case 'Hành Thổ':
        return 'Thổ Ngũ Cục';
      case 'Hành Hỏa':
        return 'Hỏa Lục Cục';
      default:
        return 'Thủy Nhị Cục';
    }
  }

  /// Tính quan hệ sinh khắc giữa Ngũ Hành Mệnh và Ngũ Hành Cục
  static String _tinhMenhCucRelation(String nguHanhMenh, String cucString) {
    // Trích ngũ hành từ tên cục
    String hanhCuc = '';
    if (cucString.contains('Thủy')) {
      hanhCuc = 'Thủy';
    } else if (cucString.contains('Mộc')) {
      hanhCuc = 'Mộc';
    } else if (cucString.contains('Kim')) {
      hanhCuc = 'Kim';
    } else if (cucString.contains('Thổ')) {
      hanhCuc = 'Thổ';
    } else if (cucString.contains('Hỏa')) {
      hanhCuc = 'Hỏa';
    }

    // Trích ngũ hành từ mệnh
    String hanhMenh = '';
    if (nguHanhMenh.contains('Thủy')) {
      hanhMenh = 'Thủy';
    } else if (nguHanhMenh.contains('Mộc')) {
      hanhMenh = 'Mộc';
    } else if (nguHanhMenh.contains('Kim')) {
      hanhMenh = 'Kim';
    } else if (nguHanhMenh.contains('Thổ')) {
      hanhMenh = 'Thổ';
    } else if (nguHanhMenh.contains('Hỏa')) {
      hanhMenh = 'Hỏa';
    }

    if (hanhMenh.isEmpty || hanhCuc.isEmpty) return 'Bình hòa';
    if (hanhMenh == hanhCuc) return 'Bình hòa';

    // Vòng tương sinh: Mộc → Hỏa → Thổ → Kim → Thủy → Mộc
    const sinhMap = {
      'Mộc': 'Hỏa',
      'Hỏa': 'Thổ',
      'Thổ': 'Kim',
      'Kim': 'Thủy',
      'Thủy': 'Mộc',
    };

    if (sinhMap[hanhCuc] == hanhMenh) return 'Cục sinh Mệnh';
    if (sinhMap[hanhMenh] == hanhCuc) return 'Mệnh sinh Cục';

    // Vòng tương khắc: Mộc → Thổ → Thủy → Hỏa → Kim → Mộc
    const khacMap = {
      'Mộc': 'Thổ',
      'Thổ': 'Thủy',
      'Thủy': 'Hỏa',
      'Hỏa': 'Kim',
      'Kim': 'Mộc',
    };

    if (khacMap[hanhMenh] == hanhCuc) return 'Mệnh khắc Cục';
    if (khacMap[hanhCuc] == hanhMenh) return 'Cục khắc Mệnh';

    return 'Bình hòa';
  }

  static List<String> _anTriet(String canNam) {
    if (['Giáp', 'Kỷ'].contains(canNam)) return ['Thân', 'Dậu'];
    if (['Ất', 'Canh'].contains(canNam)) return ['Ngọ', 'Mùi'];
    if (['Bính', 'Tân'].contains(canNam)) return ['Thìn', 'Tỵ'];
    if (['Đinh', 'Nhâm'].contains(canNam)) return ['Dần', 'Mão'];
    if (['Mậu', 'Quý'].contains(canNam)) return ['Tý', 'Sửu'];
    return [];
  }

  static List<String> _anTuan(String canNam, String chiNam) {
    int k = (chiChuan.indexOf(chiNam) - listCan.indexOf(canNam)) % 12;
    if (k < 0) k += 12;
    int t1 = (k - 2) % 12;
    if (t1 < 0) t1 += 12;
    int t2 = (k - 1) % 12;
    if (t2 < 0) t2 += 12;
    return [chiChuan[t1], chiChuan[t2]];
  }

  static Map<String, dynamic> lapThienBan(String birthDate, String birthTime) {
    try {
      final parts = birthDate.split('/');
      final lunar = convertSolar2Lunar(
        int.parse(parts[0]),
        int.parse(parts[1]),
        int.parse(parts[2]),
        7,
      );

      // ĐÃ ÉP KIỂU VỀ SỐ NGUYÊN (as int) ĐỂ VƯỢT QUA LINTER
      final int lunarDay = lunar[0];
      final int lunarMonth = lunar[1];
      final int lunarYear = lunar[2];

      // Tính Can Chi Năm chuẩn xác cho năm 1988
      String canNam = listCan[(lunarYear - 4) % 10];
      String chiNam = chiChuan[(lunarYear - 4) % 12];
      int hourIndex = _getHourIndex(birthTime);

      int viTriMenh = (2 + (lunarMonth - 1) - (hourIndex - 1)) % 12;
      if (viTriMenh < 0) viTriMenh += 12;
      String chiMenh = chiChuan[viTriMenh];

      int viTriThan = (2 + (lunarMonth - 1) + (hourIndex - 1)) % 12;
      if (viTriThan < 0) viTriThan += 12;
      String cungThan = chiChuan[viTriThan];

      final String cucString = _tinhCuc(canNam, chiMenh);
      final String napAmMenh = _tinhNguHanhMenh(canNam, chiNam);
      final String nguHanhMenh = _nguHanhFromNapAm(napAmMenh);

      // Tính quan hệ Mệnh - Cục
      final String menhCucRelation = _tinhMenhCucRelation(
        nguHanhMenh,
        cucString,
      );

      final int solarYear = parts.length == 3 ? int.tryParse(parts[2]) ?? lunarYear : lunarYear;

      return {
        'canChiNam': '$canNam $chiNam',
        'canNam': canNam,
        'chiNam': chiNam,
        'menh': napAmMenh,
        'nguHanhMenh': nguHanhMenh,
        'cuc': cucString,
        'menhCuc': '$cucString ($menhCucRelation)',
        'banMenh': napAmMenh,
        'cungMenh': chiMenh,
        'gioAm': 'Giờ ${chiChuan[hourIndex - 1]}',
        'lunarDay': lunarDay,
        'lunarMonth': lunarMonth,
        'lunarYear': lunarYear,
        'solarYear': solarYear,
        'cungThan': cungThan,
        'triet': _anTriet(canNam),
        'tuan': _anTuan(canNam, chiNam),
      };
    } catch (e) {
      return {'canChiNam': 'Lỗi dữ liệu'};
    }
  }

  static Map<String, String> an12Cung(String chiMenh) {
    Map<String, String> map12Cung = {};
    int menhIndex = chiChuan.indexOf(chiMenh);
    for (int i = 0; i < 12; i++) {
      int currentIndex = (menhIndex - i) % 12;
      if (currentIndex < 0) currentIndex += 12;
      map12Cung[chiChuan[currentIndex]] = danhSach12Cung[i];
    }
    return map12Cung;
  }
}
