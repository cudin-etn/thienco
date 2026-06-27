import 'tu_vi_binh_giai_core.dart';

class TuViBinhGiaiTongQuan {
  static String buildTongQuan({
    required String hoTen,
    required String gioiTinh,
    required String cungMenh,
    required String cungThan,
    required String menhCuc,
    required String canChiNam,
    required String ngayAm,
    required List<String> saoMenh,
    required List<String> saoThan,
    required List<String> saoTai,
    required List<String> saoQuan,
    required int diemMenh,
    required int diemTai,
    required int diemQuan,
  }) {
    final String menhTomTat = _tomTatMenh(saoMenh, diemMenh);
    final String taiTomTat = _tomTatTai(saoTai, diemTai);
    final String quanTomTat = _tomTatQuan(saoQuan, diemQuan);
    final String ketLuanMoDau = _buildKetLuanMoDau(
      saoMenh: saoMenh,
      saoTai: saoTai,
      saoQuan: saoQuan,
      diemMenh: diemMenh,
      diemTai: diemTai,
      diemQuan: diemQuan,
    );
    final String menhThanText = _buildMenhThanNarrative(
      cungMenh: cungMenh,
      cungThan: cungThan,
      saoMenh: saoMenh,
      saoThan: saoThan,
    );
    final String nhipLaSoText = _buildNhipLaSo(
      saoMenh: saoMenh,
      saoTai: saoTai,
      saoQuan: saoQuan,
      diemMenh: diemMenh,
      diemTai: diemTai,
      diemQuan: diemQuan,
    );
    final String tongLucText = _buildTongLucNarrative(
      saoMenh: saoMenh,
      saoTai: saoTai,
      saoQuan: saoQuan,
      diemMenh: diemMenh,
      diemTai: diemTai,
      diemQuan: diemQuan,
    );

    return '''
$hoTen ($gioiTinh) sinh năm $canChiNam, ngày âm $ngayAm, mệnh an tại cung $cungMenh${cungThan != '--' ? ', thân cư $cungThan' : ''}. Cục số: $menhCuc.

$ketLuanMoDau

Nếp vận chính của lá số này nghiêng về: $nhipLaSoText

Khí chất cốt lõi nổi bật là: $menhTomTat

$menhThanText

Trên trục phát triển chính, tài bạch cho thấy $taiTomTat Công danh - sự nghiệp cho thấy $quanTomTat

$tongLucText

Khi đọc toàn cục, nên ưu tiên xét trục Mệnh - Tài - Quan trước, rồi mới mở rộng sang Phu Thê, Phúc Đức, Điền Trạch và Tật Ách để hiểu rõ tiến trình đời sống.
'''
        .trim();
  }

  static String _buildNhipLaSo({
    required List<String> saoMenh,
    required List<String> saoTai,
    required List<String> saoQuan,
    required int diemMenh,
    required int diemTai,
    required int diemQuan,
  }) {
    final List<String> all = [...saoMenh, ...saoTai, ...saoQuan];
    final bool hasLoc = _hasAny(all, const [
      'Lộc Tồn',
      'Hóa Lộc',
      'Thiên Phủ',
      'Vũ Khúc',
    ]);
    final bool hasDong = _hasAny(all, const [
      'Phá Quân',
      'Tham Lang',
      'Thất Sát',
      'Thiên Mã',
    ]);
    final bool hasTri = _hasAny(all, const [
      'Văn Xương',
      'Văn Khúc',
      'Thiên Cơ',
      'Hóa Khoa',
    ]);
    final bool hasSat = _hasAny(all, const [
      'Kình Dương',
      'Đà La',
      'Hỏa Tinh',
      'Linh Tinh',
      'Địa Không',
      'Địa Kiếp',
    ]);
    final bool hasQuyen = _hasAny(all, const [
      'Hóa Quyền',
      'Tử Vi',
      'Thiên Tướng',
    ]);
    final int tong = diemMenh + diemTai + diemQuan;

    if (tong >= 4 && hasLoc && !hasSat) {
      return 'tích lũy bền và lên dần theo thời gian; càng đi lâu càng dễ thấy thành quả chắc tay';
    }
    if (tong >= 3 && hasDong && hasQuyen) {
      return 'bứt lên nhờ va chạm, đổi hướng và dám nhận vai trò lớn hơn khi thời cơ chín';
    }
    if (tong >= 3 && hasDong) {
      return 'bứt lên nhờ va chạm, đổi hướng và dám bước vào môi trường có tính cạnh tranh';
    }
    if (hasTri && tong >= 1) {
      return 'phát triển bằng đầu óc, cách tổ chức và khả năng đọc đúng thời thế hơn là chỉ dựa vào sức bền đơn thuần';
    }
    if (hasSat && tong <= 0) {
      return 'trưởng thành qua thử thách; càng giữ nền chắc và tránh nóng vội thì càng đỡ hao lực';
    }
    return 'đi theo kiểu chậm mà rõ; kết quả phụ thuộc nhiều vào môi trường sống và khả năng giữ nhịp ổn định';
  }

