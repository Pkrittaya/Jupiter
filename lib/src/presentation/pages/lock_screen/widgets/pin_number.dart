import 'package:flutter/material.dart';

import '../../../../apptheme.dart';
import '../../../../constant_value.dart';
import '../../../widgets/text_label.dart';

class PinNumber extends StatelessWidget {
  PinNumber(
      {super.key,
      required this.numberText,
      required this.pinNow,
      required this.onValueChanged});
  final String numberText;
  final String pinNow;

  final ValueChanged<String> onValueChanged;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: () {
          debugPrint('$numberText clicked ');
          onValueChanged(pinNow + numberText);
        },
        child: Center(
          child: TextLabel(
            text: numberText,
            fontWeight: FontWeight.w700,
            fontSize: AppFontSize.xxl,
            color: AppTheme.blueD,
          ),
        ),
      ),
    );
  }
}
