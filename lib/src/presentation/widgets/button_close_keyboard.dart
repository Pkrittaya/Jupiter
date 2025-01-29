import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jupiter/src/apptheme.dart';
import 'package:jupiter/src/constant_value.dart';
import 'package:jupiter/src/presentation/widgets/text_label.dart';
import 'package:jupiter/src/utilities.dart';

class ButtonCloseKeyboard extends StatelessWidget {
  const ButtonCloseKeyboard({Key? key, required this.contextPage})
      : super(key: key);

  final BuildContext contextPage;

  bool isKeyboardOpen() {
    final mediaQuery = MediaQuery.of(contextPage);
    return mediaQuery.viewInsets.bottom > 0;
  }

  @override
  Widget build(BuildContext context) {
    return renderWidget();
  }

  Widget renderWidget() {
    return isKeyboardOpen()
        ? Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(width: 0.5, color: AppTheme.black20),
                ),
                color: AppTheme.black5,
              ),
              height: 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      FocusScope.of(contextPage).unfocus();
                    },
                    child: TextLabel(
                      fontSize: Utilities.sizeFontWithDesityForDisplay(
                          contextPage, AppFontSize.normal),
                      color: AppTheme.blueD,
                      text: translate('button.done'),
                    ),
                  )
                ],
              ),
            ),
          )
        : const SizedBox();
  }
}
