class TuViBinhGiaiChuDe {
  static String buildTinhCachKhiChat({
    required List<String> saoMenh,
    required List<String> saoThan,
    required int diemMenh,
  }) {
    final all = <String>{...saoMenh, ...saoThan}.toList();
    final List<String> parts = [];

    final String cotLoi = _buildTinhCachCotLoi(all, diemMenh);
    final String bieuHien = _buildTinhCachBieuHien(all, diemMenh);
    final String diemManh = _buildTinhCachDiemManh(all);
    final String canLuuY = _buildTinhCachCanLuuY(all, diemMenh);

    if (cotLoi.isNotEmpty) parts.add(cotLoi);
    if (bieuHien.isNotEmpty) parts.add(bieuHien);
    if (diemManh.isNotEmpty) parts.add(diemManh);
    if (canLuuY.isNotEmpty) parts.add(canLuuY);

    return parts.join(' ');
  }

  static String buildCongDanh({
    required List<String> saoQuan,
    required int diemQuan,
    required int? daiHan,
  }) {
    final List<String> parts = [];

    parts.add(_buildCongDanhNenTang(saoQuan, diemQuan));
    parts.add(_buildCongDanhHopNghe(saoQuan));
    parts.add(_buildCongDanhRuiRo(saoQuan, diemQuan));

    if (daiHan != null) {
      parts.add(
        'Vào đại hạn $daiHan tuổi, trọng tâm không chỉ là làm nhiều hơn mà là chọn đúng vai: nên nâng trách nhiệm, đổi cách làm hay chuyển hẳn sang môi trường hợp lực hơn với mình.',
      );
    }

    return parts.where((e) => e.trim().isNotEmpty).join(' ');
  }

  static String buildTaiBach({
    required List<String> saoTai,
    required int diemTai,
  }) {
    final List<String> parts = [];

    parts.add(_buildTaiBachNenTang(saoTai, diemTai));
    parts.add(_buildTaiBachCachKiemTien(saoTai));
    parts.add(_buildTaiBachLuuY(saoTai, diemTai));

    return parts.where((e) => e.trim().isNotEmpty).join(' ');
  }

  static String buildTinhCam({
    required List<String> saoPhuThe,
    required int diemPhuThe,
  }) {
    final List<String> parts = [];

    parts.add(_buildTinhCamNenTang(saoPhuThe, diemPhuThe));
    parts.add(_buildTinhCamMauNguoi(saoPhuThe));
    parts.add(_buildTinhCamLuuY(saoPhuThe, diemPhuThe));

    return parts.where((e) => e.trim().isNotEmpty).join(' ');
  }

  static String buildSucKhoe({
    required List<String> saoTatAch,
    required int diemTatAch,
  }) {
    final List<String> parts = [];

    parts.add(_buildSucKhoeNenTang(saoTatAch, diemTatAch));
    parts.add(_buildSucKhoeDiemNhayCam(saoTatAch));
    parts.add(_buildSucKhoeKhuyenNghi(saoTatAch, diemTatAch));

    return parts.where((e) => e.trim().isNotEmpty).join(' ');
  }

  static String buildChaMeGiaDinhGoc({
    required List<String> saoPhuMau,
    required int diemPhuMau,
  }) {
    final List<String> parts = [];

    parts.add(_buildChaMeNenTang(saoPhuMau, diemPhuMau));
    parts.add(_buildChaMeTacDong(saoPhuMau));
    parts.add(_buildChaMeLuuY(saoPhuMau, diemPhuMau));

    return parts.where((e) => e.trim().isNotEmpty).join(' ');
  }

  static String buildAnhEmBanBe({
    required List<String> saoHuynhDe,
    required List<String> saoNoBoc,
    required int diemHuynhDe,
    required int diemNoBoc,
  }) {
    final List<String> parts = [];

    parts.add(_buildAnhEmNenTang(saoHuynhDe, diemHuynhDe));
    parts.add(_buildBanBeNenTang(saoNoBoc, diemNoBoc));
    parts.add(
      _buildQuanHeXaHoiLuuY(saoHuynhDe, saoNoBoc, diemHuynhDe, diemNoBoc),
    );

    return parts.where((e) => e.trim().isNotEmpty).join(' ');
  }

  static String buildConCaiHauVan({
    required List<String> saoTuTuc,
    required List<String> saoPhucDuc,
    required int diemTuTuc,
    required int diemPhucDuc,
  }) {
    final List<String> parts = [];

    parts.add(_buildConCaiNenTang(saoTuTuc, diemTuTuc));
    parts.add(_buildHauVanNenTang(saoPhucDuc, diemPhucDuc));
    parts.add(
      _buildConCaiHauVanLuuY(saoTuTuc, saoPhucDuc, diemTuTuc, diemPhucDuc),
    );

    return parts.where((e) => e.trim().isNotEmpty).join(' ');
  }

