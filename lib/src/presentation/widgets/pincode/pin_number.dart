import 'package:flutter/material.dart';
import 'package:jupiter/src/apptheme.dart';
import 'package:jupiter/src/constant_value.dart';
import 'package:jupiter/src/presentation/widgets/text_label.dart';
import 'package:jupiter/src/utilities.dart';

class PinNumber extends StatelessWidget {
  PinNumber(
      {super.key, required this.numberText, required this.onValueChanged});
  final String numberText;

  final ValueChanged<String> onValueChanged;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          debugPrint('$numberText clicked ');
          onValueChanged(numberText);
        },
        child: Center(
          child: TextLabel(
            text: numberText,
            fontWeight: FontWeight.w700,
            fontSize: Utilities.sizeFontWithDesityForDisplay(
                context, AppFontSize.xxl),
            color: AppTheme.blueD,
          ),
        ),
      ),
    );
  }
}
