import 'package:flutter/material.dart';
import 'package:jupiter/src/apptheme.dart';
import 'package:jupiter/src/presentation/widgets/text_label.dart';

class QrCodeTextPosition extends StatefulWidget {
  const QrCodeTextPosition({
    super.key,
    required this.position,
    required this.text,
    required this.fontSize,
    required this.fontWeight,
  });
  final double position;
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  @override
  _QrCodeTextPositionState createState() => _QrCodeTextPositionState();
}

class _QrCodeTextPositionState extends State<QrCodeTextPosition> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Positioned(
      top: widget.position,
      child: Container(
        width: width,
        child: TextLabel(
          text: widget.text,
          color: AppTheme.white,
          textAlign: TextAlign.center,
          fontSize: widget.fontSize,
          fontWeight: widget.fontWeight,
        ),
      ),
    );
  }
}
