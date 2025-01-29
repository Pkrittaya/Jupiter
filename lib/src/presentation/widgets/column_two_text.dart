import 'package:flutter/material.dart';

import '../../apptheme.dart';

class ColumnTwoText extends StatelessWidget {
  ColumnTwoText({
    super.key,
    required this.textUpper,
    required this.textLower,
    this.colorUpper = AppTheme.darkBlue,
    this.colorLower = AppTheme.black60,
    this.upperFontSize = 20,
    this.lowerFontSize = 16,
    this.upperFontWeight = FontWeight.bold,
    this.lowerFontWeight = FontWeight.normal,
  });
  final String textUpper;
  final String textLower;
  final Color colorUpper;
  final Color colorLower;
  final double upperFontSize;
  final double lowerFontSize;
  final FontWeight upperFontWeight;
  final FontWeight lowerFontWeight;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // TextLabel(
        //   text: textUpper,
        //   fontWeight: upperFontWeight,
        //   color: colorUpper,
        //   fontSize: upperFontSize,
        // ),
        Text(
          textUpper,
          style: TextStyle(
              fontWeight: upperFontWeight,
              color: colorUpper,
              fontSize: upperFontSize,
              height: 0.8),
        ),
        Text(
          textLower,
          style: TextStyle(
              fontWeight: lowerFontWeight,
              color: colorLower,
              fontSize: lowerFontSize,
              height: 0.7),
        ),
      ],
    );
  }
}
