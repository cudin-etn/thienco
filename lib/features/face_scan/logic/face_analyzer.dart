import 'dart:math';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'tuong_so_data.dart';

/// Phân tích khuôn mặt dựa trên tỷ lệ ngũ quan
/// Sử dụng Google ML Kit Face Detection landmarks
class FaceAnalyzer {
  /// Phân tích toàn bộ khuôn mặt, trả về kết quả cho từng bộ vị
  static Map<String, dynamic> analyzeFullFace(Face face) {
    final Map<String, dynamic> results = {};

    results['mat'] = _analyzeMat(face);
    results['mui'] = _analyzeMui(face);
    results['mieng'] = _analyzeMieng(face);
    results['tran'] = _analyzeTran(face);
    results['cam'] = _analyzeCam(face);
    results['tamDinh'] = _analyzeTamDinh(face);
    results['longMay'] = _analyzeLongMay(face);
    results['tai'] = _analyzeTai(face);
    results['nguHanh'] = _analyzeNguHanh(face);

    // Tính điểm tổng
    final Map<String, int> diemBoVi = {};
    for (final entry in results.entries) {
      final data = entry.value;
      if (data is Map && data.containsKey('diemSo')) {
        diemBoVi[entry.key] =
            int.tryParse(data['diemSo']?.toString() ?? '50') ?? 50;
      }
    }

    final int tongDiem = diemBoVi.values.fold(0, (sum, d) => sum + d);
    final double trungBinh = diemBoVi.isNotEmpty
        ? tongDiem / diemBoVi.length
        : 50;

    results['tongQuan'] = {
      'diemTrungBinh': trungBinh.round(),
      'diemBoVi': diemBoVi,
      'luanGiai': TuongSoData.luanTongThe(diemBoVi),
    };

    // Luận mở rộng
    results['tinhDuyen'] = TuongSoData.luanTinhDuyen(diemBoVi);
    results['conCai'] = TuongSoData.luanConCai(diemBoVi);
    results['sucKhoe'] = TuongSoData.luanSucKhoe(diemBoVi);
    results['suNghiep'] = TuongSoData.luanSuNghiep(diemBoVi);
    results['tinhCach'] = TuongSoData.luanTinhCach(diemBoVi);
    results['phatTrien'] = TuongSoData.luanPhatTrien(diemBoVi);

    return results;
  }

  /// Phân tích Mắt (khoảng cách + kích thước)
  static Map<String, String> _analyzeMat(Face face) {
    final leftEye = face.landmarks[FaceLandmarkType.leftEye];
    final rightEye = face.landmarks[FaceLandmarkType.rightEye];

    if (leftEye == null || rightEye == null) {
      return TuongSoData.mat['mat_can_doi']!;
    }

    final double dx = (rightEye.position.x - leftEye.position.x).toDouble();
    final double dy = (rightEye.position.y - leftEye.position.y).toDouble();
    final double eyeDistance = sqrt(dx * dx + dy * dy);
    final double faceWidth = face.boundingBox.width;
    final double ratio = eyeDistance / faceWidth;

    // Ước lượng kích thước mắt từ hộp giới hạn
    final double eyeBoxWidth = face.boundingBox.width * 0.12;
    final double eyeSize = (eyeBoxWidth / faceWidth);

    if (ratio > 0.47) {
      return TuongSoData.mat['mat_xa_nhau']!;
    } else if (ratio < 0.38) {
      return TuongSoData.mat['mat_gan_nhau']!;
    } else if (ratio >= 0.38 && ratio <= 0.40) {
      if (eyeSize > 0.08) {
        return TuongSoData.mat['mat_tron']!;
      }
      return TuongSoData.mat['mat_nho_sau']!;
    } else if (ratio >= 0.44 && ratio <= 0.47) {
      return TuongSoData.mat['mat_to_sang']!;
    } else {
      // Đo độ chênh đuôi mắt
      if (dy.abs() > 4) {
        if (dy > 0) {
          return TuongSoData.mat['mat_duoi_xech']!;
        } else {
          return TuongSoData.mat['mat_duoi_xuong']!;
        }
      }
      return TuongSoData.mat['mat_can_doi']!;
    }
  }