  static String buildHanNarrative({
    required int? daiHan,
    required String? tieuHan,
    required List<String> saoMenh,
    required List<String> saoTai,
    required List<String> saoQuan,
  }) {
    final allStars = [...saoMenh, ...saoTai, ...saoQuan];
    final cat = TuViBinhGiaiCore.scoreCat(allStars);
    final sat = TuViBinhGiaiCore.scoreSat(allStars);
    final bool hasCuuGiai = _hasCuuGiai(allStars);

    final String hanText = daiHan != null
        ? 'Đại hạn hiện tại rơi vào mốc $daiHan tuổi'
        : 'Đại hạn hiện tại chưa xác định rõ';

    final String tieuText = (tieuHan != null && tieuHan.isNotEmpty)
        ? ', tiểu hạn tại cung $tieuHan'
        : '';

    String xuHuong;
    if (cat >= sat + 2) {
      xuHuong =
          'vận trình nghiêng về chiều hướng sáng, dễ gặp cơ hội mở rộng và được trợ lực nếu biết đi đúng nhịp.';
    } else if (sat >= cat + 2) {
      xuHuong =
          'vận trình có thử thách rõ, dễ phát sinh áp lực, va chạm hoặc chậm tiến nếu nóng vội.';
    } else {
      xuHuong =
          'vận trình đan xen cả thuận lẫn nghịch, cần chọn thời điểm và giữ nhịp đi ổn định.';
    }

    final String cuuGiaiText = hasCuuGiai
        ? 'Điểm đáng mừng là trong nhóm sao trọng tâm vẫn có dấu hiệu cứu giải, nghĩa là dù vướng vẫn có đường tháo nếu xử lý đúng lúc và đúng cách.'
        : 'Nhóm sao trọng tâm không cho thấy lớp cứu giải quá rõ, nên càng cần giữ đầu lạnh và tránh các quyết định bốc đồng trong giai đoạn nhạy cảm.';

    return '$hanText$tieuText. Nhìn theo nhóm sao trọng tâm, $xuHuong $cuuGiaiText';
  }

