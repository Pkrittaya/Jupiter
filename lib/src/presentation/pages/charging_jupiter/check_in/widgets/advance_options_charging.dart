import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jupiter/src/constant_value.dart';
import 'package:jupiter/src/images_asset.dart';
import 'package:jupiter/src/presentation/pages/charging_jupiter/check_in/widgets/card_change_charging_cost.dart';
import 'package:jupiter/src/presentation/pages/charging_jupiter/check_in/widgets/card_change_charging_time.dart';
import 'package:jupiter/src/presentation/pages/charging_jupiter/check_in/widgets/tab_advance_option.dart';
import 'package:jupiter/src/presentation/widgets/tootip_information.dart';
import 'package:jupiter/src/utilities.dart';

import '../../../../../apptheme.dart';
import '../../../../widgets/index.dart';
import 'card_change_charging_energy.dart';

import 'charge_util_full.dart';

class AdvanceOptionCharging extends StatefulWidget {
  AdvanceOptionCharging({
    super.key,
    required this.controller,
    this.onExpansionChanged,
    // ENERGY
    required this.minValue,
    required this.maxValue,
    required this.controllerEnergyField,
    required this.onClickIncreaseChargingEnergy,
    required this.onClickReduceChargingEnergy,
    required this.onSlideChangeChargingEnergy,
    // DURATION
    required this.hourSelectedIndex,
    required this.minuteSelectedIndex,
    required this.onSelectedHourItem,
    required this.onSelectedMinuteItem,
    // AMOUNT
    required this.listItemCost,
    required this.onClickItemCost,
    required this.selectedIndex,
  });

  final TabController controller;
  final void Function(bool)? onExpansionChanged;
  // ENERGY
  final double minValue;
  final double maxValue;
  final TextEditingController controllerEnergyField;
  final Function() onClickIncreaseChargingEnergy;
  final Function() onClickReduceChargingEnergy;
  final Function(double) onSlideChangeChargingEnergy;
  // DURATION
  final int hourSelectedIndex;
  final int minuteSelectedIndex;
  final Function(int) onSelectedHourItem;
  final Function(int) onSelectedMinuteItem;
  // AMOUNT
  final List<int> listItemCost;
  final Function(int) onClickItemCost;
  final int selectedIndex;
  @override
  State<AdvanceOptionCharging> createState() => _AdvanceOptionChargingState();
}

class _AdvanceOptionChargingState extends State<AdvanceOptionCharging>
    with SingleTickerProviderStateMixin {
  TextEditingController eneryOptionController = TextEditingController();
  final Color _activeColor = AppTheme.white;
  final Color _normalColor = AppTheme.black40;

  // @override
  // void initState() {
  //   initTabController();
  //   super.initState();
  // }

  // void initTabController() {
  //   _tabOptionController = TabController(length: 4, vsync: this);
  //   _tabOptionController.addListener(() {
  //     if (!_tabOptionController.indexIsChanging) {
  //       // Your code goes here.
  //       // To get index of current tab use tabController.index
  //       _index = _tabOptionController.index;
  //       setState(() {});
  //     }
  //   });
  // }

  Color indexColor(int index) {
    return index == widget.controller.index ? _activeColor : _normalColor;
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      onExpansionChanged: widget.onExpansionChanged,
      tilePadding: EdgeInsets.zero,
      shape: const Border(),
      collapsedIconColor: AppTheme.blueDark,
      title: TextLabel(
        text: translate("check_in_page.advanced_options.advanced_options"),
        fontSize:
            Utilities.sizeFontWithDesityForDisplay(context, AppFontSize.big),
        fontWeight: FontWeight.w700,
        color: AppTheme.blueDark,
      ),
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextLabel(
              color: AppTheme.blueDark,
              text: translate("check_in_page.advanced_options.option_charging"),
              fontSize: Utilities.sizeFontWithDesityForDisplay(
                  context, AppFontSize.superlarge),
              fontWeight: FontWeight.w700,
            ),
            const SizedBox(
              width: 8,
            ),
            TooltipInformation(
              message: translate("check_in_page.information"),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          constraints: const BoxConstraints(maxHeight: 60),
          decoration: BoxDecoration(
            color: AppTheme.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: TabBar(
            labelPadding: const EdgeInsets.all(4),
            controller: widget.controller,
            indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(12), // Creates border
                color: AppTheme.blueD), //Change background color from here
            tabs: [
              Tab(
                child: TabAdvanceOption(
                  mainAxisAlignment: MainAxisAlignment.center,
                  icon: Icons.battery_charging_full,
                  text: translate("check_in_page.advanced_options.full"),
                  textSize: Utilities.sizeFontWithDesityForDisplay(
                      context, AppFontSize.normal),
                  fontWeight: FontWeight.w700,
                  iconColor: indexColor(0),
                  textColor: indexColor(0),
                  iconSize: 18,
                  sizeBetween: 4,
                ),
              ),
              Tab(
                child: TabAdvanceOption(
                  mainAxisAlignment: MainAxisAlignment.center,
                  icon: Icons.bolt,
                  text: translate("check_in_page.advanced_options.energy"),
                  textSize: Utilities.sizeFontWithDesityForDisplay(
                      context, AppFontSize.normal),
                  fontWeight: FontWeight.w700,
                  iconColor: indexColor(1),
                  textColor: indexColor(1),
                  iconSize: 18,
                  sizeBetween: 4,
                ),
              ),
              Tab(
                child: TabAdvanceOption(
                  mainAxisAlignment: MainAxisAlignment.center,
                  icon: Icons.access_time,
                  text: translate("check_in_page.advanced_options.duration"),
                  textSize: Utilities.sizeFontWithDesityForDisplay(
                      context, AppFontSize.normal),
                  fontWeight: FontWeight.w700,
                  iconColor: indexColor(2),
                  textColor: indexColor(2),
                  iconSize: 18,
                  sizeBetween: 4,
                ),
              ),
              Tab(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      ImageAsset.ic_currency_baht_fill,
                      width: 18,
                      height: 18,
                      color: indexColor(3),
                    ),
                    const SizedBox(width: 8),
                    TextLabel(
                      text: translate("check_in_page.advanced_options.amount"),
                      fontSize: Utilities.sizeFontWithDesityForDisplay(
                          context, AppFontSize.normal),
                      fontWeight: FontWeight.w700,
                      color: indexColor(3),
                      overflow: TextOverflow.ellipsis,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 230,
          child: TabBarView(
            controller: widget.controller,
            children: [
              const ChargeUntilFull(),
              CardChangeChargingEnergy(
                minValue: widget.minValue,
                maxValue: widget.maxValue,
                controllerEnergyField: widget.controllerEnergyField,
                onClickIncreaseChargingEnergy:
                    widget.onClickIncreaseChargingEnergy,
                onClickReduceChargingEnergy: widget.onClickReduceChargingEnergy,
                onSlideChangeChargingEnergy: widget.onSlideChangeChargingEnergy,
              ),
              CardChangeChargingTime(
                hourSelectedIndex: widget.hourSelectedIndex,
                minuteSelectedIndex: widget.minuteSelectedIndex,
                onSelectedHourItem: widget.onSelectedHourItem,
                onSelectedMinuteItem: widget.onSelectedMinuteItem,
              ),
              CardChangeChargingCost(
                listItemCost: widget.listItemCost,
                onClickItemCost: widget.onClickItemCost,
                selectedIndex: widget.selectedIndex,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