  /// Phân tích Mũi (chiều dài + độ rộng)
  static Map<String, String> _analyzeMui(Face face) {
    final noseBase = face.landmarks[FaceLandmarkType.noseBase];
    final leftEye = face.landmarks[FaceLandmarkType.leftEye];
    final rightEye = face.landmarks[FaceLandmarkType.rightEye];
    final leftCheek = face.landmarks[FaceLandmarkType.leftCheek];
    final rightCheek = face.landmarks[FaceLandmarkType.rightCheek];

    if (noseBase == null || leftEye == null || rightEye == null) {
      return TuongSoData.mui['mui_tron_day']!;
    }

    final double faceHeight = face.boundingBox.height;
    final double faceWidth = face.boundingBox.width;
    final double eyeY = (leftEye.position.y + rightEye.position.y) / 2;
    final double noseLength = (noseBase.position.y - eyeY).toDouble();
    final double noseRatio = noseLength / faceHeight;

    // Độ rộng cánh mũi ước lượng từ cheek và noseBase
    double wingRatio = 0.25;
    if (leftCheek != null && rightCheek != null) {
      final double cheekWidth =
          (rightCheek.position.x - leftCheek.position.x).abs().toDouble();
      if (cheekWidth > 0) {
        wingRatio = faceWidth / cheekWidth;
      }
    }

    if (noseRatio > 0.28 && noseRatio < 0.33) {
      return TuongSoData.mui['mui_doc_dua']!;
    } else if (noseRatio > 0.28) {
      if (wingRatio > 0.4) {
        return TuongSoData.mui['mui_canh_ron']!;
      }
      return TuongSoData.mui['mui_cao_thang']!;
    } else if (noseRatio < 0.20) {
      if (wingRatio < 0.25) {
        return TuongSoData.mui['mui_hec']!;
      }
      return TuongSoData.mui['mui_nho_gon']!;
    } else if (noseRatio >= 0.20 && noseRatio <= 0.23) {
      if (wingRatio < 0.25) {
        return TuongSoData.mui['mui_tet']!;
      }
      return TuongSoData.mui['mui_khoang']!;
    } else {
      return TuongSoData.mui['mui_tron_day']!;
    }
  }

  /// Phân tích Miệng (tỷ lệ rộng miệng / mặt)
  static Map<String, String> _analyzeMieng(Face face) {
    final leftMouth = face.landmarks[FaceLandmarkType.leftMouth];
    final rightMouth = face.landmarks[FaceLandmarkType.rightMouth];
    final bottomMouth = face.landmarks[FaceLandmarkType.bottomMouth];

    if (leftMouth == null || rightMouth == null) {
      return TuongSoData.mieng['mieng_rong_day']!;
    }

    final double mouthWidth = (rightMouth.position.x - leftMouth.position.x)
        .toDouble()
        .abs();
    final double faceWidth = face.boundingBox.width;
    final double ratio = mouthWidth / faceWidth;

    // Kiểm tra khóe miệng
    if (bottomMouth != null &&
        leftMouth.position.y > bottomMouth.position.y + 2) {
      return TuongSoData.mieng['mieng_khoe_xuong']!;
    }

    if (ratio > 0.45) {
      return TuongSoData.mieng['mieng_rong_day']!;
    } else if (ratio < 0.35) {
      return TuongSoData.mieng['mieng_nho_gon']!;
    } else {
      final double topMouthY = (face.landmarks[FaceLandmarkType.noseBase] != null
          ? face.landmarks[FaceLandmarkType.noseBase]!.position.y
          : 0).toDouble();
      final double lipThickness =
          (bottomMouth?.position.y ?? topMouthY + 10) - topMouthY;
      if (lipThickness > 12) {
        return TuongSoData.mieng['mieng_moi_day']!;
      } else if (lipThickness < 6) {
        return TuongSoData.mieng['mieng_moi_mong']!;
      }
      return TuongSoData.mieng['mieng_hinh_cung']!;
    }
  }

