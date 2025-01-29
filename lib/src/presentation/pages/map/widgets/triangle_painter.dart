import 'package:flutter/material.dart';

class TrianglePainter extends CustomPainter {
  final Color strokeColor;
  final PaintingStyle paintingStyle;
  final double strokeWidth;

  TrianglePainter(
      {this.strokeColor = Colors.black,
      this.strokeWidth = 3,
      this.paintingStyle = PaintingStyle.stroke});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = strokeColor
      ..strokeWidth = strokeWidth
      ..style = paintingStyle;

    // canvas.drawPath(getTrianglePath(size.width, size.height), paint);
    final Offset triangleOffset = Offset(size.width / 2, size.height);
    var path = Path();

    path.moveTo(triangleOffset.dx, triangleOffset.dy);
    path.lineTo(triangleOffset.dx + 10, triangleOffset.dy - 10);
    path.lineTo(triangleOffset.dx - 10, triangleOffset.dy - 10);
    path.close();

    canvas.drawPath(path, paint);
  }

  // Path getTrianglePath(double x, double y) {
  //   return Path()
  //     // ..moveTo(0, y)
  //     // ..lineTo(x / 2, 0)
  //     // ..lineTo(x, y)
  //     // ..lineTo(0, y);
  //     ..moveTo(x, y)
  //     ..lineTo(x + 10, y - 10)
  //     ..lineTo(x - 10, y - 10);
  // }

  @override
  bool shouldRepaint(TrianglePainter oldDelegate) {
    return oldDelegate.strokeColor != strokeColor ||
        oldDelegate.paintingStyle != paintingStyle ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
