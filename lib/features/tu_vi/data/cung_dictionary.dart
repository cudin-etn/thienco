class CungDictionary {
  // Logic luận giải cung Tài Bạch (Tiền Bạc)
  static String luanCungTaiBach(List<String> stars) {
    if (stars.isEmpty) {
      return "Cung Tài vô chính diệu: tiền bạc thường không đi theo một khuôn ổn định, lúc vào lúc ra thất thường. Muốn bền thì nên lấy kỹ năng, tài sản tích lũy và nguyên tắc quản tiền làm gốc, tránh tâm lý được bao nhiêu tiêu bấy nhiêu.";
    }

    final List<String> normalized = stars
        .map((s) => s.split(' (').first.trim())
        .where((s) => s.isNotEmpty)
        .toSet()
        .toList();

    final bool hasTaiTinhLon = _hasAny(normalized, {
      'Vũ Khúc',
      'Thiên Phủ',
      'Thái Âm',
      'Lộc Tồn',
      'Hóa Lộc',
    });
    final bool hasDotPha = _hasAny(normalized, {
      'Tham Lang',
      'Thất Sát',
      'Phá Quân',
      'Thiên Mã',
    });
    final bool hasTriTue = _hasAny(normalized, {
      'Thiên Cơ',
      'Văn Xương',
      'Văn Khúc',
      'Hóa Khoa',
    });
    final bool hasQuyNhan = _hasAny(normalized, {
      'Tả Phù',
      'Hữu Bật',
      'Thiên Khôi',
      'Thiên Việt',
      'Ân Quang',
      'Thiên Quý',
    });
    final bool hasSatHao = _hasAny(normalized, {
      'Kình Dương',
      'Đà La',
      'Hỏa Tinh',
      'Linh Tinh',
      'Địa Không',
      'Địa Kiếp',
      'Hóa Kỵ',
      'Không Kiếp',
    });

    final List<String> parts = [];

    if (hasTaiTinhLon) {
      parts.add(
        "Cung Tài có bộ sao thiên về tài tinh, cho thấy năng lực tạo ra tiền bạc, quản lý nguồn lực và tích lũy vật chất khá nổi bật. Đây không chỉ là dấu hiệu biết kiếm tiền mà còn có khả năng nhìn ra giá trị, giữ của hoặc xây nền tài chính nếu đi đúng đường.",
      );
    } else if (hasDotPha) {
      parts.add(
        "Đường tiền bạc mang màu sắc đột phá và mạo hiểm hơn bình thường. Tài lộc dễ đến từ thay đổi lớn, kinh doanh, dấn thân, mở hướng mới hoặc các quyết định cần độ liều có kiểm soát. Mặt mạnh là khả năng bật lên nhanh; mặt yếu là tài vận dễ lên xuống mạnh.",
      );
    } else if (hasTriTue) {
      parts.add(
        "Tài vận thiên về trí tuệ, kỹ năng, chuyên môn và khả năng xử lý vấn đề. Tiền thường đến nhờ đầu óc, học vấn, nghề chuyên sâu, tư duy chiến lược hoặc khả năng tạo ra giá trị bằng chất xám hơn là nhờ may mắn ngắn hạn.",
      );
    } else {
      parts.add(
        "Tài vận ở thế trung bình ổn: tiền bạc chủ yếu đến từ sự chăm chỉ, nền nghề nghiệp và quá trình bồi đắp từng bước. Không quá thiên về phát lớn bất ngờ, nhưng nếu biết giữ nhịp thì vẫn có thể tích lũy thành nền tốt.",
      );
    }

    if (hasQuyNhan) {
      parts.add(
        "Đường tài bạch còn có dấu hiệu được nâng đỡ bởi quý nhân, cộng sự hoặc mối quan hệ tốt. Nhiều cơ hội tài chính không đến hoàn toàn từ đơn độc mà đến nhờ người tin dùng, người mở cửa hoặc người cùng gánh việc với mình.",
      );
    }

    if (hasSatHao && hasTaiTinhLon) {
      parts.add(
        "Tuy có năng lực kiếm tiền, nhưng lá số cũng báo rõ tính biến động và hao tán. Nghĩa là có thể làm ra tiền khá, song khâu giữ tiền, quản rủi ro, chọn thời điểm và tiết chế lòng tham mới là yếu tố quyết định giàu bền hay chỉ phát rồi suy.",
      );
    } else if (hasSatHao) {
      parts.add(
        "Cần đặc biệt cẩn trọng ở mặt thất thoát, đầu tư nóng, quyết định vội hoặc bị cuốn vào cơ hội nhìn có vẻ hấp dẫn nhưng rủi ro cao. Đây là kiểu tài vận không sợ thiếu cơ hội, chỉ sợ sai nhịp và thiếu nguyên tắc.",
      );
    } else {
      parts.add(
        "Mặt giữ tiền và tích lũy nhìn tương đối sáng hơn. Nếu sống có kế hoạch, tránh tiêu dùng theo cảm xúc và biết ưu tiên tài sản bền thì đường tài chính càng về sau càng dễ ổn định.",
      );
    }

    parts.add(
      "Tóm lại, cung Tài Bạch này không nên chỉ đọc ở chuyện kiếm được bao nhiêu, mà phải đọc ở cách làm ra tiền, cách giữ tiền và khả năng biến tiền thành nền sống lâu dài. Khi đi đúng thế mạnh của mình, tài vận hoàn toàn có thể nâng lên rõ rệt theo thời gian.",
    );

    return parts.join("\n\n");
  }

  static bool _hasAny(List<String> stars, Set<String> targets) {
    for (final star in stars) {
      for (final target in targets) {
        if (star.contains(target)) return true;
      }
    }
    return false;
  }
}
