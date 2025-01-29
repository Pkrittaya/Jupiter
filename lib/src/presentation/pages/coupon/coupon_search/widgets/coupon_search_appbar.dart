import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jupiter/src/apptheme.dart';
import 'package:jupiter/src/constant_value.dart';
import 'package:jupiter/src/presentation/widgets/text_input_form.dart';
import 'package:jupiter/src/utilities.dart';

class CouponSearchAppbar extends StatefulWidget {
  CouponSearchAppbar({
    Key? key,
    required this.focus,
    required this.onPressedBackButton,
    required this.controllerTextSearch,
    required this.onPressedClearTextInput,
    required this.onChangTextInput,
  }) : super(key: key);

  final FocusNode focus;
  final Function() onPressedBackButton;
  final TextEditingController controllerTextSearch;
  final Function() onPressedClearTextInput;
  final Function(String) onChangTextInput;

  @override
  _CouponSearchAppbarState createState() => _CouponSearchAppbarState();
}

class _CouponSearchAppbarState extends State<CouponSearchAppbar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      padding: EdgeInsets.fromLTRB(16, Platform.isIOS ? 55 : 45, 16, 0),
      color: AppTheme.white,
      child: Column(children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 48,
          child: TextInputForm(
            contentPadding: const EdgeInsets.only(top: 8),
            focusNode: widget.focus,
            autofocus: true,
            borderRadius: 200,
            style: const TextStyle(color: AppTheme.black60),
            icon: IconButton(
              splashColor: AppTheme.transparent,
              icon: Icon(Icons.arrow_back),
              color: AppTheme.gray9CA3AF,
              onPressed: () {
                widget.onPressedBackButton();
              },
            ),

            fillColor: AppTheme.white,
            controller: widget.controllerTextSearch,
            hintText: translate('appbar.search'),
            hintStyle: TextStyle(
              color: AppTheme.black60,
              fontSize: Utilities.sizeFontWithDesityForDisplay(
                  context, AppFontSize.large),
            ),
            obscureText: false,
            // suffixText: translate('appbar.suffix_cancel'),
            suffixIcon: widget.focus.hasFocus
                ? IconButton(
                    splashColor: AppTheme.transparent,
                    icon: Icon(Icons.close),
                    color: AppTheme.gray9CA3AF,
                    onPressed: () {
                      widget.onPressedClearTextInput();
                    },
                  )
                : const SizedBox(),
            onSaved: (text) {},
            keyboardType: TextInputType.text,
            onChanged: (text) {
              widget.onChangTextInput(text ?? '');
              setState(() {});
            },
            // onFieldSubmitted: (text) {
            //   onChangTextInput(text!);
            // },
            validator: (text) {
              if (text == null || text == '') {
                return 'required field!';
              }
              return null;
            },
          ),
        ),
      ]),
    );
  }
}