  static String buildCatHungNarrative({
    required List<String> saoMenh,
    required List<String> saoTai,
    required List<String> saoQuan,
    required List<String> saoTatAch,
  }) {
    final all = <String>{
      ...saoMenh,
      ...saoTai,
      ...saoQuan,
      ...saoTatAch,
    }.toList();
    final cat = TuViBinhGiaiCore.scoreCat(all);
    final sat = TuViBinhGiaiCore.scoreSat(all);

    final List<String> catStars = all
        .where((s) => TuViBinhGiaiCore.catTinh.contains(s))
        .take(5)
        .toList();
    final List<String> satStars = all
        .where((s) => TuViBinhGiaiCore.satTinh.contains(s))
        .take(5)
        .toList();

    final String catText = catStars.isEmpty
        ? 'cát tinh không quá nổi trội'
        : 'cát tinh nổi bật gồm ${catStars.join(', ')}';
    final String satText = satStars.isEmpty
        ? 'hung sát tinh không quá dày'
        : 'hung sát tinh cần lưu ý gồm ${satStars.join(', ')}';

    final String balance;
    if (cat > sat) {
      balance =
          'Thế cục tổng thể thiên về cát nhiều hơn hung, nghĩa là dù cuộc đời không tránh hết trở lực thì bản thân vẫn thường có đường xoay, có người đỡ hoặc có cơ may gỡ thế ở những chặng quan trọng.';
    } else if (sat > cat) {
      balance =
          'Thế cục tổng thể chịu nhiều lực cản và cần thận trọng hơn bình thường, vì những pha sai nhịp dễ để lại hệ quả dài hơn mong đợi nếu thiếu tỉnh táo.';
    } else {
      balance =
          'Thế cục tổng thể tương đối cân bằng, cát hung xen lẫn, tức là lá số không quá thiên hẳn về một phía mà thành bại phụ thuộc rất nhiều vào cách chọn thời điểm và cách phản ứng trước biến động.';
    }

    final String cuuGiaiText = _hasCuuGiai(all)
        ? 'Điểm đáng chú ý là giữa các lực cản vẫn có lớp sao cứu giải đi cùng, nên lá số này không nên đọc theo hướng bi quan tuyệt đối.'
        : 'Lớp cứu giải hiện không quá dày, nên càng cần sống có nền, tránh đẩy mình vào thế phải xoay xở trong điều kiện quá bất lợi.';

    return '$balance $catText; $satText. $cuuGiaiText';
  }

  static String buildTamPhuongNarrative({
    required String cungMenh,
    required String cungTai,
    required String cungQuan,
    required List<String> saoMenh,
    required List<String> saoTai,
    required List<String> saoQuan,
  }) {
    final all = [...saoMenh, ...saoTai, ...saoQuan];
    final cat = TuViBinhGiaiCore.scoreCat(all);
    final sat = TuViBinhGiaiCore.scoreSat(all);
    final bool hasLoc = _hasAny(all, const ['Lộc Tồn', 'Hóa Lộc']);
    final bool hasQuyen = _hasAny(all, const [
      'Hóa Quyền',
      'Tử Vi',
      'Thiên Tướng',
    ]);
    final bool hasTri = _hasAny(all, const [
      'Văn Xương',
      'Văn Khúc',
      'Thiên Cơ',
      'Hóa Khoa',
    ]);
    final bool hasSatBo = _hasAny(all, const [
      'Kình Dương',
      'Đà La',
      'Hỏa Tinh',
      'Linh Tinh',
      'Địa Không',
      'Địa Kiếp',
    ]);

    String nhanXet;
    if (cat >= sat + 2) {
      nhanXet =
          'tam phương tứ chính nâng đỡ khá mạnh, cho thấy khả năng tự thân vươn lên và gặp quý nhân khi đi đúng hướng.';
    } else if (sat >= cat + 2) {
      nhanXet =
          'tam phương tứ chính chịu nhiều lực va chạm, nên làm chắc nền tảng, tránh quyết định quá cảm tính.';
    } else {
      nhanXet =
          'tam phương tứ chính ở thế trung hòa, muốn bứt lên cần dựa vào kỷ luật và lựa chọn thời điểm phù hợp.';
    }

    final List<String> layers = [];
    if (hasLoc) {
      layers.add(
        'Trục này có lộc khí, nên nếu đi đúng nhịp thì thành quả vật chất và cơ hội tăng trưởng không hề thấp.',
      );
    }
    if (hasQuyen) {
      layers.add(
        'Trục này có khí quyền và vai trò, nên càng về sau càng hợp mô hình sống mà bản thân có quyền chủ động quyết định.',
      );
    }
    if (hasTri) {
      layers.add(
        'Điểm mạnh không chỉ ở sức làm mà còn ở đầu óc, cách tổ chức và khả năng giải bài toán bằng nhận thức.',
      );
    }
    if (hasSatBo) {
      layers.add(
        'Tuy vậy, vì có sát bộ chen vào nên mọi bước tiến lớn đều nên đi bằng nền chắc, không hợp đánh cược theo hứng.',
      );
    }

    return 'Trục Mệnh ($cungMenh) - Tài Bạch ($cungTai) - Quan Lộc ($cungQuan) cho thấy $nhanXet ${layers.join(' ')}'
        .trim();
  }

