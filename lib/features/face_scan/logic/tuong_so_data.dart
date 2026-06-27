/// Kho dữ liệu nhân tướng học — phân tích theo từng bộ vị ngũ quan
class TuongSoData {
  // ============================================================
  // TRÁN (Quan Lộc Cung) — Trí tuệ, sự nghiệp tiền vận
  // ============================================================
  static const Map<String, Map<String, String>> tran = {
    'tran_cao_rong': {
      'ten': 'Trán cao rộng',
      'moTa': 'Trán chiếm tỷ lệ lớn, rộng và đầy đặn',
      'luanGiai':
          'Người có trán cao rộng thường thông minh, có tầm nhìn xa và khả năng lãnh đạo tốt. Tiền vận (trước 30 tuổi) thường thuận lợi, dễ được quý nhân nâng đỡ trong học hành và sự nghiệp sớm. Hợp công việc cần tư duy chiến lược, quản lý hoặc nghiên cứu.',
      'diemSo': '85',
    },
    'tran_hep': {
      'ten': 'Trán hẹp',
      'moTa': 'Trán thấp hoặc hẹp, tóc mọc sát xuống',
      'luanGiai':
          'Trán hẹp cho thấy tiền vận không quá thuận, thường phải tự lực từ sớm và ít được gia đình hỗ trợ nhiều. Tuy nhiên đây cũng là dấu hiệu của người thực tế, chăm chỉ và biết tích lũy từng bước. Sau 30 tuổi thường ổn định hơn nếu kiên trì.',
      'diemSo': '50',
    },
    'tran_loi': {
      'ten': 'Trán lồi (Trán bướng)',
      'moTa': 'Trán nhô ra phía trước rõ rệt',
      'luanGiai':
          'Người có trán lồi thường có cá tính mạnh, tư duy độc lập và không dễ bị thuyết phục. Có khả năng sáng tạo cao nhưng đôi khi bướng bỉnh, khó hợp tác nếu không được tôn trọng ý kiến. Hợp làm việc độc lập hoặc khởi nghiệp.',
      'diemSo': '65',
    },
    'tran_phang': {
      'ten': 'Trán phẳng đều',
      'moTa': 'Trán không quá cao, không quá thấp, phẳng đều',
      'luanGiai':
          'Trán phẳng đều cho thấy tính cách ôn hòa, biết cân nhắc và ít cực đoan. Tiền vận không quá nổi bật nhưng cũng không quá khó khăn, đi theo kiểu tích lũy dần. Hợp môi trường ổn định, có hệ thống.',
      'diemSo': '70',
    },
    'tran_vuong': {
      'ten': 'Trán vuông góc cạnh',
      'moTa': 'Trán vuông, đường chân tóc ngang, góc cạnh rõ',
      'luanGiai':
          'Trán vuông cho thấy người thiên về tư duy logic, nguyên tắc và quyết đoán. Hợp các ngành kỹ thuật, quân đội, luật pháp. Điểm yếu là đôi khi cứng nhắc, khó linh hoạt trong giao tiếp và thương lượng.',
      'diemSo': '75',
    },
    'tran_day_nhan': {
      'ten': 'Trán đầy đặn, da sáng',
      'moTa': 'Trán căng đầy, da mịn, không có nếp nhăn sâu',
      'luanGiai':
          'Trán đầy đặn da sáng là tướng phúc khí tốt. Người có tướng này thường may mắn từ nhỏ, ít bệnh tật, dễ thành công nhờ quý nhân phò trợ. Nếu là nữ thì hợp giúp chồng con, phúc đức gia đình trọn vẹn.',
      'diemSo': '82',
    },
    'tran_nhan_doc': {
      'ten': 'Trán có nếp nhăn ngang sâu',
      'moTa': 'Trán xuất hiện một hoặc nhiều nếp nhăn ngang rõ',
      'luanGiai':
          'Trán có nếp nhăn ngang thường là dấu hiệu của người lao tâm lao lực, suy nghĩ nhiều. Nếu nếp nhăn đều và không quá sâu thì vẫn tốt, cho thấy người có trải nghiệm sống phong phú và khả năng chịu áp lực cao.',
      'diemSo': '60',
    },
  };

  // ============================================================
  // MẮT (Tài Bạch / Trí Tuệ) — Tầm nhìn, tinh thần
  // ============================================================
  static const Map<String, Map<String, String>> mat = {
    'mat_to_sang': {
      'ten': 'Mắt to sáng',
      'moTa': 'Mắt lớn, tròng mắt sáng, có thần',
      'luanGiai':
          'Mắt to sáng có thần là dấu hiệu của người thông minh, nhanh nhạy và có sức hút tự nhiên. Dễ gây thiện cảm, giao tiếp tốt và thường có trực giác mạnh. Tài vận thường đến từ khả năng nhìn ra cơ hội mà người khác bỏ qua.',
      'diemSo': '88',
    },
    'mat_nho_sau': {
      'ten': 'Mắt nhỏ sâu',
      'moTa': 'Mắt nhỏ, hơi sâu trong hốc mắt',
      'luanGiai':
          'Người mắt nhỏ sâu thường kín đáo, suy nghĩ sâu và không dễ bộc lộ cảm xúc. Có khả năng quan sát tốt, tính toán kỹ và giữ bí mật giỏi. Tài vận đến từ sự kiên nhẫn và khả năng phân tích hơn là may mắn bất ngờ.',
      'diemSo': '70',
    },
    'mat_xa_nhau': {
      'ten': 'Khoảng cách mắt rộng',
      'moTa': 'Hai mắt cách xa nhau hơn bình thường',
      'luanGiai':
          'Người có mắt xa nhau thường có tầm nhìn bao quát, tính cách cởi mở và phóng khoáng. Dễ thích nghi với môi trường mới, ít câu nệ tiểu tiết. Tuy nhiên đôi khi thiếu tập trung vào chi tiết, cần người hỗ trợ phần thực thi.',
      'diemSo': '72',
    },
    'mat_gan_nhau': {
      'ten': 'Khoảng cách mắt hẹp',
      'moTa': 'Hai mắt gần nhau hơn bình thường',
      'luanGiai':
          'Khả năng tập trung cao độ, tỉ mỉ và làm việc độc lập tốt. Cẩn thận trong tài chính, biết giữ tiền nhưng đôi khi dễ bảo thủ hoặc hay lo lắng quá mức. Hợp công việc cần sự chính xác và kiên trì.',
      'diemSo': '68',
    },
    'mat_can_doi': {
      'ten': 'Đôi mắt cân đối',
      'moTa': 'Khoảng cách và kích thước mắt hài hòa',
      'luanGiai':
          'Trạng thái cân bằng tự nhiên. Tâm lý ổn định, dễ hòa đồng, có cái nhìn khách quan và khả năng thấu cảm tốt. Tài vận ổn định, không quá bùng nổ nhưng bền và ít rủi ro lớn.',
      'diemSo': '75',
    },
    'mat_duoi_xech': {
      'ten': 'Mắt đuôi xếch (Phượng Nhãn)',
      'moTa': 'Đuôi mắt hơi xếch lên phía trên, dài',
      'luanGiai':
          'Mắt đuôi xếch thuộc tướng Phượng Nhãn, cho thấy người có uy lực, bản lĩnh và tham vọng lớn. Hợp các vị trí lãnh đạo, chỉ huy. Nữ có mắt này thường mạnh mẽ, không chịu khuất phục, gia đạo dễ xảy ra tranh luận nếu không biết nhường nhịn.',
      'diemSo': '78',
    },
    'mat_duoi_xuong': {
      'ten': 'Mắt đuôi cụp',
      'moTa': 'Đuôi mắt hơi chúc xuống dưới',
      'luanGiai':
          'Người có đuôi mắt cụp thường hiền lành, dễ thông cảm và có lòng trắc ẩn. Tuy nhiên dễ bị lợi dụng lòng tốt, cần học cách nói không. Đường tình duyên dễ gặp người lệ thuộc hoặc cần được chăm sóc.',
      'diemSo': '62',
    },
    'mat_tron': {
      'ten': 'Mắt tròn',
      'moTa': 'Mắt tròn, mở to tự nhiên',
      'luanGiai':
          'Mắt tròn biểu hiện người ngây thơ, chân thành, ít toan tính. Dễ gần và dễ tạo thiện cảm. Tuy nhiên đôi khi thiếu thận trọng, dễ bị lừa hoặc đưa ra quyết định cảm tính. Nên tập suy nghĩ thấu đáo trước khi hành động.',
      'diemSo': '65',
    },
    'mat_mot_mi': {
      'ten': 'Mắt một mí',
      'moTa': 'Mí mắt trên không có nếp gấp, một mí rõ',
      'luanGiai':
          'Mắt một mí thường cho thấy người kiên định, có ý chí và ít bị chi phối bởi dư luận. Tư duy độc lập, làm việc có nguyên tắc. Tuy nhiên giao tiếp đôi khi hơi khô khan, thiếu linh hoạt trong ứng xử xã hội.',
      'diemSo': '70',
    },
    'mat_hai_mi': {
      'ten': 'Mắt hai mí rõ',
      'moTa': 'Mí mắt trên có nếp gấp rõ, mắt sâu',
      'luanGiai':
          'Mắt hai mí rõ thường gặp ở người có khiếu thẩm mỹ, dễ thu hút ánh nhìn và có năng khiếu nghệ thuật. Tính cách hướng ngoại, thích giao lưu. Tuy nhiên đôi khi thiếu kiên nhẫn với việc lặp đi lặp lại hoặc quá nhàm chán.',
      'diemSo': '74',
    },
  };

