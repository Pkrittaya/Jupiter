import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jupiter/src/apptheme.dart';
import 'package:jupiter/src/constant_value.dart';
import 'package:jupiter/src/presentation/widgets/text_label.dart';
import 'package:jupiter/src/utilities.dart';

class ButtonSaveImage extends StatefulWidget {
  const ButtonSaveImage({
    Key? key,
    required this.isLoading,
    required this.disable,
    required this.onClickButton,
  }) : super(key: key);

  final bool isLoading;
  final bool disable;
  final Function() onClickButton;

  @override
  _ButtonSaveImageState createState() => _ButtonSaveImageState();
}

class _ButtonSaveImageState extends State<ButtonSaveImage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: !widget.isLoading,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Material(
            color: !widget.disable
                ? AppTheme.blueD.withOpacity(0.85)
                : AppTheme.white,
            borderRadius: BorderRadius.circular(200),
            child: InkWell(
              borderRadius: BorderRadius.circular(200),
              onTap: widget.onClickButton,
              child: Container(
                width: 55,
                height: 55,
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: AppTheme.borderGray),
                  borderRadius: BorderRadius.circular(200),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.save_alt,
                      color: !widget.disable
                          ? AppTheme.white
                          : AppTheme.gray9CA3AF,
                      size: 30,
                    )
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 6),
          TextLabel(
            text: translate('history_detail_page.save_slip'),
            textAlign: TextAlign.center,
            color: AppTheme.black60,
            fontSize: Utilities.sizeFontWithDesityForDisplay(
                context, AppFontSize.normal),
          ),
        ],
      ),
    );
  }
}
