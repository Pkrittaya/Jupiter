import 'package:flutter/material.dart';

import '../../apptheme.dart';
import 'index.dart';

class RowWithTextTextFiled extends StatelessWidget {
  const RowWithTextTextFiled({
    super.key,
    required this.textLeft,
    required this.textTextField,
    this.textLeftSize = 20,
    this.textRightSize = 20,
    this.textLeftFontWeight = FontWeight.normal,
    this.textRightFontWeight = FontWeight.bold,
    this.flexLeft = 4,
    this.flexRight = 6,
    required this.textEditingController,
    this.textInputType = TextInputType.none,
    required this.validator,
    required this.onSaved,
    this.onTap,
    this.readOnly = false,
  });
  final String textLeft;
  final String textTextField;
  final double textLeftSize;
  final double textRightSize;
  final FontWeight textLeftFontWeight;
  final FontWeight textRightFontWeight;
  final int flexLeft;
  final int flexRight;
  final TextEditingController textEditingController;
  final TextInputType textInputType;
  final String? Function(dynamic) validator;
  final void Function(dynamic) onSaved;
  final void Function()? onTap;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          flex: flexLeft,
          fit: FlexFit.tight,
          child: TextLabel(
            maxLines: 1,
            text: textLeft,
            fontSize: textLeftSize,
            color: AppTheme.black60,
          ),
        ),
        Expanded(
          flex: flexRight,
          child: TextInputForm(
            controller: textEditingController,
            labelText: '',
            onSaved: onSaved,
            keyboardType: textInputType,
            obscureText: false,
            validator: validator,
            onTap: onTap,
            readOnly: readOnly,
          ),
        )
      ],
    );
  }
}
