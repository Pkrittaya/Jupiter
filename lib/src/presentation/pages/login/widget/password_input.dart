import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jupiter/src/constant_value.dart';
import 'package:jupiter/src/utilities.dart';

import '../../../../apptheme.dart';
import '../../../widgets/text_input_form.dart';

class PasswordInput extends StatefulWidget {
  const PasswordInput({
    Key? key,
    required this.passwordTextEditor,
    required this.onChanged,
    required this.isError,
  }) : super(key: key);

  final TextEditingController passwordTextEditor;
  final Function(String?) onChanged;
  final bool isError;

  @override
  State<PasswordInput> createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInput> {
  bool visiblePassword = false;

  Widget renderVisibilityIcon(bool visible) {
    return InkWell(
      onTap: () {
        setState(() {
          visiblePassword = !visiblePassword;
        });
      },
      child: visible
          ? Icon(Icons.visibility_off, color: AppTheme.black40)
          : Icon(Icons.visibility, color: AppTheme.black40),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextInputForm(
      controller: widget.passwordTextEditor,
      contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      hintText: translate("input_form.login.password_hint"),
      onSaved: (text) {},
      keyboardType: TextInputType.visiblePassword,
      obscureText: !visiblePassword,
      style: TextStyle(
        color: AppTheme.black60,
        fontSize:
            Utilities.sizeFontWithDesityForDisplay(context, AppFontSize.big),
      ),
      onChanged: widget.onChanged,
      hintStyle: TextStyle(
        color: AppTheme.gray9CA3AF,
        fontSize:
            Utilities.sizeFontWithDesityForDisplay(context, AppFontSize.big),
      ),
      fillColor: AppTheme.grayF1F5F9,
      borderColor: widget.isError ? AppTheme.red : AppTheme.grayF1F5F9,
      borderRadius: 200,
      suffixIcon: renderVisibilityIcon(visiblePassword),
    );
  }
}
