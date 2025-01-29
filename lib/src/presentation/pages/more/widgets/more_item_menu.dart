import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jupiter/src/apptheme.dart';
import 'package:jupiter/src/constant_value.dart';
import 'package:jupiter/src/presentation/pages/more/more_page.dart';
import 'package:jupiter/src/presentation/widgets/text_label.dart';
import 'package:jupiter/src/utilities.dart';

// ignore: must_be_immutable
class MoreItemMenu extends StatelessWidget {
  MoreItemMenu({
    super.key,
    required this.data,
    required this.onPressedItemMenu,
  });

  final MoreMenuItemData data;
  final Function(String) onPressedItemMenu;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          highlightColor: AppTheme.black5,
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            onPressedItemMenu(data.pageName);
          },
          child: Ink(
            decoration: BoxDecoration(
              color: AppTheme.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppTheme.grayD1D5DB,
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: 35,
                    height: 35,
                    child: SvgPicture.asset(
                      data.leadingIconAsset,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextLabel(
                      text: data.name,
                      fontSize: Utilities.sizeFontWithDesityForDisplay(
                          context, AppFontSize.big),
                      color: AppTheme.gray9CA3AF,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: AppTheme.gray9CA3AF,
                  )
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: 8)
      ],
    );
  }
}
