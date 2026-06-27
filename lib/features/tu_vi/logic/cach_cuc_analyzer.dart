class CachCucAnalyzer {
  static const Set<String> _satPhaTham = {'Thất Sát', 'Phá Quân', 'Tham Lang'};
  static const Set<String> _tuPhuVuTuong = {'Tử Vi', 'Thiên Phủ', 'Vũ Khúc', 'Thiên Tướng'};
  static const Set<String> _coNguyetDongLuong = {'Thiên Cơ', 'Thái Âm', 'Thiên Đồng', 'Thiên Lương'};
  static const Set<String> _catTinh = {
    'Tả Phù', 'Hữu Bật', 'Văn Xương', 'Văn Khúc',
    'Thiên Khôi', 'Thiên Việt', 'Long Trì', 'Phượng Các',
    'Tam Thai', 'Bát Tọa', 'Ân Quang', 'Thiên Quý',
    'Hóa Lộc', 'Hóa Quyền', 'Hóa Khoa',
    'Lộc Tồn', 'Thiên Đức', 'Nguyệt Đức',
  };
  static const Set<String> _hungTinh = {
    'Kình Dương', 'Đà La', 'Hỏa Tinh', 'Linh Tinh',
    'Địa Không', 'Địa Kiếp', 'Không Kiếp',
    'Hóa Kỵ', 'Tang Môn', 'Bạch Hổ', 'Thiên Hình', 'Thiên Không',
  };

  static String luanBienChung(
    List<String> saoM,
    String cungM,
    String tuanTriet,
    String menhCuc,
    bool isThan,
  ) {
    final List<String> normalized = saoM
        .map((s) => s.split(' (').first.trim())
        .where((s) => s.isNotEmpty)
        .toSet()
        .toList();

    final List<String> parts = [];

    parts.add(_buildMainTheCuc(normalized, cungM));

    final String tuanTrietText = _buildTuanTriet(tuanTriet, normalized);
    if (tuanTrietText.isNotEmpty) {
      parts.add(tuanTrietText);
    }

    final String menhCucText = _buildMenhCuc(menhCuc);
    if (menhCucText.isNotEmpty) {
      parts.add(menhCucText);
    }

    final String catHungText = _buildCatHung(normalized);
    if (catHungText.isNotEmpty) {
      parts.add(catHungText);
    }

    if (isThan) {
      parts.add(
        'Thân cư Mệnh là dấu hiệu cho thấy đời người mang tính tự thân rất rõ. Từ sớm đã hình thành ý chí tự quyết, càng trưởng thành càng thấy những lựa chọn cá nhân ảnh hưởng trực tiếp đến toàn bộ quỹ đạo cuộc sống.',
      );
    } else {
      parts.add(
        'Mệnh và Thân không đồng cung nên cuộc đời không chỉ do bản tính quyết định, mà còn chịu tác động lớn từ môi trường, quan hệ và các giai đoạn trưởng thành. Càng đi xa càng phải học cách dung hòa giữa con người thật và vai trò ngoài xã hội.',
      );
    }

    return parts.where((e) => e.trim().isNotEmpty).join(' ');
  }

  static String _buildMainTheCuc(List<String> stars, String cungM) {
    if (stars.isEmpty) {
      return 'Lá số mang cách Mệnh Vô Chính Diệu, cho thấy khả năng thích nghi và xoay chuyển rất cao. Nhờ không bị một chính tinh nào chi phối hoàn toàn, đương số dễ linh hoạt trong tư duy và hành động. Tuy nhiên mặt yếu là nếu thiếu nền tảng tinh thần hoặc môi trường không tốt thì dễ cảm thấy lênh đênh, khó định hình lý tưởng sống từ sớm. Nếu có cát tinh đi kèm thì vẫn thành công nhờ mềm dẻo; nếu sát tinh áp đảo thì dễ gặp nhiều thăng trầm.';
    }

    final int hungCount = _countMatches(stars, _hungTinh);

    // Cách đặc biệt: Tử Phủ đồng cung
    if (_hasBoth(stars, 'Tử Vi', 'Thiên Phủ')) {
      return 'Mệnh tại cung $cungM có Tử Vi và Thiên Phủ đồng cung — đây là cách cục vua - tôi cùng hiện, thuộc hàng quý cách nhất trong Tử Vi. Người mang cách này thường có khí chất lãnh đạo bẩm sinh, biết tổ chức, biết thu phục lòng người và giữ được uy nghiêm. Cuộc đời dễ đạt vị thế xã hội, nếu có thêm Khoa - Quyền - Lộc hội tụ thì càng thành công rực rỡ.';
    }

    // Tử Tướng đồng cung
    if (_hasBoth(stars, 'Tử Vi', 'Thiên Tướng')) {
      return 'Mệnh tại cung $cungM có Tử Vi và Thiên Tướng đồng cung — chủ về uy quyền hợp lý, người có khả năng quản lý, thích bao quát lớn và trọng mặt thể diện. Nếu gặp Hóa Quyền hoặc Hóa Lộc thì thường làm đến chức vụ quản lý, trưởng nhóm hoặc sáng lập. Có tầm nhìn xa nhưng đôi khi dễ bị áp lực vì trách nhiệm.';
    }

    // Sát Phá Tham đồng cung (cả 3 sao)
    if (_hasAllThree(stars, 'Thất Sát', 'Phá Quân', 'Tham Lang')) {
      return 'Mệnh tại cung $cungM có Sát - Phá - Tham hội đủ trong một cung — đây là thế cục biến động cực mạnh, cả đời ít khi yên. Người thuộc cách này có tố chất của người mở đường, không ngại đổi thay, làm việc quyết liệt, có thể rất thành công nếu đúng thời, nhưng cũng dễ đổ vỡ nếu chủ quan. Số này đi lên từ va đập, càng nhiều ngã rẽ càng giàu bản lĩnh.';
    }

    // Nhật Nguyệt đồng cung (Thái Dương + Thái Âm cùng cung)
    if (_hasBoth(stars, 'Thái Dương', 'Thái Âm')) {
      return 'Mệnh tại cung $cungM có Nhật Nguyệt đồng cung — cách Nhật Nguyệt Hợp Minh, chủ về cuộc đời có sự quân bình giữa lý trí và tình cảm. Đương số thường sáng sủa, dễ gần, giỏi dung hòa các mối quan hệ. Nếu hội thêm Khoa - Quyền - Lộc thì đỗ đạt cao, danh tiếng tốt, dễ được quý nhân giúp đỡ.';
    }

    // Tử Phủ triều viên (Tử Vi + Thiên Phủ và các sao chính tinh khác)
    // Khoa Quyền Lộc hội
    if (_hasAllThree(stars, 'Hóa Lộc', 'Hóa Quyền', 'Hóa Khoa')) {
      String extra = '';
      if (hungCount > 0) {
        extra = ' Tuy có hung tinh đi kèm nhưng nhờ tam hóa áp chế nên lực phá vẫn trong vòng kiểm soát.';
      }
      return 'Mệnh tại cung $cungM có Hóa Lộc, Hóa Quyền và Hóa Khoa đồng cung hoặc hội chiếu — đây là cách Tam Hóa thủ mệnh, thuộc hàng thượng cách. Cả đời tài danh song toàn: Lộc sinh của cải, Quyền tạo vị thế, Khoa nâng danh vọng. Đương số thường thành công trong sự nghiệp, gặp nhiều may mắn và được cấp trên tin dùng.$extra';
    }

    if (_hasBoth(stars, 'Hóa Lộc', 'Hóa Quyền')) {
      return 'Mệnh tại cung $cungM có Lộc Quyền hội tụ, chủ về làm ăn phát đạt, có khả năng quản lý tài chính tốt và dễ thăng tiến. Công danh sự nghiệp có quý nhân phù trợ, tiền bạc dồi dào nếu biết giữ nhịp phát triển ổn định.';
    }

    // Sát Phá Tham: có ít nhất 1 sao, không có Tử Phủ và Cơ Nguyệt
    final bool hasSatPhaTham = _countMatches(stars, _satPhaTham) >= 1;
    final bool hasTuPhuVuTuong = _countMatches(stars, _tuPhuVuTuong) >= 1;
    final bool hasCoNguyetDongLuong =
        _countMatches(stars, _coNguyetDongLuong) >= 1;

    if (hasSatPhaTham && !hasTuPhuVuTuong && !hasCoNguyetDongLuong) {
      return 'Mệnh tại cung $cungM mang khí của nhóm Sát - Phá - Tham, thế cục của hành động, khai phá và chuyển hóa mạnh. Đây thường là mẫu người không hợp lối sống quá an phận, càng va chạm càng lộ bản lĩnh. Nếu rèn được kỷ luật và biết chọn trận để đánh thì dễ nên việc lớn; ngược lại, nếu nóng vội thì cuộc đời dễ trải nhiều phen được - mất rõ rệt.';
    }

    if (hasTuPhuVuTuong && !hasSatPhaTham && !hasCoNguyetDongLuong) {
      return 'Mệnh tại cung $cungM mang khí của nhóm Tử - Phủ - Vũ - Tướng, thiên về bản lĩnh điều hành, giữ thế và xây nền bền vững. Đương số thường trọng danh dự, có ý thức trách nhiệm, hợp con đường tạo vị thế bằng năng lực thực chất. Càng về sau càng dễ có chỗ đứng, ít thuộc kiểu rực sớm rồi tắt nhanh.';
    }

    if (hasCoNguyetDongLuong && !hasSatPhaTham && !hasTuPhuVuTuong) {
      return 'Mệnh tại cung $cungM nghiêng về nhóm Cơ - Nguyệt - Đồng - Lương, trí tuệ, sự mềm dẻo, lòng nhân và khả năng đi đường dài bằng chất lượng nội tâm là trục chính. Không phải kiểu thắng bằng va đập mạnh, mà thường thắng bằng hiểu người, hiểu việc, biết thời và biết giữ nhịp phát triển bền.';
    }

    // Có ít nhất 1 Khoa Quyền Lộc
    final bool hasKhoa = stars.contains('Hóa Khoa');
    final bool hasQuyen = stars.contains('Hóa Quyền');
    final bool hasLoc = stars.contains('Hóa Lộc');
    if (hasKhoa || hasQuyen || hasLoc) {
      final List<String> tamHoaFound = [];
      if (hasKhoa) tamHoaFound.add('Khoa');
      if (hasQuyen) tamHoaFound.add('Quyền');
      if (hasLoc) tamHoaFound.add('Lộc');
      return 'Mệnh tại cung $cungM có ${tamHoaFound.join(' - ')} hiện diện, mang lại điểm sáng cho số mệnh. Dù thế cục tổng thể có pha trộn nhưng nhờ các hóa này mà mọi việc thường có quý nhân tương trợ, tài năng được phát huy và kết quả đạt được khả quan hơn mặt bằng chung.';
    }

    return 'Mệnh tại cung $cungM cho thấy thế cục pha trộn, không hoàn toàn nghiêng về một nhóm duy nhất. Vừa có phần muốn tiến mạnh, vừa có phần muốn giữ chắc. Cuộc đời nếu biết nhận đúng thế mạnh bản thân thì càng trưởng thành càng rõ đường đi, thành tựu có được từ sự kết hợp hài hòa giữa các tố chất đối lập.';
  }

  static bool _hasBoth(List<String> stars, String a, String b) {
    return stars.contains(a) && stars.contains(b);
  }

  static bool _hasAllThree(List<String> stars, String a, String b, String c) {
    return stars.contains(a) && stars.contains(b) && stars.contains(c);
  }

  static String _buildTuanTriet(String tuanTriet, List<String> stars) {
    if (tuanTriet == 'TRIỆT') {
      return 'Cung Mệnh có Triệt án ngữ nên tiền vận hiếm khi quá bằng phẳng. Tài năng thường không lộ ngay, muốn thành phải qua chặng bị cản, bị thử hoặc phải tự đập đi làm lại một phần đời sống cũ. Nhưng chính Triệt cũng có mặt hay là chặn bớt sự cực đoan của các bộ sao mạnh, khiến người ta chín hơn sau va vấp.';
    }
    if (tuanTriet == 'TUẦN') {
      return 'Cung Mệnh gặp Tuần nên nhịp phát triển thường theo hướng chậm mà chắc, có độ nén trước khi bật. Nhiều việc không đến ồn ào lúc đầu, nhưng càng về sau càng bền nếu đương số kiên trì. Tuần cũng làm cho cái mạnh bớt phô, cái gấp bớt gắt, nhờ đó cuộc đời đỡ cực đoan hơn.';
    }
    return '';
  }

  static String _buildMenhCuc(String menhCuc) {
    if (menhCuc.contains('Cục sinh Mệnh')) {
      return 'Thế Mệnh - Cục ở trạng thái được nâng đỡ, báo hiệu hoàn cảnh sống tương đối có lợi cho sự phát triển. Ra ngoài dễ gặp người hợp, dễ có cơ hội mở ra đúng lúc, và khi gặp khó thường vẫn còn đường tháo gỡ nếu biết nắm lấy.';
    }
    if (menhCuc.contains('Mệnh sinh Cục')) {
      return 'Thế Mệnh sinh Cục cho thấy bản thân phải bỏ nhiều công sức để nuôi hoàn cảnh, gây dựng môi trường hoặc gánh phần chủ động khá lớn. Loại số này càng dựa vào tự lực càng rõ thành quả, nhưng cũng dễ cảm thấy mình phải cho đi nhiều trước khi nhận lại.';
    }
    if (menhCuc.contains('Mệnh khắc Cục')) {
      return 'Thế Mệnh khắc Cục cho thấy đương số thường không thuận hoàn cảnh một cách tự nhiên. Muốn nên việc phải dùng ý chí, bản lĩnh và khả năng chống áp lực để vượt khung. Đây là loại số dễ trưởng thành qua nghịch cảnh, nhưng cái giá thường là mệt hơn người khác trong những giai đoạn đầu.';
    }
    if (menhCuc.contains('Cục khắc Mệnh')) {
      return 'Thế Cục khắc Mệnh báo hiệu môi trường, người xung quanh hoặc dòng đời dễ tạo sức ép lên bản thân. Nếu không có nội lực tốt thì dễ bị hoàn cảnh cuốn đi. Ngược lại, nếu rèn được sức bền tinh thần thì càng về sau càng học được cách sống thông minh và giảm hao tổn.';
    }
    return '';
  }

  static String _buildCatHung(List<String> stars) {
    if (stars.isEmpty) return '';

    final int catCount = _countMatches(stars, _catTinh);
    final int hungCount = _countMatches(stars, _hungTinh);

    if (catCount >= hungCount + 2) {
      return 'Mệnh có cát tinh nâng đỡ khá rõ, nên dù cuộc đời không tránh khỏi thử thách thì thường vẫn có quý nhân, có cơ hội hoặc có lực hồi phục sau mỗi lần chao đảo. Đây là dạng số nếu sống đúng thì càng về sau càng dễ sáng.';
    }
    if (hungCount >= catCount + 2) {
      return 'Hung tinh nổi hơn cát tinh, cho thấy số mệnh có nhiều bài kiểm tra về tâm tính, quyết định và sức chịu đựng. Thành quả nếu có thường không đến nhẹ nhàng, nhưng đổi lại người này dễ có độ dày trải nghiệm và bản lĩnh hơn mặt bằng chung.';
    }
    return 'Cát và hung cùng hiện, nghĩa là lá số vừa có lực nâng vừa có lực thử. Thành bại không nằm ở một phía tuyệt đối mà nằm nhiều ở cách sống, cách chọn môi trường và khả năng giữ mình trước những thời điểm bước ngoặt.';
  }

  static int _countMatches(List<String> stars, Set<String> targets) {
    int count = 0;
    for (final star in stars) {
      for (final target in targets) {
        if (star.contains(target)) {
          count++;
          break;
        }
      }
    }
    return count;
  }
}