  static String buildTongKet({
    required int diemMenh,
    required int diemTai,
    required int diemQuan,
    required int diemPhuThe,
    required int diemTatAch,
  }) {
    final int tong = diemMenh + diemTai + diemQuan + diemPhuThe - diemTatAch;
    final List<String> parts = [];

    if (tong >= 5) {
      parts.add(
        'Tổng kết lá số cho thấy nền số có lực phát triển khá tốt, càng về sau càng dễ ổn định và sáng rõ đường đi.',
      );
    } else if (tong <= -3) {
      parts.add(
        'Tổng kết lá số cho thấy cuộc đời có nhiều bài học và va chạm, nhưng nếu đi bền và tỉnh táo vẫn chuyển hung thành kinh nghiệm sống quý.',
      );
    } else {
      parts.add(
        'Tổng kết lá số cho thấy đây là thế số trung hòa, thành bại phụ thuộc rất nhiều vào lựa chọn môi trường, thời điểm và bản lĩnh cá nhân.',
      );
    }

    if (diemMenh >= 2) {
      parts.add(
        'Điểm sáng lớn nhất nằm ở nội lực cá nhân: khi đã hiểu mình muốn gì thì càng đi càng chắc.',
      );
    } else if (diemMenh <= -2) {
      parts.add(
        'Bài học lớn nhất nằm ở việc giữ tâm ổn định và không để các giai đoạn xuống tinh thần làm lệch hướng sống dài hạn.',
      );
    }

    if (diemTai > diemQuan && diemTai >= 1) {
      parts.add(
        'Tài vận thường mở nhanh hơn công danh, nên có thể lấy tiền bạc và kỹ năng thực chiến làm bàn đạp trước.',
      );
    } else if (diemQuan > diemTai && diemQuan >= 1) {
      parts.add(
        'Công danh và vị thế xã hội là trục nên đầu tư dài hạn, vì khi nghề nghiệp lên thì tài vận cũng theo đó mà chắc hơn.',
      );
    }

    if (diemPhuThe <= -2) {
      parts.add(
        'Đường tình cảm không nên nóng vội; càng trưởng thành cảm xúc thì hậu vận gia đạo càng đỡ sóng gió.',
      );
    }

    if (diemTatAch <= -2) {
      parts.add(
        'Nền sức khỏe và tinh thần cần được giữ như một ưu tiên chiến lược, không nên đợi có vấn đề rõ mới bắt đầu điều chỉnh.',
      );
    }

    return 'Tóm lại, ${parts.join(' ')}';
  }

  static String _buildTinhCachCotLoi(List<String> all, int diemMenh) {
    final List<String> cores = [];

    if (all.any((s) => s.contains('Tử Vi'))) {
      cores.add(
        'bản chất tự chủ, có lòng tự trọng và thích nắm thế chủ động trong việc lớn',
      );
    }
    if (all.any((s) => s.contains('Thiên Cơ'))) {
      cores.add(
        'đầu óc xoay nhanh, nhạy với biến động và khó chịu khi bị bó cứng quá lâu',
      );
    }
    if (all.any((s) => s.contains('Thái Âm'))) {
      cores.add(
        'nội tâm sâu, giàu cảm nhận và có xu hướng giữ nhiều suy nghĩ bên trong',
      );
    }
    if (all.any((s) => s.contains('Tham Lang'))) {
      cores.add(
        'ưa trải nghiệm, ham học hỏi và cần môi trường có sự vận động để thấy mình sống',
      );
    }
    if (all.any((s) => s.contains('Phá Quân'))) {
      cores.add(
        'có xu hướng phá khuôn cũ, không thích bị áp đặt và càng bí bách càng muốn bứt ra',
      );
    }

    if (cores.isEmpty) {
      if (diemMenh >= 2) {
        return 'đương số có nội lực khá tốt, khí chất sáng và thường không chịu ở yên trong thế yếu quá lâu.';
      }
      if (diemMenh <= -2) {
        return 'đương số trưởng thành nhờ va chạm, càng đi qua khó khăn càng đằm và lì hơn.';
      }
      return 'đương số có khí chất cân bằng, thiên về thích nghi theo hoàn cảnh hơn là cực đoan một chiều.';
    }

    return 'đương số mang khí chất ${cores.join(', ')}.';
  }

  static String _buildTinhCachBieuHien(List<String> all, int diemMenh) {
    if (all.any((s) => s.contains('Văn Xương')) ||
        all.any((s) => s.contains('Văn Khúc'))) {
      return 'Ra ngoài thường thể hiện qua lời nói, tư duy, khả năng diễn đạt hoặc sự chỉn chu trong cách trình bày vấn đề.';
    }
    if (all.any((s) => s.contains('Thất Sát')) ||
        all.any((s) => s.contains('Kình Dương'))) {
      return 'Khi gặp áp lực dễ phản ứng nhanh, mạnh và quyết, nên người khác thường cảm nhận đây là mẫu người khó ép buộc.';
    }
    if (all.any((s) => s.contains('Thiên Đồng')) ||
        all.any((s) => s.contains('Thiên Lương'))) {
      return 'Bề ngoài có thể mềm và ôn hơn nội tâm thật, nhưng càng thân càng thấy rõ hệ nguyên tắc riêng rất khó xê dịch.';
    }
    if (diemMenh >= 2) {
      return 'Khí chất bên ngoài thường tạo cảm giác tin cậy, có năng lượng tiến lên và ít khi chịu đầu hàng sớm.';
    }
    if (diemMenh <= -2) {
      return 'Bề ngoài đôi lúc mang cảm giác dè chừng hoặc căng, vì bản thân thường quan sát nhiều trước khi thật sự mở lòng.';
    }
    return 'Cách biểu hiện ra ngoài khá linh hoạt, tùy môi trường mà thiên về mềm hay cứng.';
  }

