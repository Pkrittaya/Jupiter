import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jupiter/src/constant_value.dart';
import 'package:jupiter/src/utilities.dart';

import '../../../../apptheme.dart';
import '../../../widgets/text_input_form.dart';

class EmailInput extends StatelessWidget {
  const EmailInput({
    Key? key,
    required this.usernameTextEditer,
    required this.onChanged,
    required this.isError,
  }) : super(key: key);

  final TextEditingController usernameTextEditer;
  final Function(String?) onChanged;
  final bool isError;

  @override
  Widget build(BuildContext context) {
    return TextInputForm(
      keyboardType: TextInputType.emailAddress,
      controller: usernameTextEditer,
      contentPadding: EdgeInsets.symmetric(vertical: 14,horizontal: 16),
      hintText: translate("input_form.login.email"),
      onSaved: (text) {},
      onChanged: onChanged,
      style: TextStyle(
        color: AppTheme.black60,
        fontSize:
            Utilities.sizeFontWithDesityForDisplay(context, AppFontSize.big),
      ),
      hintStyle: TextStyle(
        color: AppTheme.gray9CA3AF,
        fontSize:
            Utilities.sizeFontWithDesityForDisplay(context, AppFontSize.big),
      ),
      fillColor: AppTheme.grayF1F5F9,
      borderColor: isError ? AppTheme.red : AppTheme.grayF1F5F9,
      borderRadius: 200,
    );
  }
}
