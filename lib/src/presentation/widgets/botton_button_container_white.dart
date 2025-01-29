import 'package:flutter/material.dart';
import 'package:jupiter/src/apptheme.dart';

import 'index.dart';

class BottomButtonContainerWhite extends StatelessWidget {
  const BottomButtonContainerWhite({
    super.key,
    required this.icons,
    required this.text,
    required this.onPressed,
  });
  final String text;
  final IconData icons;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      color: AppTheme.white,
      height: 80,
      child: SizedBox(
        width: double.infinity,
        height: 48,
        child: ElevatedButton.icon(
            style: AppTheme.defaultButtonStyle,
            icon: Icon(
              icons,
              size: 24,
            ),
            label: TextLabel(
              text: text,
              color: AppTheme.white,
              fontSize: 20,
              fontWeight: FontWeight.w400,
            ),
            onPressed: onPressed),
      ),
    );
  }
}