  static String _buildTinhCachDiemManh(List<String> all) {
    final List<String> strengths = [];

    if (all.any((s) => s.contains('Tả Phù')) ||
        all.any((s) => s.contains('Hữu Bật'))) {
      strengths.add('biết xoay sở và tìm người đồng hành đúng lúc');
    }
    if (all.any((s) => s.contains('Thiên Khôi')) ||
        all.any((s) => s.contains('Thiên Việt'))) {
      strengths.add(
        'có duyên gặp quý nhân hoặc ít nhất gặp người biết nhìn ra điểm mạnh của mình',
      );
    }
    if (all.any((s) => s.contains('Hóa Khoa'))) {
      strengths.add(
        'giữ được sự tỉnh táo và danh dự trong những việc quan trọng',
      );
    }
    if (all.any((s) => s.contains('Hóa Quyền'))) {
      strengths.add(
        'khi vào việc thường có sức nặng và khả năng khiến người khác phải chú ý',
      );
    }

    if (strengths.isEmpty) return '';
    return 'Điểm mạnh dễ thấy là ${strengths.join(', ')}.';
  }

  static String _buildTinhCachCanLuuY(List<String> all, int diemMenh) {
    final List<String> cautions = [];

    if (all.any((s) => s.contains('Phá Quân')) ||
        all.any((s) => s.contains('Thất Sát'))) {
      cautions.add('dễ quyết nhanh khi cảm xúc đang lên');
    }
    if (all.any((s) => s.contains('Hóa Kỵ'))) {
      cautions.add('có lúc tự giữ trong lòng quá nhiều rồi thành nặng tâm');
    }
    if (all.any((s) => s.contains('Kình Dương')) ||
        all.any((s) => s.contains('Đà La'))) {
      cautions.add('khi đã căng dễ nói cứng hoặc làm mạnh tay quá cần thiết');
    }

    if (cautions.isEmpty) {
      if (diemMenh <= -2) {
        return 'Điều cần lưu ý là không nên sống quá gồng, vì càng tự ép mình lâu dài càng dễ mất cân bằng tinh thần.';
      }
      return 'Điều cần lưu ý là phải giữ nhịp sống ổn định, tránh để tài năng bị kéo lệch bởi cảm xúc nhất thời.';
    }

    return 'Điều cần lưu ý là ${cautions.join(', ')}; càng trưởng thành càng nên học cách giữ nhịp và hạ bớt cực đoan.';
  }

  static String _buildCongDanhNenTang(List<String> saoQuan, int diemQuan) {
    final List<String> traits = [];

    if (saoQuan.any((s) => s.contains('Tử Vi'))) {
      traits.add(
        'có xu hướng muốn nắm việc, không hợp ở mãi vị trí chỉ làm theo mà không có tiếng nói',
      );
    }
    if (saoQuan.any((s) => s.contains('Thiên Tướng'))) {
      traits.add(
        'hợp môi trường có tổ chức, nơi trách nhiệm và vai trò được phân rõ',
      );
    }
    if (saoQuan.any((s) => s.contains('Thất Sát'))) {
      traits.add(
        'đường nghề dễ đi cùng áp lực cao, nhưng càng va chạm càng lộ bản lĩnh',
      );
    }
    if (saoQuan.any((s) => s.contains('Văn Xương')) ||
        saoQuan.any((s) => s.contains('Văn Khúc'))) {
      traits.add(
        'có lợi thế ở các công việc cần tư duy, diễn đạt, giấy tờ hoặc chuyên môn',
      );
    }

    if (traits.isNotEmpty) {
      return 'Nhìn theo khía cạnh đời sống, công việc của đương số ${traits.join(', ')}.';
    }

    if (diemQuan >= 2) {
      return 'Đường công danh có lực đi lên, nhưng kiểu tiến mạnh nhất là tiến bằng vị thế và độ tin cậy chứ không phải chỉ bằng bề nổi.';
    }
    if (diemQuan <= -2) {
      return 'Công việc thường không yên ngay từ đầu; phải qua đổi hướng, va chạm hoặc tự chỉnh mình khá nhiều mới vào đúng guồng.';
    }
    return 'Công danh đi theo kiểu tích lũy, càng bền nghề và bền nhịp thì càng dễ có chỗ đứng chắc hơn về sau.';
  }

  static String _buildCongDanhHopNghe(List<String> saoQuan) {
    if (saoQuan.any((s) => s.contains('Vũ Khúc'))) {
      return 'Kiểu nghề hợp thường liên quan quản trị tài chính, kinh doanh, vận hành hoặc các việc phải làm chắc tay và nhìn thẳng vào hiệu quả.';
    }
    if (saoQuan.any((s) => s.contains('Thiên Cơ'))) {
      return 'Kiểu nghề hợp thường là việc cần đầu óc, kỹ thuật, chiến lược, xử lý hệ thống hoặc xoay xở nhanh trước biến động.';
    }
    if (saoQuan.any((s) => s.contains('Tham Lang'))) {
      return 'Kiểu nghề hợp thường nghiêng về thị trường, thương mại, giao tiếp, phát triển khách hàng hoặc môi trường tăng trưởng nhanh.';
    }
    if (saoQuan.any((s) => s.contains('Thiên Đồng')) ||
        saoQuan.any((s) => s.contains('Thiên Lương'))) {
      return 'Kiểu nghề hợp thường thiên về hỗ trợ con người, giáo dục, cố vấn, chăm sóc hoặc môi trường cần sự mềm dẻo và hiểu người.';
    }
    return 'Nguyên tắc chọn nghề của lá số này là chọn nơi có đất phát huy sở trường lâu dài, không nên vì vẻ ngoài hào nhoáng mà bước vào chỗ không hợp khí chất thật.';
  }

