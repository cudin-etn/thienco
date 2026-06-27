class TuViBinhGiaiCore {
  static const List<String> listCung = [
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

  static const Set<String> catTinh = {
    'Tả Phù',
    'Hữu Bật',
    'Văn Xương',
    'Văn Khúc',
    'Thiên Khôi',
    'Thiên Việt',
    'Long Trì',
    'Phượng Các',
    'Tam Thai',
    'Bát Tọa',
    'Ân Quang',
    'Thiên Quý',
    'Hóa Lộc',
    'Hóa Quyền',
    'Hóa Khoa',
    'Lộc Tồn',
    'Thiên Đức',
    'Nguyệt Đức',
  };

  static const Set<String> satTinh = {
    'Kình Dương',
    'Đà La',
    'Hỏa Tinh',
    'Linh Tinh',
    'Địa Không',
    'Địa Kiếp',
    'Không Kiếp',
    'Thiên Hình',
    'Hóa Kỵ',
    'Bạch Hổ',
    'Tang Môn',
    'Thiên Không',
  };

  static List<String> mergeStarsForCung(String cung, dynamic mC, dynamic mP) {
    final raw = [
      ...List<String>.from(mC[cung] ?? []),
      ...List<String>.from(mP[cung] ?? []),
    ];
    final List<String> result = [];
    for (final s in raw) {
      // Giữ nguyên độ sáng: "Tử Vi (M)" → tên gốc để scoring dùng
      // Tách Tứ Hóa suffix để thêm làm sao riêng
      final String hoaStripped = s.split(' [').first.trim();
      if (!result.contains(hoaStripped)) {
        result.add(hoaStripped);
      }
      // Nếu có Tứ Hóa, thêm như sao riêng để scoring nhận diện
      final RegExp hoaRegex = RegExp(
        r'\[(Hóa Lộc|Hóa Quyền|Hóa Khoa|Hóa Kỵ)\]',
      );
      final Match? hoaMatch = hoaRegex.firstMatch(s);
      if (hoaMatch != null) {
        final String hoaName = hoaMatch.group(1)!;
        if (!result.contains(hoaName)) {
          result.add(hoaName);
        }
      }
    }
    return result;
  }

  static int? readDaiHanAtCung(dynamic mD, String cung) {
    final value = mD[cung];
    if (value is int) return value;
    if (value is String) return int.tryParse(value);
    return null;
  }

  static String? readTieuHanAtCung(dynamic mT, String cung) {
    final value = mT[cung];
    if (value == null) return null;
    return value.toString();
  }

  static String getTuanTrietAtCung(dynamic tb, String cung) {
    String tuanTriet = '';
    final tuan = List<String>.from(tb['tuan'] ?? []);
    final triet = List<String>.from(tb['triet'] ?? []);
    if (tuan.contains(cung)) tuanTriet = 'TUẦN';
    if (triet.contains(cung)) tuanTriet = 'TRIỆT';
    return tuanTriet;
  }

  /// Strip brightness suffix và Tứ Hóa suffix trước khi so sánh
  /// VD: "Tử Vi (M) [Hóa Lộc]" → "Tử Vi"
  static String _stripBrightness(String star) {
    return star.split(' (').first.split(' [').first.trim();
  }

  /// Trọng số theo độ sáng (M/V/Đ/B/H)
  static const Map<String, double> _brightnessWeight = {
    'M': 3.0,
    'V': 2.0,
    'Đ': 1.5,
    'B': 1.0,
    'H': 0.5,
  };

  /// Trích độ sáng từ tên sao: "Tử Vi (M)" → "M"
  static String _extractBrightness(String star) {
    final regex = RegExp(r'\((\w)\)');
    final match = regex.firstMatch(star);
    if (match != null) return match.group(1)!;
    return 'B';
  }

  /// Tính điểm cát tinh có trọng số theo độ sáng
  static int scoreCat(List<String> stars) {
    double score = 0;
    for (final s in stars) {
      final base = _stripBrightness(s);
      if (catTinh.contains(base)) {
        final doSang = _extractBrightness(s);
        final weight = _brightnessWeight[doSang] ?? 1.0;
        score += weight;
      }
    }
    return score.round();
  }

  /// Tính điểm sát tinh có trọng số theo độ sáng
  static int scoreSat(List<String> stars) {
    double score = 0;
    for (final s in stars) {
      final base = _stripBrightness(s);
      if (satTinh.contains(base)) {
        final doSang = _extractBrightness(s);
        final weight = _brightnessWeight[doSang] ?? 1.0;
        score += weight;
      }
    }
    return score.round();
  }
}
