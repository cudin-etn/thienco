import 'package:flutter_test/flutter_test.dart';

import 'package:thien_co/features/can_chi/logic/can_chi_calculator.dart';
import 'package:thien_co/features/tu_vi/logic/tu_vi_engine.dart';

void main() {
  group('Can Chi calculator', () {
    test('resolves common year and first lunar month anchors', () {
      expect(CanChiCalculator.getCanChiYear(2024), 'Giáp Thìn');
      expect(CanChiCalculator.getCanChiYear(2025), 'Ất Tỵ');
      expect(CanChiCalculator.getCanChiYear(2026), 'Bính Ngọ');

      expect(CanChiCalculator.getCanChiMonth(2024, 1), 'Bính Dần');
      expect(CanChiCalculator.getCanChiMonth(2025, 1), 'Mậu Dần');
    });
  });

  group('Tu Vi chart anchors', () {
    test('builds the Tet 2024 heavenly board consistently', () {
      final thienBan = TuViEngine.lapThienBan('10/02/2024', 'Giờ Tý');

      expect(thienBan['lunarDay'], 1);
      expect(thienBan['lunarMonth'], 1);
      expect(thienBan['lunarYear'], 2024);
      expect(thienBan['canChiNam'], 'Giáp Thìn');
      expect(thienBan['banMenh'], 'Phú Đăng Hỏa');
      expect(thienBan['cungMenh'], 'Dần');
      expect(thienBan['cungThan'], 'Dần');
      expect(thienBan['cuc'], 'Mộc Tam Cục');
    });

    test('places the main stars for a known day/cuc anchor', () {
      final stars = TuViEngine.an14ChinhTinh(1, 'Mộc Tam Cục');

      expect(stars['Thìn'], contains('Tử Vi (M)'));
      expect(stars['Tý'], contains('Thiên Phủ (M)'));
      expect(stars['Mão'], contains('Thiên Cơ (M)'));
      expect(stars['Ngọ'], contains('Thất Sát (M)'));
    });
  });
}
