class FacePoint {
  final double x;
  final double y;
  const FacePoint(this.x, this.y);
}

class FaceData {
  final FacePoint? leftEye;
  final FacePoint? rightEye;
  final FacePoint? noseBase;
  final FacePoint? leftCheek;
  final FacePoint? rightCheek;
  final FacePoint? leftMouth;
  final FacePoint? rightMouth;
  final FacePoint? bottomMouth;
  final double boundingTop;
  final double boundingBottom;
  final double boundingWidth;
  final double boundingHeight;

  const FaceData({
    this.leftEye,
    this.rightEye,
    this.noseBase,
    this.leftCheek,
    this.rightCheek,
    this.leftMouth,
    this.rightMouth,
    this.bottomMouth,
    this.boundingTop = 0,
    this.boundingBottom = 0,
    this.boundingWidth = 0,
    this.boundingHeight = 0,
  });
}