  // ============================================================
  // MŨI (Tài Bạch Cung) — Tài chính, ý chí
  // ============================================================
  static const Map<String, Map<String, String>> mui = {
    'mui_cao_thang': {
      'ten': 'Mũi cao thẳng (Mũi Huyền Đảm)',
      'moTa': 'Sống mũi cao, thẳng, đầu mũi tròn đầy',
      'luanGiai':
          'Đây là tướng mũi đẹp nhất về tài vận. Người có mũi cao thẳng, đầu tròn đầy thường có ý chí mạnh, biết kiếm tiền và giữ tiền. Trung vận (30-50 tuổi) thường phát triển mạnh về tài chính. Hợp kinh doanh, đầu tư hoặc quản lý tài sản.',
      'diemSo': '90',
    },
    'mui_tron_day': {
      'ten': 'Mũi tròn đầy (Mũi Phú Quý)',
      'moTa': 'Mũi không quá cao nhưng tròn, đầu mũi có thịt',
      'luanGiai':
          'Mũi tròn đầy là dấu hiệu phúc lộc. Người này thường có đời sống vật chất đầy đủ dù không phải kiểu giàu bùng nổ. Tính cách hào phóng, biết hưởng thụ và cũng biết chia sẻ. Tiền bạc đến đều và giữ được lâu.',
      'diemSo': '82',
    },
    'mui_nho_gon': {
      'ten': 'Mũi nhỏ gọn',
      'moTa': 'Mũi nhỏ, sống mũi thấp, cánh mũi gọn',
      'luanGiai':
          'Mũi nhỏ gọn cho thấy tài vận cần tự thân phấn đấu nhiều hơn. Không phải kiểu giàu sẵn mà phải đi từng bước. Tuy nhiên người này thường tiết kiệm, biết quản lý chi tiêu và ít khi rơi vào cảnh túng quẫn nếu sống có kế hoạch.',
      'diemSo': '58',
    },
    'mui_khoang': {
      'ten': 'Mũi khoằm (Mũi Ưng)',
      'moTa': 'Sống mũi cong, đầu mũi hơi nhọn xuống',
      'luanGiai':
          'Người mũi khoằm thường có đầu óc kinh doanh sắc bén, biết tính toán và không dễ bị lừa. Có khả năng nắm bắt cơ hội nhanh nhưng đôi khi quá tính toán khiến người khác e ngại. Hợp làm việc liên quan tài chính, đàm phán.',
      'diemSo': '72',
    },
    'mui_hec': {
      'ten': 'Mũi hếch (Mũi Lộ)',
      'moTa': 'Đầu mũi hếch lên nhìn thấy lỗ mũi',
      'luanGiai':
          'Mũi hếch là tướng hao tài, tiền bạc đến nhanh đi nhanh. Người có mũi này thường phóng khoáng, hào phóng nhưng khó giữ tiền. Cần có người quản lý tài chính giúp. Điểm hay là tính cách cởi mở, không thù dai và dễ tha thứ.',
      'diemSo': '48',
    },
    'mui_tet': {
      'ten': 'Mũi tẹt (Sống mũi thấp)',
      'moTa': 'Sống mũi thấp, gần như phẳng với mặt',
      'luanGiai':
          'Mũi tẹt cho thấy mức độ cầu tiến và tham vọng không quá cao. Người này thường bằng lòng với cuộc sống hiện tại, không thích bon chen. Tuy nhiên nếu có kết hợp các bộ vị khác tốt thì cuộc sống vẫn ổn định, an nhàn.',
      'diemSo': '52',
    },
    'mui_canh_ron': {
      'ten': 'Cánh mũi rộng (Mũi Vương)',
      'moTa': 'Hai cánh mũi nở rộng, dày',
      'luanGiai':
          'Cánh mũi rộng là tướng tài vận tốt, đặc biệt về tích lũy tài sản. Người này thường thành công trong lĩnh vực cần vốn và tài nguyên. Đầu tư bất động sản hoặc kinh doanh truyền thống rất hợp. Đường tài chính bền vững.',
      'diemSo': '80',
    },
    'mui_doc_dua': {
      'ten': 'Mũi dọc dừa (Mũi Đại Tướng)',
      'moTa': 'Sống mũi thẳng cao từ gốc đến đầu, đầu tròn',
      'luanGiai':
          'Mũi dọc dừa thuộc tướng quý. Người có sống mũi thẳng từ ấn đường xuống đầu mũi thường trung thực, quyết đoán và có trách nhiệm. Đường công danh thăng tiến đều đặn, hợp chính trường, quản lý cấp cao hoặc nghề đòi hỏi uy tín.',
      'diemSo': '87',
    },
  };

