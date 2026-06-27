import 'package:vnlunar/vnlunar.dart';

class CanChiCalculator {
  static const List<String> _listCan = [
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
  static const List<String> _listChi = [
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

  // Lấy dữ liệu ngày Âm Lịch từ ngày Dương Lịch
  static Map<String, dynamic> getLunarDate(DateTime solarDate) {
    // Múi giờ Việt Nam là 7
    final lunar = convertSolar2Lunar(
      solarDate.day,
      solarDate.month,
      solarDate.year,
      7,
    );

    int lunarDay = lunar[0];
    int lunarMonth = lunar[1];
    int lunarYear = lunar[2];
    bool isLeap = lunar[3] == 1;

    return {
      'day': lunarDay,
      'month': lunarMonth,
      'year': lunarYear,
      'isLeap': isLeap,
      'dayString': _formatDayPrefix(lunarDay),
      'canChiYear': getCanChiYear(lunarYear),
      'canChiMonth': getCanChiMonth(lunarYear, lunarMonth),
      'canChiDay': getCanChiDay(solarDate),
      'canChiHour': getCanChiHour(solarDate),
    };
  }

  // Thuật toán chuẩn hóa cách gọi ngày
  static String _formatDayPrefix(int day) {
    if (day >= 1 && day <= 10) {
      return 'Mùng $day';
    } else {
      return 'Ngày $day';
    }
  }

  // Thuật toán tính Can Chi của Năm
  static String getCanChiYear(int year) {
    const listCan = [
      "Canh",
      "Tân",
      "Nhâm",
      "Quý",
      "Giáp",
      "Ất",
      "Bính",
      "Đinh",
      "Mậu",
      "Kỷ",
    ];
    const listChi = [
      "Thân",
      "Dậu",
      "Tuất",
      "Hợi",
      "Tý",
      "Sửu",
      "Dần",
      "Mão",
      "Thìn",
      "Tỵ",
      "Ngọ",
      "Mùi",
    ];

    String can = listCan[year % 10];
    String chi = listChi[year % 12];

    return '$can $chi';
  }

  /// Tính Can Chi của Tháng âm lịch
  /// Công thức: Can tháng Giêng phụ thuộc Can năm
  static String getCanChiMonth(int lunarYear, int lunarMonth) {
    // Can năm → Can tháng Giêng:
    // Giáp/Kỷ → Bính Dần, Ất/Canh → Mậu Dần, Bính/Tân → Canh Dần
    // Đinh/Nhâm → Nhâm Dần, Mậu/Quý → Giáp Dần
    final int canNamIdx = (lunarYear - 4) % 10;
    int canThangGiengIdx;
    switch (canNamIdx) {
      case 0:
      case 5: // Giáp, Kỷ
        canThangGiengIdx = 2; // Bính
        break;
      case 1:
      case 6: // Ất, Canh
        canThangGiengIdx = 4; // Mậu
        break;
      case 2:
      case 7: // Bính, Tân
        canThangGiengIdx = 6; // Canh
        break;
      case 3:
      case 8: // Đinh, Nhâm
        canThangGiengIdx = 8; // Nhâm
        break;
      default: // Mậu, Quý
        canThangGiengIdx = 0; // Giáp
    }

    final int canThangIdx = (canThangGiengIdx + lunarMonth - 1) % 10;
    // Chi tháng: tháng Giêng = Dần (index 2), tháng 2 = Mão...
    final int chiThangIdx = (lunarMonth + 1) % 12;

    return '${_listCan[canThangIdx]} ${_listChi[chiThangIdx]}';
  }

  /// Tính Can Chi của Ngày dương lịch
  /// Dùng công thức Julius Day Number (JDN)
  static String getCanChiDay(DateTime solarDate) {
    final int jdn = _julianDayNumber(
      solarDate.year,
      solarDate.month,
      solarDate.day,
    );
    // Can ngày: JDN % 10, offset để Giáp = 0
    final int canIdx = (jdn + 9) % 10;
    // Chi ngày: JDN % 12, offset để Tý = 0
    final int chiIdx = (jdn + 1) % 12;
    return '${_listCan[canIdx]} ${_listChi[chiIdx]}';
  }

  /// Tính Can Chi giờ hiện tại
  static String getCanChiHour(DateTime dateTime) {
    final int hour = dateTime.hour;
    // Xác định Chi giờ
    int chiIdx;
    if (hour == 23 || hour == 0) {
      chiIdx = 0; // Tý
    } else if (hour >= 1 && hour < 3) {
      chiIdx = 1; // Sửu
    } else if (hour >= 3 && hour < 5) {
      chiIdx = 2; // Dần
    } else if (hour >= 5 && hour < 7) {
      chiIdx = 3; // Mão
    } else if (hour >= 7 && hour < 9) {
      chiIdx = 4; // Thìn
    } else if (hour >= 9 && hour < 11) {
      chiIdx = 5; // Tỵ
    } else if (hour >= 11 && hour < 13) {
      chiIdx = 6; // Ngọ
    } else if (hour >= 13 && hour < 15) {
      chiIdx = 7; // Mùi
    } else if (hour >= 15 && hour < 17) {
      chiIdx = 8; // Thân
    } else if (hour >= 17 && hour < 19) {
      chiIdx = 9; // Dậu
    } else if (hour >= 19 && hour < 21) {
      chiIdx = 10; // Tuất
    } else {
      chiIdx = 11; // Hợi
    }

    // Can giờ phụ thuộc Can ngày
    final int jdn = _julianDayNumber(
      dateTime.year,
      dateTime.month,
      dateTime.day,
    );
    final int canNgayIdx = (jdn + 9) % 10;
    // Can giờ Tý = (Can ngày * 2) % 10
    final int canGioTyIdx = (canNgayIdx * 2) % 10;
    final int canGioIdx = (canGioTyIdx + chiIdx) % 10;

    return '${_listCan[canGioIdx]} ${_listChi[chiIdx]}';
  }

  /// Julian Day Number từ ngày dương lịch
  static int _julianDayNumber(int year, int month, int day) {
    final int a = ((14 - month) / 12).floor();
    final int y = year + 4800 - a;
    final int m = month + 12 * a - 3;
    return day +
        ((153 * m + 2) / 5).floor() +
        365 * y +
        (y / 4).floor() -
        (y / 100).floor() +
        (y / 400).floor() -
        32045;
  }
}
