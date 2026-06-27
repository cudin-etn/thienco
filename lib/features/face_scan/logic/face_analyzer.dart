import 'dart:math';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'face_data.dart';
import 'tuong_so_data.dart';

class FaceAnalyzer {
  static Map<String, dynamic> analyzeFullFace(Face face) {
    final leftEye = _pos(face.landmarks[FaceLandmarkType.leftEye]);
    final rightEye = _pos(face.landmarks[FaceLandmarkType.rightEye]);
    final noseBase = _pos(face.landmarks[FaceLandmarkType.noseBase]);
    final leftCheek = _pos(face.landmarks[FaceLandmarkType.leftCheek]);
    final rightCheek = _pos(face.landmarks[FaceLandmarkType.rightCheek]);
    final leftMouth = _pos(face.landmarks[FaceLandmarkType.leftMouth]);
    final rightMouth = _pos(face.landmarks[FaceLandmarkType.rightMouth]);
    final bottomMouth = _pos(face.landmarks[FaceLandmarkType.bottomMouth]);

    return analyzeFullFaceFromData(FaceData(
      leftEye: leftEye,
      rightEye: rightEye,
      noseBase: noseBase,
      leftCheek: leftCheek,
      rightCheek: rightCheek,
      leftMouth: leftMouth,
      rightMouth: rightMouth,
      bottomMouth: bottomMouth,
      boundingTop: face.boundingBox.top,
      boundingBottom: face.boundingBox.bottom,
      boundingWidth: face.boundingBox.width,
      boundingHeight: face.boundingBox.height,
    ));
  }

  static FacePoint? _pos(dynamic landmark) {
    if (landmark == null) return null;
    return FacePoint(landmark.position.x.toDouble(), landmark.position.y.toDouble());
  }

  static Map<String, dynamic> analyzeFullFaceFromData(FaceData d) {
    final Map<String, dynamic> results = {};

    results['mat'] = _analyzeMat(d);
    results['mui'] = _analyzeMui(d);
    results['mieng'] = _analyzeMieng(d);
    results['tran'] = _analyzeTran(d);
    results['cam'] = _analyzeCam(d);
    results['tamDinh'] = _analyzeTamDinh(d);
    results['longMay'] = _analyzeLongMay(d);
    results['tai'] = _analyzeTai(d);
    results['nguHanh'] = _analyzeNguHanh(d);

    final Map<String, int> diemBoVi = {};
    for (final entry in results.entries) {
      final data = entry.value;
      if (data is Map && data.containsKey('diemSo')) {
        diemBoVi[entry.key] = int.tryParse(data['diemSo']?.toString() ?? '50') ?? 50;
      }
    }

    final int tongDiem = diemBoVi.values.fold(0, (sum, d) => sum + d);
    final double trungBinh = diemBoVi.isNotEmpty ? tongDiem / diemBoVi.length : 50;

    results['tongQuan'] = {
      'diemTrungBinh': trungBinh.round(),
      'diemBoVi': diemBoVi,
      'luanGiai': TuongSoData.luanTongThe(diemBoVi),
    };

    results['tinhDuyen'] = TuongSoData.luanTinhDuyen(diemBoVi);
    results['conCai'] = TuongSoData.luanConCai(diemBoVi);
    results['sucKhoe'] = TuongSoData.luanSucKhoe(diemBoVi);
    results['suNghiep'] = TuongSoData.luanSuNghiep(diemBoVi);
    results['tinhCach'] = TuongSoData.luanTinhCach(diemBoVi);
    results['phatTrien'] = TuongSoData.luanPhatTrien(diemBoVi);

    return results;
  }

  // ==================== MẮT ====================
  static Map<String, String> _analyzeMat(FaceData d) {
    if (d.leftEye == null || d.rightEye == null) {
      return TuongSoData.mat['mat_can_doi']!;
    }
    final dx = d.rightEye!.x - d.leftEye!.x;
    final dy = d.rightEye!.y - d.leftEye!.y;
    final eyeDistance = sqrt(dx * dx + dy * dy);
    final ratio = eyeDistance / d.boundingWidth;
    final eyeSize = 0.12;

    if (ratio > 0.47) return TuongSoData.mat['mat_xa_nhau']!;
    if (ratio < 0.38) return TuongSoData.mat['mat_gan_nhau']!;
    if (ratio >= 0.38 && ratio <= 0.40) {
      return eyeSize > 0.08 ? TuongSoData.mat['mat_tron']! : TuongSoData.mat['mat_nho_sau']!;
    }
    if (ratio >= 0.44 && ratio <= 0.47) return TuongSoData.mat['mat_to_sang']!;
    if (dy.abs() > 4) return dy > 0 ? TuongSoData.mat['mat_duoi_xech']! : TuongSoData.mat['mat_duoi_xuong']!;
    return TuongSoData.mat['mat_can_doi']!;
  }

