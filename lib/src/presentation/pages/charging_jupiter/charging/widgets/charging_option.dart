import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jupiter/src/apptheme.dart';
import 'package:jupiter/src/constant_value.dart';
import 'package:jupiter/src/images_asset.dart';
import 'package:jupiter/src/presentation/widgets/index.dart';
import 'package:jupiter/src/utilities.dart';

class ChargingOption extends StatefulWidget {
  const ChargingOption({
    super.key,
    required this.type,
    required this.value,
    required this.unit,
  });

  final String type;
  final double value;
  final String unit;
  @override
  State<ChargingOption> createState() => _ChargingOptionState();
}

class _ChargingOptionState extends State<ChargingOption> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppTheme.grayD4A50),
          color: AppTheme.white),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                renderIconFromType(widget.type),
                const SizedBox(width: 8),
                TextLabel(
                  text: renderTextTypeFromType(),
                  fontSize: Utilities.sizeFontWithDesityForDisplay(
                      context, AppFontSize.normal),
                  fontWeight: FontWeight.bold,
                  color: AppTheme.blueDark,
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextLabel(
                  text: checkType()
                      ? ''
                      : '${widget.value.toStringAsFixed(0)} ${widget.unit}',
                  fontSize: Utilities.sizeFontWithDesityForDisplay(
                      context, AppFontSize.normal),
                  fontWeight: FontWeight.bold,
                  color: AppTheme.blueDark,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget renderIconFromType(String type) {
    switch (widget.type) {
      case 'full':
        return const Icon(
          Icons.battery_charging_full,
          size: 24,
          color: AppTheme.blueDark,
        );
      case 'energy':
        return const Icon(
          Icons.bolt,
          size: 26,
          color: AppTheme.blueDark,
        );
      case 'duration':
        return const Icon(
          Icons.access_time_filled,
          size: 28,
          color: AppTheme.blueDark,
        );
      case 'amount':
        return SvgPicture.asset(
          ImageAsset.ic_currency_baht_fill,
          width: 24,
          height: 24,
          color: AppTheme.blueDark,
        );
      default:
        return const Icon(
          Icons.battery_charging_full,
          size: 24,
          color: AppTheme.blueDark,
        );
    }
  }

  String renderTextTypeFromType() {
    switch (widget.type) {
      case 'full':
        return translate("check_in_page.advanced_options.full");
      case 'energy':
        return translate("check_in_page.charger_energy.title");
      case 'duration':
        return translate("charging_page.charging_duration.title");
      case 'amount':
        return translate("check_in_page.charger_cost.title");
      default:
        return translate("check_in_page.advanced_options.full");
    }
  }

  bool checkType() {
    switch (widget.type) {
      case 'full':
        return true;
      case 'energy':
        return false;
      default:
        return false;
    }
  }
}
