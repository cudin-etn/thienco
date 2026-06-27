import 'tu_vi_binh_giai_core.dart';

class TuViBinhGiaiCungPaths {
  static String cungTaiBachFromMenh(String cungMenh) {
    final int idxMenh = TuViBinhGiaiCore.listCung.indexOf(cungMenh);
    if (idxMenh == -1) return 'Dậu';
    return TuViBinhGiaiCore.listCung[(idxMenh + 4) % 12];
  }

  static String cungQuanLocFromMenh(String cungMenh) {
    final int idxMenh = TuViBinhGiaiCore.listCung.indexOf(cungMenh);
    if (idxMenh == -1) return 'Sửu';
    return TuViBinhGiaiCore.listCung[(idxMenh + 8) % 12];
  }

  static String cungPhuTheFromMenh(String cungMenh) {
    final int idxMenh = TuViBinhGiaiCore.listCung.indexOf(cungMenh);
    if (idxMenh == -1) return 'Hợi';
    return TuViBinhGiaiCore.listCung[(idxMenh + 2) % 12];
  }

  static String cungTatAchFromMenh(String cungMenh) {
    final int idxMenh = TuViBinhGiaiCore.listCung.indexOf(cungMenh);
    if (idxMenh == -1) return 'Mão';
    return TuViBinhGiaiCore.listCung[(idxMenh + 6) % 12];
  }
}
