import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jupiter/src/apptheme.dart';
import 'package:jupiter/src/presentation/widgets/text_input_form.dart';
import 'package:jupiter/src/presentation/widgets/text_label.dart';

class TextInputWithLabel extends StatelessWidget {
  const TextInputWithLabel({
    super.key,
    required this.controller,
    required this.labelText,
    this.hintText,
    required this.onSaved,
    required this.keyboardType,
    required this.obscureText,
    required this.validator,
    this.maxLength,
    this.readOnly = false,
    this.onTap,
    this.onChanged,
  });

  final TextEditingController controller;
  final String? hintText;
  final String labelText;
  final void Function(dynamic text) onSaved;
  final TextInputType keyboardType;
  final bool obscureText;
  final String? Function(dynamic text) validator;
  final int? maxLength;
  final bool readOnly;
  final void Function()? onTap;
  final void Function(String? value)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        TextLabel(
          fontSize: 14,
          text: labelText,
          color: AppTheme.darkBlue,
        ),
        const SizedBox(
          height: 4,
        ),
        TextInputForm(
          obscureText: obscureText,
          style: const TextStyle(
            fontSize: 16,
          ),
          fillColor: AppTheme.white,
          controller: controller,
          hintText: hintText ?? translate('widgets.please_fill_in'),
          keyboardType: keyboardType,
          onSaved: onSaved,
          validator: validator,
          maxLength: maxLength,
          readOnly: readOnly,
          onTap: onTap,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
