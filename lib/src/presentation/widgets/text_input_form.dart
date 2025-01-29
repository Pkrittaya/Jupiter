import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jupiter/src/apptheme.dart';

class TextInputForm extends StatelessWidget {
  const TextInputForm(
      {Key? key,
      this.onSaved,
      this.onChanged,
      this.validator,
      this.icon,
      this.suffixIcon,
      this.hintText,
      this.labelText,
      this.suffixText,
      this.controller,
      this.keyboardType = TextInputType.text,
      this.onTap,
      this.obscureText = false,
      this.maxLength,
      this.showCursor = true,
      this.readOnly = false,
      this.style,
      this.labelStyle,
      this.hintStyle,
      this.errorStyle,
      this.fillColor,
      this.contentPadding,
      this.focusNode,
      this.textAlign = TextAlign.start,
      this.enabled = true,
      this.borderRadius = 10,
      this.obscuringCharacter = '•',
      this.borderColor = AppTheme.black5,
      this.onFieldSubmitted,
      this.autofocus = false,
      this.inputFormatters})
      : super(key: key);

  final void Function(String?)? onSaved;
  final void Function(String?)? onChanged;
  final String? Function(String?)? validator;
  final Widget? icon;
  final Widget? suffixIcon;
  final String? hintText;
  final String? labelText;
  final String? suffixText;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final int? maxLength;
  final bool obscureText;
  final void Function()? onTap;
  final bool showCursor;
  final bool readOnly;

  final TextStyle? style;
  final TextStyle? labelStyle;
  final TextStyle? hintStyle;
  final TextStyle? errorStyle;
  final Color? fillColor;
  final EdgeInsetsGeometry? contentPadding;
  final FocusNode? focusNode;

  final TextAlign textAlign;
  final bool enabled;

  final double borderRadius;

  final String obscuringCharacter;
  final Color? borderColor;
  final void Function(String?)? onFieldSubmitted;
  final bool autofocus;
  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      style: style,
      controller: controller,
      decoration: InputDecoration(
          // floatingLabelBehavior: FloatingLabelBehavior.always,
          // border: InputBorder.none,
          counterText: '',
          filled: true,
          contentPadding: contentPadding,
          fillColor: fillColor,
          prefixIcon: icon,
          suffixText: suffixText,
          suffixIcon: suffixIcon,
          hintText: hintText,
          labelText: labelText,
          labelStyle: labelStyle,
          errorStyle: errorStyle,
          hintStyle: hintStyle,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
            borderSide:
                BorderSide(color: borderColor ?? AppTheme.black5, width: 1.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
            borderSide:
                BorderSide(color: borderColor ?? AppTheme.black5, width: 1.0),
          ),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: BorderSide(color: AppTheme.red)),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: BorderSide(color: AppTheme.red))),
      onSaved: onSaved,
      onChanged: onChanged,
      validator: validator,
      obscureText: obscureText,
      obscuringCharacter: obscuringCharacter,
      onTap: onTap,
      showCursor: showCursor,
      readOnly: readOnly,
      maxLength: maxLength,
      focusNode: focusNode,
      textAlign: textAlign,
      enabled: enabled,
      onFieldSubmitted: onFieldSubmitted,
      autofocus: autofocus,
      inputFormatters: inputFormatters,
    );
  }
}
