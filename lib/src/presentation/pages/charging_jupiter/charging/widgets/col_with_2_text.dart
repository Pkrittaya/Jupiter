import 'package:flutter/material.dart';
import 'package:jupiter/src/apptheme.dart';

import '../../../../widgets/index.dart';

class ColWith2Text extends StatelessWidget {
  const ColWith2Text({
    super.key,
    required this.icon,
    required this.text1,
    required this.text2,
    this.text1Size = 20,
    this.text2Size = 14,
    this.text1Weight = FontWeight.normal,
    this.text2Weight = FontWeight.normal,
    this.text1Color = AppTheme.black,
    this.text2Color = AppTheme.black,
  });
  final Icon icon;
  final String text1;
  final String text2;
  final double text1Size;
  final double text2Size;
  final FontWeight text1Weight;
  final FontWeight text2Weight;
  final Color text1Color;
  final Color text2Color;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        icon,
        const SizedBox(
          height: 10,
        ),
        TextLabel(
          maxLines: 1,
          text: text1,
          fontSize: text1Size,
          fontWeight: text1Weight,
          color: text1Color,
        ),
        TextLabel(
          maxLines: 1,
          text: text2,
          fontSize: text2Size,
          fontWeight: text2Weight,
          color: text2Color,
        ),
      ],
    );
  }
}