  // ==================== MŨI ====================
  static Map<String, String> _analyzeMui(FaceData d) {
    if (d.noseBase == null || d.leftEye == null || d.rightEye == null) {
      return TuongSoData.mui['mui_tron_day']!;
    }
    final eyeY = (d.leftEye!.y + d.rightEye!.y) / 2;
    final noseRatio = (d.noseBase!.y - eyeY) / d.boundingHeight;

    double wingRatio = 0.25;
    if (d.leftCheek != null && d.rightCheek != null) {
      final cheekWidth = (d.rightCheek!.x - d.leftCheek!.x).abs();
      if (cheekWidth > 0) wingRatio = d.boundingWidth / cheekWidth;
    }

    if (noseRatio > 0.28 && noseRatio < 0.33) return TuongSoData.mui['mui_doc_dua']!;
    if (noseRatio > 0.28) return wingRatio > 0.4 ? TuongSoData.mui['mui_canh_ron']! : TuongSoData.mui['mui_cao_thang']!;
    if (noseRatio < 0.20) return wingRatio < 0.25 ? TuongSoData.mui['mui_hec']! : TuongSoData.mui['mui_nho_gon']!;
    if (noseRatio >= 0.20 && noseRatio <= 0.23) {
      return wingRatio < 0.25 ? TuongSoData.mui['mui_tet']! : TuongSoData.mui['mui_khoang']!;
    }
    return TuongSoData.mui['mui_tron_day']!;
  }

  // ==================== MIỆNG ====================
  static Map<String, String> _analyzeMieng(FaceData d) {
    if (d.leftMouth == null || d.rightMouth == null) {
      return TuongSoData.mieng['mieng_rong_day']!;
    }
    final mouthWidth = (d.rightMouth!.x - d.leftMouth!.x).abs();
    final ratio = mouthWidth / d.boundingWidth;

    if (d.bottomMouth != null && d.leftMouth!.y > d.bottomMouth!.y + 2) {
      return TuongSoData.mieng['mieng_khoe_xuong']!;
    }

    if (ratio > 0.45) return TuongSoData.mieng['mieng_rong_day']!;
    if (ratio < 0.35) return TuongSoData.mieng['mieng_nho_gon']!;

    final topMouthY = d.noseBase?.y ?? 0;
    final lipThickness = (d.bottomMouth?.y ?? topMouthY + 10) - topMouthY;
    if (lipThickness > 12) return TuongSoData.mieng['mieng_moi_day']!;
    if (lipThickness < 6) return TuongSoData.mieng['mieng_moi_mong']!;
    return TuongSoData.mieng['mieng_hinh_cung']!;
  }

  // ==================== TRÁN ====================
  static Map<String, String> _analyzeTran(FaceData d) {
    if (d.leftEye == null || d.rightEye == null) return TuongSoData.tran['tran_phang']!;
    final eyeY = (d.leftEye!.y + d.rightEye!.y) / 2;
    final ratio = (eyeY - d.boundingTop) / d.boundingHeight;
    if (ratio > 0.38) return TuongSoData.tran['tran_cao_rong']!;
    if (ratio < 0.28) return TuongSoData.tran['tran_hep']!;
    if (ratio >= 0.28 && ratio <= 0.31) return TuongSoData.tran['tran_loi']!;
    return TuongSoData.tran['tran_phang']!;
  }

  // ==================== CẰM ====================
  static Map<String, String> _analyzeCam(FaceData d) {
    if (d.bottomMouth == null) return TuongSoData.cam['cam_tron']!;
    final chinLength = d.boundingBottom - d.bottomMouth!.y;
    final ratio = chinLength / d.boundingHeight;
    final chinWidthRatio = d.boundingWidth / d.boundingHeight;

    if (ratio > 0.22 && chinWidthRatio > 0.75) return TuongSoData.cam['cam_vuong_day']!;
    if (ratio > 0.22) return TuongSoData.cam['cam_day_nhan']!;
    if (ratio < 0.15) return TuongSoData.cam['cam_nhon']!;
    if (ratio >= 0.15 && ratio <= 0.18) {
      return chinWidthRatio > 0.7 ? TuongSoData.cam['cam_lec']! : TuongSoData.cam['cam_hec']!;
    }
    return TuongSoData.cam['cam_tron']!;
  }