  static String _buildCongDanhRuiRo(List<String> saoQuan, int diemQuan) {
    final List<String> risks = [];

    if (saoQuan.any((s) => s.contains('Hóa Kỵ'))) {
      risks.add('dễ vướng hiểu lầm, áp lực danh dự hoặc sai sót giấy tờ');
    }
    if (saoQuan.any((s) => s.contains('Kình Dương')) ||
        saoQuan.any((s) => s.contains('Đà La'))) {
      risks.add('dễ cứng quá trong phối hợp hoặc va chạm quyền hạn');
    }
    if (saoQuan.any((s) => s.contains('Địa Không')) ||
        saoQuan.any((s) => s.contains('Địa Kiếp'))) {
      risks.add('dễ đổi mạnh khi nền chưa vững hoặc quyết sai thời điểm');
    }

    if (risks.isEmpty) {
      if (diemQuan <= -2) {
        return 'Điều cần giữ nhất là đừng vừa gặp khó đã đổi đường liên tục; bài toán lớn của công danh là bền nhịp chứ không phải tăng tốc ngắn hạn.';
      }
      return 'Điều cần giữ nhất là kỷ luật dài hạn, vì đường nghề của lá số này mạnh ở độ bền hơn là cú bứt một lần rồi thôi.';
    }

    return 'Điểm dễ vướng trong sự nghiệp là ${risks.join(', ')}.';
  }

  static String _buildTaiBachNenTang(List<String> saoTai, int diemTai) {
    final List<String> traits = [];

    if (saoTai.any((s) => s.contains('Vũ Khúc'))) {
      traits.add(
        'có duyên với tiền bạc thực chất và biết nhìn vào giá trị thật',
      );
    }
    if (saoTai.any((s) => s.contains('Thiên Phủ'))) {
      traits.add('thiên về giữ tiền, tích lũy và xây nền tài chính bền');
    }
    if (saoTai.any((s) => s.contains('Tham Lang'))) {
      traits.add(
        'kiếm tiền tốt khi năng động, bám thị trường và mở quan hệ đúng lúc',
      );
    }
    if (saoTai.any((s) => s.contains('Hóa Lộc'))) {
      traits.add('có cửa đón lộc tài nếu đi đúng thời và đúng mạch việc');
    }

    if (traits.isNotEmpty) {
      return 'Về đời sống thực tế, đường tiền bạc cho thấy ${traits.join(', ')}.';
    }

    if (diemTai >= 2) {
      return 'Nền tài vận khá sáng, càng đi lâu càng có khả năng dày vốn hoặc dày nền tích lũy nếu không tự phá nhịp.';
    }
    if (diemTai <= -2) {
      return 'Tiền bạc dễ lên xuống, nên điểm sống còn không phải là kiếm nhanh mà là giữ được và xoay đúng lúc.';
    }
    return 'Tiền bạc ở mức vừa, muốn bền phải coi trọng quản trị dòng tiền hơn là chỉ chăm chăm nhìn cơ hội tăng nhanh.';
  }

  static String _buildTaiBachCachKiemTien(List<String> saoTai) {
    if (saoTai.any((s) => s.contains('Văn Xương')) ||
        saoTai.any((s) => s.contains('Văn Khúc'))) {
      return 'Tiền cũng dễ đến từ tri thức, kỹ năng chuyên môn, nội dung, tư vấn hoặc công việc phải dùng đầu óc và lời nói.';
    }
    if (saoTai.any((s) => s.contains('Lộc Tồn'))) {
      return 'Cách kiếm tiền hợp nhất là làm đều tay, tích chậm mà chắc, không quá hợp lối đánh một cú lớn rồi phó mặc may rủi.';
    }
    if (saoTai.any((s) => s.contains('Thiên Mã'))) {
      return 'Tiền tài dễ mở ra khi có dịch chuyển, mở địa bàn, thay đổi mô hình hoặc làm trong môi trường linh hoạt.';
    }
    return 'Cách kiếm tiền hợp lá số này là đi theo giá trị thật và năng lực thật, tránh ham đường tắt quá nhanh nhưng nền chưa đủ dày.';
  }

  static String _buildTaiBachLuuY(List<String> saoTai, int diemTai) {
    final List<String> cautions = [];

    if (saoTai.any((s) => s.contains('Hóa Kỵ'))) {
      cautions.add(
        'dễ sai giấy tờ, đầu tư theo cảm xúc hoặc tin người quá nhanh',
      );
    }
    if (saoTai.any((s) => s.contains('Địa Không')) ||
        saoTai.any((s) => s.contains('Địa Kiếp'))) {
      cautions.add('dễ hao hụt bất ngờ hoặc đánh đổi lớn khi dữ kiện chưa đủ');
    }
    if (saoTai.any((s) => s.contains('Kình Dương')) ||
        saoTai.any((s) => s.contains('Đà La'))) {
      cautions.add(
        'dễ gồng tài chính quá mức hoặc giữ một quyết định sai quá lâu',
      );
    }

    if (cautions.isEmpty) {
      if (diemTai <= -2) {
        return 'Điều cần nhất là tách rõ nhu cầu thật với chi tiêu cảm tính và giữ kỷ luật tiền bạc chặt hơn bình thường.';
      }
      return 'Muốn tài vận bền, nên ưu tiên tích lũy và kiểm soát rủi ro thay vì chỉ nhìn chỗ tăng nhanh.';
    }

    return 'Điểm cần giữ trong tiền bạc là ${cautions.join(', ')}.';
  }

