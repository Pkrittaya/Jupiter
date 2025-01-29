import 'package:flutter/material.dart';
import 'package:jupiter/src/constant_value.dart';
import 'package:jupiter/src/utilities.dart';

import '../../../../../apptheme.dart';
import '../../../../widgets/index.dart';

class RowWith3Text extends StatelessWidget {
  const RowWith3Text({
    super.key,
    required this.text,
    this.textColor = AppTheme.white,
  });
  final String text;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          // color: AppTheme.red,
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width * 0.435,
          child: TextLabel(
            text: text,
            fontSize: Utilities.sizeFontWithDesityForDisplay(
                context, AppFontSize.small),
            color: textColor,
            fontWeight: FontWeight.w400,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
