import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:share_plus/share_plus.dart';

class PdfHelper {
  static pw.Font? _font;

  static Future<pw.Font> get _defaultFont async {
    _font ??= pw.Font.ttf(
      await rootBundle.load('assets/fonts/NotoSans-Regular.ttf'),
    );
    return _font!;
  }

  static Future<File> _generatePdf({
    required pw.Document Function(pw.Font font) buildDoc,
  }) async {
    final font = await _defaultFont;
    final doc = buildDoc(font);
    final tempDir = await getTemporaryDirectory();
    final file = File(
      '${tempDir.path}/thien_co_${DateTime.now().millisecondsSinceEpoch}.pdf',
    );
    await file.writeAsBytes(await doc.save());
    return file;
  }

  static Future<void> sharePdf({
    required pw.Document Function(pw.Font font) buildDoc,
    required String subject,
    String? text,
  }) async {
    try {
      final file = await _generatePdf(buildDoc: buildDoc);
      await SharePlus.instance.share(
        ShareParams(
          files: [XFile(file.path)],
          text: text ?? subject,
          subject: subject,
        ),
      );
    } catch (_) {}
  }

  // ========== TƯỚNG SỐ PDF ==========

  static Future<void> shareTuongSoPdf({
    required double diemTongQuan,
    required Map<String, int> diemBoVi,
    required Map<String, Map<String, dynamic>> phanTichChiTiet,
    required String nguHanh,
    required Map<String, dynamic> moRong,
    required String luanGiaiTong,
  }) async {
    await sharePdf(
      subject: 'Kết quả Tướng Số',
      buildDoc: (font) => _buildTuongSoDoc(
        font,
        diemTongQuan,
        diemBoVi,
        phanTichChiTiet,
        nguHanh,
        moRong,
        luanGiaiTong,
      ),
    );
  }