  // ============================================================
  // MIỆNG (Phúc Đức) — Phúc lộc, giao tiếp, hưởng thụ
  // ============================================================
  static const Map<String, Map<String, String>> mieng = {
    'mieng_rong_day': {
      'ten': 'Miệng rộng đầy đặn',
      'moTa': 'Miệng rộng, môi dày vừa phải, khóe miệng hướng lên',
      'luanGiai':
          'Miệng rộng đầy đặn với khóe hướng lên là tướng phúc lộc. Người này thường ăn nói có duyên, giao tiếp tốt và dễ được lòng người. Phúc đức dày, hậu vận thường an nhàn. Hợp công việc cần giao tiếp, thuyết trình hoặc kinh doanh.',
      'diemSo': '85',
    },
    'mieng_nho_gon': {
      'ten': 'Miệng nhỏ gọn',
      'moTa': 'Miệng nhỏ, môi mỏng, nét thanh',
      'luanGiai':
          'Miệng nhỏ gọn cho thấy người kín đáo, nói ít nhưng đúng trọng tâm. Không phải kiểu phô trương nhưng khi cần thì lời nói có sức nặng. Phúc đức ở mức vừa, cần tự bồi đắp bằng cách sống và cách đối xử.',
      'diemSo': '65',
    },
    'mieng_moi_day': {
      'ten': 'Môi dày',
      'moTa': 'Cả môi trên và môi dưới đều dày, đầy đặn',
      'luanGiai':
          'Môi dày là dấu hiệu của người giàu tình cảm, hào phóng và biết hưởng thụ cuộc sống. Thường có phúc ăn uống, đời sống vật chất không thiếu thốn. Tuy nhiên cần cẩn thận với việc chi tiêu theo cảm xúc.',
      'diemSo': '75',
    },
    'mieng_khoe_xuong': {
      'ten': 'Khóe miệng hướng xuống',
      'moTa': 'Hai khóe miệng hơi trễ xuống',
      'luanGiai':
          'Khóe miệng hướng xuống thường cho thấy người hay lo lắng, dễ bi quan hoặc trải qua nhiều thất vọng. Tuy nhiên đây cũng là dấu hiệu của người thận trọng, ít bị lừa. Cần chú ý giữ tinh thần lạc quan để phúc đức không bị hao.',
      'diemSo': '48',
    },
    'mieng_moi_mong': {
      'ten': 'Môi mỏng',
      'moTa': 'Cả hai môi mỏng, đường môi rõ',
      'luanGiai':
          'Môi mỏng cho thấy người lý trí, ít bị cảm xúc chi phối. Có khả năng hùng biện và tranh luận, hợp các nghề cần nói nhiều. Tuy nhiên dễ bị đánh giá là khô khan, thiếu ấm áp trong quan hệ cá nhân. Cần rèn sự mềm mỏng.',
      'diemSo': '60',
    },
    'mieng_trai_tim': {
      'ten': 'Môi trái tim (Môi Cupid)',
      'moTa': 'Môi trên cong hình trái tim rõ nét',
      'luanGiai':
          'Môi trên hình trái tim là tướng thu hút, quyến rũ tự nhiên. Người có môi này thường có đời sống tình cảm phong phú, có duyên với người khác giới. Hợp công việc nghệ thuật, sáng tạo. Nữ có môi này thường được nhiều người theo đuổi.',
      'diemSo': '78',
    },
    'mieng_cuoi_khe': {
      'ten': 'Miệng cười có lúm đồng tiền',
      'moTa': 'Khi cười xuất hiện lúm nhỏ hai bên má hoặc một bên',
      'luanGiai':
          'Người có lúm đồng tiền khi cười thường duyên dáng, dễ gây thiện cảm ngay lần đầu gặp. Tính cách vui vẻ, lạc quan và có khiếu hài hước. Đường tình duyên sớm nhưng cần tỉnh táo để chọn đúng người. Hợp nghề dịch vụ, chăm sóc khách hàng.',
      'diemSo': '76',
    },
    'mieng_hinh_cung': {
      'ten': 'Miệng hình cung nguyệt',
      'moTa': 'Miệng cong tự nhiên, khi đóng lại vẫn thấy đường cong',
      'luanGiai':
          'Miệng hình cung nguyệt thường thấy ở người lạc quan, yêu đời và có nụ cười đẹp. Đường phúc đức tốt, gặp nhiều may mắn trong cuộc sống. Nếu là nữ thì có số phú quý, được chồng con yêu thương và cuộc đời ít thăng trầm.',
      'diemSo': '82',
    },
  };

  // ============================================================
  // CẰM (Hậu Vận) — Sức bền cuối đời, nền tảng
  // ============================================================
  static const Map<String, Map<String, String>> cam = {
    'cam_vuong_day': {
      'ten': 'Cằm vuông đầy',
      'moTa': 'Cằm rộng, vuông vức, có thịt',
      'luanGiai':
          'Cằm vuông đầy là tướng hậu vận vững chắc. Người này càng về sau càng ổn định, có nền tảng vật chất và tinh thần tốt khi về già. Tính cách kiên định, có sức chịu đựng và biết xây dựng lâu dài.',
      'diemSo': '88',
    },
    'cam_nhon': {
      'ten': 'Cằm nhọn',
      'moTa': 'Cằm nhỏ, nhọn, ít thịt',
      'luanGiai':
          'Cằm nhọn cho thấy hậu vận cần được chăm sóc sớm. Nếu không tích lũy từ trung vận thì cuối đời dễ thiếu thốn hoặc cô đơn. Tuy nhiên người cằm nhọn thường nhạy cảm, có gu thẩm mỹ và sáng tạo. Cần chú ý tiết kiệm và giữ sức khỏe.',
      'diemSo': '50',
    },
    'cam_tron': {
      'ten': 'Cằm tròn',
      'moTa': 'Cằm tròn, mềm mại, không quá nhọn không quá vuông',
      'luanGiai':
          'Cằm tròn là dấu hiệu hậu vận an nhàn, có phúc hưởng thụ. Người này thường được con cháu hiếu thảo, cuối đời không phải lo lắng nhiều. Tính cách dễ chịu, biết sống hòa thuận và ít gây thù chuốc oán.',
      'diemSo': '80',
    },
    'cam_lech': {
      'ten': 'Cằm lệch hoặc thụt',
      'moTa': 'Cằm ngắn, thụt vào hoặc lệch sang một bên',
      'luanGiai':
          'Cằm thụt hoặc lệch cho thấy hậu vận có biến động, cần chủ động chuẩn bị từ sớm. Không nên trông chờ vào người khác mà phải tự tạo nền tảng cho mình. Điểm mạnh là thường rất linh hoạt và biết thích nghi.',
      'diemSo': '45',
    },
    'cam_day_nhan': {
      'ten': 'Cằm đầy đặn, căng tròn',
      'moTa': 'Cằm dày thịt, săn chắc, không chảy xệ',
      'luanGiai':
          'Cằm đầy đặn săn chắc là tướng của người giàu sinh lực, sức khỏe tốt và có nền tảng vật chất vững vàng từ tuổi trung niên trở đi. Hợp các công việc đòi hỏi sức bền thể chất và tinh thần. Hậu vận rất tốt.',
      'diemSo': '84',
    },
    'cam_hec': {
      'ten': 'Cằm hếch',
      'moTa': 'Cằm nhô ra phía trước, đường cằm chéo',
      'luanGiai':
          'Cằm hếch cho thấy người có tinh thần độc lập cao, không thích bị sai bảo. Có thể thành công trong sự nghiệp tự do hoặc sáng tạo. Tuy nhiên dễ bị đánh giá là kiêu ngạo. Cần học cách khiêm tốn và lắng nghe người khác.',
      'diemSo': '62',
    },
    'cam_lum_dong_tien': {
      'ten': 'Cằm có lúm đồng tiền',
      'moTa': 'Phần cằm có vết lõm nhỏ ở giữa',
      'luanGiai':
          'Cằm có lúm đồng tiền là tướng hiếm, cho thấy người có cá tính mạnh và sức hút đặc biệt. Thường là người quyến rũ, có duyên với người khác phái. Nếu là nữ thì có đường tình duyên sôi động, nhiều người theo đuổi.',
      'diemSo': '74',
    },
    'cam_doi': {
      'ten': 'Cằm đôi (Cằm Phúc)',
      'moTa': 'Cằm có lớp thịt đệm phía dưới tạo thành hai tầng',
      'luanGiai':
          'Cằm đôi là tướng phúc hậu và giàu sang. Người có cằm đôi thường hưởng thụ cuộc sống vật chất dồi dào, đặc biệt là ăn uống. Hậu vận sung túc, con cháu đề huề. Tuy nhiên cần chú ý kiểm soát cân nặng và sức khỏe tim mạch.',
      'diemSo': '79',
    },
  };

