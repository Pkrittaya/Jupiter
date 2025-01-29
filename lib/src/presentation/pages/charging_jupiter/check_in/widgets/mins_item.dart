import 'package:flutter/material.dart';
import 'package:jupiter/src/apptheme.dart';
import 'package:jupiter/src/constant_value.dart';
import 'package:jupiter/src/presentation/widgets/index.dart';
import 'package:jupiter/src/utilities.dart';

class MinsItem extends StatefulWidget {
  const MinsItem({
    Key? key,
    required this.mins,
  }) : super(key: key);

  final int mins;
  @override
  _MinsItemState createState() => _MinsItemState();
}

class _MinsItemState extends State<MinsItem> {
  renderShowValueMins(int valueMinsInt) {
    if (valueMinsInt == 0) {
      return '00';
    } else {
      return (valueMinsInt * 15).toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Center(
          child: TextLabel(
              text: renderShowValueMins(widget.mins),
              fontSize: Utilities.sizeFontWithDesityForDisplay(context, AppFontSize.big),
              fontWeight: FontWeight.bold,
              color: AppTheme.blueDark)),
    );
  }
}
