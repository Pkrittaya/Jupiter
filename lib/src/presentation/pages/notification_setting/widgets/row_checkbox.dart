import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../apptheme.dart';
import '../../../../constant_value.dart';
import '../../../../utilities.dart';
import '../../../widgets/text_label.dart';

class RowCheckbox extends StatelessWidget {
  const RowCheckbox(
      {super.key,
      required this.title,
      this.description,
      required this.onPressed,
      required this.value,
      this.disable,
      required this.loadingPage,
      required this.loadingCheckbox});

  final void Function()? onPressed;
  final String title;
  final String? description;
  final bool value;
  final bool? disable;
  final bool loadingPage;
  final bool loadingCheckbox;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          color: AppTheme.white,
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            highlightColor: AppTheme.black5,
            onTap: (disable != true) ? onPressed : () {},
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextLabel(
                        text: title,
                        fontSize: Utilities.sizeFontWithDesityForDisplay(
                            context, AppFontSize.big),
                        color: AppTheme.blueDark,
                        fontWeight: FontWeight.bold,
                      ),
                      (description != null)
                          ? TextLabel(
                              text: description ?? '',
                              fontSize: Utilities.sizeFontWithDesityForDisplay(
                                  context, AppFontSize.normal),
                              color: AppTheme.gray9CA3AF,
                            )
                          : SizedBox(),
                    ],
                  ),
                  renderIconCheckbox(context)
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

  Widget renderIconCheckbox(BuildContext context) {
    if (!loadingPage || !loadingCheckbox) {
      return Icon(
        value ? Icons.check_box : Icons.square_rounded,
        size: 24,
        color: value && disable != true ? AppTheme.blueD : AppTheme.black20,
      );
    } else {
      return Skeletonizer(
        child: Bone.circle(size: 30),
      );
    }
  }
}
