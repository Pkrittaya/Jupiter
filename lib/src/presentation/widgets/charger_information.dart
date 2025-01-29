import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jupiter/src/images_asset.dart';
import 'package:jupiter/src/utilities.dart';
import '../../apptheme.dart';
import '../../constant_value.dart';
import 'index.dart';

class ChargerInfomation extends StatelessWidget {
  const ChargerInfomation({
    super.key,
    required this.chargerStatus,
    required this.chargerBrand,
    required this.chargerId,
    required this.totalConnector,
    this.iconSize = 46,
  });

  final String chargerStatus;
  final String chargerBrand;
  final String chargerId;
  final int totalConnector;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(
          ImageAsset.ic_charger_station,
          width: 40,
          height: 40,
        ),
        const SizedBox(
          width: 8,
        ),
        TextLabel(
          color: AppTheme.blueDark,
          text: chargerBrand,
          fontSize: Utilities.sizeFontWithDesityForDisplay(
              context, AppFontSize.normal),
          fontWeight: FontWeight.w400,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
      ],
    );
  }
}