  static String _buildTinhCamNenTang(List<String> saoPhuThe, int diemPhuThe) {
    final List<String> traits = [];

    if (saoPhuThe.any((s) => s.contains('Thái Âm')) ||
        saoPhuThe.any((s) => s.contains('Thiên Đồng'))) {
      traits.add(
        'tình cảm thiên về sự mềm mỏng, cảm xúc và nhu cầu được hiểu sâu',
      );
    }
    if (saoPhuThe.any((s) => s.contains('Tham Lang'))) {
      traits.add(
        'duyên đến khá mạnh, dễ rung động và cũng dễ bị cảm xúc kéo đi nếu thiếu nền ổn định',
      );
    }
    if (saoPhuThe.any((s) => s.contains('Đào Hoa')) ||
        saoPhuThe.any((s) => s.contains('Hồng Loan'))) {
      traits.add('nhân duyên không kém, dễ được chú ý hoặc có sức hút riêng');
    }

    if (traits.isNotEmpty) {
      return 'Nhìn theo đời sống tình cảm, đương số ${traits.join(', ')}.';
    }

    if (diemPhuThe >= 2) {
      return 'Đường tình cảm có nền thuận hơn nghịch, dễ ổn định khi gặp đúng người và đúng thời điểm sống.';
    }
    if (diemPhuThe <= -2) {
      return 'Tình cảm thường có thử thách, dễ chậm ổn định hoặc phải qua va chạm mới hiểu rõ mình thật sự cần ai và cần kiểu gắn bó nào.';
    }
    return 'Đường tình cảm ở mức trung bình, muốn bền phải dựa vào sự trưởng thành hơn là cảm xúc nhất thời.';
  }

  static String _buildTinhCamMauNguoi(List<String> saoPhuThe) {
    if (saoPhuThe.any((s) => s.contains('Thiên Tướng')) ||
        saoPhuThe.any((s) => s.contains('Thiên Phủ'))) {
      return 'Mẫu người hợp thường là người chững, giữ lời, có trách nhiệm và không quá thất thường trong cảm xúc lẫn lối sống.';
    }
    if (saoPhuThe.any((s) => s.contains('Tham Lang')) ||
        saoPhuThe.any((s) => s.contains('Đào Hoa'))) {
      return 'Mẫu duyên đến thường có sức hút, biết giao tiếp và tạo cảm xúc mạnh, nhưng càng hấp dẫn càng cần xét kỹ độ bền để tránh say quá sớm.';
    }
    if (saoPhuThe.any((s) => s.contains('Thất Sát')) ||
        saoPhuThe.any((s) => s.contains('Phá Quân'))) {
      return 'Tình cảm không hợp kiểu mập mờ kéo dài; càng rõ ràng, trưởng thành và có nguyên tắc thì càng dễ bền.';
    }
    return 'Người hợp nhất vẫn là người có khả năng đồng hành lâu dài, biết sống cùng và biết gánh cùng, chứ không chỉ tạo cảm xúc mạnh lúc ban đầu.';
  }

  static String _buildTinhCamLuuY(List<String> saoPhuThe, int diemPhuThe) {
    final List<String> cautions = [];

    if (saoPhuThe.any((s) => s.contains('Hóa Kỵ'))) {
      cautions.add(
        'dễ hiểu lầm, giữ trong lòng quá lâu hoặc kỳ vọng mà không nói rõ',
      );
    }
    if (saoPhuThe.any((s) => s.contains('Kình Dương')) ||
        saoPhuThe.any((s) => s.contains('Đà La'))) {
      cautions.add(
        'dễ va chạm vì cái tôi hoặc phản ứng quá thẳng khi đang tổn thương',
      );
    }
    if (saoPhuThe.any((s) => s.contains('Cô Thần')) ||
        saoPhuThe.any((s) => s.contains('Quả Tú'))) {
      cautions.add(
        'dễ có cảm giác cô độc trong quan hệ dù bề ngoài vẫn còn gắn bó',
      );
    }

    if (cautions.isEmpty) {
      if (diemPhuThe <= -2) {
        return 'Điều quan trọng nhất là không nên chốt quá sớm khi nền hiểu nhau chưa đủ sâu và chưa thử được sức bền của mối quan hệ.';
      }
      return 'Muốn tình cảm đi xa, đương số cần giữ sự ổn định trong cách yêu và học cách nói thật điều mình cần.';
    }

    return 'Điểm cần lưu ý trong tình cảm là ${cautions.join(', ')}.';
  }

  static String _buildSucKhoeNenTang(List<String> saoTatAch, int diemTatAch) {
    final List<String> parts = [];

    if (saoTatAch.any((s) => s.contains('Hỏa Tinh')) ||
        saoTatAch.any((s) => s.contains('Linh Tinh'))) {
      parts.add(
        'thể trạng hoặc tinh thần dễ nóng, dễ bốc và dễ quá tải nếu sống thiếu điều độ',
      );
    }
    if (saoTatAch.any((s) => s.contains('Kình Dương')) ||
        saoTatAch.any((s) => s.contains('Đà La'))) {
      parts.add(
        'cần lưu ý va chạm, đau nhức kéo dài hoặc trạng thái dồn nén thành căng cứng cơ thể',
      );
    }
    if (saoTatAch.any((s) => s.contains('Thiên Hình'))) {
      parts.add(
        'không nên chủ quan với các vấn đề phải can thiệp y khoa, chấn thương hoặc dao kéo',
      );
    }

    if (parts.isNotEmpty) {
      return 'Trong đời sống thường ngày, nền sức khỏe cho thấy ${parts.join(', ')}.';
    }

    if (diemTatAch <= -2) {
      return 'Sức khỏe là phần cần phòng hơn chữa, càng giữ nếp sống tốt sớm bao nhiêu thì càng đỡ hao tổn về sau bấy nhiêu.';
    }
    return 'Nền sức khỏe không phải quá xấu, nhưng vẫn cần sống đều để tránh tích tiểu thành đại.';
  }

