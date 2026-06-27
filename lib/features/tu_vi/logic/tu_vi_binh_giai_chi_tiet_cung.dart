import 'tu_vi_binh_giai_core.dart';

class TuViBinhGiaiChiTietCung {
  static String buildChiTietCung({
    required String tenCung,
    required List<String> sao,
    required int? daiHan,
    required String? tieuHan,
    required String tuanTriet,
  }) {
    final int cat = TuViBinhGiaiCore.scoreCat(sao);
    final int sat = TuViBinhGiaiCore.scoreSat(sao);

    final List<String> parts = [];

    parts.add(_moTaTheoTenCung(tenCung, sao, cat, sat));
    parts.add(_moTaTheoTheCucCung(tenCung, sao, cat, sat));
    parts.add(_moTaTheoSaoNoiBat(sao));
    parts.add(_moTaTheoBoSao(sao, tenCung));
    parts.add(_moTaTheoCuuGiai(tenCung, sao, cat, sat));
    parts.add(_moTaTheoHan(daiHan: daiHan, tieuHan: tieuHan));
    if (tuanTriet.isNotEmpty) {
      parts.add(_moTaTheoTuanTriet(tuanTriet, tenCung));
    }

    return parts.where((e) => e.trim().isNotEmpty).join('\n\n');
  }

  static String _moTaTheoTenCung(
    String tenCung,
    List<String> sao,
    int cat,
    int sat,
  ) {
    switch (tenCung) {
      case 'Mệnh':
        return _cungMenh(sao, cat, sat);
      case 'Phụ Mẫu':
        return _cungPhuMau(sao, cat, sat);
      case 'Phúc Đức':
        return _cungPhucDuc(sao, cat, sat);
      case 'Điền Trạch':
        return _cungDienTrach(sao, cat, sat);
      case 'Quan Lộc':
        return _cungQuanLoc(sao, cat, sat);
      case 'Nô Bộc':
        return _cungNoBoc(sao, cat, sat);
      case 'Thiên Di':
        return _cungThienDi(sao, cat, sat);
      case 'Tật Ách':
        return _cungTatAch(sao, cat, sat);
      case 'Tài Bạch':
        return _cungTaiBach(sao, cat, sat);
      case 'Tử Tức':
        return _cungTuTuc(sao, cat, sat);
      case 'Phu Thê':
        return _cungPhuThe(sao, cat, sat);
      case 'Huynh Đệ':
        return _cungHuynhDe(sao, cat, sat);
      default:
        return 'Cung $tenCung cần được đọc trong liên hệ với toàn cục lá số, nhưng ngay tại cung này vẫn có thể nhận ra mức độ thuận nghịch qua nhóm sao tọa thủ, thế cát hung và cách cung phản ứng với vận hạn.';
    }
  }

  static String _moTaTheoTheCucCung(
    String tenCung,
    List<String> sao,
    int cat,
    int sat,
  ) {
    final List<String> parts = [];
    final bool hasLoc = _hasAny(sao, ['Lộc Tồn', 'Hóa Lộc']);
    final bool hasQuyen = _hasAny(sao, ['Hóa Quyền', 'Tử Vi', 'Thiên Tướng']);
    final bool hasTri = _hasAny(sao, [
      'Văn Xương',
      'Văn Khúc',
      'Thiên Cơ',
      'Hóa Khoa',
    ]);
    final bool hasSatBo = _hasAny(sao, [
      'Kình Dương',
      'Đà La',
      'Hỏa Tinh',
      'Linh Tinh',
      'Địa Không',
      'Địa Kiếp',
    ]);

    if (cat >= sat + 2) {
      parts.add(
        'Xét riêng thế cục nội tại của cung $tenCung, cát khí đang nhỉnh hơn hung khí. Điều này cho thấy nếu đương số tác động đúng cách thì cung này thường có cửa mở, không phải kiểu bế hoàn toàn từ gốc.',
      );
    } else if (sat >= cat + 2) {
      parts.add(
        'Xét riêng thế cục nội tại của cung $tenCung, lực cản đang dày hơn lực nâng. Vì vậy cùng một việc, cung này thường đòi hỏi đi chậm, đi chắc và không được xử lý theo tâm thế chủ quan.',
      );
    } else {
      parts.add(
        'Xét riêng thế cục nội tại của cung $tenCung, cát hung đang đan xen tương đối rõ. Điểm đáng chú ý là kết quả thường không nằm hết ở lá số tĩnh, mà phụ thuộc rất mạnh vào cách đương số chọn thời điểm và cách phản ứng.',
      );
    }

    if (hasLoc && !hasSatBo) {
      parts.add(
        'Cung này có mạch lộc hoặc mạch tăng trưởng khá sạch, nên nếu gặp đúng vận thì thường dễ tạo thành quả thực hơn là chỉ dừng ở tiềm năng.',
      );
    } else if (hasLoc && hasSatBo) {
      parts.add(
        'Điểm đáng chú ý là cung này có lộc khí nhưng không đi đường bằng, nghĩa là có cơ hội thật nhưng thường phải qua va đập, sửa nhịp hoặc trả giá bằng trải nghiệm mới giữ được thành quả.',
      );
    }

    if (hasQuyen) {
      parts.add(
        'Khí quyền hoặc khí vai trò hiện diện cho thấy chuyện của cung này thường sáng hơn khi đương số dám đứng ra nắm việc, chịu trách nhiệm hoặc giữ thế chủ động thay vì chỉ chờ hoàn cảnh đẩy đi.',
      );
    }
    if (hasTri) {
      parts.add(
        'Ngoài ra cung này không chỉ giải bằng sức mà còn giải bằng đầu óc, chuẩn mực và khả năng đọc tình thế. Càng xử lý có chiến lược thì càng đỡ hao.',
      );
    }

    return parts.join(' ');
  }