  // ============================================================
  // LÔNG MÀY (Bảo Thọ Cung) — Tuổi thọ, huynh đệ, quan hệ
  // ============================================================
  static const Map<String, Map<String, String>> longMay = {
    'long_may_rong_day': {
      'ten': 'Lông mày rộng đều đặn',
      'moTa': 'Lông mày rộng, dài qua đuôi mắt, sợi đều',
      'luanGiai':
          'Lông mày rộng và đều đặn là tướng trường thọ, có phúc đức với anh em họ hàng. Người này thường bao dung, có trách nhiệm với gia đình và dòng họ. Đường huynh đệ hòa thuận, quý nhân là anh em hoặc bạn bè thân thiết.',
      'diemSo': '85',
    },
    'long_may_nho_cao': {
      'ten': 'Lông mày nhỏ cao',
      'moTa': 'Lông mày mảnh, cong cao, cách xa mắt',
      'luanGiai':
          'Lông mày mảnh cao cho thấy người có khiếu thẩm mỹ, thông minh và có gu ăn mặc. Hợp các ngành nghệ thuật, thời trang, làm đẹp. Tuy nhiên đường huynh đệ có thể lạnh nhạt, ít gần gũi anh em họ hàng.',
      'diemSo': '72',
    },
    'long_may_reu_roi': {
      'ten': 'Lông mày rậm rối',
      'moTa': 'Lông mày dày, sợi thô, mọc không theo hàng lối',
      'luanGiai':
          'Lông mày rậm rối cho thấy người nóng tính, bộc trực và dễ xung đột. Tuy nhiên đây cũng là tướng của người có sức khỏe tốt, thể lực dồi dào và sống lâu. Cần kiểm soát cảm xúc và học cách bình tĩnh trong giao tiếp.',
      'diemSo': '58',
    },
    'long_may_thua_ngan': {
      'ten': 'Lông mày thưa ngắn',
      'moTa': 'Lông mày thưa, ngắn, không quá nửa mắt',
      'luanGiai':
          'Lông mày thưa ngắn cho thấy tình cảm gia đình và anh em có thể không gắn bó. Dễ xảy ra mâu thuẫn về tài sản thừa kế hoặc trách nhiệm với cha mẹ. Về sức khỏe, cần chú ý hệ miễn dịch và tuổi thọ trong dòng họ.',
      'diemSo': '42',
    },
    'long_may_dep': {
      'ten': 'Lông mày đẹp (Mày Ngài)',
      'moTa': 'Lông mày cong tự nhiên, mềm mại, đều sợi',
      'luanGiai':
          'Lông mày đẹp tự nhiên là tướng đại quý. Người này thường thành công trong sự nghiệp, có uy tín và được kính trọng. Đường huynh đệ tốt, anh em giúp đỡ nhau thành công. Nữ có mày này thường có số mệnh phú quý, phúc lộc song toàn.',
      'diemSo': '90',
    },
    'long_may_dai_xuong_duoi_mat': {
      'ten': 'Lông mày dài qua mắt (Mày Phủ)',
      'moTa': 'Đuôi lông mày kéo dài quá đuôi mắt',
      'luanGiai':
          'Lông mày dài qua mắt là tướng trường thọ và nhân hậu. Người này thường sống trên 80 tuổi, ít bệnh tật lớn. Tính tình ôn hòa, được lòng mọi người. Anh em họ hàng quý mến, giúp đỡ nhiều trong cuộc sống.',
      'diemSo': '86',
    },
  };

  // ============================================================
  // TAI (Tứ Tự Cung) — Tuổi thọ, phúc khí, quý cách
  // ============================================================
  static const Map<String, Map<String, String>> tai = {
    'tai_to_day': {
      'ten': 'Tai to dày (Tai Phú)',
      'moTa': 'Tai to, dái tai dày và dài, vành tai rõ',
      'luanGiai':
          'Tai to dày dái là tướng phú quý và trường thọ nhất trong nhân tướng. Người này thường có cuộc sống sung túc, gia đạo bình an. Càng về già càng được quý trọng. Đây là tướng của người có phúc đức tổ tiên và dòng dõi cao quý.',
      'diemSo': '90',
    },
    'tai_nho_mong': {
      'ten': 'Tai nhỏ mỏng',
      'moTa': 'Tai nhỏ, vành tai mỏng, dái tai ngắn',
      'luanGiai':
          'Tai nhỏ mỏng cho thấy phúc khí trung bình, sức khỏe cần chú ý bồi dưỡng. Người này thường nhạy cảm, dễ bị tổn thương và khó làm việc dưới áp lực cao. Tuy nhiên bù lại là sự tinh tế và khả năng cảm nhận sâu sắc.',
      'diemSo': '50',
    },
    'tai_cheo_day_nho': {
      'ten': 'Tai trái to phải nhỏ',
      'moTa': 'Hai tai không đều, một bên to một bên nhỏ',
      'luanGiai':
          'Tai không đều cho thấy cuộc đời có nhiều thay đổi bất ngờ, có giai đoạn thịnh có giai đoạn suy. Tuổi thọ vẫn tốt nếu biết chăm sóc sức khỏe. Cha mẹ có thể một người mất sớm hoặc công việc của cha mẹ bấp bênh.',
      'diemSo': '55',
    },
    'tai_dai_day_day': {
      'ten': 'Dái tai dày dài, sáng bóng',
      'moTa': 'Phần dái tai dày, dài, căng đầy và có màu hồng sáng',
      'luanGiai':
          'Dái tai dày dài sáng bóng là tướng số đại quý. Người này có trí tuệ uyên thâm, phúc đức sâu dày, thường sống lâu trên 80 tuổi. Sự nghiệp thăng tiến đều đặn, gặp nhiều may mắn trong cuộc đời. Đặc biệt phù hợp với công việc tâm linh hoặc giáo dục.',
      'diemSo': '92',
    },
    'tai_vang_mong_sat_dau': {
      'ten': 'Tai vành mỏng sát đầu',
      'moTa': 'Tai áp sát vào đầu, vành tai mỏng nhẵn',
      'luanGiai':
          'Tai vành mỏng sát đầu là tướng thông minh, nhanh nhạy. Người này có năng khiếu ngôn ngữ và biện luận. Tuy nhiên sức khỏe có thể yếu hơn người khác, cần chú ý dinh dưỡng và nghỉ ngơi. Hợp nghề nghiên cứu, viết lách hoặc giảng dạy.',
      'diemSo': '68',
    },
    'tai_cao_tren_mat': {
      'ten': 'Tai cao hơn mắt',
      'moTa': 'Đỉnh tai cao hơn so với đuôi mắt',
      'luanGiai':
          'Tai cao hơn mắt là tướng thông minh xuất chúng. Người này thường đỗ đạt cao từ sớm, danh vọng vang xa. Hợp chính trường, học thuật hoặc quản lý cấp cao. Trong lịch sử, Khổng Tử và nhiều bậc vĩ nhân đều có tướng tai này.',
      'diemSo': '88',
    },
  };

