import 'package:flutter/cupertino.dart';
import '../../apptheme.dart';
import 'dart:math' as math;
import 'index.dart';

class IconWithText extends StatelessWidget {
  const IconWithText({
    super.key,
    required this.icon,
    required this.text,
    this.iconSize = 24,
    this.textSize = 14,
    this.rotate = 0,
    this.textColor = AppTheme.black40,
    this.iconColor = AppTheme.black40,
    this.fontStyle = FontStyle.normal,
    this.textDecoration = TextDecoration.none,
    this.flexFit = FlexFit.loose,
    this.fontWeight = FontWeight.normal,
    this.expaned = false,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.sizeBetween = 8,
    this.maxLines,
  });
  final IconData icon;
  final String text;
  final double rotate;
  final double iconSize;
  final double sizeBetween;
  final double textSize;
  final Color textColor;
  final Color iconColor;
  final FontStyle fontStyle;
  final TextDecoration textDecoration;
  final FlexFit flexFit;
  final FontWeight fontWeight;
  final bool expaned;

  final MainAxisAlignment mainAxisAlignment;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      children: [
        Transform.rotate(
          angle: rotate * math.pi / 180,
          child: Icon(
            icon,
            color: iconColor,
            size: iconSize,
          ),
        ),
        SizedBox(
          width: sizeBetween,
        ),
        expaned
            ? Expanded(
                child: TextLabel(
                  maxLines: maxLines,
                  textDecoration: textDecoration,
                  fontStyle: fontStyle,
                  color: textColor,
                  text: text,
                  fontSize: textSize,
                  fontWeight: fontWeight,
                ),
              )
            : TextLabel(
                maxLines: 2,
                textDecoration: textDecoration,
                fontStyle: fontStyle,
                color: textColor,
                text: text,
                fontSize: textSize,
                fontWeight: fontWeight,
              ),
      ],
    );
  }
}
