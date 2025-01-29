import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jupiter/src/apptheme.dart';
import 'package:jupiter/src/constant_value.dart';
import 'package:jupiter/src/presentation/pages/charging_jupiter/check_in/widgets/hour_item.dart';
import 'package:jupiter/src/presentation/pages/charging_jupiter/check_in/widgets/mins_item.dart';
import 'package:jupiter/src/presentation/widgets/index.dart';
import 'package:jupiter/src/utilities.dart';

class CardChangeChargingTime extends StatefulWidget {
  const CardChangeChargingTime({
    Key? key,
    required this.hourSelectedIndex,
    required this.minuteSelectedIndex,
    required this.onSelectedHourItem,
    required this.onSelectedMinuteItem,
  }) : super(key: key);

  final int hourSelectedIndex;
  final int minuteSelectedIndex;
  final Function(int) onSelectedHourItem;
  final Function(int) onSelectedMinuteItem;
  @override
  _CardChangeChargingTimeState createState() => _CardChangeChargingTimeState();
}

class _CardChangeChargingTimeState extends State<CardChangeChargingTime> {
  @override
  void initState() {
    super.initState();
  }

  final formKey = GlobalKey<FormState>();
  double buttonChargingEnergyHeight = 45;
  double spaceLineHeight = 16;
  double widthSelector = 0.25;
  double widthSizedbox = 0.15;
  double heightItem = 35;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
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
                  border: Border.all(color: AppTheme.blueDark),
                  color: AppTheme.white),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 5),
                    child: TextLabel(
                        text: translate("check_in_page.charger_time.title"),
                        fontSize: Utilities.sizeFontWithDesityForDisplay(
                            context, AppFontSize.big),
                        fontWeight: FontWeight.bold,
                        color: AppTheme.blueDark),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
                    child: TextLabel(
                        text: translate("check_in_page.charger_time.sub_title"),
                        fontSize: Utilities.sizeFontWithDesityForDisplay(
                            context, AppFontSize.little),
                        color: AppTheme.gray9CA3AF),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                    child: Stack(
                      alignment: AlignmentDirectional.center,
                      children: [
                        Container(
                          width: double.infinity,
                          height: heightItem,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2),
                              color: AppTheme.lightTextFieldChargingEnergy),
                        ),
                        SizedBox(
                            width: double.infinity,
                            height: heightItem * 3,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: width * widthSizedbox,
                                ),
                                _listSelectorHour(
                                    context, widget.hourSelectedIndex),
                                TextLabel(
                                    text: ':',
                                    fontSize:
                                        Utilities.sizeFontWithDesityForDisplay(
                                            context, AppFontSize.big),
                                    fontWeight: FontWeight.bold,
                                    color: AppTheme.blueDark),
                                _listSelectorMins(
                                    context, widget.minuteSelectedIndex),
                                SizedBox(
                                    width: width * widthSizedbox,
                                    child: Center(
                                        child: TextLabel(
                                            text: translate(
                                                "check_in_page.charger_time.time"),
                                            fontSize: Utilities
                                                .sizeFontWithDesityForDisplay(
                                                    context, AppFontSize.big),
                                            fontWeight: FontWeight.bold,
                                            color: AppTheme.blueDark))),
                              ],
                            ))
                      ],
                    ),
                  ),
                ],
              ))
        ],
      ),
    );
  }

  Widget _listSelectorHour(BuildContext context, int indexSelected) {
    var width = MediaQuery.of(context).size.width;
    return SizedBox(
        width: width * widthSelector,
        child: ListWheelScrollView.useDelegate(
            itemExtent: heightItem,
            perspective: 0.005,
            // diameterRatio: 1.5,
            physics: const FixedExtentScrollPhysics(),
            onSelectedItemChanged: (index) {
              widget.onSelectedHourItem(index);
            },
            childDelegate: ListWheelChildLoopingListDelegate(
              children: List<Widget>.generate(
                24,
                (index) => HourItem(hour: index),
              ),
            )));
  }

  Widget _listSelectorMins(BuildContext context, int indexSelected) {
    var width = MediaQuery.of(context).size.width;
    return SizedBox(
        width: width * widthSelector,
        child: ListWheelScrollView.useDelegate(
          itemExtent: heightItem,
          perspective: 0.005,
          // diameterRatio: 1.5,
          physics: const FixedExtentScrollPhysics(),
          onSelectedItemChanged: (index) {
            widget.onSelectedMinuteItem(index);
          },
          childDelegate: ListWheelChildLoopingListDelegate(
            children: List<Widget>.generate(
              4,
              (index) => MinsItem(mins: index),
            ),
          ),
        ));
  }
}
