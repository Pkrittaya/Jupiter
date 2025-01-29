import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jupiter/src/apptheme.dart';
import 'package:jupiter/src/constant_value.dart';
import 'package:jupiter/src/presentation/widgets/index.dart';
import 'package:jupiter/src/utilities.dart';

class TextEmptySelectPayment extends StatefulWidget {
  const TextEmptySelectPayment({
    Key? key,
    required this.error,
  }) : super(key: key);

  final bool error;
  @override
  _TextEmptySelectPaymentState createState() => _TextEmptySelectPaymentState();
}

class _TextEmptySelectPaymentState extends State<TextEmptySelectPayment> {
  @override
  Widget build(BuildContext context) {
    if (widget.error) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: TextLabel(
          text: translate("check_in_page.select_payment.error"),
          fontSize:
              Utilities.sizeFontWithDesityForDisplay(context, AppFontSize.small),
          color: AppTheme.red,
        ),
      );
    } else {
      return SizedBox();
    }
  }
}
