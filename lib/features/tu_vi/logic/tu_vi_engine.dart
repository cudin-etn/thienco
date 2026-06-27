import 'core_engine.dart';
import 'star_engine.dart';
import 'time_engine.dart';

class TuViEngine {
  static Map<String, dynamic> lapThienBan(String birthDate, String birthTime) =>
      CoreEngine.lapThienBan(birthDate, birthTime);

  static Map<String, String> an12Cung(String chiMenh) =>
      CoreEngine.an12Cung(chiMenh);

  static Map<String, List<String>> an14ChinhTinh(
    int ngaySinh,
    String cucString,
  ) => StarEngine.an14ChinhTinh(ngaySinh, cucString);

  static Map<String, List<String>> anPhuTinh(
    Map<String, dynamic> data,
    String time, {
    bool isMale = true,
  }) => StarEngine.anPhuTinh(data, time, isMale: isMale);

  /// An Tứ Hóa theo Can năm
  static Map<String, String> anTuHoa(String canNam) =>
      StarEngine.anTuHoa(canNam);

  /// Gắn Tứ Hóa vào map chính tinh + phụ tinh đã an
  static void applyTuHoa(
    Map<String, List<String>> mapChinhTinh,
    Map<String, List<String>> mapPhuTinh,
    String canNam,
  ) => StarEngine.applyTuHoa(mapChinhTinh, mapPhuTinh, canNam);

  static Map<String, int> tinhDaiHan(
    String cuc,
    String can,
    String chi, {
    bool isMale = true,
  }) => TimeEngine.tinhDaiHan(cuc, can, chi, isMale: isMale);

  static Map<String, String> tinhTieuHan(
    String chiNamSinh, {
    bool isMale = true,
  }) => TimeEngine.tinhTieuHan(chiNamSinh, isMale: isMale);

  /// Tính Lưu Niên cho năm cụ thể
  static Map<String, dynamic> tinhLuuNien({
    required int namXem,
    required int namSinh,
    required String chiNamSinh,
    required String cucString,
    required String canNam,
    required String chiMenh,
    bool isMale = true,
  }) => TimeEngine.tinhLuuNien(
    namXem: namXem,
    namSinh: namSinh,
    chiNamSinh: chiNamSinh,
    cucString: cucString,
    canNam: canNam,
    chiMenh: chiMenh,
    isMale: isMale,
  );

  /// Luận giải lưu niên
  static String luanLuuNien({
    required Map<String, dynamic> luuNienData,
    required List<String> saoCungTieuHan,
    required List<String> saoCungDaiHan,
  }) => TimeEngine.luanLuuNien(
    luuNienData: luuNienData,
    saoCungTieuHan: saoCungTieuHan,
    saoCungDaiHan: saoCungDaiHan,
  );

  static Map<String, dynamic> lapDiaBanTongHop({
    required String birthDate,
    required String birthTime,
    bool isMale = true,
  }) {
    final Map<String, dynamic> thienBan = lapThienBan(birthDate, birthTime);

    final String chiMenh = thienBan['cungMenh'] ?? 'Tỵ';
    final String cuc = thienBan['cuc'] ?? 'Thủy Nhị Cục';
    final int lunarDay = thienBan['lunarDay'] ?? 1;
    final String canNam = thienBan['canNam'] ?? 'Giáp';
    final String chiNam = thienBan['chiNam'] ?? 'Tý';

    final Map<String, String> cungMap = an12Cung(chiMenh);
    final Map<String, List<String>> chinhTinh = an14ChinhTinh(lunarDay, cuc);
    final Map<String, List<String>> phuTinh = anPhuTinh(
      thienBan,
      birthTime,
      isMale: isMale,
    );
    final Map<String, int> daiHan = tinhDaiHan(
      cuc,
      canNam,
      chiMenh,
      isMale: isMale,
    );
    final Map<String, String> tieuHan = tinhTieuHan(chiNam, isMale: isMale);

    return {
      'thienBan': thienBan,
      'cungMap': cungMap,
      'chinhTinh': chinhTinh,
      'phuTinh': phuTinh,
      'daiHan': daiHan,
      'tieuHan': tieuHan,
    };
  }

  static Map<String, dynamic> lapLaSoHoanChinh({
    required String birthDate,
    required String birthTime,
    bool isMale = true,
  }) {
    final data = lapDiaBanTongHop(
      birthDate: birthDate,
      birthTime: birthTime,
      isMale: isMale,
    );

    return {
      'profile': {
        'birthDate': birthDate,
        'birthTime': birthTime,
        'isMale': isMale,
      },
      ...data,
    };
  }

  static Map<String, dynamic> tomTatThongTinLaSo({
    required String birthDate,
    required String birthTime,
    bool isMale = true,
  }) {
    final Map<String, dynamic> thienBan = lapThienBan(birthDate, birthTime);

    return {
      'gioiTinh': isMale ? 'Nam' : 'Nữ',
      'amLich':
          '${thienBan['lunarDay'] ?? '--'}/${thienBan['lunarMonth'] ?? '--'}/${thienBan['lunarYear'] ?? '----'}',
      'cungMenh': thienBan['cungMenh'] ?? '--',
      'cungThan': thienBan['cungThan'] ?? '--',
      'menhCuc': thienBan['menhCuc'] ?? (thienBan['cuc'] ?? '--'),
      'canChiNam': thienBan['canChiNam'] ?? '--',
      'banMenh': thienBan['banMenh'] ?? '--',
      'chuMenh': thienBan['chuMenh'] ?? '--',
      'chuThan': thienBan['chuThan'] ?? '--',
    };
  }
}