  // ============================================================
  // TAM ĐÌNH (Tỷ lệ 3 phần mặt) — Cân bằng vận mệnh
  // ============================================================
  static const Map<String, Map<String, String>> tamDinh = {
    'can_doi': {
      'ten': 'Tam đình cân đối',
      'moTa': 'Ba phần mặt (trán - mũi - cằm) tỷ lệ đều nhau',
      'luanGiai':
          'Tam đình cân đối là tướng lý tưởng: tiền vận, trung vận và hậu vận đều thuận. Cuộc đời phát triển đều đặn, ít có giai đoạn quá khó khăn hoặc quá bùng nổ. Đây là nền tảng tốt để xây dựng cuộc sống bền vững.',
      'diemSo': '85',
    },
    'thuong_dinh_dai': {
      'ten': 'Thượng đình lớn (Trán dài)',
      'moTa': 'Phần trán chiếm tỷ lệ lớn hơn 2 phần còn lại',
      'luanGiai':
          'Thượng đình lớn cho thấy tiền vận sáng, trí tuệ phát triển sớm và thường thành công trong học hành. Tuy nhiên trung và hậu vận cần nỗ lực duy trì, tránh ỷ lại vào thành tích ban đầu.',
      'diemSo': '72',
    },
    'trung_dinh_dai': {
      'ten': 'Trung đình lớn (Mũi dài)',
      'moTa': 'Phần giữa mặt (từ mắt đến mũi) chiếm tỷ lệ lớn',
      'luanGiai':
          'Trung đình lớn báo hiệu trung vận (30-50 tuổi) là giai đoạn phát triển mạnh nhất. Đây là thời kỳ vàng để tích lũy tài sản và xây dựng sự nghiệp. Cần tận dụng tốt giai đoạn này.',
      'diemSo': '78',
    },
    'ha_dinh_dai': {
      'ten': 'Hạ đình lớn (Cằm dài)',
      'moTa': 'Phần cằm chiếm tỷ lệ lớn hơn bình thường',
      'luanGiai':
          'Hạ đình lớn cho thấy hậu vận tốt, càng về sau càng ổn định. Người này thường "chín muộn", thành công đến sau 40-50 tuổi nhưng bền và vững. Cần kiên nhẫn ở giai đoạn đầu.',
      'diemSo': '76',
    },
  };

  // ============================================================
  // NGŨ HÀNH DIỆN TƯỚNG — Phân loại mặt theo ngũ hành
  // ============================================================
  static const Map<String, Map<String, String>> nguHanhDien = {
    'kim_dien': {
      'ten': 'Diện tướng Kim (Mặt vuông)',
      'moTa': 'Mặt vuông vức góc cạnh, xương hàm rõ, da trắng',
      'luanGiai':
          'Mặt vuông thuộc hành Kim. Người này có khí chất uy nghi, nguyên tắc và quyết đoán. Hợp chính trường, quân đội, quản lý. Hành Kim khắc Mộc, nếu gặp người mặt dài Mộc diện thì dễ xung khắc. Cần rèn sự linh hoạt để bù đắp tính cố chấp.',
      'diemSo': '80',
    },
    'moc_dien': {
      'ten': 'Diện tướng Mộc (Mặt dài)',
      'moTa': 'Mặt dài, xương nhỏ, da hơi xanh hoặc vàng nhạt',
      'luanGiai':
          'Mặt dài thuộc hành Mộc. Người này có tư duy sáng tạo, linh hoạt, yêu thiên nhiên và nghệ thuật. Hợp giáo dục, văn hóa, thiết kế. Hành Mộc sinh Hỏa, nếu kết hợp với người mặt nhọn Hỏa diện thì hỗ trợ nhau tốt. Điểm yếu là dễ dao động, thiếu kiên định.',
      'diemSo': '75',
    },
    'thuy_dien': {
      'ten': 'Diện tướng Thủy (Mặt tròn)',
      'moTa': 'Mặt tròn đầy đặn, da sáng hoặc ngăm, mắt ướt',
      'luanGiai':
          'Mặt tròn thuộc hành Thủy. Người này khéo giao tiếp, thích nghi nhanh và có tài ngoại giao. Hợp kinh doanh, dịch vụ, quan hệ công chúng. Hành Thủy khắc Hỏa, nếu gặp người mặt nhọn Hỏa diện dễ mâu thuẫn. Tính tình hào phóng nhưng đôi khi cảm xúc quá mức.',
      'diemSo': '78',
    },
    'hoa_dien': {
      'ten': 'Diện tướng Hỏa (Mặt nhọn)',
      'moTa': 'Mặt nhọn về phía cằm, trán rộng, da hồng đỏ',
      'luanGiai':
          'Mặt nhọn thuộc hành Hỏa. Người này nhiệt tình, năng động, có tài lãnh đạo nhưng nóng tính. Hợp nghề cần sự quyết đoán, thể thao, kinh doanh. Hành Hỏa sinh Thổ, nếu kết hợp với mặt vuông Thổ thì công việc thuận lợi. Cần kiềm chế cảm xúc để tránh hối tiếc.',
      'diemSo': '72',
    },
    'tho_dien': {
      'ten': 'Diện tướng Thổ (Mặt dày vuông)',
      'moTa': 'Mặt vuông nhưng đầy đặn, da vàng, sống mũi dày',
      'luanGiai':
          'Mặt đầy vuông thuộc hành Thổ. Người này trung hậu, đáng tin cậy, có trách nhiệm. Hợp bất động sản, xây dựng, nông nghiệp. Hành Thổ sinh Kim, hợp với người mặt vuông Kim diện. Điểm yếu là chậm thay đổi, đôi khi quá bảo thủ.',
      'diemSo': '82',
    },
  };

  // ============================================================
  // LUẬN THEO GIỚI TÍNH
  // ============================================================
  static const Map<String, Map<String, String>> luanGioiTinh = {
    'nam_tran_cao': {
      'ten': 'Nam trán cao',
      'moTa': 'Nam giới có trán cao rộng',
      'luanGiai':
          'Nam giới trán cao rộng là tướng đại lợi cho công danh. Người này thông minh, có tài lãnh đạo, dễ đạt vị trí cao trong xã hội. Kết hôn muộn (sau 30) thì gia đạo càng bền. Hợp chính trường, doanh nghiệp lớn.',
      'diemSo': '86',
    },
    'nu_tran_cao': {
      'ten': 'Nữ trán cao',
      'moTa': 'Nữ giới có trán cao rộng',
      'luanGiai':
          'Nữ giới trán cao thường thông minh, cá tính mạnh và không chịu khuất phục. Đường hôn nhân dễ trắc trở nếu lấy chồng sớm. Hợp kết hôn muộn hoặc lấy chồng hiền lành biết nhường nhịn. Sự nghiệp riêng tốt, có thể làm lãnh đạo.',
      'diemSo': '70',
    },
    'nam_mat_to': {
      'ten': 'Nam mắt to',
      'moTa': 'Nam giới có mắt to, sáng',
      'luanGiai':
          'Nam giới mắt to sáng là tướng thông minh, trực giác tốt. Làm việc năng động, dễ thành công trong giao tiếp. Tuy nhiên cẩn thận đường tình cảm dễ bị chi phối bởi sắc đẹp và cảm xúc nhất thời.',
      'diemSo': '78',
    },
    'nu_mat_to': {
      'ten': 'Nữ mắt to',
      'moTa': 'Nữ giới có mắt to, mơ màng',
      'luanGiai':
          'Nữ giới mắt to thường có sức hút tự nhiên, dễ làm say đắm lòng người. Tình duyên sớm nhưng cần tỉnh táo để không bị lừa tình. Nếu biết chọn người, cuộc sống hôn nhân hạnh phúc. Hợp các nghề cần giao tiếp và nghệ thuật.',
      'diemSo': '76',
    },
    'nam_mui_cao': {
      'ten': 'Nam mũi cao',
      'moTa': 'Nam giới có mũi cao thẳng',
      'luanGiai':
          'Nam giới mũi cao thẳng là tướng đại quý. Sự nghiệp thăng tiến, tài chính vững mạnh sau 35 tuổi. Có chí hướng lớn, biết kiếm tiền và quản lý tài sản. Vợ con nhờ đó mà hưởng phúc, cuộc sống sung túc.',
      'diemSo': '88',
    },
    'nu_mui_cao': {
      'ten': 'Nữ mũi cao',
      'moTa': 'Nữ giới có mũi cao, sống mũi rõ',
      'luanGiai':
          'Nữ giới mũi cao là tướng có cá tính, độc lập và có năng lực quản lý tài chính. Hợp giúp chồng trong kinh doanh hoặc tự làm chủ. Tuy nhiên nếu sống mũi cao mà có xương thì dễ chủ động trong hôn nhân, cần người chồng biết lắng nghe.',
      'diemSo': '75',
    },
    'nam_mieng_rong': {
      'ten': 'Nam miệng rộng',
      'moTa': 'Nam giới có miệng rộng, môi dày',
      'luanGiai':
          'Nam giới miệng rộng là tướng phúc khí, ăn nói có uy tín. Hợp các vị trí cần nói nhiều như MC, diễn giả, chính trị gia. Có tài hùng biện và thuyết phục người khác. Tiền vận tốt, càng về sau càng nhiều tài lộc.',
      'diemSo': '84',
    },
    'nu_mieng_rong': {
      'ten': 'Nữ miệng rộng',
      'moTa': 'Nữ giới có miệng rộng hơn trung bình',
      'luanGiai':
          'Nữ giới miệng rộng là tướng phúc, an nhàn và ít lo nghĩ. Đường ăn uống tốt, cuộc sống vật chất không thiếu. Tình duyên thuận, được chồng yêu thương và cung phụng. Hợp lấy chồng giàu hoặc làm nghề liên quan ẩm thực, dịch vụ.',
      'diemSo': '80',
    },
  };

