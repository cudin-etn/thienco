/// Tính toán hợp tuổi, tương hợp giữa 2 người dựa trên Can Chi năm sinh
class HopTuoiCalculator {
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

  static const List<String> _listCan = [
    'Giáp',
    'Ất',
    'Bính',
    'Đinh',
    'Mậu',
    'Kỷ',
    'Canh',
    'Tân',
    'Nhâm',
    'Quý',
  ];

  /// Tam Hợp (3 tuổi hợp nhau mạnh nhất)
  static const List<List<String>> tamHop = [
    ['Thân', 'Tý', 'Thìn'], // Thủy cục
    ['Dần', 'Ngọ', 'Tuất'], // Hỏa cục
    ['Tỵ', 'Dậu', 'Sửu'], // Kim cục
    ['Hợi', 'Mão', 'Mùi'], // Mộc cục
  ];

  /// Lục Hợp (2 tuổi hợp nhau)
  static const Map<String, String> lucHop = {
    'Tý': 'Sửu',
    'Sửu': 'Tý',
    'Dần': 'Hợi',
    'Hợi': 'Dần',
    'Mão': 'Tuất',
    'Tuất': 'Mão',
    'Thìn': 'Dậu',
    'Dậu': 'Thìn',
    'Tỵ': 'Thân',
    'Thân': 'Tỵ',
    'Ngọ': 'Mùi',
    'Mùi': 'Ngọ',
  };

  /// Lục Xung (2 tuổi xung nhau)
  static const Map<String, String> lucXung = {
    'Tý': 'Ngọ',
    'Ngọ': 'Tý',
    'Sửu': 'Mùi',
    'Mùi': 'Sửu',
    'Dần': 'Thân',
    'Thân': 'Dần',
    'Mão': 'Dậu',
    'Dậu': 'Mão',
    'Thìn': 'Tuất',
    'Tuất': 'Thìn',
    'Tỵ': 'Hợi',
    'Hợi': 'Tỵ',
  };

  /// Lục Hại (2 tuổi hại nhau)
  static const Map<String, String> lucHai = {
    'Tý': 'Mùi',
    'Mùi': 'Tý',
    'Sửu': 'Ngọ',
    'Ngọ': 'Sửu',
    'Dần': 'Tỵ',
    'Tỵ': 'Dần',
    'Mão': 'Thìn',
    'Thìn': 'Mão',
    'Thân': 'Hợi',
    'Hợi': 'Thân',
    'Dậu': 'Tuất',
    'Tuất': 'Dậu',
  };

  /// Tứ Hành Xung (Hình)
  static const List<List<String>> tuHanhXung = [
    ['Dần', 'Tỵ', 'Thân'], // Vô Ân chi Hình
    ['Sửu', 'Tuất', 'Mùi'], // Trì Thế chi Hình
  ];

  /// Tự Hình (cùng tuổi nhưng thuộc nhóm hình)
  static const Set<String> tuHinh = {'Thìn', 'Ngọ', 'Dậu', 'Hợi'};

  /// Thiên Can hợp (Ngũ Hợp)
  static const Map<String, String> canHop = {
    'Giáp': 'Kỷ',
    'Kỷ': 'Giáp',
    'Ất': 'Canh',
    'Canh': 'Ất',
    'Bính': 'Tân',
    'Tân': 'Bính',
    'Đinh': 'Nhâm',
    'Nhâm': 'Đinh',
    'Mậu': 'Quý',
    'Quý': 'Mậu',
  };

  /// Thiên Can xung (tương khắc)
  static const Map<String, String> canXung = {
    'Giáp': 'Canh',
    'Canh': 'Giáp',
    'Ất': 'Tân',
    'Tân': 'Ất',
    'Bính': 'Nhâm',
    'Nhâm': 'Bính',
    'Đinh': 'Quý',
    'Quý': 'Đinh',
  };

  /// Ngũ Hành tương sinh
  static const Map<String, String> nguHanhSinh = {
    'Kim': 'Thủy',
    'Thủy': 'Mộc',
    'Mộc': 'Hỏa',
    'Hỏa': 'Thổ',
    'Thổ': 'Kim',
  };

  /// Ngũ Hành tương khắc
  static const Map<String, String> nguHanhKhac = {
    'Kim': 'Mộc',
    'Mộc': 'Thổ',
    'Thổ': 'Thủy',
    'Thủy': 'Hỏa',
    'Hỏa': 'Kim',
  };

  /// Trích ngũ hành từ Nạp Âm
  static String _nguHanhFromNapAm(String napAm) {
    if (napAm.contains('Kim')) return 'Kim';
    if (napAm.contains('Mộc')) return 'Mộc';
    if (napAm.contains('Thủy')) return 'Thủy';
    if (napAm.contains('Hỏa')) return 'Hỏa';
    if (napAm.contains('Thổ')) return 'Thổ';
    return 'Thổ';
  }