  /// Phân tích Trán (tỷ lệ chiều cao trán / mặt)
  static Map<String, String> _analyzeTran(Face face) {
    final leftEye = face.landmarks[FaceLandmarkType.leftEye];
    final rightEye = face.landmarks[FaceLandmarkType.rightEye];

    if (leftEye == null || rightEye == null) {
      return TuongSoData.tran['tran_phang']!;
    }

    final double faceTop = face.boundingBox.top;
    final double eyeY = (leftEye.position.y + rightEye.position.y) / 2;
    final double foreheadHeight = eyeY - faceTop;
    final double faceHeight = face.boundingBox.height;
    final double ratio = foreheadHeight / faceHeight;

    if (ratio > 0.38) {
      return TuongSoData.tran['tran_cao_rong']!;
    } else if (ratio < 0.28) {
      return TuongSoData.tran['tran_hep']!;
    } else if (ratio >= 0.28 && ratio <= 0.31) {
      return TuongSoData.tran['tran_loi']!;
    } else {
      return TuongSoData.tran['tran_phang']!;
    }
  }

  /// Phân tích Cằm (tỷ lệ chiều dài cằm / mặt)
  static Map<String, String> _analyzeCam(Face face) {
    final bottomMouth = face.landmarks[FaceLandmarkType.bottomMouth];

    if (bottomMouth == null) {
      return TuongSoData.cam['cam_tron']!;
    }

    final double faceBottom = face.boundingBox.bottom;
    final double chinLength = faceBottom - bottomMouth.position.y;
    final double faceHeight = face.boundingBox.height;
    final double ratio = chinLength / faceHeight;

    final double faceWidth = face.boundingBox.width;
    final double chinWidthRatio = faceWidth / faceHeight;

    if (ratio > 0.22 && chinWidthRatio > 0.75) {
      return TuongSoData.cam['cam_vuong_day']!;
    } else if (ratio > 0.22) {
      return TuongSoData.cam['cam_day_nhan']!;
    } else if (ratio < 0.15) {
      return TuongSoData.cam['cam_nhon']!;
    } else if (ratio >= 0.15 && ratio <= 0.18) {
      if (chinWidthRatio > 0.7) {
        return TuongSoData.cam['cam_lec']!;
      }
      return TuongSoData.cam['cam_hec']!;
    } else {
      return TuongSoData.cam['cam_tron']!;
    }
  }

  /// Phân tích Tam Đình (3 phần mặt: trán - mũi - cằm)
  static Map<String, String> _analyzeTamDinh(Face face) {
    final leftEye = face.landmarks[FaceLandmarkType.leftEye];
    final rightEye = face.landmarks[FaceLandmarkType.rightEye];
    final noseBase = face.landmarks[FaceLandmarkType.noseBase];
    final bottomMouth = face.landmarks[FaceLandmarkType.bottomMouth];

    if (leftEye == null || rightEye == null || noseBase == null) {
      return TuongSoData.tamDinh['can_doi']!;
    }

    final double faceTop = face.boundingBox.top;
    final double faceBottom = face.boundingBox.bottom;
    final double faceHeight = faceBottom - faceTop;

    final double eyeY = (leftEye.position.y + rightEye.position.y) / 2;
    final double thuongDinh = eyeY - faceTop;
    final double mouthY = bottomMouth != null
        ? bottomMouth.position.y.toDouble()
        : (noseBase.position.y.toDouble() + faceHeight * 0.15);
    final double trungDinh = mouthY - eyeY;
    final double haDinh = faceBottom - mouthY;

    final double total = thuongDinh + trungDinh + haDinh;
    if (total <= 0) return TuongSoData.tamDinh['can_doi']!;

    final double thuongRatio = thuongDinh / total;
    final double trungRatio = trungDinh / total;
    final double haRatio = haDinh / total;

    final double deviation =
        (thuongRatio - 0.333).abs() +
        (trungRatio - 0.333).abs() +
        (haRatio - 0.333).abs();

    if (deviation < 0.12) {
      return TuongSoData.tamDinh['can_doi']!;
    }

    if (thuongRatio > trungRatio && thuongRatio > haRatio) {
      return TuongSoData.tamDinh['thuong_dinh_dai']!;
    } else if (trungRatio > thuongRatio && trungRatio > haRatio) {
      return TuongSoData.tamDinh['trung_dinh_dai']!;
    } else {
      return TuongSoData.tamDinh['ha_dinh_dai']!;
    }
  }