  // ============================================================
  // THẬP PHÁP NHÂN TƯỚNG — 10 Pháp xem tướng cốt lõi
  // ============================================================
  /// 1. Pháp Khí Sắc: xem thần khí qua da mặt và ánh mắt
  static String phapKhiSac(String luongDa, String sacMat) {
    if (luongDa == 'sang' && sacMat == 'co-than') {
      return 'Khí sắc sáng, mắt có thần là tướng đại cát. Người này thời vận đang lên, mọi việc hanh thông. Gặp khó cũng dễ vượt qua nhờ tinh thần minh mẫn và sức sống dồi dào. Mùa xuân và thu là thời điểm tốt nhất để triển khai đại sự.';
    }
    if (luongDa == 'sang' && sacMat == 'mo-diu') {
      return 'Da mặt sáng mịn nhưng mắt trầm cho thấy người có nội lực tốt nhưng không thích phô trương. Hợp công việc tĩnh tại, nghiên cứu hoặc tâm linh. Sức khỏe ổn định, tuổi thọ cao. Thời vận đi theo hướng tích lũy dần.';
    }
    if (luongDa == 'am-dam' && sacMat == 'duc-hoac') {
      return 'Khí sắc tối, mắt đục là tướng hung. Thời vận đang xuống, cần thận trọng trong mọi quyết định. Tránh đầu tư lớn, thay đổi công việc hoặc kết hôn trong 6 tháng tới. Nên tĩnh dưỡng, cải thiện sức khỏe và đợi thời.';
    }
    return 'Khí sắc trung bình, không có biến động lớn. Thời vận ổn định, không quá tốt cũng không quá xấu. Nên duy trì lối sống lành mạnh và nắm bắt cơ hội khi đến.';
  }

  /// 2. Pháp Hình Thần: xem sự cân đối thân thể và tinh thần
  static String phapHinhThan(double height, double weight) {
    final double bmi = weight / ((height / 100) * (height / 100));
    if (bmi >= 18.5 && bmi <= 24.9) {
      return 'Thân thể cân đối (BMI chuẩn) cho thấy thể - tâm tương đối hài hòa. Sức khỏe tổng thể tốt, ít bệnh tật. Vận mệnh có xu hướng ổn định, làm việc gì cũng đạt kết quả trung bình khá nhờ sự đều đặn và kiên trì.';
    }
    if (bmi < 18.5) {
      return 'Thân thể hơi gầy so với chuẩn. Người này thường năng động, suy nghĩ nhiều và khó tăng cân. Cần chú ý bồi bổ sức khỏe và tránh lao tâm quá độ. Thần lực tốt, có xu hướng thành công nhờ trí tuệ hơn thể lực.';
    }
    if (bmi > 24.9) {
      return 'Thân thể quá khổ cho thấy người này hưởng thụ vật chất tốt nhưng cần kiểm soát sức khỏe. Nguy cơ cao về tim mạch, tiểu đường. Về tướng số, người đầy đặn thường hào phóng, dễ gần nhưng cần cẩn thận về đường ăn uống và vận động.';
    }
    return 'Không có dữ liệu BMI, không thể đánh giá hình thần.';
  }

  /// 3. Pháp Ngũ Nhạc: xem 5 ngọn núi trên mặt
  static String phapNguNhac(
    int diemTran,
    int diemMui,
    int diemMieng,
    int diemCam,
    int diemMat,
  ) {
    final int tong = diemTran + diemMui + diemMieng + diemCam + diemMat;
    if (tong >= 400) {
      return 'Ngũ nhạc tề tụ — Không chỉ đẹp về tướng mạo mà còn có phúc khí tổng thể rất tốt. Cả năm bộ vị chính đều đạt điểm cao, báo hiệu một cuộc đời toàn diện: sức khỏe, tài lộc, danh vọng, tình duyên và hậu vận đều tốt.';
    }
    if (tong >= 350) {
      return 'Ngũ nhạc tương đối hài hòa. Cuộc sống không quá xuất sắc ở mọi mặt nhưng nhìn chung thuận lợi. Có một vài bộ vị cần cải thiện nhưng không đáng ngại.';
    }
    if (tong >= 300) {
      return 'Ngũ nhạc có sự lệch pha giữa các bộ vị. Một số mặt tốt, một số mặt cần nỗ lực nhiều. Cuộc đời sẽ có thăng trầm rõ rệt tùy theo giai đoạn. Cần phát huy điểm mạnh và cải thiện điểm yếu.';
    }
    return 'Ngũ nhạc có nhiều điểm yếu. Tuy nhiên tướng tại tâm sinh — nếu rèn luyện nhân cách và trí tuệ thì tướng mạo và vận mệnh cũng thay đổi theo thời gian.';
  }

  // ============================================================
  // TỔNG HỢP — Đánh giá tổng thể
  // ============================================================
  static String luanTongThe(Map<String, int> diemBoVi) {
    final int tongDiem = diemBoVi.values.fold(0, (sum, d) => sum + d);
    final double trungBinh = tongDiem / diemBoVi.length;

    if (trungBinh >= 80) {
      return 'Tổng quan khuôn mặt cho thấy tướng mạo khá đẹp và cân đối. Đây là nền tảng tốt cho cả sự nghiệp, tài chính lẫn quan hệ xã hội. Điểm mạnh nằm ở sự hài hòa tổng thể, giúp tạo ấn tượng tốt và dễ được tin tưởng.';
    }
    if (trungBinh >= 65) {
      return 'Tổng quan khuôn mặt ở mức khá, có những điểm sáng rõ ràng bên cạnh một vài điểm cần lưu ý. Nhìn chung đây là tướng mạo thuận lợi cho phát triển nếu biết phát huy đúng thế mạnh và bù đắp điểm yếu bằng nỗ lực.';
    }
    if (trungBinh >= 50) {
      return 'Tổng quan khuôn mặt ở mức trung bình, không quá nổi bật nhưng cũng không có điểm xấu rõ rệt. Thành bại phụ thuộc nhiều vào cách sống, cách rèn luyện và môi trường. Tướng tại tâm sinh — tâm tốt thì tướng cũng dần sáng.';
    }
    return 'Tổng quan khuôn mặt có một số điểm cần chú ý. Tuy nhiên trong nhân tướng học, tướng mạo chỉ là một phần — tâm tính, hành động và nỗ lực mới quyết định phần lớn vận mệnh. Hãy tập trung vào điểm mạnh và cải thiện dần.';
  }

