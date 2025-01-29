import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jupiter/src/apptheme.dart';
import 'package:jupiter/src/constant_value.dart';
import 'package:jupiter/src/images_asset.dart';
import 'package:jupiter/src/presentation/widgets/text_label.dart';
import 'package:jupiter/src/utilities.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ColTextWithImage extends StatelessWidget {
  const ColTextWithImage({
    super.key,
    required this.loading,
  });

  final bool loading;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextLabel(
          text: translate("receipt_page.good_day"),
          fontSize: Utilities.sizeFontWithDesityForDisplay(
            context,
            32,
          ),
          fontWeight: FontWeight.w700,
          color: AppTheme.blueDark,
        ),
        const SizedBox(height: 8),
        !loading
            ? SvgPicture.asset(
                ImageAsset.logo_color,
                height: 10,
              )
            : Bone.text(
                words: 1,
                fontSize: Utilities.sizeFontWithDesityForDisplay(
                  context,
                  AppFontSize.supermini,
                ),
              ),
      ],
    );
  }
}