  static String _buildSucKhoeDiemNhayCam(List<String> saoTatAch) {
    if (saoTatAch.any((s) => s.contains('Thái Âm')) ||
        saoTatAch.any((s) => s.contains('Cự Môn'))) {
      return 'Điểm nhạy cảm thường không chỉ ở thân thể mà còn ở tinh thần, giấc ngủ, suy nghĩ và mức độ hấp thụ áp lực.';
    }
    if (saoTatAch.any((s) => s.contains('Thiên Đồng'))) {
      return 'Sức khỏe dễ bị ảnh hưởng bởi nếp sinh hoạt thất thường, ăn ngủ sai nhịp hoặc cảm xúc dao động kéo dài.';
    }
    if (saoTatAch.any((s) => s.contains('Thiên Mã'))) {
      return 'Khi di chuyển nhiều, làm quá sức hoặc đổi nhịp sống liên tục thì thể trạng dễ tụt nhanh hơn bình thường.';
    }
    return 'Điểm nhạy cảm lớn nhất là khi cơ thể và tinh thần đã quá ngưỡng nhưng bản thân vẫn cố chịu đựng mà không nghỉ đúng lúc.';
  }

  static String _buildSucKhoeKhuyenNghi(
    List<String> saoTatAch,
    int diemTatAch,
  ) {
    final List<String> tips = [];

    if (saoTatAch.any((s) => s.contains('Hỏa Tinh')) ||
        saoTatAch.any((s) => s.contains('Linh Tinh'))) {
      tips.add('giảm thức khuya, giảm nóng trong và giữ nhịp vận động đều');
    }
    if (saoTatAch.any((s) => s.contains('Kình Dương')) ||
        saoTatAch.any((s) => s.contains('Đà La'))) {
      tips.add('cẩn trọng xe cộ, vật sắc và các tình huống va chạm');
    }
    if (diemTatAch <= -2) {
      tips.add(
        'coi sức khỏe là nền bắt buộc phải giữ, không phải phần có thể để sau',
      );
    }

    if (tips.isEmpty) {
      return 'Điều nên giữ là lịch sinh hoạt đều, ngủ đủ và giảm thói quen tự ép mình kéo dài quá mức.';
    }

    return 'Điều nên làm thực tế là ${tips.join(', ')}.';
  }

  static String _buildChaMeNenTang(List<String> saoPhuMau, int diemPhuMau) {
    final List<String> traits = [];

    if (saoPhuMau.any((s) => s.contains('Thiên Lương')) ||
        saoPhuMau.any((s) => s.contains('Thiên Phủ'))) {
      traits.add(
        'nền gia đình gốc có xu hướng giữ khuôn phép và ảnh hưởng khá rõ đến cách đương số hình thành nguyên tắc sống',
      );
    }
    if (saoPhuMau.any((s) => s.contains('Ân Quang')) ||
        saoPhuMau.any((s) => s.contains('Thiên Quý'))) {
      traits.add(
        'mối liên hệ với cha mẹ hoặc người lớn trong nhà vẫn có yếu tố nâng đỡ, dù không phải lúc nào cũng thể hiện bằng sự gần gũi rõ ràng',
      );
    }

    if (traits.isNotEmpty) {
      return 'Nhìn theo đời sống gia đình, nền gốc cho thấy ${traits.join(', ')}.';
    }

    if (diemPhuMau >= 2) {
      return 'Gia đình gốc nhìn chung có phần nâng đỡ, ít nhất về nền nếp, tinh thần hoặc hướng sống ban đầu.';
    }
    if (diemPhuMau <= -2) {
      return 'Gia đình gốc dễ để lại áp lực, khoảng cách hoặc cảm giác khó được hiểu trọn vẹn, khiến đương số sớm phải tự lập về tinh thần.';
    }
    return 'Gia đình gốc vừa là nền đỡ vừa là bài học trưởng thành, nghĩa là có cả phần gắn bó lẫn phần khó hiểu nhau.';
  }

  static String _buildChaMeTacDong(List<String> saoPhuMau) {
    if (saoPhuMau.any((s) => s.contains('Hóa Kỵ'))) {
      return 'Tác động lớn của gia đình nằm ở những điều khó nói, kỳ vọng âm thầm hoặc cảm giác mang trách nhiệm nhiều hơn là được sống hoàn toàn theo ý mình.';
    }
    if (saoPhuMau.any((s) => s.contains('Kình Dương')) ||
        saoPhuMau.any((s) => s.contains('Đà La'))) {
      return 'Ảnh hưởng từ cha mẹ hoặc gia đình gốc có thể nghiêm và cứng, dễ va chạm quan điểm; càng lớn càng phải học cách hiểu giới hạn của nhau thay vì cố ép mọi thứ theo một chuẩn duy nhất.';
    }
    if (saoPhuMau.any((s) => s.contains('Thiên Đức')) ||
        saoPhuMau.any((s) => s.contains('Nguyệt Đức'))) {
      return 'Điểm đáng quý là nền gia đình vẫn còn phúc khí, nên khi gặp khúc quanh lớn thường chưa đến mức mất hẳn chỗ đỡ.';
    }
    return 'Ảnh hưởng của cha mẹ lên đương số khá sâu, không chỉ ở hoàn cảnh sống mà còn ở cách nhìn đời, cách phản ứng với trách nhiệm và nhu cầu được công nhận trong gia đình.';
  }