  static String _tomTatMenh(List<String> saoMenh, int diemMenh) {
    if (saoMenh.any((s) => s.contains('Tử Vi'))) {
      return 'có xu hướng trọng khí chất, tự tôn, thích chủ động và muốn nắm quyền kiểm soát cuộc sống.';
    }
    if (saoMenh.any((s) => s.contains('Thiên Phủ'))) {
      return 'thiên về ổn định, tích lũy, giữ thế an toàn và có năng lực quản lý thực tế.';
    }
    if (saoMenh.any((s) => s.contains('Tham Lang'))) {
      return 'linh hoạt, nhiều ham muốn phát triển, dễ bị hấp dẫn bởi cơ hội mới và môi trường sôi động.';
    }
    if (saoMenh.any((s) => s.contains('Phá Quân'))) {
      return 'mạnh về đổi mới, quyết liệt, dám phá khuôn cũ nhưng cần học cách tiết chế nóng vội.';
    }
    if (diemMenh >= 2) {
      return 'mệnh cục có nhiều điểm sáng, nội lực khá và dễ tạo dấu ấn riêng.';
    }
    if (diemMenh <= -2) {
      return 'mệnh cục trải qua nhiều va đập hơn người thường, trưởng thành nhờ thử thách.';
    }
    return 'tính cách pha trộn giữa nội lực, sự thích nghi và nhu cầu tự khẳng định.';
  }

  static String _tomTatTai(List<String> saoTai, int diemTai) {
    if (saoTai.any((s) => s.contains('Vũ Khúc'))) {
      return 'có duyên với tiền bạc thực tế, hợp cách làm ra giá trị rõ ràng và biết tính toán.';
    }
    if (saoTai.any((s) => s.contains('Thiên Phủ'))) {
      return 'thiên về tích lũy bền, giữ của, tăng tài sản theo hướng chậm mà chắc.';
    }
    if (saoTai.any((s) => s.contains('Tham Lang'))) {
      return 'dễ kiếm tiền nhờ giao tiếp, thị trường, thương mại hoặc các cơ hội linh hoạt.';
    }
    if (diemTai >= 2) {
      return 'đường tài bạch khá sáng, nếu biết giữ nhịp thì tài chính tăng dần.';
    }
    if (diemTai <= -2) {
      return 'tiền bạc dễ lên xuống, cần tránh đầu tư nóng và tiêu xài cảm tính.';
    }
    return 'tài vận ở mức trung bình, muốn bền phải đi theo hướng ổn định và quản trị tốt.';
  }

  static String _tomTatQuan(List<String> saoQuan, int diemQuan) {
    if (saoQuan.any((s) => s.contains('Tử Vi'))) {
      return 'dễ hướng tới vị trí điều phối, quản lý hoặc vai trò có tiếng nói.';
    }
    if (saoQuan.any((s) => s.contains('Thiên Tướng'))) {
      return 'hợp môi trường có quy chuẩn, vai trò hỗ trợ điều hành, tổ chức và giữ cân bằng.';
    }
    if (saoQuan.any((s) => s.contains('Thất Sát'))) {
      return 'sự nghiệp thường có áp lực cao, cạnh tranh mạnh, nhưng càng va chạm càng lên tay.';
    }
    if (diemQuan >= 2) {
      return 'đường công danh có lực phát triển, dễ tạo vị thế nếu kiên trì.';
    }
    if (diemQuan <= -2) {
      return 'đường công danh nhiều thử thách, dễ đổi hướng hoặc chịu sức ép lớn trước khi ổn định.';
    }
    return 'sự nghiệp tiến theo kiểu tích lũy dần, cần kiên trì và chọn đúng môi trường.';
  }