  // ============================================================
  // LUẬN MỞ RỘNG — Tình cảm, con cái, sức khỏe theo tướng mạo
  // ============================================================

  /// Luận về tình duyên / vợ chồng dựa trên tổng hợp ngũ quan
  static String luanTinhDuyen(Map<String, int> diemBoVi) {
    final int diemMat = diemBoVi['mat'] ?? 50;
    final int diemMieng = diemBoVi['mieng'] ?? 50;
    final int diemMui = diemBoVi['mui'] ?? 50;

    final List<String> parts = [];

    if (diemMat >= 80) {
      parts.add(
        'Đôi mắt sáng và cân đối cho thấy người có duyên tình cảm tốt, dễ thu hút đối phương và biết nhìn người. Thường gặp được người phù hợp nếu không vội vàng.',
      );
    } else if (diemMat >= 60) {
      parts.add(
        'Mắt ở mức khá cho thấy duyên tình cảm có nhưng cần thời gian để tìm đúng người. Không nên chọn theo cảm xúc nhất thời mà nên xét cả sự đồng điệu lâu dài.',
      );
    } else {
      parts.add(
        'Mắt cho thấy đường tình cảm cần kiên nhẫn hơn bình thường. Dễ gặp hiểu lầm hoặc chọn sai nếu quá vội. Nên ưu tiên hiểu rõ bản thân trước khi gắn bó.',
      );
    }

    if (diemMieng >= 75) {
      parts.add(
        'Miệng đẹp là dấu hiệu phúc đức gia đạo tốt. Hôn nhân thường thuận hòa, biết cách giao tiếp và giữ gìn quan hệ. Gia đình sau này có nền ổn định.',
      );
    } else if (diemMieng < 55) {
      parts.add(
        'Miệng cho thấy cần chú ý cách giao tiếp trong quan hệ vợ chồng. Đôi khi lời nói vô tình gây tổn thương. Học cách nói mềm và lắng nghe sẽ giúp gia đạo bền hơn.',
      );
    }

    if (diemMui >= 75) {
      parts.add(
        'Mũi tốt báo hiệu nền tài chính gia đình vững. Vợ chồng ít phải lo lắng về vật chất, có khả năng xây dựng tổ ấm ổn định.',
      );
    } else if (diemMui < 55) {
      parts.add(
        'Mũi cho thấy tài chính gia đình cần được quản lý cẩn thận. Nên có kế hoạch tài chính chung rõ ràng với bạn đời để tránh mâu thuẫn về tiền bạc.',
      );
    }

    if (parts.isEmpty) {
      parts.add(
        'Nhìn chung tướng mạo cho thấy đường tình duyên ở mức trung bình, thành bại phụ thuộc nhiều vào cách đối xử và sự trưởng thành cảm xúc của cả hai.',
      );
    }

    return parts.join('\n\n');
  }

  /// Luận về con cái / hậu duệ dựa trên tướng mạo
  static String luanConCai(Map<String, int> diemBoVi) {
    final int diemCam = diemBoVi['cam'] ?? 50;
    final int diemMieng = diemBoVi['mieng'] ?? 50;
    final int diemTamDinh = diemBoVi['tamDinh'] ?? 50;

    final List<String> parts = [];

    if (diemCam >= 80) {
      parts.add(
        'Cằm vuông đầy là tướng có phúc con cháu. Hậu duệ thường hiếu thảo, gia đình về sau đông đúc và hòa thuận. Cuối đời được con cái phụng dưỡng.',
      );
    } else if (diemCam >= 60) {
      parts.add(
        'Cằm ở mức khá cho thấy đường con cái thuận, có thể có 1-2 người con ngoan và biết lo. Quan hệ cha mẹ - con cái nhìn chung tốt nếu biết giáo dục đúng cách.',
      );
    } else {
      parts.add(
        'Cằm cho thấy phương diện con cái cần chú ý. Có thể muộn con hoặc con cái tính cách mạnh, khó bảo. Cần kiên nhẫn trong giáo dục và tránh áp đặt quá mức.',
      );
    }

    if (diemMieng >= 70) {
      parts.add(
        'Miệng đẹp cho thấy có phúc nuôi con, con cái lớn lên khỏe mạnh và ít bệnh vặt. Gia đình có nếp ăn uống tốt, biết chăm sóc nhau.',
      );
    }

    if (diemTamDinh >= 75) {
      parts.add(
        'Tam đình cân đối báo hiệu cuộc sống gia đình phát triển đều qua các giai đoạn. Con cái sinh ra đúng thời điểm, không quá sớm cũng không quá muộn.',
      );
    }

    if (parts.isEmpty) {
      parts.add(
        'Tướng mạo cho thấy đường con cái ở mức bình thường. Quan trọng nhất vẫn là cách giáo dục, yêu thương và tạo môi trường tốt cho con phát triển.',
      );
    }

    return parts.join('\n\n');
  }

  /// Luận về sức khỏe dựa trên tướng mạo
  static String luanSucKhoe(Map<String, int> diemBoVi) {
    final int diemMat = diemBoVi['mat'] ?? 50;
    final int diemMui = diemBoVi['mui'] ?? 50;
    final int diemMieng = diemBoVi['mieng'] ?? 50;
    final int diemTran = diemBoVi['tran'] ?? 50;

    final List<String> parts = [];

    if (diemMat >= 75) {
      parts.add(
        'Mắt sáng có thần cho thấy tinh thần minh mẫn, sức sống dồi dào. Ít bị trầm cảm hoặc suy nhược tinh thần. Nền tảng sức khỏe tâm lý tốt.',
      );
    } else if (diemMat < 55) {
      parts.add(
        'Mắt cho thấy cần chú ý sức khỏe tinh thần. Dễ mệt mỏi, stress hoặc mất ngủ nếu làm việc quá sức. Nên có thói quen nghỉ ngơi đều đặn.',
      );
    }

    if (diemMui >= 75) {
      parts.add(
        'Mũi tốt báo hiệu hệ hô hấp khỏe, sinh lực dồi dào. Ít bị các bệnh về phổi, mũi họng. Sức đề kháng tự nhiên khá.',
      );
    } else if (diemMui < 55) {
      parts.add(
        'Mũi cho thấy cần chú ý hệ hô hấp. Dễ bị viêm mũi, dị ứng hoặc các vấn đề về đường thở. Nên tránh môi trường ô nhiễm và giữ ấm vùng mũi họng.',
      );
    }

    if (diemMieng >= 70) {
      parts.add(
        'Miệng đẹp cho thấy hệ tiêu hóa tốt, biết ăn uống điều độ. Ít gặp vấn đề về dạ dày, đường ruột.',
      );
    } else if (diemMieng < 50) {
      parts.add(
        'Miệng cho thấy cần chú ý hệ tiêu hóa. Dễ bị đau dạ dày, khó tiêu hoặc ăn uống thất thường. Nên giữ nếp ăn đều giờ và tránh đồ cay nóng quá mức.',
      );
    }

    if (diemTran < 55) {
      parts.add(
        'Trán cho thấy cần chú ý sức khỏe vùng đầu. Dễ đau đầu, mất tập trung hoặc căng thẳng thần kinh khi áp lực cao. Nên tập thiền hoặc yoga để giảm stress.',
      );
    }

    if (parts.isEmpty) {
      parts.add(
        'Tướng mạo cho thấy nền sức khỏe ở mức trung bình. Quan trọng nhất vẫn là duy trì lối sống lành mạnh: ăn đủ, ngủ đủ, vận động đều.',
      );
    }

    return parts.join('\n\n');
  }

