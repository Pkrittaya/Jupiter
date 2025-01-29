import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jupiter/src/apptheme.dart';
import 'package:jupiter/src/constant_value.dart';
import 'package:jupiter/src/images_asset.dart';
import 'package:jupiter/src/presentation/widgets/text_label.dart';
import 'package:jupiter/src/utilities.dart';
import 'row_with_3_text.dart';

class ChargingMode extends StatefulWidget {
  const ChargingMode(
      {Key? key,
      required this.controller,
      required this.standardColor,
      required this.highSpeedColor,
      required this.standard_charger_power,
      required this.standard_charger_price,
      required this.standard_charger_power_unit,
      required this.standard_charger_price_unit,
      required this.hightspeed_charger_power,
      required this.hightspeed_charger_price,
      required this.hightspeed_charger_power_unit,
      required this.hightspeed_charger_price_unit,
      required this.hightspeedStatus})
      : super(key: key);

  final TabController controller;
  final Color standardColor;
  final Color highSpeedColor;
  final double standard_charger_power;
  final String standard_charger_price;
  final String standard_charger_power_unit;
  final String standard_charger_price_unit;
  final double hightspeed_charger_power;
  final String hightspeed_charger_price;
  final String hightspeed_charger_power_unit;
  final String hightspeed_charger_price_unit;
  final bool hightspeedStatus;

  @override
  _ChargingModeState createState() => _ChargingModeState();
}

class _ChargingModeState extends State<ChargingMode>
    with SingleTickerProviderStateMixin {
  // late TabController _tabController;

  // Color _standardColor = AppTheme.white;
  // Color _highSpeedColor = AppTheme.blueD;

  // @override
  // void initState() {
  //   super.initState();
  // }

  // @override
  // void dispose() {
  //   _tabController.dispose();
  //   super.dispose();
  // }

  // void initTabController() {
  //   _tabController = TabController(length: 2, vsync: this);
  //   _tabController.addListener(() {
  //     if (!_tabController.indexIsChanging) {
  //       // Your code goes here.
  //       // To get index of current tab use tabController.index
  //       int index = _tabController.index;
  //       if (index == 0) {
  //         _standardColor = AppTheme.white;
  //         _highSpeedColor = AppTheme.blueD;
  //       }
  //       if (index == 1) {
  //         _standardColor = AppTheme.blueDark;
  //         _highSpeedColor = AppTheme.white;
  //       }
  //       setState(() {});
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 60),
      decoration: BoxDecoration(
        color: AppTheme.blueLight,
        borderRadius: BorderRadius.circular(12),
      ),
      child: TabBar(
        labelPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 2),
        controller: widget.controller,
        indicator: BoxDecoration(
            borderRadius: BorderRadius.circular(12), // Creates border
            color: AppTheme.blueD), //Change background color from here
        tabs: [
          Tab(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextLabel(
                  text: translate("check_in_page.standard_charging"),
                  fontSize: Utilities.sizeFontWithDesityForDisplay(
                      context, AppFontSize.big),
                  fontWeight: FontWeight.w700,
                  color: widget.standardColor,
                  overflow: TextOverflow.ellipsis,
                ),
                RowWith3Text(
                  textColor: widget.standardColor,
                  text:
                      '${translate("check_in_page.power")} ${widget.standard_charger_power} ${widget.standard_charger_power_unit}  ●  ${widget.standard_charger_price_unit} ${widget.standard_charger_price}',
                ),
              ],
            ),
          ),
          if (widget.hightspeedStatus) tabPremium(),
        ],
      ),
    );
  }

  Widget tabPremium() {
    return Tab(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                ImageAsset.ic_crown,
                width: 18,
                height: 18,
              ),
              const SizedBox(width: 4),
              TextLabel(
                text: translate("check_in_page.hight_speed_charging"),
                fontSize: Utilities.sizeFontWithDesityForDisplay(
                    context, AppFontSize.big),
                fontWeight: FontWeight.w700,
                color: widget.highSpeedColor,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
          RowWith3Text(
            textColor: widget.highSpeedColor,
            text:
                '${translate("check_in_page.power")} ${widget.hightspeed_charger_power} ${widget.hightspeed_charger_power_unit}  ●  ${widget.hightspeed_charger_price_unit} ${widget.hightspeed_charger_price}',
          ),
        ],
      ),
    );
  }
}
