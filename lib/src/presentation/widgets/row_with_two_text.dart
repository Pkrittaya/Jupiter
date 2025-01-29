import 'package:flutter/material.dart';

import '../../apptheme.dart';
import 'index.dart';

class RowWithTwoText extends StatelessWidget {
  const RowWithTwoText({
    super.key,
    required this.textLeft,
    required this.textRight,
    this.textLeftSize = 20,
    this.textRightSize = 20,
    this.textLeftFontWeight = FontWeight.normal,
    this.textRightFontWeight = FontWeight.bold,
    this.textLeftFontColor = AppTheme.black60,
    this.textRightFontColor = AppTheme.darkBlue,
    this.flexLeft = 4,
    this.flexRight = 6,
  });
  final String textLeft;
  final String textRight;
  final double textLeftSize;
  final double textRightSize;
  final FontWeight textLeftFontWeight;
  final FontWeight textRightFontWeight;
  final Color textLeftFontColor;
  final Color textRightFontColor;
  final int flexLeft;
  final int flexRight;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TextLabel(
          maxLines: 1,
          text: textLeft,
          fontSize: textLeftSize,
          color: textLeftFontColor,
          fontWeight: textLeftFontWeight,
        ),
        const Expanded(child: SizedBox()),
        TextLabel(
          maxLines: 1,
          textAlign: TextAlign.end,
          text: textRight,
          fontSize: textRightSize,
          color: textRightFontColor,
          fontWeight: textRightFontWeight,
        )
      ],
    );
  }
}
