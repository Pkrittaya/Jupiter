import 'package:flutter/material.dart';
import 'package:jupiter/src/apptheme.dart';
import 'package:jupiter/src/constant_value.dart';
import 'package:jupiter/src/presentation/widgets/text_label.dart';
import 'package:jupiter/src/utilities.dart';

// ignore: must_be_immutable
class MoreTitleMenu extends StatelessWidget {
  MoreTitleMenu({
    super.key,
    required this.text,
    required this.paddingTop,
  });

  final String text;
  final bool paddingTop;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: paddingTop ? 8 : 0, bottom: 8),
      child: TextLabel(
        text: text,
        fontSize: Utilities.sizeFontWithDesityForDisplay(
            context, AppFontSize.superlarge),
        fontWeight: FontWeight.bold,
        color: AppTheme.blueDark,
      ),
    );
  }
}
