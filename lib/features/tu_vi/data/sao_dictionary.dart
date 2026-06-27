class SaoDictionary {
  static String getYNghiaChinhTinh(String sao, String cung) {
    if (sao.isEmpty) return "";
    final String ten = sao.split(' (')[0].trim();

    if (ten == 'Tử Vi') {
      return ['Ngọ', 'Tý', 'Thìn', 'Tuất', 'Dần', 'Thân'].contains(cung)
          ? "🌟 Tử Vi (Miếu/Vượng): Cốt cách chủ mệnh mạnh, khí chất lãnh đạo, có ý thức danh dự và xu hướng đứng mũi chịu sào. Khi đắc địa thì dễ tạo uy tín, hợp vai trò tổ chức, quản trị và gánh việc lớn."
          : "📉 Tử Vi (Bình/Hãm): Vẫn có tố chất làm chủ nhưng dễ rơi vào thế cô, tài năng không gặp thời, tâm cao mà hoàn cảnh không nâng. Nếu nóng vội hoặc tự ái quá mức thì dễ sinh bất mãn và khó hòa hợp tập thể.";
    }
    if (ten == 'Thiên Phủ') {
      return ['Tý', 'Ngọ', 'Dần', 'Thân', 'Thìn', 'Tuất'].contains(cung)
          ? "🌟 Thiên Phủ (Miếu/Vượng): Chủ kho tàng, nền tảng và khả năng giữ của. Đương số thường chín chắn, biết tính đường dài, có năng lực quản lý tiền bạc, tài sản hoặc nguồn lực. Hậu vận dễ ổn và bền."
          : "📉 Thiên Phủ (Bình/Hãm): Có tư duy giữ gìn nhưng lực tụ tài kém hơn, dễ rơi vào thế cẩn trọng quá mức hoặc giữ mà không biết khai thông. Tiền của có lúc đến rồi đi, cơ hội tốt dễ bỏ lỡ vì do dự.";
    }
    if (ten == 'Vũ Khúc') {
      return ['Thìn', 'Tuất', 'Sửu', 'Mùi'].contains(cung)
          ? "🌟 Vũ Khúc (Miếu/Vượng): Sao tài lộc và quyết đoán rất mạnh. Hợp kinh doanh, tài chính, kỹ thuật, quản trị hiệu suất. Khi sáng thì làm việc rắn, thực tế, không ngại áp lực và có khả năng tích lũy rõ rệt."
          : "📉 Vũ Khúc (Hãm): Tính quyết vẫn còn nhưng dễ hóa cứng, khô và cô độc. Đường tiền bạc thường phải tự thân bươn chải, có lúc kiếm được nhưng giữ không dễ. Tình cảm cũng dễ bị ảnh hưởng bởi sự khô tính hoặc quá thực dụng.";
    }
    if (ten == 'Thiên Tướng') {
      return ['Dần', 'Thân', 'Tỵ', 'Hợi'].contains(cung)
          ? "🌟 Thiên Tướng (Miếu/Vượng): Chính trực, biết giữ nguyên tắc và có khí chất bảo hộ. Hợp môi trường cần trách nhiệm, uy tín, công tâm. Dễ được tin cậy giao việc, làm chỗ dựa cho người khác."
          : "📉 Thiên Tướng (Hãm): Tâm vẫn muốn ngay thẳng nhưng dễ rơi vào thế bị lợi dụng, tin người không đúng chỗ hoặc gánh trách nhiệm mà không được ghi nhận. Sự nghiệp có thể lên xuống vì quan hệ hơn là vì năng lực.";
    }

    if (ten == 'Thất Sát') {
      return ['Dần', 'Thân', 'Tý', 'Ngọ'].contains(cung)
          ? "🌟 Thất Sát (Miếu/Vượng): Bản lĩnh, quyết đoán, dám làm việc khó và chịu va chạm lớn. Đây là khí của người không ngại nghịch cảnh, hợp môi trường cạnh tranh, tái cấu trúc, mở đường và xử lý việc khó."
          : "📉 Thất Sát (Hãm): Khí mạnh nhưng dễ thành gắt, nóng và cô. Nếu thiếu điểm tựa tinh thần hoặc thiếu người dìu dắt thì dễ va vấp, gặp thị phi, tai ách hoặc tự đẩy mình vào thế đối đầu quá mức.";
    }
    if (ten == 'Phá Quân') {
      return ['Tý', 'Ngọ', 'Sửu', 'Mùi'].contains(cung)
          ? "🌟 Phá Quân (Miếu/Vượng): Khả năng phá cũ lập mới rất mạnh. Hợp người sáng tạo, dám đổi mô hình, dám đi đường khác số đông. Tuổi trẻ thường bôn ba nhưng càng về sau càng dễ thành nếu biết gom lực và giữ kỷ luật."
          : "📉 Phá Quân (Hãm): Tính phá nhiều hơn tính dựng, dễ thay đổi thất thường, hao tán, làm lại nhiều lần. Nếu không có chiến lược dài hơi thì cuộc sống thường lặp lại vòng dựng lên rồi phá đi.";
    }
    if (ten == 'Tham Lang') {
      return ['Sửu', 'Mùi'].contains(cung)
          ? "🌟 Tham Lang (Đắc địa): Mạnh về giao tiếp, xoay xở, hưởng ứng cơ hội và thu hút. Có tham vọng, biết mở rộng quan hệ, hợp môi trường kinh doanh, dịch vụ, đối ngoại, nghệ thuật hoặc lĩnh vực cần sức hút cá nhân."
          : "📉 Tham Lang (Hãm): Dục cầu mạnh nhưng lực giữ chưa chắc, dễ sa đà vào thú vui, cảm xúc hoặc các lựa chọn quá ngắn hạn. Nếu không tự kỷ luật thì tài lộc và tình cảm đều dễ sinh rối.";
    }

    if (ten == 'Thiên Cơ') {
      return ['Tỵ', 'Ngọ', 'Mùi'].contains(cung)
          ? "🌟 Thiên Cơ (Miếu/Vượng): Đầu óc linh hoạt, mưu trí, nhìn vấn đề nhanh và có thiên hướng nghiên cứu, kỹ thuật, chiến lược, cố vấn. Đây là sao của trí lực, sự xoay chuyển và năng lực tính toán đường đi nước bước."
          : "📉 Thiên Cơ (Hãm): Trí vẫn có nhưng dễ tán, lo nghĩ nhiều, thay đổi ý nhanh hoặc suy quá mức thành rối. Tài năng khó ổn định nếu môi trường thiếu định hướng hoặc bản thân thiếu kiên trì.";
    }
    if (ten == 'Thái Âm') {
      return ['Dậu', 'Tuất', 'Hợi', 'Tý', 'Sửu'].contains(cung)
          ? "🌟 Thái Âm (Miếu/Vượng): Tinh tế, mềm mại, nội tâm sâu và có duyên với tài lộc ngầm, bất động sản, tích lũy, hậu phương. Khi sáng thì tâm hồn đẹp, biết lo, biết giữ và thường được nữ quý nhân hoặc phúc âm phù trợ."
          : "📉 Thái Âm (Hãm): Tình cảm dễ nhiều uẩn khúc, nội tâm nhạy nhưng khó nói ra. Tiền bạc hoặc cảm xúc thường có tính lên xuống, dễ mơ mộng, kỳ vọng rồi hụt hẫng nếu không sống thực tế hơn.";
    }
    if (ten == 'Thiên Đồng') {
      return ['Dần', 'Thân'].contains(cung)
          ? "🌟 Thiên Đồng (Đắc địa): Phúc tinh, thiên về sự hiền hòa, nhân hậu, mềm mỏng và có lộc hóa giải. Cuộc đời thường gặp lúc nguy lại có đường lui, hợp môi trường cần tính người, sự chăm sóc hoặc kết nối mềm."
          : "📉 Thiên Đồng (Hãm): Tâm thiện nhưng dễ mềm quá, ngại va chạm, thiếu quyết liệt hoặc hay đổi ý. Nếu không có chí hướng rõ thì cuộc sống dễ trôi theo hoàn cảnh, bỏ lỡ nhiều thời điểm tốt.";
    }
    if (ten == 'Thiên Lương') {
      return ['Ngọ', 'Dần', 'Thân', 'Tý'].contains(cung)
          ? "🌟 Thiên Lương (Miếu/Vượng): Sao của phúc, thọ, đức và khả năng che chở. Thường mang khí chất chững chạc, nhân nghĩa, hợp sư phạm, y dược, cố vấn, pháp lý hoặc vai trò bảo hộ, dẫn dắt chuẩn mực."
          : "📉 Thiên Lương (Hãm): Tâm tốt nhưng dễ thành lo xa, ôm việc, lý thuyết nhiều hơn hành động hoặc phải gánh trách nhiệm cho người khác. Đôi khi sống vì nghĩa quá mà phần mình lại thiệt.";
    }

    if (ten == 'Liêm Trinh') {
      return ['Dần', 'Thân', 'Tý', 'Ngọ'].contains(cung)
          ? "🌟 Liêm Trinh (Miếu/Vượng): Cương trực, tự trọng, có khả năng quản trị, kiểm soát và giữ kỷ cương. Khi sáng thì rất rõ ràng đúng sai, làm việc có nguyên tắc, phù hợp môi trường cần bản lĩnh và sự minh bạch."
          : "📉 Liêm Trinh (Hãm): Dễ cực đoan trong cảm xúc, cứng về quan điểm hoặc vướng điều tiếng, pháp lý, tranh chấp. Tình cảm cũng dễ lận đận nếu để cái tôi và sự nghi ngờ đi quá xa.";
    }
    if (ten == 'Cự Môn') {
      return ['Mão', 'Dậu', 'Tý', 'Ngọ'].contains(cung)
          ? "🌟 Cự Môn (Miếu/Vượng): Miệng lưỡi sắc bén, tư duy phản biện mạnh, hợp tranh luận, đào sâu, nghiên cứu, truyền thông, luật, tư vấn. Khi dùng đúng chỗ thì lời nói thành công cụ tạo vị thế."
          : "📉 Cự Môn (Hãm): Dễ sinh thị phi, hiểu lầm, lời nói làm hỏng việc hoặc tự đẩy mình vào tranh cãi. Nhiều khi không phải xấu bản chất, nhưng cách biểu đạt khiến quan hệ và công việc đều mệt.";
    }
    if (ten == 'Thái Dương') {
      return ['Dần', 'Mão', 'Thìn', 'Tỵ', 'Ngọ'].contains(cung)
          ? "🌟 Thái Dương (Miếu/Vượng): Quang minh, rộng rãi, chủ về danh tiếng, vai trò dẫn dắt và năng lượng hướng ngoại. Dễ nổi bật, hợp đứng trước công chúng, quản lý, giáo dục hoặc các việc cần tầm ảnh hưởng."
          : "📉 Thái Dương (Hãm): Ý muốn cống hiến vẫn có nhưng dễ rơi vào thế làm nhiều hưởng ít, công sức không được ghi nhận hoặc sức khỏe, tinh thần bị bào mòn do gánh vác quá sức.";
    }

    return "🔹 $ten: Ý nghĩa riêng của sao này cần xét thêm vị trí cung, bộ sao đi cùng và thế tam phương tứ chính mới luận rõ cát hung.";
  }

  static String getYNghiaPhuTinh(String phu) {
    final String ten = phu.split(' (')[0].trim();
    if (ten.isEmpty) return "";

    if (_containsAny(ten, {'Địa Không', 'Địa Kiếp', 'Không Kiếp'})) {
      return "🔥 $ten: Bộ sao hao tán và đột biến mạnh. Khi đi với cát tinh vẫn có thể tạo bứt phá lớn, nhưng nếu đi với hung tinh thì dễ báo cảnh được nhanh mất nhanh, đầu tư liều lĩnh hoặc biến cố bất ngờ.";
    }
    if (_containsAny(ten, {'Kình Dương', 'Đà La'})) {
      return "⚔️ $ten: Tăng tính va chạm, cạnh tranh và cản trở. Đương số thường không đi đường dễ, phải tranh đấu mới thành. Mặt mạnh là lì đòn, mặt yếu là dễ sinh thương tổn, xung đột hoặc cố chấp.";
    }
    if (_containsAny(ten, {'Hỏa Tinh', 'Linh Tinh'})) {
      return "⚡ $ten: Tính chất nhanh, gắt, đột ngột, dễ tạo bước ngoặt mạnh. Nếu biết kiểm soát thì đây là lực bộc phát, hành động nhanh; nếu không thì dễ thành nóng nảy, hấp tấp, tai nạn hoặc quyết sai trong lúc nóng.";
    }
    if (_containsAny(ten, {'Văn Xương', 'Văn Khúc'})) {
      return "✍️ $ten: Tăng học thức, khả năng biểu đạt, cảm thụ nghệ thuật và sự tinh tế. Hợp con đường học hành, nội dung, truyền thông, sáng tạo, viết lách, thiết kế hoặc công việc cần đầu óc thanh nhã.";
    }
    if (_containsAny(ten, {'Thiên Khôi', 'Thiên Việt'})) {
      return "💎 $ten: Quý nhân, cơ hội, sự nâng đỡ và tính nổi bật. Thường báo hiệu gặp người giỏi chỉ đường, được trọng dụng hoặc có khả năng vươn lên nhóm trên trong môi trường làm việc.";
    }
    if (_containsAny(ten, {'Tả Phù', 'Hữu Bật'})) {
      return "🤝 $ten: Sao trợ lực, tăng khả năng gặp người hỗ trợ, có cộng sự, có người kề vai gánh việc. Khi đi với chính tinh tốt thì càng tăng lực tổ chức, thực thi và hậu thuẫn.";
    }
    if (_containsAny(ten, {'Long Trì', 'Phượng Các'})) {
      return "🏵️ $ten: Tăng vẻ thanh quý, danh dự, khí chất đẹp và sự nâng tầm hình ảnh. Thường giúp đương số dễ tạo thiện cảm, có phong thái hoặc được nhìn nhận tốt hơn trong xã hội.";
    }
    if (_containsAny(ten, {'Tam Thai', 'Bát Tọa'})) {
      return "🏛️ $ten: Tăng nền học hành, danh vị, sự nâng đỡ về vị thế và khả năng từng bước đi lên. Hợp người làm việc bài bản, leo dần bằng thành tích và sự bền bỉ.";
    }
    if (_containsAny(ten, {'Ân Quang', 'Thiên Quý'})) {
      return "🌈 $ten: Bộ phúc thiện, hay gặp may trong lúc khó, tăng lòng nhân, sự cảm thông và nhân duyên tốt. Nhiều khi không phải đại phát, nhưng có lực cứu giải ở thời điểm cần nhất.";
    }
    if (_containsAny(ten, {'Hóa Lộc'})) {
      return "💰 Hóa Lộc: Tăng khả năng sinh tài, hút việc, hút cơ hội, dễ có nguồn thu hoặc được lợi về tiền bạc, quan hệ, giá trị vật chất. Nhưng đi kèm hung tinh thì cũng dễ kích ham muốn và tiêu mạnh.";
    }
    if (_containsAny(ten, {'Hóa Quyền'})) {
      return "🛡️ Hóa Quyền: Tăng quyền chủ động, tiếng nói, năng lực điều hành và sức ảnh hưởng. Hợp môi trường cần cầm trịch, quyết đoán, chịu trách nhiệm và dẫn dắt người khác.";
    }
    if (_containsAny(ten, {'Hóa Khoa'})) {
      return "🎓 Hóa Khoa: Tăng danh tiếng, tri thức, sự công nhận và khả năng hóa giải tai ách. Đây là sao đẹp cho học hành, nghề chuyên môn, uy tín xã hội và việc dùng tri thức để mở đường.";
    }
    if (_containsAny(ten, {'Hóa Kỵ'})) {
      return "🌫️ Hóa Kỵ: Tăng sự vướng mắc, hiểu lầm, phiền muộn hoặc cảm giác bị cản trở. Không phải lúc nào cũng là đại họa, nhưng thường là điểm nghẽn tâm lý hoặc nút thắt khiến việc khó trôi chảy.";
    }
    if (_containsAny(ten, {'Đào Hoa', 'Hồng Loan', 'Thiên Hỷ'})) {
      return "💕 $ten: Tăng duyên giao tiếp, sức hút cá nhân, cảm xúc và nhân duyên. Tốt cho xã hội, nghệ thuật, quan hệ; nhưng đi lệch bộ dễ làm tình cảm phức tạp hoặc sinh đa cảm.";
    }
    if (_containsAny(ten, {'Cô Thần', 'Quả Tú'})) {
      return "🕯️ $ten: Tăng cảm giác cô độc, khép kín hoặc khó chia sẻ chiều sâu nội tâm. Không hẳn cô độc tuyệt đối, nhưng dễ có quãng sống tự thân, khó được thấu hiểu trọn vẹn.";
    }
    if (_containsAny(ten, {'Tang Môn', 'Bạch Hổ', 'Thiên Hình'})) {
      return "🩹 $ten: Bộ sao tăng áp lực, va chạm, thương tổn hoặc chuyện buồn lo. Cần đọc cùng toàn cục để tránh luận quá nặng, nhưng rõ ràng là nhóm sao khiến cuộc đời phải cứng cáp hơn qua trải nghiệm.";
    }
    if (_containsAny(ten, {'Thiên Mã'})) {
      return "🐎 Thiên Mã: Tăng tính dịch chuyển, thay đổi môi trường, bôn ba, di động và khả năng phát triển khi không đứng yên. Hợp người đi nhiều, làm xa, đổi chỗ mà mở vận.";
    }
    if (_containsAny(ten, {'Lộc Tồn'})) {
      return "🏦 Lộc Tồn: Lộc bền, thiên về tích lũy, đều đặn, giữ của và dựng nền lâu dài. Không ồn ào như phát tài nhanh nhưng tốt cho kiểu làm ăn chắc, bồi dần mà giàu.";
    }
    if (_containsAny(ten, {'Thiên Đức', 'Nguyệt Đức'})) {
      return "☀️ $ten: Tăng đức độ, sự mềm hóa tai ách và nhân duyên tốt. Đây là nhóm sao giúp nhiều việc xấu bớt xấu, nhiều va chạm có đường nhẹ đi nhờ phúc đức và cách sống.";
    }

    return "";
  }

  static bool _containsAny(String input, Set<String> keywords) {
    for (final keyword in keywords) {
      if (input.contains(keyword)) return true;
    }
    return false;
  }
}
