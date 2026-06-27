/// Tính toán giờ hoàng đạo, hắc đạo, hướng xuất hành và việc nên/kiêng theo ngày
class DailyCalculator {
  static const List<String> _listChi = [
    'Tý',
    'Sửu',
    'Dần',
    'Mão',
    'Thìn',
    'Tỵ',
    'Ngọ',
    'Mùi',
    'Thân',
    'Dậu',
    'Tuất',
    'Hợi',
  ];

  /// 6 giờ Hoàng Đạo trong ngày dựa trên Chi ngày
  /// Công thức: Dựa theo bảng Thanh Long, Minh Đường, Kim Quỹ, Thiên Đức, Ngọc Đường, Tư Mệnh
  static List<String> gioHoangDao(String chiNgay) {
    // Bảng giờ Hoàng Đạo theo Chi ngày (6 giờ tốt)
    const Map<String, List<String>> hoangDaoTable = {
      'Tý': ['Tý', 'Sửu', 'Mão', 'Ngọ', 'Thân', 'Dậu'],
      'Sửu': ['Dần', 'Mão', 'Tỵ', 'Thân', 'Tuất', 'Hợi'],
      'Dần': ['Tý', 'Sửu', 'Thìn', 'Tỵ', 'Mùi', 'Tuất'],
      'Mão': ['Tý', 'Dần', 'Mão', 'Ngọ', 'Mùi', 'Dậu'],
      'Thìn': ['Tý', 'Sửu', 'Thìn', 'Tỵ', 'Thân', 'Dậu'],
      'Tỵ': ['Dần', 'Mão', 'Ngọ', 'Mùi', 'Tuất', 'Hợi'],
      'Ngọ': ['Tý', 'Sửu', 'Mão', 'Ngọ', 'Thân', 'Dậu'],
      'Mùi': ['Dần', 'Mão', 'Tỵ', 'Thân', 'Tuất', 'Hợi'],
      'Thân': ['Tý', 'Sửu', 'Thìn', 'Tỵ', 'Mùi', 'Tuất'],
      'Dậu': ['Tý', 'Dần', 'Mão', 'Ngọ', 'Mùi', 'Dậu'],
      'Tuất': ['Tý', 'Sửu', 'Thìn', 'Tỵ', 'Thân', 'Dậu'],
      'Hợi': ['Dần', 'Mão', 'Ngọ', 'Mùi', 'Tuất', 'Hợi'],
    };

    return hoangDaoTable[chiNgay] ?? ['Tý', 'Sửu', 'Mão', 'Ngọ', 'Thân', 'Dậu'];
  }

  /// 6 giờ Hắc Đạo (giờ xấu) = 12 chi - 6 giờ hoàng đạo
  static List<String> gioHacDao(String chiNgay) {
    final hoangDao = gioHoangDao(chiNgay);
    return _listChi.where((chi) => !hoangDao.contains(chi)).toList();
  }

  /// Trực trong ngày (12 Trực: Kiến, Trừ, Mãn, Bình, Định, Chấp, Phá, Nguy, Thành, Thu, Khai, Bế)
  static String trucNgay(int lunarMonth, int lunarDay) {
    const List<String> danhSachTruc = [
      'Kiến',
      'Trừ',
      'Mãn',
      'Bình',
      'Định',
      'Chấp',
      'Phá',
      'Nguy',
      'Thành',
      'Thu',
      'Khai',
      'Bế',
    ];
    // Trực Kiến bắt đầu từ Chi tháng, mỗi ngày tiến 1
    final int startIdx = (lunarMonth - 1) % 12;
    final int trucIdx = (startIdx + lunarDay - 1) % 12;
    return danhSachTruc[trucIdx];
  }

  /// Việc nên làm theo Trực ngày
  static Map<String, dynamic> viecNenKieng(String truc) {
    const Map<String, Map<String, dynamic>> trucData = {
      'Kiến': {
        'nen': 'Xuất hành, khai trương, nhậm chức, cầu tài',
        'kieng': 'Động thổ, phá dỡ, kiện tụng',
        'muc': 'tốt',
      },
      'Trừ': {
        'nen': 'Trị bệnh, tẩy uế, dọn dẹp, cắt may',
        'kieng': 'Cưới hỏi, khai trương, xuất hành xa',
        'muc': 'trung',
      },
      'Mãn': {
        'nen': 'Cưới hỏi, khai trương, nhập trạch, cầu tài',
        'kieng': 'Động thổ, phá dỡ, kiện tụng',
        'muc': 'tốt',
      },
      'Bình': {
        'nen': 'Sửa chữa, xây dựng, trồng cây, giao dịch',
        'kieng': 'Xuất hành xa, cưới hỏi, khai trương',
        'muc': 'trung',
      },
      'Định': {
        'nen': 'Cưới hỏi, ký kết, nhập học, cầu phúc',
        'kieng': 'Kiện tụng, xuất hành, phá dỡ',
        'muc': 'tốt',
      },
      'Chấp': {
        'nen': 'Xây dựng, sửa chữa, trồng cây, chăn nuôi',
        'kieng': 'Xuất hành, cưới hỏi, khai trương',
        'muc': 'trung',
      },
      'Phá': {
        'nen': 'Phá dỡ, tháo gỡ, trị bệnh, tẩy uế',
        'kieng': 'Cưới hỏi, khai trương, ký kết, nhập trạch',
        'muc': 'xấu',
      },
      'Nguy': {
        'nen': 'Cầu phúc, cúng tế, an táng',
        'kieng': 'Xuất hành, leo cao, xây dựng, khai trương',
        'muc': 'xấu',
      },
      'Thành': {
        'nen': 'Cưới hỏi, khai trương, ký kết, nhập trạch, xuất hành',
        'kieng': 'Kiện tụng, phá dỡ',
        'muc': 'tốt',
      },
      'Thu': {
        'nen': 'Thu hoạch, nhập kho, cất giữ, trả nợ',
        'kieng': 'Khai trương, xuất hành, cưới hỏi',
        'muc': 'trung',
      },
      'Khai': {
        'nen': 'Khai trương, xuất hành, cưới hỏi, nhập học, xây dựng',
        'kieng': 'An táng, phá dỡ',
        'muc': 'tốt',
      },
      'Bế': {
        'nen': 'An táng, bế quan, nghỉ ngơi',
        'kieng': 'Khai trương, xuất hành, cưới hỏi, ký kết',
        'muc': 'xấu',
      },
    };

    return trucData[truc] ?? {'nen': '--', 'kieng': '--', 'muc': 'trung'};
  }