  static String _buildChaMeLuuY(List<String> saoPhuMau, int diemPhuMau) {
    final List<String> cautions = [];

    if (saoPhuMau.any((s) => s.contains('Cô Thần')) ||
        saoPhuMau.any((s) => s.contains('Quả Tú'))) {
      cautions.add('dễ có cảm giác cô độc trong chính mối liên hệ gia đình');
    }
    if (saoPhuMau.any((s) => s.contains('Tang Môn')) ||
        saoPhuMau.any((s) => s.contains('Bạch Hổ'))) {
      cautions.add(
        'nội bộ gia đình có lúc nặng khí, khó nói và để cảm xúc âm thầm kéo dài',
      );
    }
    if (diemPhuMau <= -2) {
      cautions.add(
        'càng trưởng thành càng cần tách bài học gia đình khỏi việc tự trách mình quá mức',
      );
    }

    if (cautions.isEmpty) {
      return 'Điều quan trọng là biết ơn phần tốt nhưng không để những kỳ vọng cũ trói toàn bộ cách sống hiện tại.';
    }

    return 'Điều cần lưu ý ở phương diện gia đình là ${cautions.join(', ')}.';
  }

  static String _buildAnhEmNenTang(List<String> saoHuynhDe, int diemHuynhDe) {
    final List<String> traits = [];

    if (saoHuynhDe.any((s) => s.contains('Tả Phù')) ||
        saoHuynhDe.any((s) => s.contains('Hữu Bật'))) {
      traits.add(
        'anh em hoặc người ngang vai có thể trở thành lực đỡ ở những giai đoạn quan trọng',
      );
    }
    if (saoHuynhDe.any((s) => s.contains('Long Trì')) ||
        saoHuynhDe.any((s) => s.contains('Phượng Các'))) {
      traits.add(
        'mối liên hệ anh em thường còn phần nể nhau, giữ ý hoặc vẫn giữ tình nghĩa nền',
      );
    }

    if (traits.isNotEmpty) {
      return 'Ở phương diện anh em và người ngang vai, ${traits.join(', ')}.';
    }

    if (diemHuynhDe >= 2) {
      return 'Quan hệ anh em nhìn chung có thể làm chỗ dựa, hoặc ít nhất khi cần vẫn có người cùng gánh việc.';
    }
    if (diemHuynhDe <= -2) {
      return 'Quan hệ anh em dễ có lúc xa cách, va chạm hoặc khó đồng quan điểm, nên càng lớn càng cần tôn trọng ranh giới riêng.';
    }
    return 'Quan hệ anh em ở mức trung bình, có tình nghĩa nhưng độ gần xa thay đổi nhiều theo hoàn cảnh sống và giai đoạn trưởng thành.';
  }

  static String _buildBanBeNenTang(List<String> saoNoBoc, int diemNoBoc) {
    final List<String> traits = [];

    if (saoNoBoc.any((s) => s.contains('Thiên Khôi')) ||
        saoNoBoc.any((s) => s.contains('Thiên Việt'))) {
      traits.add(
        'bạn bè hoặc cộng sự tốt thường xuất hiện khi đương số bước vào việc lớn',
      );
    }
    if (saoNoBoc.any((s) => s.contains('Văn Xương')) ||
        saoNoBoc.any((s) => s.contains('Văn Khúc'))) {
      traits.add(
        'quan hệ xã hội có xu hướng kết nối qua công việc, tri thức hoặc sự đồng điệu trong cách nói chuyện',
      );
    }
    if (saoNoBoc.any((s) => s.contains('Đào Hoa')) ||
        saoNoBoc.any((s) => s.contains('Hồng Loan'))) {
      traits.add(
        'dễ tạo cảm tình và không khó để mở kết nối mới, nhưng giữ được người đi đường dài mới là điều quan trọng',
      );
    }

    if (traits.isNotEmpty) {
      return 'Ở phương diện bạn bè và quan hệ xã hội, ${traits.join(', ')}.';
    }

    if (diemNoBoc >= 2) {
      return 'Bạn bè, cộng sự và người hỗ trợ nhìn chung có chất lượng khá, biết chọn đúng người thì đi xa được.';
    }
    if (diemNoBoc <= -2) {
      return 'Quan hệ xã hội dễ phát sinh phiền lòng, nên càng quen nhiều càng phải giữ chuẩn chọn lọc, tránh đặt niềm tin quá nhanh.';
    }
    return 'Mạng lưới xã hội ở mức vừa phải, có ích nhưng hiệu quả đến đâu phụ thuộc nhiều vào khả năng chọn người của chính đương số.';
  }

  static String _buildQuanHeXaHoiLuuY(
    List<String> saoHuynhDe,
    List<String> saoNoBoc,
    int diemHuynhDe,
    int diemNoBoc,
  ) {
    final List<String> cautions = [];
    final all = [...saoHuynhDe, ...saoNoBoc];

    if (all.any((s) => s.contains('Kình Dương')) ||
        all.any((s) => s.contains('Đà La'))) {
      cautions.add(
        'càng thân càng dễ va chạm vì cái tôi hoặc cách nói quá thẳng',
      );
    }
    if (all.any((s) => s.contains('Cô Thần')) ||
        all.any((s) => s.contains('Quả Tú'))) {
      cautions.add(
        'có lúc ở giữa nhiều người nhưng vẫn thấy không thật sự thuộc về',
      );
    }
    if (all.any((s) => s.contains('Hóa Kỵ'))) {
      cautions.add(
        'dễ sinh hiểu lầm hoặc bị kéo vào chuyện thị phi nếu mất cảnh giác',
      );
    }
    if (diemHuynhDe <= -2 || diemNoBoc <= -2) {
      cautions.add(
        'bài học lớn là phân biệt người đi cùng thật với người chỉ hợp trong một chặng ngắn',
      );
    }

    if (cautions.isEmpty) {
      return 'Điều đáng giữ trong các mối quan hệ là sự bền, sự chọn lọc và việc để mỗi người có khoảng riêng thay vì cố giữ tất cả.';
    }

    return 'Điều cần lưu ý trong quan hệ là ${cautions.join(', ')}.';
  }

