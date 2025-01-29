import 'package:flutter/material.dart';
import 'package:jupiter/src/apptheme.dart';

class DashedLinePainter extends CustomPainter {
  DashedLinePainter({
    this.dashWidth = 9,
    this.dashSpace = 5,
    this.startX = 0,
    this.color = AppTheme.black,
  });
  final double dashWidth;
  final double dashSpace;
  double startX;
  final Color color;
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1;
    while (startX < size.width) {
      canvas.drawLine(Offset(startX, 0), Offset(startX + dashWidth, 0), paint);
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
