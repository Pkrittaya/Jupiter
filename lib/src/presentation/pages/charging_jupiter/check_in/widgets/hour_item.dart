import 'package:flutter/material.dart';
import 'package:jupiter/src/apptheme.dart';
import 'package:jupiter/src/constant_value.dart';
import 'package:jupiter/src/presentation/widgets/text_label.dart';
import 'package:jupiter/src/utilities.dart';

class HourItem extends StatefulWidget {
  HourItem({
    Key? key,
    required this.hour,
  }) : super(key: key);

  final int hour;

  @override
  _HourItemState createState() => _HourItemState();
}

class _HourItemState extends State<HourItem> {
  renderShowValueHour(int valueHourInt) {
    return valueHourInt.toString().length == 1
        ? '0${valueHourInt.toString()}'
        : valueHourInt.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Center(
          child: TextLabel(
              text: renderShowValueHour(widget.hour),
              fontSize: Utilities.sizeFontWithDesityForDisplay(context, AppFontSize.big),
              fontWeight: FontWeight.bold,
              color: AppTheme.blueDark)),
    );
  }
}