  /// Luận về sự nghiệp / công danh chi tiết hơn
  static String luanSuNghiep(Map<String, int> diemBoVi) {
    final int diemTran = diemBoVi['tran'] ?? 50;
    final int diemMat = diemBoVi['mat'] ?? 50;
    final int diemMui = diemBoVi['mui'] ?? 50;
    final int diemTamDinh = diemBoVi['tamDinh'] ?? 50;

    final List<String> parts = [];

    if (diemTran >= 80) {
      parts.add(
        'Trán cao rộng là tướng quan lộc sáng. Sự nghiệp phát triển sớm, dễ được cấp trên tin tưởng và giao trọng trách. Hợp con đường học thuật, quản lý hoặc chuyên gia.',
      );
    } else if (diemTran >= 60) {
      parts.add(
        'Trán ở mức khá cho thấy sự nghiệp tiến dần, không bùng nổ ngay nhưng bền. Cần kiên trì tích lũy kinh nghiệm và uy tín.',
      );
    } else {
      parts.add(
        'Trán cho thấy sự nghiệp cần tự thân phấn đấu nhiều. Ít được nâng đỡ sẵn, nhưng nếu chịu khó thì sau 30 tuổi sẽ ổn định dần.',
      );
    }

    if (diemMat >= 75 && diemMui >= 75) {
      parts.add(
        'Mắt sáng kết hợp mũi tốt là tướng vừa có trí tuệ vừa có tài vận. Rất hợp kinh doanh hoặc quản lý tài chính. Dễ thành công nếu chọn đúng ngành.',
      );
    }

    if (diemTamDinh >= 75) {
      parts.add(
        'Tam đình cân đối cho thấy sự nghiệp phát triển đều qua các giai đoạn, không bị gãy nhịp đột ngột. Đây là nền tảng tốt cho sự nghiệp dài hạn.',
      );
    }

    if (parts.isEmpty) {
      parts.add(
        'Tướng mạo cho thấy sự nghiệp ở mức trung bình, cần nỗ lực và chọn đúng hướng. Tập trung vào thế mạnh bản thân thay vì chạy theo xu hướng.',
      );
    }

    return parts.join('\n\n');
  }

  /// Luận chuyên sâu tính cách dựa trên tổng hợp tướng mạo
  static String luanTinhCach(Map<String, int> diemBoVi) {
    final List<String> parts = [];
    final int diemTran = diemBoVi['tran'] ?? 50;
    final int diemMat = diemBoVi['mat'] ?? 50;
    final int diemMui = diemBoVi['mui'] ?? 50;
    final int diemMieng = diemBoVi['mieng'] ?? 50;
    final int diemCam = diemBoVi['cam'] ?? 50;

    if (diemTran >= 75 && diemMat >= 75) {
      parts.add(
        'Trí tuệ và tầm nhìn là điểm mạnh nổi bật. Bạn thuộc mẫu người vừa thông minh vừa sắc sảo trong quan sát, có khả năng đánh giá tình huống và đưa ra quyết định chính xác. Người khác thường tìm đến bạn để xin lời khuyên.',
      );
    } else if (diemTran >= 75) {
      parts.add(
        'Thiên về trí tuệ và tư duy chiến lược. Bạn thích nhìn xa, lên kế hoạch và ít khi bị cuốn vào chuyện nhỏ nhặt. Điểm mạnh là tầm nhìn, điểm yếu là đôi khi sống trong đầu quá nhiều.',
      );
    } else if (diemMat >= 75) {
      parts.add(
        'Giàu cảm xúc và trực giác. Bạn nhìn người bằng trái tim nhiều hơn lý trí, có khả năng thấu cảm tốt. Hợp công việc liên quan chăm sóc, tư vấn hoặc sáng tạo.',
      );
    } else {
      parts.add(
        'Tính cách thực tế, thiên về hành động hơn suy nghĩ. Bạn không thích lý thuyết dài dòng mà muốn kết quả cụ thể. Đôi khi hơi thiếu kiên nhẫn nhưng bù lại rất quyết đoán.',
      );
    }

    if (diemMui >= 75 && diemCam >= 75) {
      parts.add(
        'Ý chí mạnh mẽ và kiên định. Khi đã đặt mục tiêu, bạn gần như không bỏ cuộc giữa chừng. Đây là phẩm chất giúp bạn vượt qua nghịch cảnh và đạt được thành công bền vững trong cuộc sống.',
      );
    } else if (diemMui < 55 && diemCam < 55) {
      parts.add(
        'Tính cách có phần mềm yếu hoặc thiếu kiên định. Bạn dễ bị tác động bởi người khác và có thể thay đổi quyết định nhiều lần. Cần rèn luyện ý chí và lòng tự tin để vững vàng hơn.',
      );
    }

    if (diemMieng >= 75) {
      parts.add(
        'Bạn có duyên ăn nói và tài giao tiếp bẩm sinh. Dễ kết bạn, dễ tạo ảnh hưởng và thường là trung tâm của các cuộc trò chuyện. Hợp nghề cần giao tiếp nhiều như bán hàng, giảng dạy, ngoại giao.',
      );
    } else if (diemMieng < 55) {
      parts.add(
        'Bạn là người ít nói, sống nội tâm. Không thích tụ tập đông người hay chuyện phiếm. Khi cần nói, bạn nói ngắn gọn, trúng vấn đề. Đây là điểm mạnh trong công việc cần sự tập trung và bí mật.',
      );
    }

    return parts.join('\n\n');
  }

  /// Luận về hướng phát triển bản thân dựa trên tướng
  static String luanPhatTrien(Map<String, int> diemBoVi) {
    final List<String> parts = [];
    final int diemTran = diemBoVi['tran'] ?? 50;
    final int diemMui = diemBoVi['mui'] ?? 50;

    if (diemTran >= 75) {
      parts.add(
        '● Học tập & tri thức: Trán đẹp cho thấy bạn có nền tảng trí tuệ tốt. Nên đầu tư vào học vấn, đọc sách và phát triển chuyên môn. Các lĩnh vực như công nghệ, tài chính, luật hoặc học thuật phù hợp với bạn.',
      );
    } else {
      parts.add(
        '● Học tập & tri thức: Không phải mẫu người học theo trường lớp truyền thống, nhưng bạn học rất tốt qua trải nghiệm thực tế. Học nghề, học qua làm việc hoặc tự học là con đường phù hợp nhất.',
      );
    }

    if (diemMui >= 75) {
      parts.add(
        '● Tài chính & sự nghiệp: Khả năng quản lý tài chính tốt. Nếu kết hợp với kỷ luật đầu tư dài hạn, bạn có thể đạt tự do tài chính trước 50 tuổi. Kinh doanh, đầu tư hoặc làm chủ là hướng đi phù hợp.',
      );
    } else {
      parts.add(
        '● Tài chính & sự nghiệp: Nên ưu tiên ổn định trước khi mạo hiểm. Làm công ở môi trường tốt để tích lũy vốn và kinh nghiệm, sau đó mới tính đến chuyện riêng. Tiết kiệm đều đặn là chìa khóa.',
      );
    }

    if (diemBoVi['tamDinh'] != null && (diemBoVi['tamDinh'] ?? 50) >= 70) {
      parts.add(
        '● Phát triển toàn diện: Tam đình cân đối cho thấy bạn có tiềm năng phát triển đều ở cả ba giai đoạn đời. Hãy tận dụng từng giai đoạn đúng cách: học hỏi khi trẻ, hành động khi trung niên và hưởng thụ khi về già.',
      );
    }

    return parts.join('\n\n');
  }
}
