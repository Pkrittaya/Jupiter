import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jupiter/src/images_asset.dart';

import '../../../../../apptheme.dart';
import '../../../../../utilities.dart';
import '../../../../widgets/text_label.dart';

class ColTextWithImage extends StatelessWidget {
  const ColTextWithImage({
    super.key,
  });

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
        const SizedBox(
          height: 8,
        ),
        SvgPicture.asset(
          ImageAsset.logo_color,
          height: 10,
        ),
      ],
    );
  }
}