  /// Hướng xuất hành tốt theo Chi ngày
  static Map<String, String> huongXuatHanh(String chiNgay) {
    // Hỷ Thần (hướng vui), Tài Thần (hướng tài), Hạc Thần (hướng xấu)
    const Map<String, Map<String, String>> huongTable = {
      'Tý': {
        'hyThan': 'Đông Nam',
        'taiThan': 'Chính Nam',
        'xauThan': 'Tây Bắc',
      },
      'Sửu': {
        'hyThan': 'Đông Bắc',
        'taiThan': 'Đông Nam',
        'xauThan': 'Tây Nam',
      },
      'Dần': {
        'hyThan': 'Tây Bắc',
        'taiThan': 'Chính Đông',
        'xauThan': 'Chính Nam',
      },
      'Mão': {
        'hyThan': 'Tây Nam',
        'taiThan': 'Đông Nam',
        'xauThan': 'Đông Bắc',
      },
      'Thìn': {
        'hyThan': 'Chính Nam',
        'taiThan': 'Chính Bắc',
        'xauThan': 'Chính Đông',
      },
      'Tỵ': {
        'hyThan': 'Đông Nam',
        'taiThan': 'Chính Đông',
        'xauThan': 'Tây Bắc',
      },
      'Ngọ': {
        'hyThan': 'Đông Bắc',
        'taiThan': 'Chính Nam',
        'xauThan': 'Tây Nam',
      },
      'Mùi': {
        'hyThan': 'Tây Bắc',
        'taiThan': 'Đông Nam',
        'xauThan': 'Chính Nam',
      },
      'Thân': {
        'hyThan': 'Tây Nam',
        'taiThan': 'Chính Đông',
        'xauThan': 'Đông Bắc',
      },
      'Dậu': {
        'hyThan': 'Chính Nam',
        'taiThan': 'Đông Nam',
        'xauThan': 'Chính Đông',
      },
      'Tuất': {
        'hyThan': 'Đông Nam',
        'taiThan': 'Chính Bắc',
        'xauThan': 'Tây Bắc',
      },
      'Hợi': {
        'hyThan': 'Đông Bắc',
        'taiThan': 'Chính Đông',
        'xauThan': 'Tây Nam',
      },
    };

    return huongTable[chiNgay] ??
        {'hyThan': '--', 'taiThan': '--', 'xauThan': '--'};
  }

  /// Tuổi xung khắc trong ngày (dựa trên Chi ngày)
  static List<String> tuoiXungKhac(String chiNgay) {
    // Lục Xung
    const Map<String, String> lucXung = {
      'Tý': 'Ngọ',
      'Sửu': 'Mùi',
      'Dần': 'Thân',
      'Mão': 'Dậu',
      'Thìn': 'Tuất',
      'Tỵ': 'Hợi',
      'Ngọ': 'Tý',
      'Mùi': 'Sửu',
      'Thân': 'Dần',
      'Dậu': 'Mão',
      'Tuất': 'Thìn',
      'Hợi': 'Tỵ',
    };

    final String xung = lucXung[chiNgay] ?? '';
    if (xung.isEmpty) return [];
    return ['Tuổi $xung'];
  }

  /// Tổng hợp thông tin ngày
  static Map<String, dynamic> tongHopNgay({
    required String canChiDay,
    required int lunarMonth,
    required int lunarDay,
  }) {
    final parts = canChiDay.split(' ');
    final String chiNgay = parts.length > 1 ? parts[1] : 'Tý';

    final String truc = trucNgay(lunarMonth, lunarDay);
    final viecData = viecNenKieng(truc);
    final hoangDao = gioHoangDao(chiNgay);
    final hacDao = gioHacDao(chiNgay);
    final huong = huongXuatHanh(chiNgay);
    final xung = tuoiXungKhac(chiNgay);

    return {
      'truc': truc,
      'trucMuc': viecData['muc'],
      'viecNen': viecData['nen'],
      'viecKieng': viecData['kieng'],
      'gioHoangDao': hoangDao,
      'gioHacDao': hacDao,
      'huongHyThan': huong['hyThan'],
      'huongTaiThan': huong['taiThan'],
      'huongXau': huong['xauThan'],
      'tuoiXung': xung,
    };
  }
}
