import 'package:flutter/material.dart';

import '../../../../apptheme.dart';
import '../../../../constant_value.dart';
import '../../../../utilities.dart';
import '../../../widgets/text_label.dart';

class RowButtonSetting extends StatelessWidget {
  const RowButtonSetting({
    super.key,
    required this.title,
    required this.textStatus,
    required this.onPressed,
  });
  final void Function()? onPressed;
  final String textStatus;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          color: AppTheme.white,
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            highlightColor: AppTheme.black5,
            onTap: onPressed,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextLabel(
                    text: title,
                    fontSize: Utilities.sizeFontWithDesityForDisplay(
                        context, AppFontSize.big),
                    color: AppTheme.blueDark,
                    fontWeight: FontWeight.bold,
                  ),
                  Row(
                    children: [
                      TextLabel(
                        text: textStatus,
                        fontSize: Utilities.sizeFontWithDesityForDisplay(
                            context, AppFontSize.normal),
                        color: AppTheme.gray9CA3AF,
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: AppTheme.gray9CA3AF,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 8),
          height: 1,
          width: double.infinity,
          color: AppTheme.borderGray,
        )
      ],
    );
  }
}