  /// Phân tích Lông mày (ước lượng từ vị trí mắt)
  static Map<String, String> _analyzeLongMay(Face face) {
    final leftEye = face.landmarks[FaceLandmarkType.leftEye];
    final rightEye = face.landmarks[FaceLandmarkType.rightEye];

    if (leftEye == null || rightEye == null) {
      return TuongSoData.longMay['long_may_dep']!;
    }

    final double faceTop = face.boundingBox.top;
    final double eyeY = (leftEye.position.y + rightEye.position.y) / 2;
    final double browHeight = eyeY - faceTop;
    final double faceHeight = face.boundingBox.height;
    final double browRatio = browHeight / faceHeight;

    // Khoảng cách giữa mắt (ước lượng độ rộng lông mày)
    final double eyeDistance =
        (rightEye.position.x - leftEye.position.x).abs().toDouble();
    final double faceWidth = face.boundingBox.width;
    final double eyeDistanceRatio = eyeDistance / faceWidth;

    if (browRatio > 0.22) {
      return TuongSoData.longMay['long_may_rong_day']!;
    } else if (browRatio < 0.14) {
      if (eyeDistanceRatio < 0.38) {
        return TuongSoData.longMay['long_may_thua_ngan']!;
      }
      return TuongSoData.longMay['long_may_nho_cao']!;
    } else if (eyeDistanceRatio > 0.42) {
      return TuongSoData.longMay['long_may_thua_ngan']!;
    } else {
      return TuongSoData.longMay['long_may_dep']!;
    }
  }

  /// Phân tích Tai (ước lượng từ vị trí mắt, má)
  static Map<String, String> _analyzeTai(Face face) {
    // ML Kit không có landmark tai, dùng bounding box và eye position
    final leftEye = face.landmarks[FaceLandmarkType.leftEye];
    final rightEye = face.landmarks[FaceLandmarkType.rightEye];

    if (leftEye == null || rightEye == null) {
      return TuongSoData.tai['tai_nho_mong']!;
    }

    final double faceWidth = face.boundingBox.width;
    final double faceHeight = face.boundingBox.height;
    final double eyeY = (leftEye.position.y + rightEye.position.y) / 2;
    final double relativeEarHeight = faceHeight / faceWidth;

    // Tỷ lệ mặt càng gần vuông thì tai càng rộng
    if (relativeEarHeight > 1.4) {
      // Mặt dài → tai thường cao hơn mắt
      final double eyeRatio = eyeY / faceHeight;
      if (eyeRatio < 0.45) {
        return TuongSoData.tai['tai_cao_tren_mat']!;
      }
      return TuongSoData.tai['tai_cao_tren_mat']!;
    } else if (relativeEarHeight < 1.2) {
      // Mặt ngắn → tai thường to
      return TuongSoData.tai['tai_to_day']!;
    } else if (faceWidth > 140 && faceHeight > 180) {
      return TuongSoData.tai['tai_dai_day_day']!;
    } else {
      return TuongSoData.tai['tai_to_day']!;
    }
  }

  /// Phân tích Ngũ Hành Diện Tướng (từ tỷ lệ mặt)
  static Map<String, String> _analyzeNguHanh(Face face) {
    final double faceWidth = face.boundingBox.width;
    final double faceHeight = face.boundingBox.height;
    if (faceHeight <= 0) return TuongSoData.nguHanhDien['tho_dien']!;

    final double ratio = faceWidth / faceHeight;

    // Mặt tròn (Thủy): ratio > 0.8
    // Mặt vuông (Kim): ratio 0.7-0.8
    // Mặt dài (Mộc): ratio < 0.65
    // Mặt nhọn (Hỏa): ratio 0.65-0.7 + cằm nhọn
    // Mặt đầy vuông (Thổ): ratio 0.7-0.75 + đầy đặn

    if (ratio > 0.83) {
      return TuongSoData.nguHanhDien['thuy_dien']!;
    } else if (ratio >= 0.78) {
      return TuongSoData.nguHanhDien['tho_dien']!;
    } else if (ratio >= 0.72) {
      return TuongSoData.nguHanhDien['kim_dien']!;
    } else if (ratio >= 0.67) {
      // Kiểm tra thêm: cằm nhọn hơn mặt → Hỏa
      final bottomMouth = face.landmarks[FaceLandmarkType.bottomMouth];
      if (bottomMouth != null) {
        final double chinLength =
            face.boundingBox.bottom - bottomMouth.position.y;
        if (chinLength < faceHeight * 0.17) {
          return TuongSoData.nguHanhDien['hoa_dien']!;
        }
      }
      return TuongSoData.nguHanhDien['moc_dien']!;
    } else {
      return TuongSoData.nguHanhDien['moc_dien']!;
    }
  }
}
