import 'package:flutter/material.dart';
import 'package:jupiter/src/apptheme.dart';
import 'package:jupiter/src/presentation/widgets/text_label.dart';

class ButtonGoToFleetOperation extends StatefulWidget {
  const ButtonGoToFleetOperation({
    Key? key,
    required this.text,
    required this.onClickButton,
  }) : super(key: key);

  final String text;
  final Function() onClickButton;

  @override
  _ButtonGoToFleetOperationState createState() =>
      _ButtonGoToFleetOperationState();
}

class _ButtonGoToFleetOperationState extends State<ButtonGoToFleetOperation> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        color: AppTheme.blueD,
        borderRadius: BorderRadius.circular(200),
        child: InkWell(
          borderRadius: BorderRadius.circular(200),
          onTap: widget.onClickButton,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(200),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.arrow_back_ios,
                  size: 16,
                  color: AppTheme.white,
                ),
                const SizedBox(width: 4),
                TextLabel(
                  text: widget.text,
                  color: AppTheme.white,
                ),
              ],
            ),
          ),
        ));
  }
}
