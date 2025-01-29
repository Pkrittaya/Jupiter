import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jupiter/src/apptheme.dart';
import 'package:jupiter/src/constant_value.dart';
import 'package:jupiter/src/presentation/widgets/index.dart';
import 'package:jupiter/src/utilities.dart';

class CardChangeChargingCost extends StatefulWidget {
  const CardChangeChargingCost({
    Key? key,
    required this.selectedIndex,
    required this.listItemCost,
    required this.onClickItemCost,
  }) : super(key: key);

  final int selectedIndex;
  final List<int> listItemCost;
  final Function(int) onClickItemCost;
  @override
  _CardChangeChargingCostState createState() => _CardChangeChargingCostState();
}

class _CardChangeChargingCostState extends State<CardChangeChargingCost> {
  final formKey = GlobalKey<FormState>();
  double buttonChargingEnergyHeight = 45;
  double spaceLineHeight = 16;
  double widthSelector = 0.25;
  double widthSizedbox = 0.15;
  double heightItem = 35;

  isSelected(int value) {
    return widget.selectedIndex == value;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 16, 0, 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              padding: const EdgeInsets.fromLTRB(0, 16, 0, 16),
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppTheme.blueD),
                  color: AppTheme.white),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 5),
                    child: TextLabel(
                        text: translate("check_in_page.charger_cost.title"),
                        fontSize: Utilities.sizeFontWithDesityForDisplay(
                            context, AppFontSize.big),
                        fontWeight: FontWeight.bold,
                        color: AppTheme.blueDark),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
                    child: TextLabel(
                        text:
                            translate("check_in_page.charger_cost.sub_title"),
                        fontSize: Utilities.sizeFontWithDesityForDisplay(
                            context, AppFontSize.little),
                        color: AppTheme.gray9CA3AF),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                    child: _listSelectorCost(),
                  )
                ],
              ))
        ],
      ),
    );
  }

  Widget _listSelectorCost() {
    return Container(
        padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
        height: 100,
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30), color: AppTheme.blueLight),
        child: ListView.separated(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: widget.listItemCost.length,
          separatorBuilder: (context, index) => const SizedBox(width: 10),
          itemBuilder: (context, index) => _itemCost(index),
        ));
  }

  Widget _itemCost(int value) {
    return GestureDetector(
      onTap: () {
        widget.onClickItemCost(value);
      },
      child: Container(
        padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: isSelected(value) ? AppTheme.blueD : AppTheme.blueLight),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextLabel(
                text: (widget.listItemCost[value]).toString(),
                fontSize: Utilities.sizeFontWithDesityForDisplay(
                    context, AppFontSize.title),
                fontWeight: FontWeight.bold,
                color: isSelected(value) ? AppTheme.white : AppTheme.blueDark),
            const SizedBox(height: 4),
            TextLabel(
                text: '฿',
                fontSize: Utilities.sizeFontWithDesityForDisplay(
                    context, AppFontSize.small),
                fontWeight: FontWeight.bold,
                color: isSelected(value) ? AppTheme.white : AppTheme.blueDark)
          ],
        ),
      ),
    );
  }
}