  /// Tính Can Chi năm từ năm dương lịch
  static String canChiNam(int year) {
    final int canIdx = (year - 4) % 10;
    final int chiIdx = (year - 4) % 12;
    return '${_listCan[canIdx]} ${_listChi[chiIdx]}';
  }

  /// Lấy Chi từ Can Chi năm
  static String _chiFromCanChi(String canChi) {
    final parts = canChi.trim().split(RegExp(r'\s+'));
    return parts.length > 1 ? parts[1] : parts[0];
  }

  /// Phân tích tương hợp giữa 2 tuổi
  static Map<String, dynamic> phanTichHopTuoi({
    required int namSinh1,
    required int namSinh2,
    required String napAm1,
    required String napAm2,
  }) {
    final String canChi1 = canChiNam(namSinh1);
    final String canChi2 = canChiNam(namSinh2);
    final String chi1 = _chiFromCanChi(canChi1);
    final String chi2 = _chiFromCanChi(canChi2);
    final String can1 = canChi1.split(' ').first;
    final String can2 = canChi2.split(' ').first;
    final String hanh1 = _nguHanhFromNapAm(napAm1);
    final String hanh2 = _nguHanhFromNapAm(napAm2);

    int diem = 50; // Điểm cơ bản
    final List<String> nhanXet = [];
    final List<String> diemManh = [];
    final List<String> diemYeu = [];

    // 1. Kiểm tra Tam Hợp
    bool isTamHop = false;
    for (final group in tamHop) {
      if (group.contains(chi1) && group.contains(chi2) && chi1 != chi2) {
        isTamHop = true;
        break;
      }
    }
    if (isTamHop) {
      diem += 25;
      diemManh.add(
        'Tam Hợp: Tuổi $chi1 và $chi2 nằm trong bộ Tam Hợp, tương trợ mạnh mẽ, dễ đồng lòng trong mọi việc',
      );
    }

    // 2. Kiểm tra Lục Hợp
    if (lucHop[chi1] == chi2) {
      diem += 20;
      diemManh.add(
        'Lục Hợp: Tuổi $chi1 hợp trực tiếp với tuổi $chi2, nhân duyên tốt đẹp, dễ gắn bó tự nhiên',
      );
    }

    // 3. Kiểm tra Nhị Hợp (Bán Hợp) — nửa bộ Tam Hợp nhưng không đủ 3
    if (!isTamHop) {
      for (final group in tamHop) {
        if (group.contains(chi1) && group.contains(chi2) && chi1 != chi2) {
          diem += 10;
          diemManh.add(
            'Nhị Hợp: Hai tuổi có phần tương trợ nhẹ qua nửa bộ Tam Hợp',
          );
          break;
        }
      }
    }

    // 4. Kiểm tra Thiên Can hợp
    if (canHop[can1] == can2) {
      diem += 12;
      diemManh.add(
        'Thiên Can hợp: $can1 hợp $can2, tư duy và cách nghĩ dễ đồng điệu',
      );
    }

    // 5. Kiểm tra Thiên Can xung
    if (canXung[can1] == can2) {
      diem -= 8;
      diemYeu.add(
        'Thiên Can xung: $can1 xung $can2, cách nghĩ và quan điểm dễ trái chiều',
      );
    }

    // 6. Kiểm tra Lục Xung
    if (lucXung[chi1] == chi2) {
      diem -= 25;
      diemYeu.add(
        'Lục Xung: Tuổi $chi1 xung trực tiếp với tuổi $chi2, dễ va chạm, bất đồng và khó nhường nhịn',
      );
    }

    // 7. Kiểm tra Lục Hại
    if (lucHai[chi1] == chi2) {
      diem -= 15;
      diemYeu.add(
        'Lục Hại: Tuổi $chi1 hại tuổi $chi2, quan hệ dễ có hiểu lầm ngầm, tổn thương không nói ra',
      );
    }

    // 8. Kiểm tra Tứ Hành Xung (Tam Hình)
    for (final group in tuHanhXung) {
      if (group.contains(chi1) && group.contains(chi2) && chi1 != chi2) {
        diem -= 10;
        diemYeu.add(
          'Tương Hình: Hai tuổi nằm trong bộ Tam Hình, dễ gây áp lực lẫn nhau, cần nhẫn nhịn nhiều',
        );
        break;
      }
    }

    // 9. Kiểm tra Tự Hình (cùng tuổi thuộc nhóm hình)
    if (chi1 == chi2 && tuHinh.contains(chi1)) {
      diem -= 8;
      diemYeu.add(
        'Tự Hình: Cùng tuổi $chi1 thuộc nhóm Tự Hình, dễ cạnh tranh ngầm hoặc không ai chịu nhường',
      );
    }

    // 10. Kiểm tra Ngũ Hành Nạp Âm
    if (hanh1 == hanh2) {
      diem += 10;
      diemManh.add(
        'Đồng hành $hanh1: Cùng ngũ hành nên dễ đồng cảm, hiểu nhau về bản chất',
      );
    } else if (nguHanhSinh[hanh1] == hanh2) {
      diem += 15;
      diemManh.add(
        'Tương sinh: Mệnh $napAm1 ($hanh1) sinh mệnh $napAm2 ($hanh2), người trước nâng đỡ người sau',
      );
    } else if (nguHanhSinh[hanh2] == hanh1) {
      diem += 15;
      diemManh.add(
        'Tương sinh: Mệnh $napAm2 ($hanh2) sinh mệnh $napAm1 ($hanh1), người sau nâng đỡ người trước',
      );
    } else if (nguHanhKhac[hanh1] == hanh2) {
      diem -= 10;
      diemYeu.add(
        'Tương khắc: Mệnh $hanh1 khắc mệnh $hanh2, cần ý thức điều hòa và tránh áp đặt',
      );
    } else if (nguHanhKhac[hanh2] == hanh1) {
      diem -= 10;
      diemYeu.add(
        'Tương khắc: Mệnh $hanh2 khắc mệnh $hanh1, cần ý thức điều hòa và tránh áp đặt',
      );
    }

    // Giới hạn điểm
    if (diem > 100) diem = 100;
    if (diem < 0) diem = 0;

    // Tổng kết + lời khuyên
    String mucDoHop;
    if (diem >= 80) {
      mucDoHop = 'Rất hợp';
      nhanXet.add(
        'Hai tuổi này có mức tương hợp cao. Dù là vợ chồng, đối tác hay bạn bè đều dễ đồng hành lâu dài, hỗ trợ nhau phát triển và ít xung đột lớn.',
      );
      nhanXet.add(
        'Lời khuyên: Giữ sự trân trọng, đừng vì quá thuận mà lơ là chăm sóc quan hệ.',
      );
    } else if (diem >= 60) {
      mucDoHop = 'Khá hợp';
      nhanXet.add(
        'Hai tuổi có nền tương hợp tốt. Quan hệ có thể bền vững nếu cả hai biết giữ gìn và tôn trọng khác biệt nhỏ.',
      );
      nhanXet.add(
        'Lời khuyên: Tận dụng điểm mạnh chung, chủ động giao tiếp khi có bất đồng nhỏ.',
      );
    } else if (diem >= 40) {
      mucDoHop = 'Bình thường';
      nhanXet.add(
        'Hai tuổi không quá hợp cũng không quá xung. Thành bại phụ thuộc nhiều vào cách sống, cách đối xử và sự nỗ lực của cả hai.',
      );
      nhanXet.add(
        'Lời khuyên: Không nên quá lo lắng về tuổi, quan trọng là cách hai người đối đãi nhau hằng ngày.',
      );
    } else if (diem >= 20) {
      mucDoHop = 'Ít hợp';
      nhanXet.add(
        'Hai tuổi có nhiều điểm va chạm tiềm ẩn. Quan hệ cần nỗ lực nhiều hơn bình thường để duy trì hài hòa.',
      );
      nhanXet.add(
        'Lời khuyên: Cần kiên nhẫn, tránh tranh luận thắng thua, ưu tiên lắng nghe và nhường nhịn đúng lúc.',
      );
    } else {
      mucDoHop = 'Xung khắc';
      nhanXet.add(
        'Hai tuổi xung khắc khá mạnh. Quan hệ dễ căng thẳng, va chạm thường xuyên nếu không có ý thức điều hòa rất cao.',
      );
      nhanXet.add(
        'Lời khuyên: Nếu đã gắn bó thì cần đặt quy tắc rõ ràng, tránh đụng chạm vùng nhạy cảm của nhau, và tìm điểm chung để xây dựng.',
      );
    }

    return {
      'canChi1': canChi1,
      'canChi2': canChi2,
      'chi1': chi1,
      'chi2': chi2,
      'can1': can1,
      'can2': can2,
      'napAm1': napAm1,
      'napAm2': napAm2,
      'hanh1': hanh1,
      'hanh2': hanh2,
      'diem': diem,
      'mucDoHop': mucDoHop,
      'nhanXet': nhanXet,
      'diemManh': diemManh,
      'diemYeu': diemYeu,
    };
  }
}