  static String _buildConCaiNenTang(List<String> saoTuTuc, int diemTuTuc) {
    final List<String> traits = [];

    if (saoTuTuc.any((s) => s.contains('Thiên Hỷ')) ||
        saoTuTuc.any((s) => s.contains('Hồng Loan'))) {
      traits.add(
        'đường con cái hoặc sự tiếp nối có phần mang niềm vui và cảm xúc gắn bó',
      );
    }
    if (saoTuTuc.any((s) => s.contains('Đào Hoa'))) {
      traits.add(
        'phần nuôi dưỡng và truyền tiếp không chỉ là trách nhiệm mà còn là bài học tình cảm lớn',
      );
    }
    if (saoTuTuc.any((s) => s.contains('Hóa Kỵ'))) {
      traits.add(
        'phương diện con cái hoặc sự nối tiếp dễ đi kèm nỗi lo và những điều không thể kiểm soát hoàn toàn',
      );
    }

    if (traits.isNotEmpty) {
      return 'Ở phương diện con cái và sự nối tiếp, ${traits.join(', ')}.';
    }

    if (diemTuTuc >= 2) {
      return 'Đường con cái và sự truyền tiếp nhìn chung có nét thuận, về sau dễ có niềm vui hoặc cảm giác được tiếp nối.';
    }
    if (diemTuTuc <= -2) {
      return 'Phương diện con cái hoặc những gì mình để lại về sau thường đòi hỏi nhiều kiên nhẫn, công sức và bao dung hơn người khác.';
    }
    return 'Phương diện con cái và sự nối tiếp ở mức trung bình, càng sống chín càng đọc ra rõ ý nghĩa thật của cung này.';
  }

  static String _buildHauVanNenTang(List<String> saoPhucDuc, int diemPhucDuc) {
    final List<String> traits = [];

    if (saoPhucDuc.any((s) => s.contains('Thiên Đức')) ||
        saoPhucDuc.any((s) => s.contains('Nguyệt Đức'))) {
      traits.add(
        'hậu vận có nền phúc khí, nghĩa là càng sống đúng và giữ tâm tốt thì về sau càng nhẹ hơn thời đầu',
      );
    }
    if (saoPhucDuc.any((s) => s.contains('Long Trì')) ||
        saoPhucDuc.any((s) => s.contains('Phượng Các'))) {
      traits.add(
        'về sau vẫn có cơ hội giữ được phẩm giá, vị thế hoặc sự yên ổn nhất định nếu biết chọn lối sống bền',
      );
    }
    if (saoPhucDuc.any((s) => s.contains('Tang Môn')) ||
        saoPhucDuc.any((s) => s.contains('Bạch Hổ'))) {
      traits.add(
        'hậu vận không chỉ xét vật chất mà còn phải xét sức bền tinh thần, vì càng lớn càng thấy rõ điều gì mới thật sự nặng lòng',
      );
    }

    if (traits.isNotEmpty) {
      return 'Nhìn về hậu vận và tuổi về sau, ${traits.join(', ')}.';
    }

    if (diemPhucDuc >= 2) {
      return 'Hậu vận có xu hướng sáng dần, càng về sau càng dễ sống chậm hơn, chắc hơn và bớt bị đời xô lệch nếu biết giữ nền sống đúng.';
    }
    if (diemPhucDuc <= -2) {
      return 'Hậu vận cần được nuôi từ sớm bằng cách sống điều độ và giữ tinh thần ổn định, vì về sau điều đáng lo không chỉ là hoàn cảnh mà còn là sức nặng nội tâm.';
    }
    return 'Hậu vận ở thế trung hòa, tốt hay mệt phụ thuộc rất nhiều vào cách đương số sống từ trung vận trở đi.';
  }

  static String _buildConCaiHauVanLuuY(
    List<String> saoTuTuc,
    List<String> saoPhucDuc,
    int diemTuTuc,
    int diemPhucDuc,
  ) {
    final List<String> cautions = [];
    final all = [...saoTuTuc, ...saoPhucDuc];

    if (all.any((s) => s.contains('Cô Thần')) ||
        all.any((s) => s.contains('Quả Tú'))) {
      cautions.add(
        'về sau dễ có cảm giác cô tịch nếu chỉ lo việc mà không vun mối gắn bó thật từ sớm',
      );
    }
    if (all.any((s) => s.contains('Hóa Kỵ'))) {
      cautions.add(
        'kỳ vọng quá cao vào con cái, hậu duệ hoặc người tiếp nối có thể làm tăng nỗi thất vọng về sau',
      );
    }
    if (diemTuTuc <= -2) {
      cautions.add('cần đi bằng kiên nhẫn và bao dung nhiều hơn là kiểm soát');
    }
    if (diemPhucDuc <= -2) {
      cautions.add(
        'hậu vận muốn nhẹ phải bắt đầu từ việc bồi nền tinh thần ngay từ trung vận',
      );
    }

    if (cautions.isEmpty) {
      return 'Điều quan trọng nhất là xây một nền sống có người, có tình và có giá trị để truyền lại; khi đó con cái và hậu vận mới thật sự trở thành phần an của cuộc đời.';
    }

    return 'Điều cần lưu ý về con cái và hậu vận là ${cautions.join(', ')}.';
  }
}