  static String _buildMenhThanNarrative({
    required String cungMenh,
    required String cungThan,
    required List<String> saoMenh,
    required List<String> saoThan,
  }) {
    if (cungThan == '--') {
      return 'Dữ liệu Thân cư chưa đủ rõ, nên hiện trọng tâm vẫn đặt vào khí của cung Mệnh và trục Mệnh - Tài - Quan để đọc bản chất lá số.';
    }

    if (cungThan == cungMenh) {
      return 'Mệnh và Thân đồng cung tại $cungMenh nên phần bản chất bên trong và cách sống thể hiện ra ngoài tương đối thống nhất. Người mang cách này thường sống thiên về tự thân lập thế, nghĩ gì làm nấy rõ hơn và các quyết định cá nhân tác động trực tiếp đến nhịp đời.';
    }

    final bool thanDong =
        saoThan.isNotEmpty &&
        _hasAny(saoThan, const [
          'Phá Quân',
          'Tham Lang',
          'Thiên Mã',
          'Thất Sát',
        ]);
    final bool menhOn =
        saoMenh.isNotEmpty &&
        _hasAny(saoMenh, const [
          'Tử Vi',
          'Thiên Phủ',
          'Thiên Tướng',
          'Hóa Khoa',
        ]);

    if (thanDong && menhOn) {
      return 'Mệnh an tại $cungMenh nhưng Thân cư $cungThan cho thấy bên trong muốn sống có nền, có chuẩn, còn cuộc đời thực tế lại buộc phải vận động, thay đổi và va chạm nhiều hơn. Đây là kiểu người càng lớn càng phải học cách dung hòa giữa phần ổn định bên trong và yêu cầu chuyển động của hoàn cảnh.';
    }

    return 'Mệnh an tại $cungMenh nhưng Thân cư $cungThan nên cuộc đời thường có hai lớp: bản chất bên trong một hướng, còn cách bộc lộ ra ngoài và các giai đoạn trưởng thành lại đi theo hướng khác. Vì vậy lá số này không nên đọc quá đơn tuyến mà phải nhìn cả phần “người thật” lẫn phần “đời đẩy mình thành ai”.';
  }

  static String _buildKetLuanMoDau({
    required List<String> saoMenh,
    required List<String> saoTai,
    required List<String> saoQuan,
    required int diemMenh,
    required int diemTai,
    required int diemQuan,
  }) {
    final List<String> all = [...saoMenh, ...saoTai, ...saoQuan];
    final int tong = diemMenh + diemTai + diemQuan;
    final bool hasLoc = _hasAny(all, const ['Lộc Tồn', 'Hóa Lộc']);
    final bool hasQuy = _hasAny(all, const [
      'Thiên Khôi',
      'Thiên Việt',
      'Hóa Khoa',
    ]);
    final bool hasSat = _hasAny(all, const [
      'Kình Dương',
      'Đà La',
      'Hỏa Tinh',
      'Linh Tinh',
      'Địa Không',
      'Địa Kiếp',
    ]);
    final bool hasQuyen = _hasAny(all, const [
      'Hóa Quyền',
      'Tử Vi',
      'Thiên Tướng',
    ]);

    if (tong >= 5 && hasLoc && hasQuy) {
      return 'Đây là lá số có nền phát triển sáng: bản thân có lực, đường tiến thân có cửa mở và khi gặp nút khó thường vẫn còn điểm gỡ chứ không dễ rơi hẳn vào thế bí.';
    }
    if (tong >= 3 && hasLoc && hasQuyen) {
      return 'Đây là lá số có khả năng đi lên bằng thực lực, tích lũy và quyền chủ động. Càng sống đúng nhịp, đương số càng dễ vừa tạo thành quả vừa dựng được vị thế cho riêng mình.';
    }
    if (tong >= 3 && hasLoc) {
      return 'Đây là lá số có khả năng đi lên bằng thực lực và tích lũy, nghĩa là thành quả thường không đến quá ồn ào lúc đầu nhưng càng về sau càng dễ dày lên nếu giữ được nhịp bền.';
    }
    if (tong <= -3 && hasSat && !hasQuy) {
      return 'Đây là lá số nhiều thử thách, không hợp đi theo tâm thế chủ quan hay đánh nhanh thắng nhanh. Càng biết giữ nền và tránh sai nhịp lớn thì càng đỡ hao lực về sau.';
    }
    if (tong <= -2 && hasSat) {
      return 'Đây là lá số phải trưởng thành qua va chạm, nghĩa là thành tựu có thể đến chậm hơn nhưng độ dày kinh nghiệm và sức chịu đựng lại là phần rất đáng giá nếu đương số không nản giữa đường.';
    }
    return 'Đây là lá số trung hòa, không quá thiên lệch một phía, nên kết quả đời sống phụ thuộc nhiều vào cách chọn thời điểm, chọn môi trường và giữ nhịp sống đủ ổn định.';
  }

