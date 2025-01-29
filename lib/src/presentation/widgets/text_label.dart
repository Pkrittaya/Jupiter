import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class TextLabel extends StatelessWidget {
  const TextLabel({
    Key? key,
    required this.text,
    this.fontWeight,
    this.fontSize = 18,
    this.color = Colors.black54,
    this.fontStyle = FontStyle.normal,
    this.textDecoration = TextDecoration.none,
    this.textAlign,
    this.maxLines,
    this.isAutoSize = false,
    this.overflow,
    this.presetFontSizes,
    this.minFontSize = 10,
    this.maxFontSize = 20,
    this.letterSpacing = 0.4,
    this.textStyleHeight = 1,
  }) : super(key: key);
  final bool isAutoSize;
  final String text;
  final FontWeight? fontWeight;
  final double? fontSize;
  final double? minFontSize;
  final double? maxFontSize;
  final Color? color;
  final FontStyle? fontStyle;
  final TextDecoration? textDecoration;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final List<double>? presetFontSizes;
  final double? letterSpacing;
  final double? textStyleHeight;

  @override
  Widget build(BuildContext context) {
    return isAutoSize
        ? AutoSizeText(
            presetFontSizes: presetFontSizes,
            maxLines: maxLines,
            textAlign: textAlign,
            text,
            minFontSize: minFontSize ?? 10,
            maxFontSize: maxFontSize ?? 20,
            style: TextStyle(
              decoration: textDecoration,
              fontWeight: fontWeight,
              fontSize: fontSize,
              color: color,
              fontStyle: fontStyle,
              letterSpacing: letterSpacing,
              height: textStyleHeight,
            ),
          )
        : Text(
            maxLines: maxLines,
            textAlign: textAlign,
            text,
            overflow: overflow,
            style: TextStyle(
              decoration: textDecoration,
              fontWeight: fontWeight,
              fontSize: fontSize,
              color: color,
              fontStyle: fontStyle,
              letterSpacing: letterSpacing,
              height: textStyleHeight,
            ),
          );
  }
}
