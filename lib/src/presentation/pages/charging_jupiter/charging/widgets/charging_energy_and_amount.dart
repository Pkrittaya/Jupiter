import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jupiter/src/apptheme.dart';
import 'package:jupiter/src/constant_value.dart';
import 'package:jupiter/src/images_asset.dart';
import 'package:jupiter/src/presentation/widgets/column_two_text.dart';
import 'package:jupiter/src/presentation/widgets/index.dart';
import 'package:jupiter/src/utilities.dart';

class ChargingEnergyAndAmount extends StatefulWidget {
  const ChargingEnergyAndAmount({
    super.key,
    required this.energyDelivered,
    required this.amountPaid,
  });

  final String energyDelivered;
  final String amountPaid;

  @override
  State<ChargingEnergyAndAmount> createState() =>
      _ChargingEnergyAndAmountState();
}

class _ChargingEnergyAndAmountState extends State<ChargingEnergyAndAmount> {
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 2,
      shadowColor: AppTheme.black20,
      color: AppTheme.white,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.bolt,
                    size: 32,
                    color: AppTheme.blueD,
                  ),
                  const SizedBox(width: 4),
                  ColumnTwoText(
                    textUpper:
                        Utilities.formatMoney('${widget.energyDelivered}', 3),
                    textLower: translate("charging_page.energy_delivered"),
                    colorUpper: AppTheme.blueD,
                    colorLower: AppTheme.black40,
                    upperFontSize:
                        Utilities.sizeFontWithDesityForDisplay(context, 48),
                    lowerFontSize: Utilities.sizeFontWithDesityForDisplay(
                        context, AppFontSize.small),
                    upperFontWeight: FontWeight.w400,
                    lowerFontWeight: FontWeight.w400,
                  ),
                  const SizedBox(width: 4),
                  TextLabel(
                    text: translate("charging_page.charging_change.kWh"),
                    fontSize: Utilities.sizeFontWithDesityForDisplay(
                        context, AppFontSize.small),
                    fontWeight: FontWeight.w400,
                    color: AppTheme.blueD,
                  ),
                ],
              ),
            ),
            Container(
              constraints: const BoxConstraints(maxHeight: 65),
              width: 1,
              height: double.infinity,
              color: AppTheme.blueLight,
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    ImageAsset.ic_baht,
                    width: 24,
                    height: 24,
                  ),
                  const SizedBox(width: 8),
                  ColumnTwoText(
                    textUpper: Utilities.formatMoney('${widget.amountPaid}', 2),
                    textLower: translate("charging_page.amount_paid"),
                    colorUpper: AppTheme.blueD,
                    colorLower: AppTheme.black40,
                    upperFontSize:
                        Utilities.sizeFontWithDesityForDisplay(context, 48),
                    lowerFontSize: Utilities.sizeFontWithDesityForDisplay(
                        context, AppFontSize.small),
                    upperFontWeight: FontWeight.w400,
                    lowerFontWeight: FontWeight.w400,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