  static String _moTaTheoCuuGiai(
    String tenCung,
    List<String> sao,
    int cat,
    int sat,
  ) {
    final bool hasCuuGiai = _hasAny(sao, [
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
    final bool hasSatBo = _hasAny(sao, [
      'Kình Dương',
      'Đà La',
      'Hỏa Tinh',
      'Linh Tinh',
      'Địa Không',
      'Địa Kiếp',
      'Hóa Kỵ',
    ]);

    if (hasSatBo && hasCuuGiai) {
      return 'Điểm rất quan trọng của cung $tenCung là tuy có sát khí hoặc nút vướng, nhưng không phải dạng vô cứu. Trong thực tế, điều này thường ứng thành việc vấp vẫn có đường gỡ, khó vẫn có người đỡ hoặc sai còn kịp sửa nếu đương số đủ tỉnh và không cố chấp đi tiếp theo hướng sai.';
    }

    if (hasSatBo && !hasCuuGiai && sat >= cat) {
      return 'Cung $tenCung hiện không cho thấy lớp cứu giải quá rõ ngay trong nội cung. Vì vậy những việc liên quan cung này càng phải phòng từ đầu, giữ chuẩn xử lý và tránh để sai nhỏ tích lại thành nút lớn mới quay lại sửa.';
    }

    if (hasCuuGiai && cat >= sat) {
      return 'Cung $tenCung có lớp sao cứu giải khá đẹp, nghĩa là khi đi đúng đường thì không chỉ thuận mà còn thường có quý nhân, có cách tháo nút hoặc có cơ hội hồi phục sau những pha trục trặc nhỏ.';
    }

    return '';
  }

  static String _moTaTheoSaoNoiBat(List<String> sao) {
    final List<String> moTa = [];

    if (sao.any((s) => s.contains('Tử Vi'))) {
      moTa.add(
        'Tử Vi xuất hiện làm cung này có xu hướng muốn giữ quyền quyết định, trọng vị thế và ít chấp nhận bị dẫn dắt hoàn toàn. Khi đi đúng hướng thì dễ tạo trục ổn định, còn khi lệch hướng thì dễ thành cố chấp hoặc tự gánh quá nhiều.',
      );
    }
    if (sao.any((s) => s.contains('Thiên Phủ'))) {
      moTa.add(
        'Thiên Phủ làm tăng tính giữ nền, bền bỉ, biết lo phần căn cơ và có xu hướng ưu tiên sự chắc chắn hơn là thắng nhanh. Đây là dạng sao giúp cung bớt chao đảo nếu đương số biết đi đường dài.',
      );
    }
    if (sao.any((s) => s.contains('Vũ Khúc'))) {
      moTa.add(
        'Vũ Khúc khiến cung này thiên về thực tế, tính toán rõ ràng, quan tâm hiệu quả cụ thể và ít thích sự mơ hồ. Mặt tốt là chắc tay, mặt khó là đôi lúc cứng, khô hoặc đặt tiêu chuẩn quá cao.',
      );
    }
    if (sao.any((s) => s.contains('Thiên Cơ'))) {
      moTa.add(
        'Thiên Cơ đưa vào cung này tính mưu trí, linh hoạt và khả năng xoay chuyển theo tình thế. Tuy nhiên đi kèm với đó là sắc thái hay nghĩ, hay động và dễ đổi ý khi bối cảnh thay đổi quá nhanh.',
      );
    }
    if (sao.any((s) => s.contains('Tham Lang'))) {
      moTa.add(
        'Tham Lang làm tăng nhu cầu phát triển, giao tế, mở rộng trải nghiệm hoặc theo đuổi điều mình thấy hấp dẫn. Nếu biết tiết chế thì đây là động lực đi lên; nếu không dễ thành phân tán hoặc bị kéo bởi ham muốn nhất thời.',
      );
    }
    if (sao.any((s) => s.contains('Phá Quân'))) {
      moTa.add(
        'Phá Quân báo hiệu cung này khó đứng yên một chỗ quá lâu, thường có nhu cầu thay đổi, bứt khỏi khuôn cũ hoặc phá cái không còn hợp. Điểm mạnh là dám làm lại, điểm yếu là dễ cực đoan nếu thiếu nền đỡ.',
      );
    }
    if (sao.any((s) => s.contains('Hóa Lộc'))) {
      moTa.add(
        'Hóa Lộc đem theo sắc thái tăng trưởng, mở ra lộc khí, cơ hội và khả năng có thêm nguồn lực nếu biết nắm thời thế. Nó không hứa hẹn mọi việc tự tốt lên, nhưng thường cho thấy nơi này có cửa để khai mở.',
      );
    }
    if (sao.any((s) => s.contains('Hóa Kỵ'))) {
      moTa.add(
        'Hóa Kỵ nhắc đến nút thắt, điều khó nói, cảm giác vướng hoặc mặt khuất cần được xử lý bằng sự tỉnh táo. Cung có Hóa Kỵ thường không xấu hoàn toàn, nhưng luôn đòi hỏi học bài học rõ ràng mới thông.',
      );
    }
    if (sao.any((s) => s.contains('Lộc Tồn'))) {
      moTa.add(
        'Lộc Tồn khiến cung này thiên về giữ, tích, chậm mà chắc. Ý nghĩa nổi bật không phải là bùng nổ thật nhanh, mà là khả năng gom lực, giữ lợi thế và tạo nền lâu dài nếu biết kiên trì.',
      );
    }
    if (sao.any((s) => s.contains('Thiếu Dương'))) {
      moTa.add(
        'Thiếu Dương làm cung này sáng hơn theo nghĩa tư duy, nhận thức, sự lanh lẹ và tinh thần muốn tiến lên. Khi đi với cát tinh thì tăng minh mẫn, còn gặp sát tinh thì dễ thành nóng đầu hoặc quá tin vào góc nhìn chủ quan.',
      );
    }
    if (sao.any((s) => s.contains('Tràng Sinh'))) {
      moTa.add(
        'Tràng Sinh báo hiệu khí sống và sức phát triển của cung này còn lực, tức là nếu có nền phù hợp thì dễ nảy nở, hồi phục hoặc tiến dần lên theo thời gian. Đây là một dấu hiệu thiên về sức tăng trưởng hơn là thành quả tức thì.',
      );
    }
    if (sao.any((s) => s.contains('Thiên Hỷ'))) {
      moTa.add(
        'Thiên Hỷ làm mềm cung này theo hướng tăng niềm vui, sự dễ chịu, nhân hòa hoặc cơ hội vui mừng. Tuy nhiên mức độ tốt đến đâu còn tùy toàn bộ nhóm sao đi cùng, chứ không phải chỉ có một mình Thiên Hỷ là đủ.',
      );
    }
    if (sao.any((s) => s.contains('Văn Xương'))) {
      moTa.add(
        'Văn Xương làm cung này sáng về tư duy, học hỏi, năng lực hệ thống hóa và cách biểu đạt mạch lạc. Khi đi đúng bộ, sao này giúp đương số giải việc bằng đầu óc và sự chuẩn chỉnh hơn là chỉ dùng sức hoặc cảm hứng.',
      );
    }
    if (sao.any((s) => s.contains('Văn Khúc'))) {
      moTa.add(
        'Văn Khúc đem vào cung này sắc thái tinh tế, khả năng cảm thụ, biểu đạt và độ nhạy với ý nghĩa ẩn sau câu chữ hay hoàn cảnh. Khi tốt thì thành duyên ăn nói và cảm quan thẩm mỹ; khi lệch thì dễ thành nghĩ nhiều, khó dứt hoặc thiên cảm xúc.',
      );
    }
    if (sao.any((s) => s.contains('Thiên Khôi'))) {
      moTa.add(
        'Thiên Khôi là dấu hiệu của sự nổi bật, được nhìn nhận hoặc có cơ hội bước lên nhờ phẩm chất riêng. Ở cung này, nó thường cho thấy khi đi đúng đường sẽ có người nhận ra giá trị và mở cửa cho đương số.',
      );
    }
    if (sao.any((s) => s.contains('Thiên Việt'))) {
      moTa.add(
        'Thiên Việt tăng duyên gặp quý nhân, gặp người mềm mà đúng lúc, hoặc gặp cơ hội không quá ồn ào nhưng đủ để đổi cục diện. Đây là sao trợ lực theo kiểu kín mà có ích lâu dài.',
      );
    }
    if (sao.any((s) => s.contains('Tả Phù'))) {
      moTa.add(
        'Tả Phù làm rõ yếu tố trợ thủ, phối hợp, có người đứng bên hỗ trợ hoặc ít nhất là không phải tự gánh một mình mọi việc của cung này.',
      );
    }
    if (sao.any((s) => s.contains('Hữu Bật'))) {
      moTa.add(
        'Hữu Bật cho thấy cung này dễ có người phụ lực, thêm tay thêm sức hoặc có những mối quan hệ giúp việc khó trở nên khả thi hơn.',
      );
    }
    if (sao.any((s) => s.contains('Hóa Quyền'))) {
      moTa.add(
        'Hóa Quyền khiến cung này tăng sức nặng, tăng tính chủ động và nhu cầu nắm thế điều khiển. Điểm mạnh là rõ vai, rõ lực; điểm cần giữ là đừng biến thành áp người hoặc quá cứng.',
      );
    }
    if (sao.any((s) => s.contains('Hóa Khoa'))) {
      moTa.add(
        'Hóa Khoa làm cung này sáng về danh, về uy tín, về khả năng gỡ rối bằng tri thức và chuẩn mực. Khi gặp việc khó, đây là một lớp sao giúp đương số thoát bằng sự sáng suốt hơn là may rủi.',
      );
    }
    if (sao.any((s) => s.contains('Kình Dương'))) {
      moTa.add(
        'Kình Dương làm cung này thêm tính cứng, sắc và va chạm. Nó cho sức bật và tính quyết, nhưng cũng khiến sự việc dễ đi căng nếu không biết mềm đúng lúc.',
      );
    }
    if (sao.any((s) => s.contains('Đà La'))) {
      moTa.add(
        'Đà La đem đến lực cản kiểu âm, chậm, lì và dễ kéo dài. Cung có Đà La thường không ngã gục ngay, nhưng lại dễ mắc vào tình trạng nặng đầu, trì trệ hoặc khó gỡ nhanh.',
      );
    }
    if (sao.any((s) => s.contains('Hỏa Tinh'))) {
      moTa.add(
        'Hỏa Tinh làm sự việc tại cung này nóng lên, nhanh lên và dễ bùng phát theo hướng rõ rệt. Khi dùng đúng thì tạo đột phá, khi lệch thì thành hấp tấp, nóng vội hoặc phản ứng quá tay.',
      );
    }
    if (sao.any((s) => s.contains('Linh Tinh'))) {
      moTa.add(
        'Linh Tinh làm cung này nhạy hơn về phản ứng, tâm thế và dao động. Nó thường khiến đương số khó giữ bình hoàn toàn khi sự việc động đến vùng trọng yếu của cung.',
      );
    }
    if (sao.any((s) => s.contains('Địa Không'))) {
      moTa.add(
        'Địa Không làm cung này có sắc thái hụt, rỗng, hoặc thành rồi lại thấy chưa chắc. Những gì liên quan cung này thường cần kiểm kỹ nền tảng, vì vẻ ngoài có thể không phản ánh hết phần thực.',
      );
    }
    if (sao.any((s) => s.contains('Địa Kiếp'))) {
      moTa.add(
        'Địa Kiếp báo hiệu cung này dễ có những pha gãy nhịp, hao lực hoặc biến chuyển gắt nếu xử lý sai thời điểm. Đây là sao đòi hỏi tỉnh táo và không được chủ quan với rủi ro nhỏ.',
      );
    }
    if (sao.any((s) => s.contains('Thiên Hình'))) {
      moTa.add(
        'Thiên Hình làm cung này thêm tính cứng, tính phẫu tích, tính quyết liệt và đôi lúc là cảm giác phải xử lý bằng đường thẳng thay vì đường vòng. Tốt thì thành rõ ranh giới, xấu thì thành căng và đau.',
      );
    }

    if (moTa.isEmpty) {
      return 'Nhóm sao tại cung này không rơi vào mẫu quá đặc thù, nhưng điều đó không có nghĩa là cung vô nghĩa. Trường hợp này nên đọc trọng vào thế cát hung chung, nhịp vận hạn và bộ sao đi cùng để hiểu hướng phát triển của cung.';
    }

    return moTa.join(' ');
  }

  static String _moTaTheoBoSao(List<String> sao, String tenCung) {
    final List<String> parts = [];

    if (_hasAny(sao, ['Tả Phù', 'Hữu Bật'])) {
      parts.add(
        'Cặp Tả Phù - Hữu Bật cho thấy cung này không hoàn toàn đơn độc, thường có trợ lực, người phối hợp hoặc yếu tố nâng đỡ nếu đương số biết mở đúng mối quan hệ và tận dụng đúng thời điểm.',
      );
    }
    if (_hasAny(sao, ['Văn Xương', 'Văn Khúc'])) {
      parts.add(
        'Bộ Văn Xương - Văn Khúc làm cung này sáng về trí, lời nói, học hỏi, giấy tờ hoặc cách trình bày. Khi áp vào đời sống, nó cho thấy chuyện của cung này thường không giải bằng sức mạnh đơn thuần mà bằng đầu óc và cách xử lý tinh tế.',
      );
    }
    if (_hasAny(sao, ['Thiên Khôi', 'Thiên Việt'])) {
      parts.add(
        'Thiên Khôi - Thiên Việt báo hiệu cung này có duyên gặp người nâng đỡ, được nhìn ra giá trị hoặc ít nhất có lúc gặp đúng người đúng thời mà xoay chuyển cục diện.',
      );
    }
    if (_hasAny(sao, ['Đào Hoa', 'Hồng Loan', 'Thiên Hỷ'])) {
      parts.add(
        'Nhóm sao đào hoa - hỷ khí làm cung này có sắc thái mềm, dễ tạo cảm tình, dễ mở nhân duyên hoặc mang theo yếu tố vui mừng. Với các cung về tình cảm, xã hội hay con cái thì tác động này càng rõ.',
      );
    }
    if (_hasAny(sao, ['Kình Dương', 'Đà La'])) {
      parts.add(
        'Kình Dương - Đà La khiến cung này khó đi theo đường mềm hoàn toàn. Nơi nào lẽ ra chỉ cần thuận thì lại sinh va chạm, nơi nào cần kiên nhẫn thì lại hay bị đẩy vào thế gấp, do đó càng phải giữ đầu lạnh.',
      );
    }
    if (_hasAny(sao, ['Địa Không', 'Địa Kiếp', 'Không Kiếp'])) {
      parts.add(
        'Không Kiếp làm tăng sắc thái bất ổn, hụt hẫng hoặc biến chuyển khó lường. Khi hiện diện ở cung $tenCung, điều quan trọng là không vội nhìn một thời điểm để kết luận cả đời, mà phải xét nền bền của cung và cách ứng xử của đương số.',
      );
    }
    if (_hasAny(sao, ['Hỏa Tinh', 'Linh Tinh'])) {
      parts.add(
        'Hỏa Linh làm cung này mang tính bộc phát, nhanh, mạnh và dễ tăng biên độ của sự việc. Nếu gặp cát tinh thì có thể tạo đột phá; nếu gặp sát tinh dày thì dễ đẩy sự việc đi theo hướng quá tay.',
      );
    }
    if (_hasAny(sao, ['Lộc Tồn', 'Hóa Lộc'])) {
      parts.add(
        'Khi Lộc Tồn đi cùng Hóa Lộc hoặc cùng hiện diện với nhóm sao cát, cung này thường có cửa tăng trưởng thực tế hơn, nghĩa là không chỉ có tiềm năng mà còn có khả năng thành hình thành quả nếu đi đúng nhịp.',
      );
    }

    if (_hasAll(sao, ['Văn Xương', 'Văn Khúc'])) {
      parts.add(
        'Văn Xương đi cùng Văn Khúc là bộ tăng trí lực, học lực, khả năng diễn đạt và độ sáng trong cách xử lý vấn đề. Đặt tại cung $tenCung, bộ này thường cho thấy càng dùng đầu óc, chuẩn mực và kỹ năng tinh thì càng khai mở tốt ý nghĩa của cung.',
      );
    }
    if (_hasAll(sao, ['Tả Phù', 'Hữu Bật'])) {
      parts.add(
        'Tả Phù đi cùng Hữu Bật làm rõ thế có người hợp lực, có tay chân, có cộng hưởng. Với cung $tenCung, đây là dấu hiệu cho thấy thành tựu ít khi đến từ đơn độc hoàn toàn mà đến từ khả năng đi cùng đúng người.',
      );
    }
    if (_hasAll(sao, ['Thiên Khôi', 'Thiên Việt'])) {
      parts.add(
        'Thiên Khôi đi cùng Thiên Việt là bộ quý nhân khá rõ, làm cung $tenCung có thêm cửa gặp đúng người, đúng thời, hoặc được nâng bằng uy tín và phẩm chất thay vì chỉ bằng may mắn ngẫu nhiên.',
      );
    }
    if (_hasAll(sao, ['Lộc Tồn', 'Hóa Lộc'])) {
      parts.add(
        'Lộc Tồn đi cùng Hóa Lộc là thế vừa có lộc vừa biết giữ lộc, nên nếu cung $tenCung vốn là nơi có thể sinh thành quả thì bộ này làm cho khả năng tích thành quả càng rõ hơn.',
      );
    }
    if (_hasAll(sao, ['Kình Dương', 'Đà La'])) {
      parts.add(
        'Kình Dương đi cùng Đà La là bộ va cản khá mạnh: một bên đẩy gắt, một bên ghì lì. Vì vậy việc của cung $tenCung thường không êm mà phải thắng bằng bản lĩnh, nhịp chịu đựng và khả năng xử lý xung đột.',
      );
    }
    if (_hasAll(sao, ['Hỏa Tinh', 'Linh Tinh'])) {
      parts.add(
        'Hỏa Tinh đi cùng Linh Tinh làm cung $tenCung tăng mạnh tính bộc phát. Nếu gặp cát tinh nâng đỡ thì thành bứt tốc, còn nếu gặp sát tinh dày thì dễ sinh biến động lớn, nóng nhanh và hao nhanh.',
      );
    }
    if (_hasAll(sao, ['Địa Không', 'Địa Kiếp'])) {
      parts.add(
        'Địa Không đi cùng Địa Kiếp là bộ báo hiệu các pha hụt lực, đổi cục và thử thách khá gắt. Cung $tenCung khi gặp bộ này thì càng cần đọc theo chiều dài thời gian, không nên vội kết luận bằng một thời điểm đơn lẻ.',
      );
    }
    if (_hasAny(sao, ['Đào Hoa', 'Hồng Loan']) &&
        sao.any((s) => s.contains('Thiên Hỷ'))) {
      parts.add(
        'Đào Hoa hoặc Hồng Loan đi cùng Thiên Hỷ làm cung $tenCung đậm sắc thái nhân duyên, vui mừng, mềm hóa và tạo cảm tình. Tác dụng mạnh nhất thường rơi vào các cung tình cảm, xã hội, tử tức hoặc các việc liên quan kết nối con người.',
      );
    }
    if (_hasAny(sao, ['Hóa Kỵ', 'Kình Dương', 'Đà La']) &&
        _hasAny(sao, ['Tả Phù', 'Hữu Bật', 'Hóa Khoa'])) {
      parts.add(
        'Điểm đáng chú ý là cung $tenCung không chỉ có lực cản mà còn có sao cứu giải đi cùng. Điều đó cho thấy tuy vướng, nhưng không phải không có cách hóa giải; mấu chốt nằm ở cách xử lý, thời điểm và độ tỉnh táo của đương số.',
      );
    }
    return parts.join(' ');
  }

  static String _moTaTheoHan({required int? daiHan, required String? tieuHan}) {
    final String han1 = daiHan != null
        ? 'Đại hạn đang đọc tại cung này ứng với mốc $daiHan tuổi'
        : 'Đại hạn tại cung này chưa xác định rõ';
    final String han2 = (tieuHan != null && tieuHan.isNotEmpty)
        ? ', tiểu hạn rơi vào cung $tieuHan'
        : '';

    return '$han1$han2. Khi xét vận, không nên đọc cung này như một ảnh chụp đứng yên. Cùng một cấu trúc sao nhưng vào vận thuận thì thành cơ hội, vào vận ép thì lại thành bài học, vì vậy phải hiểu đây là phần biến động theo chu kỳ chứ không chỉ là lời phán tĩnh.';
  }

  static String _moTaTheoTuanTriet(String tuanTriet, String tenCung) {
    if (tuanTriet == 'TUẦN') {
      return 'Có TUẦN án ngữ tại cung $tenCung nên ý nghĩa của cung này thường đến chậm, thành quả khó thấy ngay từ đầu và nhiều việc phải qua một vòng thử thách mới sáng rõ. Mặt tốt là bớt bốc đồng, mặt khó là dễ sinh cảm giác chậm nhịp so với mong muốn.';
    }
    if (tuanTriet == 'TRIỆT') {
      return 'Có TRIỆT án ngữ tại cung $tenCung nên cung này dễ gặp cảm giác ngắt quãng, bị chặn giữa chừng hoặc phải sửa hướng rồi mới ổn. Điều này không đồng nghĩa cung hỏng, mà thường cho thấy con đường đúng không đi theo lối thẳng và cần sự tỉnh táo để xoay hướng kịp thời.';
    }
    return '';
  }

  static String _cungMenh(List<String> sao, int cat, int sat) {
    final List<String> parts = [];

    if (cat >= sat + 2) {
      parts.add(
        'Cung Mệnh sáng, cho thấy trục bản thân khá vững: biết mình là ai, biết mình muốn gì và càng về sau càng dễ đứng bằng chân của chính mình. Điểm quan trọng ở cung này không phải là hào nhoáng bên ngoài, mà là độ chắc của lõi cá nhân.',
      );
    } else if (sat >= cat + 2) {
      parts.add(
        'Cung Mệnh chịu nhiều va đập, nghĩa là bản thân thường phải trưởng thành qua áp lực, thử thách và các pha tự điều chỉnh khá mạnh. Cung này không hứa một đường dễ đi, nhưng lại cho khả năng tôi luyện bản lĩnh nếu đương số không buông mình theo biến động.',
      );
    } else {
      parts.add(
        'Cung Mệnh ở thế cân bằng, nghĩa là trục bản thân không quá thiên hẳn về thuận hay nghịch. Điều nổi bật là con người này càng sống càng lộ rõ mình, chứ không phải dạng sớm ổn định hoàn toàn ngay từ đầu.',
      );
    }

    if (_hasAny(sao, ['Tử Vi', 'Thiên Phủ', 'Thiên Tướng'])) {
      parts.add(
        'Nhóm sao chủ khí quản trị và giữ nền cho thấy bản thân hợp thế sống có trọng tâm, có vai trò và có phần chủ động quyết định. Càng sống buông trôi hoặc phụ thuộc hoàn toàn vào hoàn cảnh thì càng khó phát đúng chất của cung Mệnh.',
      );
    }
    if (_hasAny(sao, ['Phá Quân', 'Thất Sát', 'Tham Lang'])) {
      parts.add(
        'Nhóm sao thiên động và mạnh cá tính xuất hiện làm cung Mệnh mang sắc thái không chịu ở yên trong khuôn cũ quá lâu. Vì vậy điểm cần giữ không phải là ép mình đứng yên, mà là biết đổi đúng lúc và không đổi theo cảm xúc bốc đồng.',
      );
    }

    return parts.join(' ');
  }

  static String _cungPhuMau(List<String> sao, int cat, int sat) {
    final List<String> parts = [];

    if (cat > sat) {
      parts.add(
        'Cung Phụ Mẫu cho thấy nền gia đạo thời đầu đời có phần nâng đỡ, ít nhất về nề nếp, định hướng hoặc chỗ dựa tinh thần. Ý nghĩa chính của cung này nằm ở phần gốc rễ mình nhận từ gia đình nhiều hơn là chỉ xét chuyện gần gũi cảm xúc đơn thuần.',
      );
    } else if (sat > cat) {
      parts.add(
        'Cung Phụ Mẫu báo hiệu nền gia đình gốc không hoàn toàn nhẹ, dễ có khoảng cách thế hệ, áp lực kỳ vọng hoặc cảm giác phải trưởng thành sớm. Đây là dạng cung khiến đương số chịu ảnh hưởng từ “cách lớn lên” khá mạnh.',
      );
    } else {
      parts.add(
        'Cung Phụ Mẫu ở mức trung bình, nghĩa là gia đạo thời đầu vừa có phần nâng đỡ vừa có phần khó hiểu nhau. Đọc cung này nên nhìn như phần gốc hình thành con người chứ không chỉ là chuyện thuận hay nghịch với cha mẹ ở một giai đoạn cụ thể.',
      );
    }

    if (_hasAny(sao, ['Thiên Lương', 'Thiên Phủ', 'Ân Quang', 'Thiên Quý'])) {
      parts.add(
        'Nhóm sao phúc và bảo hộ cho thấy trong nền gia đình vẫn có lớp giữ khuôn, giữ nghĩa hoặc giữ phúc, nên khi gặp khúc quanh lớn thường không đến mức mất hết chỗ dựa.',
      );
    }
    if (_hasAny(sao, ['Kình Dương', 'Đà La', 'Hóa Kỵ', 'Cô Thần'])) {
      parts.add(
        'Nhóm sao gây cản nhắc rằng điều khó của cung này thường nằm ở sự khó nói, khó mềm hoặc kỳ vọng không trùng nhau. Vì vậy đọc cung Phụ Mẫu nên nghiêng về bài học gia đạo và ảnh hưởng nền sống hơn là chỉ phán quan hệ gần hay xa.',
      );
    }

    return parts.join(' ');
  }

  static String _cungPhucDuc(List<String> sao, int cat, int sat) {
    final List<String> parts = [];

    if (cat > sat) {
      parts.add(
        'Cung Phúc Đức khá ổn, cho thấy nền phúc khí và sức đỡ vô hình còn tốt. Đây là cung nói nhiều về độ dày của nền tinh thần, phúc phần và khả năng “còn đường xoay” khi đời đẩy vào thế khó.',
      );
    } else if (sat > cat) {
      parts.add(
        'Cung Phúc Đức có điểm hao hụt, nghĩa là nền tinh thần và phúc khí cần được bồi nhiều hơn người khác. Dạng cung này không hẳn làm đời xấu ngay, nhưng dễ khiến đương số mệt âm thầm nếu sống lâu trong môi trường hao tâm.',
      );
    } else {
      parts.add(
        'Cung Phúc Đức trung hòa, nghĩa là phúc phần không mỏng nhưng cũng không phải loại sẵn dày để tiêu. Muốn hậu vận yên và lòng nhẹ thì phải tự bồi thêm bằng cách sống, cách nghĩ và cách giữ tâm.',
      );
    }

    if (_hasAny(sao, ['Thiên Đức', 'Nguyệt Đức', 'Long Trì', 'Phượng Các'])) {
      parts.add(
        'Nhóm sao phúc thiện và quý khí tại đây làm rõ rằng lá số vẫn có lớp mềm cứu, tức là những pha khó thường chưa đến mức bít hoàn toàn đường sống nếu bản thân còn giữ được nền đúng.',
      );
    }
    if (_hasAny(sao, ['Tang Môn', 'Bạch Hổ', 'Không Kiếp'])) {
      parts.add(
        'Nếu đi cùng nhiều sao hao và sát, trọng tâm của cung này nằm ở việc nuôi sức bền tinh thần, vì khi Phúc Đức mỏng thì cùng một biến cố nhỏ cũng có thể hao tâm rất lâu.',
      );
    }

    return parts.join(' ');
  }

  static String _cungDienTrach(List<String> sao, int cat, int sat) {
    final List<String> parts = [];

    if (cat > sat) {
      parts.add(
        'Cung Điền Trạch sáng, cho thấy nền sống hữu hình như nhà cửa, chỗ ở, nơi an cư hoặc tài sản giữ được bằng tay có triển vọng khá. Đây là cung thiên về “cái nền để ở và để giữ” hơn là phần tăng trưởng tài chính thuần túy.',
      );
    } else if (sat > cat) {
      parts.add(
        'Cung Điền Trạch có lực cản, nghĩa là chuyện nhà cửa, nơi ở, đất đai hoặc cảm giác an cư dễ chậm nhịp, đổi dời hoặc phát sinh việc phải xử lý kỹ. Điều đáng đọc ở đây là độ ổn của nền sống hơn là chỉ nhìn xem có tài sản hay không.',
      );
    } else {
      parts.add(
        'Cung Điền Trạch ở mức vừa, nền sống hữu hình tiến theo kiểu tích lũy dần. Muốn bền phải đi từng bước, ưu tiên ổn chỗ ở, ổn nhịp sinh hoạt và ổn cách giữ tài sản trước khi tính chuyện nhảy nhanh.',
      );
    }

    if (_hasAny(sao, ['Thiên Phủ', 'Lộc Tồn', 'Hóa Lộc'])) {
      parts.add(
        'Nhóm sao tài và giữ nền cho thấy nếu kiên trì thì chuyện tích sản, giữ chỗ ở ổn hoặc tạo nền sống bền về lâu dài vẫn khá sáng.',
      );
    }
    if (_hasAny(sao, ['Địa Không', 'Địa Kiếp', 'Hóa Kỵ'])) {
      parts.add(
        'Nhóm sao hao và trở lực nhắc rằng mọi chuyện liên quan giấy tờ nhà đất, quyết định mua bán hoặc thay đổi nơi ở đều phải kiểm kỹ, vì sai ở cung này thường kéo dài và ảnh hưởng trực tiếp đến cảm giác ổn định của cuộc sống.',
      );
    }

    return parts.join(' ');
  }

  static String _cungQuanLoc(List<String> sao, int cat, int sat) {
    final List<String> parts = [];

    if (cat > sat) {
      parts.add(
        'Cung Quan Lộc có lực phát triển, cho thấy đường nghề nghiệp có nền để thành việc nếu đi đúng môi trường và giữ được nhịp bền. Trọng tâm của cung này là vị trí đứng trong công việc, khả năng gánh trách nhiệm và cách sự nghiệp tạo ra chỗ đứng xã hội.',
      );
    } else if (sat > cat) {
      parts.add(
        'Cung Quan Lộc nhiều áp lực, nghĩa là công việc thường không đi theo đường quá phẳng mà phải qua cạnh tranh, đổi hướng hoặc va chạm mới ổn dần. Đây là cung cần đọc theo chiều sức chịu nghề và độ chín nghề nghiệp nhiều hơn là chỉ hỏi sớm muộn có thành công hay không.',
      );
    } else {
      parts.add(
        'Cung Quan Lộc ở mức trung bình, cho thấy nghề nghiệp đi theo kiểu tích lũy qua chặng. Ý chính của cung này là phải xây vị thế từng bước, chứ không hợp tâm thế muốn có tên tuổi rõ ràng khi nền còn chưa đủ dày.',
      );
    }

    if (_hasAny(sao, ['Tử Vi', 'Thiên Tướng', 'Hóa Quyền'])) {
      parts.add(
        'Nhóm sao quyền và vai trò xuất hiện cho thấy càng làm công việc có quyền quyết, có phần điều phối hoặc phải đứng ra gánh việc thật thì càng rõ năng lực.',
      );
    }
    if (_hasAny(sao, ['Văn Xương', 'Văn Khúc', 'Thiên Cơ'])) {
      parts.add(
        'Nhóm sao trí và kỹ năng nhấn mạnh rằng sự nghiệp của cung này không chỉ đi bằng sức làm, mà đi mạnh nhờ đầu óc, cách tổ chức và khả năng xử lý vấn đề sắc gọn.',
      );
    }
    if (_hasAny(sao, ['Kình Dương', 'Đà La', 'Hóa Kỵ'])) {
      parts.add(
        'Nhóm sao cản trở báo hiệu điểm khó của cung Quan Lộc thường đến từ quyền hạn, áp lực môi trường, hiểu nhầm hoặc những lỗi có thể ảnh hưởng đến vị thế nghề nghiệp. Vì vậy càng tiến cao càng phải giữ chuẩn và giữ độ tỉnh.',
      );
    }

    return parts.join(' ');
  }

  static String _cungNoBoc(List<String> sao, int cat, int sat) {
    final List<String> parts = [];

    if (cat > sat) {
      parts.add(
        'Cung Nô Bộc cho thấy quan hệ cộng sự, bạn bè đi việc hoặc người hỗ trợ có thể trở thành nguồn nâng lực khá rõ. Đây là cung thiên về mạng lưới đồng hành ngoài huyết thống, nhất là người cùng làm, cùng đi việc hoặc cùng nâng nhau trong đời sống thực tế.',
      );
    } else if (sat > cat) {
      parts.add(
        'Cung Nô Bộc báo hiệu quan hệ xã hội và cộng sự cần chọn lọc kỹ, vì rất dễ gặp người nói hay làm dở, thiếu bền hoặc kéo mình vào phiền lòng. Cung này nên đọc theo chất lượng đội ngũ và môi trường kết giao hơn là chỉ hỏi có đông người quanh mình hay không.',
      );
    } else {
      parts.add(
        'Cung Nô Bộc trung hòa, nghĩa là vẫn có kết nối xã hội hữu ích nhưng hiệu quả đến đâu phụ thuộc rất nhiều vào khả năng chọn người và giữ ranh giới của chính đương số.',
      );
    }

    if (_hasAny(sao, ['Tả Phù', 'Hữu Bật', 'Thiên Khôi', 'Thiên Việt'])) {
      parts.add(
        'Nhóm sao trợ lực cho thấy nếu biết giữ uy tín và mở đúng mối quan hệ thì cộng sự, bạn bè đi việc hoặc người hỗ trợ vẫn có thể trở thành nguồn nâng đỡ đáng kể.',
      );
    }
    if (_hasAny(sao, ['Cô Thần', 'Quả Tú', 'Tang Môn', 'Bạch Hổ'])) {
      parts.add(
        'Nhóm sao cô và hao nhắc rằng ở giữa tập thể chưa chắc đã hết cô độc. Vì vậy đọc cung Nô Bộc nên trọng vào chất lượng kết giao, khả năng phân người và mức độ an toàn của môi trường xã hội quanh mình.',
      );
    }

    return parts.join(' ');
  }

  static String _cungThienDi(List<String> sao, int cat, int sat) {
    final List<String> parts = [];

    if (cat > sat) {
      parts.add(
        'Cung Thiên Di sáng, cho thấy khi bước ra ngoài phạm vi quen thuộc thì dễ gặp cơ hội, môi trường mới hoặc quý nhân giúp mình mở thế. Trọng tâm của cung này là cách lá số phản ứng với thế giới bên ngoài, với việc đi xa, đổi môi trường và va chạm xã hội rộng.',
      );
    } else if (sat > cat) {
      parts.add(
        'Cung Thiên Di có nhiều va chạm, nghĩa là ra ngoài dễ gặp áp lực, thị phi hoặc những pha phải trả giá bằng trải nghiệm trước khi thành kinh nghiệm. Đây là cung cần đọc theo chiều dịch chuyển và va chạm ngoại cảnh, không nên trộn quá nhiều với phần quan hệ thân gần.',
      );
    } else {
      parts.add(
        'Cung Thiên Di ở mức trung bình, đi ra ngoài có cơ hội nhưng phải chủ động thích nghi mới lợi. Ý chính của cung này là khả năng xoay mình trước ngoại cảnh hơn là chỉ nhìn việc đi hay ở.',
      );
    }

    if (_hasAny(sao, ['Thiên Mã', 'Lộc Tồn', 'Hóa Lộc'])) {
      parts.add(
        'Nhóm sao động và lộc cho thấy càng mở địa bàn, giao lưu, đi xa hoặc thay đổi môi trường đúng lúc thì càng dễ mở vận và mở cơ hội thực tế.',
      );
    }
    if (_hasAny(sao, ['Kình Dương', 'Đà La', 'Không Kiếp'])) {
      parts.add(
        'Nhóm sao sát báo hiệu khi ra ngoài không nên chủ quan, vì áp lực ngoại cảnh thường đến nhanh và dễ buộc đương số phải phản ứng trong điều kiện chưa thật sẵn sàng.',
      );
    }

    return parts.join(' ');
  }

  static String _cungTatAch(List<String> sao, int cat, int sat) {
    final List<String> parts = [];

    if (sat >= cat + 2) {
      parts.add(
        'Cung Tật Ách khá nhạy, cho thấy đây là vùng cần chủ động phòng hơn chữa. Trọng tâm của cung này không chỉ nằm ở bệnh tật hữu hình mà còn ở cách cơ thể và tinh thần phản ứng khi bị kéo quá ngưỡng chịu đựng.',
      );
    } else if (cat > sat) {
      parts.add(
        'Cung Tật Ách không quá xấu, nghĩa là khả năng hồi phục và cân bằng còn khá nếu giữ nếp sống điều độ. Ý chính của cung này là biết giữ sức đúng lúc để nền tốt không bị mài mòn dần bởi thói quen xấu.',
      );
    } else {
      parts.add(
        'Cung Tật Ách trung tính, nên sức khỏe không phải điểm quá yếu nhưng cũng không được phép chủ quan. Điều đáng đọc ở đây là các tín hiệu kéo dài, vì nhiều vấn đề nhỏ lặp lại mới là thứ bào mòn nền sức thực sự.',
      );
    }

    if (_hasAny(sao, ['Hỏa Tinh', 'Linh Tinh'])) {
      parts.add(
        'Hỏa Linh tại đây làm tăng xu hướng stress, nóng, bốc hoặc phản ứng cơ thể mạnh khi làm việc quá sức và thiếu nghỉ ngơi.',
      );
    }
    if (_hasAny(sao, ['Kình Dương', 'Đà La', 'Thiên Hình'])) {
      parts.add(
        'Nhóm sao này nhắc phải cẩn trọng va chạm, thương tích, đau nhức kéo dài hoặc những việc liên quan can thiệp y khoa.',
      );
    }
    if (_hasAny(sao, ['Thái Âm', 'Cự Môn'])) {
      parts.add(
        'Ngoài thân thể, cung này còn nhấn mạnh phần nhạy cảm về tinh thần, giấc ngủ, tâm trạng và khả năng hấp thụ áp lực từ môi trường sống.',
      );
    }

    return parts.join(' ');
  }

  static String _cungTaiBach(List<String> sao, int cat, int sat) {
    final List<String> parts = [];

    if (cat > sat) {
      parts.add(
        'Cung Tài Bạch khá sáng, cho thấy khả năng giữ nhịp tiền bạc và tạo thành quả vật chất có cơ sở tốt nếu đi đúng cách. Cung này nên đọc theo chiều dòng tiền, cách tích lũy và năng lực biến công sức thành giá trị thực, chứ không chỉ nhìn chuyện may mắn nhất thời.',
      );
    } else if (sat > cat) {
      parts.add(
        'Cung Tài Bạch báo hiệu tiền bạc dễ lên xuống, nghĩa là việc kiếm - giữ - xoay tiền cần nhiều kỷ luật hơn người khác. Điều đáng lo ở cung này thường không phải một cú mất lớn duy nhất, mà là các quyết định sai nhịp tích lại thành hao hụt dài.',
      );
    } else {
      parts.add(
        'Cung Tài Bạch ở mức vừa, nghĩa là tiền bạc có cửa đi lên nhưng không hợp nóng vội. Trọng tâm của cung này là biết thiết kế nhịp tài chính bền trước, rồi mới tính chuyện mở nhanh hay đánh lớn.',
      );
    }

    if (_hasAny(sao, ['Vũ Khúc', 'Thiên Phủ', 'Lộc Tồn', 'Hóa Lộc'])) {
      parts.add(
        'Nhóm sao tài và giữ của xuất hiện cho thấy nếu làm đúng lĩnh vực, có kỷ luật và giữ được dòng tiền thì tài bạch hoàn toàn có thể thành nền chắc, không chỉ là khoản đến rồi đi.',
      );
    }
    if (_hasAny(sao, ['Địa Không', 'Địa Kiếp', 'Hóa Kỵ'])) {
      parts.add(
        'Nhóm sao hao tổn nhắc rằng mọi chuyện liên quan tiền bạc, giấy tờ, đầu tư hay hùn hạp đều phải kiểm kỹ. Sai ở cung Tài thường không lộ ngay mà phát tác sau, nên càng cần tỉnh ở khâu quyết định.',
      );
    }

    return parts.join(' ');
  }

  static String _cungTuTuc(List<String> sao, int cat, int sat) {
    final List<String> parts = [];

    if (cat > sat) {
      parts.add(
        'Cung Tử Tức nhìn chung có nét thuận, cho thấy phương diện con cái, sự truyền tiếp hoặc những gì mình nuôi dưỡng về sau có cơ sở để thành niềm vui. Đây là cung nên đọc theo chiều hậu duệ, sự nối dài và cảm giác “để lại được gì” nhiều hơn là chỉ hiểu hẹp theo một nghĩa.',
      );
    } else if (sat > cat) {
      parts.add(
        'Cung Tử Tức có điểm lo nghĩ, nghĩa là chuyện con cái hoặc sự nối tiếp dễ đòi hỏi công sức, kiên nhẫn và độ bao dung lớn. Điều khó của cung này thường không nằm ở một sự kiện đơn lẻ mà ở quá trình dài phải học cách chấp nhận điều không thể kiểm soát hoàn toàn.',
      );
    } else {
      parts.add(
        'Cung Tử Tức ở mức trung bình, tức là phương diện con cái và sự nối dài đời mình sẽ sáng nghĩa hơn ở giai đoạn trưởng thành về sau. Cung này nên đọc theo chiều hậu duệ và kết quả nuôi dưỡng lâu dài, không nên vội luận quá sớm bằng tâm thế nóng.',
      );
    }

    if (_hasAny(sao, ['Thiên Hỷ', 'Hồng Loan', 'Đào Hoa'])) {
      parts.add(
        'Nhóm sao hỷ khí làm mềm cung Tử Tức, cho thấy vẫn có cửa đón niềm vui, gắn bó và cảm xúc ấm hơn ở phương diện con cái hoặc những gì mình chăm bón để truyền tiếp.',
      );
    }
    if (_hasAny(sao, ['Cô Thần', 'Quả Tú', 'Hóa Kỵ'])) {
      parts.add(
        'Nhóm sao cô và vướng báo hiệu chuyện con cái, truyền tiếp hoặc cảm giác được nối dài dễ đi kèm lo nghĩ và kỳ vọng. Vì vậy đọc cung này nên nghiêng về bài học nuôi dưỡng và buông kiểm soát đúng lúc.',
      );
    }

    return parts.join(' ');
  }

  static String _cungPhuThe(List<String> sao, int cat, int sat) {
    final List<String> parts = [];

    if (cat > sat) {
      parts.add(
        'Cung Phu Thê có nền thuận hơn nghịch, cho thấy chuyện gắn bó lâu dài có cơ sở để bền nếu chọn đúng người đồng hành. Cung này nên đọc theo chiều xây đời sống chung và khả năng đi đường dài cùng nhau, không chỉ theo cảm xúc yêu đương lúc đầu.',
      );
    } else if (sat > cat) {
      parts.add(
        'Cung Phu Thê có thử thách, nghĩa là đường hôn phối và gắn bó lâu dài thường đòi hỏi độ chín cảm xúc cao. Ý khó của cung này không nằm ở chuyện có duyên hay không, mà ở việc hai người có đủ khả năng sống cùng nhau qua những giai đoạn khắc nghiệt hay không.',
      );
    } else {
      parts.add(
        'Cung Phu Thê ở mức trung hòa, nghĩa là độ bền của quan hệ phụ thuộc nhiều vào giao tiếp, cách giữ nhịp sống chung và khả năng điều chỉnh cái tôi của cả hai bên.',
      );
    }

    if (_hasAny(sao, ['Thái Âm', 'Thiên Đồng', 'Thiên Hỷ', 'Đào Hoa'])) {
      parts.add(
        'Nhóm sao mềm và duyên cho thấy tình cảm không thiếu cảm xúc và sự hấp dẫn, nhưng càng có duyên càng phải giữ độ thật và độ bền để không đẹp lúc đầu rồi mỏi về sau.',
      );
    }
    if (_hasAny(sao, ['Kình Dương', 'Đà La', 'Hóa Kỵ', 'Cô Thần', 'Quả Tú'])) {
      parts.add(
        'Nhóm sao cản và cô nhắc rằng vấn đề lớn của cung này thường nằm ở giao tiếp, chịu đựng, kỳ vọng và cách xử lý xung đột. Vì vậy đọc cung Phu Thê nên trọng vào năng lực đồng hành thực tế hơn là chỉ luận chuyện tình cảm chung chung.',
      );
    }

    return parts.join(' ');
  }

  static String _cungHuynhDe(List<String> sao, int cat, int sat) {
    final List<String> parts = [];

    if (cat > sat) {
      parts.add(
        'Cung Huynh Đệ cho thấy mối liên hệ với anh em hoặc người ngang vai có thể trở thành chỗ dựa nền khi cần. Ý chính của cung này nằm ở tình thân đồng hàng và sức nâng đỡ trong cùng thế hệ hơn là phần giao tế xã hội rộng.',
      );
    } else if (sat > cat) {
      parts.add(
        'Cung Huynh Đệ báo hiệu quan hệ anh em hoặc người rất ngang vai dễ có lúc xa cách, va chạm hoặc khó giữ cùng một nhịp sống lâu dài. Đây là cung nên đọc theo chiều ranh giới thân tộc và tình nghĩa gần, không nên trộn quá nhiều với quan hệ bạn bè ngoài xã hội.',
      );
    } else {
      parts.add(
        'Cung Huynh Đệ ở mức vừa, nghĩa là tình thân và sự hỗ trợ có nhưng không phải lúc nào cũng lộ rõ bằng hành động. Giá trị của cung này thường sáng dần theo thời gian sống và độ chín của mỗi người trong gia đình.',
      );
    }

    if (_hasAny(sao, ['Tả Phù', 'Hữu Bật', 'Long Trì', 'Phượng Các'])) {
      parts.add(
        'Nhóm sao trợ lực và quý khí cho thấy nếu nền gia đạo không quá rối thì anh em hoặc người ngang vai vẫn có thể là chỗ nối lực khá đáng kể ở những thời điểm then chốt.',
      );
    }
    if (_hasAny(sao, ['Kình Dương', 'Đà La', 'Tang Môn', 'Bạch Hổ'])) {
      parts.add(
        'Nhóm sao va chạm nhắc rằng điều khó ở cung này thường đến từ kỳ vọng thân tình, tức là càng gần càng dễ chạm. Vì vậy đọc cung Huynh Đệ nên nghiêng về bài học giữ nghĩa và hiểu giới hạn hơn là chỉ hỏi hợp hay khắc.',
      );
    }

    return parts.join(' ');
  }

  static bool _hasAll(List<String> sao, List<String> targets) {
    for (final target in targets) {
      if (!sao.any((s) => s.contains(target))) {
        return false;
      }
    }
    return true;
  }

  static bool _hasAny(List<String> sao, List<String> targets) {
    for (final target in targets) {
      if (sao.any((s) => s.contains(target))) {
        return true;
      }
    }
    return false;
  }
}