  static pw.Document _buildTuongSoDoc(
    pw.Font font,
    double diemTongQuan,
    Map<String, int> diemBoVi,
    Map<String, Map<String, dynamic>> phanTichChiTiet,
    String nguHanh,
    Map<String, dynamic> moRong,
    String luanGiaiTong,
  ) {
    final doc = pw.Document();

    doc.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(32),
        build: (ctx) => [
          _header(font),
          pw.SizedBox(height: 20),
          _gradientTitle(font, 'TƯỚNG SỐ'),
          pw.SizedBox(height: 20),
          _scoreSection(font, diemTongQuan, nguHanh),
          pw.SizedBox(height: 24),
          _sectionTitle(font, 'Tổng Quan'),
          pw.SizedBox(height: 10),
          pw.Text(luanGiaiTong, style: pw.TextStyle(font: font, fontSize: 12, lineSpacing: 1.5)),
          pw.SizedBox(height: 24),
          _sectionTitle(font, 'Chi Tiết Các Bộ Vị'),
          pw.SizedBox(height: 10),
          ...diemBoVi.entries.map((e) => _boViRow(font, e.key, e.value, phanTichChiTiet[e.key])),
        ],
        footer: (ctx) => _footer(font),
      ),
    );

    if (moRong.isNotEmpty) {
      doc.addPage(
        pw.MultiPage(
          pageFormat: PdfPageFormat.a4,
          margin: const pw.EdgeInsets.all(32),
          build: (ctx) => [
            _header(font),
            pw.SizedBox(height: 20),
            _sectionTitle(font, 'Luận Giải Mở Rộng'),
            pw.SizedBox(height: 14),
            ..._buildMoRongSections(font, moRong),
          ],
          footer: (ctx) => _footer(font),
        ),
      );
    }

    return doc;
  }

  static List<pw.Widget> _buildMoRongSections(pw.Font font, Map<String, dynamic> moRong) {
    final sections = <String, String>{};
    if (moRong['tinhCach'] is String) sections['Tính Cách'] = moRong['tinhCach'] as String;
    if (moRong['tinhDuyen'] is String) sections['Tình Duyên'] = moRong['tinhDuyen'] as String;
    if (moRong['suNghiep'] is String) sections['Sự Nghiệp'] = moRong['suNghiep'] as String;
    if (moRong['sucKhoe'] is String) sections['Sức Khỏe'] = moRong['sucKhoe'] as String;
    if (moRong['conCai'] is String) sections['Con Cái'] = moRong['conCai'] as String;
    if (moRong['phatTrien'] is String) sections['Phát Triển'] = moRong['phatTrien'] as String;

    return sections.entries.map((e) {
      return pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          _subTitle(font, e.key),
          pw.SizedBox(height: 8),
          pw.Text(e.value, style: pw.TextStyle(font: font, fontSize: 12, lineSpacing: 1.5)),
          pw.SizedBox(height: 20),
        ],
      );
    }).toList();
  }

  // ========== TỬ VI PDF ==========

  static Future<void> shareTuViPdf({
    required String hoTen,
    required String gioiTinh,
    required String ngaySinhAmLich,
    required String gioSinh,
    required int tuoiMu,
    required String cungMenh,
    required String menhChinhTinh,
    required String menhCuc,
    required String cungThan,
    required String canChiNam,
    required List<Map<String, dynamic>> segments,
  }) async {
    await sharePdf(
      subject: 'Lá số Tử Vi - $hoTen',
      buildDoc: (font) => _buildTuViDoc(
        font,
        hoTen,
        gioiTinh,
        ngaySinhAmLich,
        gioSinh,
        tuoiMu,
        cungMenh,
        menhChinhTinh,
        menhCuc,
        cungThan,
        canChiNam,
        segments,
      ),
    );
  }

  static pw.Document _buildTuViDoc(
    pw.Font font,
    String hoTen,
    String gioiTinh,
    String ngaySinhAmLich,
    String gioSinh,
    int tuoiMu,
    String cungMenh,
    String menhChinhTinh,
    String menhCuc,
    String cungThan,
    String canChiNam,
    List<Map<String, dynamic>> segments,
  ) {
    final doc = pw.Document();

    doc.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(32),
        build: (ctx) => [
          _header(font),
          pw.SizedBox(height: 20),
          _gradientTitle(font, 'LÁ SỐ TỬ VI'),
          pw.SizedBox(height: 20),
          _infoCard(font, [
            ('Họ tên', hoTen),
            ('Giới tính', gioiTinh),
            ('Âm lịch', ngaySinhAmLich),
            ('Giờ sinh', gioSinh),
            ('Tuổi mụ', '$tuoiMu'),
            ('Mệnh', '$cungMenh - $menhChinhTinh'),
            ('Thân', cungThan),
            ('Cục', menhCuc),
            ('Năm', canChiNam),
          ]),
          pw.SizedBox(height: 28),
          _sectionTitle(font, 'Bình Giải Chi Tiết'),
          pw.SizedBox(height: 14),
        ],
        footer: (ctx) => _footer(font),
      ),
    );

    for (int i = 0; i < segments.length; i++) {
      final seg = segments[i];
      final title = seg['title'] as String? ?? '';
      final keyPoints = seg['keyPoints'] as List? ?? [];
      final tier1 = seg['tier1'] as String? ?? '';
      final tier2Content = seg['tier2Content'] as String? ?? '';
      final tier3Content = seg['tier3Content'] as String? ?? '';

      doc.addPage(
        pw.MultiPage(
          pageFormat: PdfPageFormat.a4,
          margin: const pw.EdgeInsets.all(32),
          build: (ctx) => [
            _header(font),
            pw.SizedBox(height: 16),
            _segmentTitle(font, title),
            pw.SizedBox(height: 20),
            if (keyPoints.isNotEmpty) ...[
              _subTitle(font, 'Điểm Chính'),
              pw.SizedBox(height: 8),
              ...keyPoints.map((kp) => pw.Padding(
                padding: const pw.EdgeInsets.only(bottom: 6, left: 8),
                child: pw.Row(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text('• ', style: pw.TextStyle(font: font, fontSize: 13, color: PdfColors.cyan)),
                    pw.Expanded(
                      child: pw.Text(kp.toString(), style: pw.TextStyle(font: font, fontSize: 12, lineSpacing: 1.5)),
                    ),
                  ],
                ),
              )),
              pw.SizedBox(height: 16),
            ],
            if (tier1.isNotEmpty) ...[
              _subTitle(font, 'Chi Tiết'),
              pw.SizedBox(height: 8),
              pw.Text(tier1, style: pw.TextStyle(font: font, fontSize: 12, lineSpacing: 1.5)),
              pw.SizedBox(height: 14),
            ],
            if (tier2Content.isNotEmpty) ...[
              _subTitle(font, 'Chuyên Sâu'),
              pw.SizedBox(height: 8),
              pw.Text(tier2Content, style: pw.TextStyle(font: font, fontSize: 12, lineSpacing: 1.5)),
              pw.SizedBox(height: 14),
            ],
            if (tier3Content.isNotEmpty) ...[
              _subTitle(font, 'Mở Rộng'),
              pw.SizedBox(height: 8),
              pw.Text(tier3Content, style: pw.TextStyle(font: font, fontSize: 12, lineSpacing: 1.5)),
            ],
          ],
          footer: (ctx) => _footer(font),
        ),
      );
    }

    return doc;
  }

  // ========== SHARED WIDGETS ==========

  static pw.Widget _header(pw.Font font) {
    return pw.Column(
      children: [
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.center,
          children: [
            pw.Container(
              width: 40,
              height: 40,
              decoration: pw.BoxDecoration(
                gradient: pw.LinearGradient(
                  begin: pw.Alignment.topLeft,
                  end: pw.Alignment.bottomRight,
                  colors: [PdfColors.cyan600, PdfColors.cyan],
                ),
                shape: pw.BoxShape.circle,
              ),
              child: pw.Center(
                child: pw.Text('TC', style: pw.TextStyle(font: font, fontSize: 16, color: PdfColors.white)),
              ),
            ),
            pw.SizedBox(width: 12),
            pw.Text('THIÊN CƠ', style: pw.TextStyle(font: font, fontSize: 22, letterSpacing: 5, color: PdfColors.cyan)),
          ],
        ),
        pw.SizedBox(height: 14),
        pw.Divider(color: PdfColors.grey400, thickness: 0.5),
      ],
    );
  }

  static pw.Widget _footer(pw.Font font) {
    return pw.Column(
      children: [
        pw.Divider(color: PdfColors.grey400, thickness: 0.5),
        pw.SizedBox(height: 6),
        pw.Text(
          'Kết quả được tạo bởi THIÊN CƠ',
          style: pw.TextStyle(font: font, fontSize: 9, color: PdfColors.grey500),
        ),
      ],
    );
  }

  static pw.Widget _gradientTitle(pw.Font font, String title) {
    return pw.Container(
      padding: const pw.EdgeInsets.symmetric(vertical: 14, horizontal: 24),
      decoration: pw.BoxDecoration(
        gradient: pw.LinearGradient(
          begin: pw.Alignment.centerLeft,
          end: pw.Alignment.centerRight,
          colors: [PdfColors.cyan700, PdfColors.cyan, PdfColors.cyan600],
        ),
        borderRadius: const pw.BorderRadius.all(pw.Radius.circular(10)),
        boxShadow: [
          pw.BoxShadow(
            color: PdfColors.cyan.withAlpha(0.3),
            blurRadius: 8,
            offset: const PdfPoint(0, 3),
          ),
        ],
      ),
      child: pw.Center(
        child: pw.Text(
          title,
          style: pw.TextStyle(font: font, fontSize: 24, color: PdfColors.white, letterSpacing: 3),
        ),
      ),
    );
  }

  static pw.Widget _sectionTitle(pw.Font font, String title) {
    return pw.Container(
      padding: const pw.EdgeInsets.fromLTRB(14, 10, 14, 10),
      decoration: pw.BoxDecoration(
        color: PdfColors.cyan50,
        borderRadius: const pw.BorderRadius.all(pw.Radius.circular(8)),
        border: pw.Border(
          left: pw.BorderSide(color: PdfColors.cyan, width: 5),
        ),
      ),
      child: pw.Text(
        title,
        style: pw.TextStyle(font: font, fontSize: 16, color: PdfColors.cyan800),
      ),
    );
  }

  static pw.Widget _subTitle(pw.Font font, String title) {
    return pw.Text(
      title,
      style: pw.TextStyle(font: font, fontSize: 14, color: PdfColors.cyan),
    );
  }

  static pw.Widget _segmentTitle(pw.Font font, String title) {
    return pw.Container(
      padding: const pw.EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      decoration: pw.BoxDecoration(
        gradient: pw.LinearGradient(
          begin: pw.Alignment.centerLeft,
          end: pw.Alignment.centerRight,
          colors: [PdfColors.cyan700, PdfColors.cyan, PdfColors.cyan600],
        ),
        borderRadius: const pw.BorderRadius.all(pw.Radius.circular(10)),
        boxShadow: [
          pw.BoxShadow(
            color: PdfColors.cyan.withAlpha(0.25),
            blurRadius: 6,
            offset: const PdfPoint(0, 2),
          ),
        ],
      ),
      child: pw.Center(
        child: pw.Text(
          title,
          style: pw.TextStyle(font: font, fontSize: 18, color: PdfColors.white, letterSpacing: 2),
        ),
      ),
    );
  }

  static pw.Widget _infoCard(pw.Font font, List<(String, String)> rows) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(22),
      decoration: pw.BoxDecoration(
        color: PdfColors.grey50,
        borderRadius: const pw.BorderRadius.all(pw.Radius.circular(12)),
        border: pw.Border.all(color: PdfColors.grey300, width: 0.5),
        boxShadow: [
          pw.BoxShadow(
            color: PdfColors.grey.withAlpha(0.1),
            blurRadius: 6,
            offset: const PdfPoint(0, 2),
          ),
        ],
      ),
      child: pw.Column(
        children: rows.map((r) => pw.Padding(
          padding: const pw.EdgeInsets.symmetric(vertical: 4),
          child: pw.Row(
            children: [
              pw.SizedBox(
                width: 90,
                child: pw.Text(r.$1, style: pw.TextStyle(font: font, fontSize: 12, color: PdfColors.grey600)),
              ),
              pw.Expanded(
                child: pw.Text(r.$2, style: pw.TextStyle(font: font, fontSize: 12)),
              ),
            ],
          ),
        )).toList(),
      ),
    );
  }

  static pw.Widget _scoreSection(pw.Font font, double score, String nguHanh) {
    final color = score >= 75 ? PdfColors.green : (score >= 55 ? PdfColors.orange : PdfColors.red);
    return pw.Container(
      padding: const pw.EdgeInsets.all(28),
      decoration: pw.BoxDecoration(
        color: PdfColors.grey50,
        borderRadius: const pw.BorderRadius.all(pw.Radius.circular(14)),
        border: pw.Border.all(color: PdfColors.grey300, width: 0.5),
        boxShadow: [
          pw.BoxShadow(
            color: PdfColors.grey.withAlpha(0.1),
            blurRadius: 8,
            offset: const PdfPoint(0, 3),
          ),
        ],
      ),
      child: pw.Column(
        children: [
          pw.Stack(
            alignment: pw.Alignment.center,
            children: [
              pw.SizedBox(
                width: 110,
                height: 110,
                child: pw.CircularProgressIndicator(
                  value: score / 100,
                  color: color,
                  strokeWidth: 8,
                  backgroundColor: PdfColors.grey300,
                ),
              ),
              pw.Column(
                children: [
                  pw.Text(score.toStringAsFixed(0), style: pw.TextStyle(font: font, fontSize: 32)),
                  pw.Text('TỔNG ĐIỂM', style: pw.TextStyle(font: font, fontSize: 10, color: PdfColors.grey600)),
                ],
              ),
            ],
          ),
          pw.SizedBox(height: 16),
          pw.Container(
            padding: const pw.EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            decoration: pw.BoxDecoration(
              color: PdfColors.purple50,
              borderRadius: const pw.BorderRadius.all(pw.Radius.circular(20)),
              border: pw.Border.all(color: PdfColors.purple200, width: 0.5),
            ),
            child: pw.Text('Ngũ hành diện tướng: $nguHanh', style: pw.TextStyle(font: font, fontSize: 13, color: PdfColors.purple)),
          ),
        ],
      ),
    );
  }

  static pw.Widget _boViRow(
    pw.Font font,
    String ten,
    int diem,
    Map<String, dynamic>? chiTiet,
  ) {
    final color = diem >= 75 ? PdfColors.green : (diem >= 55 ? PdfColors.orange : PdfColors.red);
    final moTa = chiTiet?['moTa'] as String? ?? '--';
    final nhanXet = chiTiet?['nhanXet'] as String? ?? '';

    return pw.Container(
      margin: const pw.EdgeInsets.only(bottom: 10),
      padding: const pw.EdgeInsets.all(14),
      decoration: pw.BoxDecoration(
        color: PdfColors.grey50,
        borderRadius: const pw.BorderRadius.all(pw.Radius.circular(10)),
        border: pw.Border.all(color: PdfColors.grey300, width: 0.5),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Row(
            children: [
              pw.Text(ten, style: pw.TextStyle(font: font, fontSize: 13)),
              pw.Spacer(),
              pw.Text('$diem/100', style: pw.TextStyle(font: font, fontSize: 13, color: color)),
            ],
          ),
          pw.SizedBox(height: 8),
          pw.Container(
            height: 6,
            decoration: pw.BoxDecoration(
              borderRadius: const pw.BorderRadius.all(pw.Radius.circular(3)),
              color: PdfColors.grey300,
            ),
            child: pw.Align(
              alignment: pw.Alignment.centerLeft,
              child: pw.Container(
                width: (diem / 100) * 300,
                height: 6,
                decoration: pw.BoxDecoration(
                  borderRadius: const pw.BorderRadius.all(pw.Radius.circular(3)),
                  color: color,
                ),
              ),
            ),
          ),
          if (moTa.isNotEmpty) ...[
            pw.SizedBox(height: 8),
            pw.Text(moTa, style: pw.TextStyle(font: font, fontSize: 11, color: PdfColors.grey700)),
          ],
          if (nhanXet.isNotEmpty) ...[
            pw.SizedBox(height: 6),
            pw.Text(nhanXet, style: pw.TextStyle(font: font, fontSize: 11, lineSpacing: 1.4)),
          ],
        ],
      ),
    );
  }
}