  static String _buildTongLucNarrative({
    required List<String> saoMenh,
    required List<String> saoTai,
    required List<String> saoQuan,
    required int diemMenh,
    required int diemTai,
    required int diemQuan,
  }) {
    final int tong = diemMenh + diemTai + diemQuan;
    final List<String> all = [...saoMenh, ...saoTai, ...saoQuan];
    final bool hasLoc = _hasAny(all, const ['Lộc Tồn', 'Hóa Lộc']);
    final bool hasQuy = _hasAny(all, const [
      'Thiên Khôi',
      'Thiên Việt',
      'Hóa Khoa',
    ]);
    final bool hasSat = _hasAny(all, const [
      'Kình Dương',
      'Đà La',
      'Hỏa Tinh',
      'Linh Tinh',
      'Địa Không',
      'Địa Kiếp',
    ]);
    final bool hasQuyen = _hasAny(all, const [
      'Hóa Quyền',
      'Tử Vi',
      'Thiên Tướng',
    ]);

    final List<String> parts = [];
    if (tong >= 5) {
      parts.add(
        'Tổng lực lá số khá tốt, nghĩa là khi đã vào đúng guồng thì bản thân có khả năng đẩy cả tài lẫn công danh đi lên cùng nhau.',
      );
    } else if (tong <= -3) {
      parts.add(
        'Tổng lực lá số chịu nhiều lực nén hơn bình thường, nên đường đi hợp nhất vẫn là làm chắc nền và thắng bằng độ bền thay vì thắng bằng nước rút.',
      );
    } else {
      parts.add(
        'Tổng lực lá số ở mức trung hòa: không thiếu cửa phát triển, nhưng đòi hỏi đi từng nhịp và bung lực đúng lúc.',
      );
    }

    if (hasLoc && hasQuyen) {
      parts.add(
        'Điểm mạnh là vừa có lộc khí vừa có khí chủ động, nên nếu giữ được nhịp thì không chỉ có thành quả mà còn có quyền quyết trong phần đời mình dựng lên.',
      );
    } else if (hasLoc) {
      parts.add(
        'Điểm tích cực là mạch lộc vẫn hiện, nên nếu biết chọn đúng nhịp thì thành quả vật chất vẫn có cơ sở để dày lên.',
      );
    }

    if (hasQuy) {
      parts.add(
        'Ngoài ra còn có lớp quý và cứu giải, cho thấy lúc khó thường chưa đến mức hết đường, miễn là đương số đủ tỉnh để nhận ra điểm gỡ.',
      );
    }
    if (hasSat) {
      parts.add(
        'Tuy nhiên sát khí vẫn chen vào, nên mọi bước nhảy lớn đều phải đi bằng nền thật, tránh đốt giai đoạn hoặc quyết quá tay khi cảm xúc đang cao.',
      );
    }

    return parts.join(' ');
  }

  static bool _hasCuuGiai(List<String> stars) {
    return _hasAny(stars, const [
      'Tả Phù',
      'Hữu Bật',
      'Thiên Khôi',
      'Thiên Việt',
      'Hóa Khoa',
      'Thiên Đức',
      'Nguyệt Đức',
      'Ân Quang',
      'Thiên Quý',
    ]);
  }

  static bool _hasAny(List<String> stars, List<String> targets) {
    for (final target in targets) {
      if (stars.any((s) => s.contains(target))) {
        return true;
      }
    }
    return false;
  }
}
