import 'package:flutter/material.dart';

import '../../../../../apptheme.dart';
import '../../../../widgets/index.dart';

class RowWithTextAndBoxText extends StatelessWidget {
  const RowWithTextAndBoxText({
    super.key,
    required this.text,
    required this.textBox,
    // this.widthBase = 100,
    this.textSize = 20,
    this.textBoxSize = 20,
    this.textColor = AppTheme.black,
    this.textBoxColor = AppTheme.black,
    this.textWeight = FontWeight.normal,
    this.textBoxWeight = FontWeight.normal,
    this.boxColor = AppTheme.blueDark,
  });
  // final double widthBase;
  final String text;
  final String textBox;
  final double textSize;
  final double textBoxSize;
  final Color textColor;
  final Color textBoxColor;
  final FontWeight textWeight;
  final FontWeight textBoxWeight;
  final Color boxColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: widthBase,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 4),
            child: TextLabel(
              text: text,
              fontSize: textSize,
              fontWeight: textWeight,
              color: textColor,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2),
              color: boxColor,
            ),
            child: TextLabel(
              text: textBox,
              fontSize: textBoxSize,
              fontWeight: textBoxWeight,
              color: textBoxColor,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          )
        ],
      ),
    );
  }
}
