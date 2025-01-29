import 'package:flutter/material.dart';
import 'package:jupiter/src/apptheme.dart';

import 'package:jupiter/src/presentation/widgets/index.dart';

class Button extends StatelessWidget {
  const Button({
    Key? key,
    required this.text,
    this.onPressed,
    this.style,
    this.textColor,
    this.fontWeight,
    this.height,
    this.width,
    this.visible = true,
  }) : super(key: key);

  final String text;
  final Function()? onPressed;
  final ButtonStyle? style;
  final Color? textColor;
  final FontWeight? fontWeight;
  final double? height;
  final double? width;
  final bool visible;

  @override
  Widget build(BuildContext context) {
    if (!visible) {
      return const SizedBox();
    }

    return Container(
      height: height ?? 48,
      width: width,
      child: ElevatedButton(
        style: style ?? AppTheme.defaultButtonStyle,
        onPressed: onPressed,
        child: TextLabel(
          text: text,
          fontSize: 20,
          fontWeight: fontWeight ?? FontWeight.bold,
          color: textColor ?? Colors.white,
        ),
      ),
    );
  }
}