  // ==================== TAM ĐÌNH ====================
  static Map<String, String> _analyzeTamDinh(FaceData d) {
    if (d.leftEye == null || d.rightEye == null || d.noseBase == null) {
      return TuongSoData.tamDinh['can_doi']!;
    }
    final faceHeight = d.boundingBottom - d.boundingTop;
    final eyeY = (d.leftEye!.y + d.rightEye!.y) / 2;
    final thuongDinh = eyeY - d.boundingTop;
    final mouthY = d.bottomMouth?.y ?? (d.noseBase!.y + faceHeight * 0.15);
    final trungDinh = mouthY - eyeY;
    final haDinh = d.boundingBottom - mouthY;
    final total = thuongDinh + trungDinh + haDinh;
    if (total <= 0) return TuongSoData.tamDinh['can_doi']!;

    final thuongRatio = thuongDinh / total;
    final trungRatio = trungDinh / total;
    final haRatio = haDinh / total;
    final deviation = (thuongRatio - 0.333).abs() + (trungRatio - 0.333).abs() + (haRatio - 0.333).abs();

    if (deviation < 0.12) return TuongSoData.tamDinh['can_doi']!;
    if (thuongRatio > trungRatio && thuongRatio > haRatio) return TuongSoData.tamDinh['thuong_dinh_dai']!;
    if (trungRatio > thuongRatio && trungRatio > haRatio) return TuongSoData.tamDinh['trung_dinh_dai']!;
    return TuongSoData.tamDinh['ha_dinh_dai']!;
  }

  // ==================== LÔNG MÀY ====================
  static Map<String, String> _analyzeLongMay(FaceData d) {
    if (d.leftEye == null || d.rightEye == null) return TuongSoData.longMay['long_may_dep']!;
    final eyeY = (d.leftEye!.y + d.rightEye!.y) / 2;
    final browRatio = (eyeY - d.boundingTop) / d.boundingHeight;
    final eyeDistance = (d.rightEye!.x - d.leftEye!.x).abs();
    final eyeDistanceRatio = eyeDistance / d.boundingWidth;

    if (browRatio > 0.22) return TuongSoData.longMay['long_may_rong_day']!;
    if (browRatio < 0.14) {
      return eyeDistanceRatio < 0.38 ? TuongSoData.longMay['long_may_thua_ngan']! : TuongSoData.longMay['long_may_nho_cao']!;
    }
    if (eyeDistanceRatio > 0.42) return TuongSoData.longMay['long_may_thua_ngan']!;
    return TuongSoData.longMay['long_may_dep']!;
  }

  // ==================== TAI ====================
  static Map<String, String> _analyzeTai(FaceData d) {
    if (d.leftEye == null || d.rightEye == null) return TuongSoData.tai['tai_nho_mong']!;
    final relativeHeight = d.boundingHeight / d.boundingWidth;

    if (relativeHeight > 1.4) {
      return TuongSoData.tai['tai_cao_tren_mat']!;
    } else if (relativeHeight < 1.2) {
      return TuongSoData.tai['tai_to_day']!;
    } else if (d.boundingWidth > 140 && d.boundingHeight > 180) {
      return TuongSoData.tai['tai_dai_day_day']!;
    }
    return TuongSoData.tai['tai_to_day']!;
  }

  // ==================== NGŨ HÀNH ====================
  static Map<String, String> _analyzeNguHanh(FaceData d) {
    if (d.boundingHeight <= 0) return TuongSoData.nguHanhDien['tho_dien']!;
    final ratio = d.boundingWidth / d.boundingHeight;

    if (ratio > 0.83) return TuongSoData.nguHanhDien['thuy_dien']!;
    if (ratio >= 0.78) return TuongSoData.nguHanhDien['tho_dien']!;
    if (ratio >= 0.72) return TuongSoData.nguHanhDien['kim_dien']!;
    if (ratio >= 0.67) {
      if (d.bottomMouth != null) {
        final chinLength = d.boundingBottom - d.bottomMouth!.y;
        if (chinLength < d.boundingHeight * 0.17) return TuongSoData.nguHanhDien['hoa_dien']!;
      }
      return TuongSoData.nguHanhDien['moc_dien']!;
    }
    return TuongSoData.nguHanhDien['moc_dien']!;
  }
}
