import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jupiter/src/apptheme.dart';
import 'package:jupiter/src/constant_value.dart';
import 'package:jupiter/src/presentation/widgets/index.dart';
import 'package:jupiter/src/utilities.dart';

class CardChangeChargingEnergy extends StatefulWidget {
  CardChangeChargingEnergy({
    Key? key,
    required this.minValue,
    required this.maxValue,
    required this.controllerEnergyField,
    required this.onClickIncreaseChargingEnergy,
    required this.onClickReduceChargingEnergy,
    required this.onSlideChangeChargingEnergy,
  }) : super(key: key);

  final double minValue;
  final double maxValue;
  final TextEditingController controllerEnergyField;
  final Function() onClickIncreaseChargingEnergy;
  final Function() onClickReduceChargingEnergy;
  final Function(double) onSlideChangeChargingEnergy;

  @override
  _CardChangeChargingEnergyState createState() =>
      _CardChangeChargingEnergyState();
}

class _CardChangeChargingEnergyState extends State<CardChangeChargingEnergy> {
  @override
  void initState() {
    super.initState();
  }

  final formKey = GlobalKey<FormState>();
  double buttonChargingEnergyHeight = 45;
  double spaceLineHeight = 16;

  double getValueSilder() {
    double value = double.parse(widget.controllerEnergyField.text);
    if (value > widget.maxValue) {
      return 150.0;
    }
    return value;
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    final ButtonStyle buttonChangeEnergy = ElevatedButton.styleFrom(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      backgroundColor: AppTheme.lightButtonChargingEnergy,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      minimumSize: Size(width * 0.18, 46),
      elevation: 0,
    );

    return Container(
      padding: const EdgeInsets.fromLTRB(0, 16, 0, 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              padding: const EdgeInsets.fromLTRB(0, 24, 0, 16),
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
                        text: translate("check_in_page.charger_energy.title"),
                        fontSize: Utilities.sizeFontWithDesityForDisplay(
                            context, AppFontSize.big),
                        fontWeight: FontWeight.bold,
                        color: AppTheme.blueDark),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
                    child: TextLabel(
                        text:
                            translate("check_in_page.charger_energy.sub_title"),
                        fontSize: Utilities.sizeFontWithDesityForDisplay(
                            context, AppFontSize.little),
                        color: AppTheme.gray9CA3AF),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          style: buttonChangeEnergy,
                          onPressed: widget.onClickReduceChargingEnergy,
                          child: TextLabel(
                              text: "-10",
                              fontSize: Utilities.sizeFontWithDesityForDisplay(
                                  context, AppFontSize.title),
                              fontWeight: FontWeight.bold,
                              color: AppTheme.lightButtonTextChargingEnergy),
                        ),
                        Container(
                            height: buttonChargingEnergyHeight,
                            width: width * 0.4,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: AppTheme.lightTextFieldChargingEnergy),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  // color: AppTheme.green80,
                                  width: width * 0.08,
                                ),
                                Container(
                                  // color: AppTheme.green80,
                                  width: width * 0.22,
                                  height: buttonChargingEnergyHeight,
                                  child: TextFormField(
                                    textAlign: TextAlign.center,
                                    keyboardType: TextInputType.number,
                                    style: TextStyle(
                                        fontSize: Utilities
                                            .sizeFontWithDesityForDisplay(
                                                context, AppFontSize.title),
                                        fontWeight: FontWeight.bold,
                                        color: AppTheme.blueDark),
                                    controller: widget.controllerEnergyField,
                                    // initialValue: energy.toString(),
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                      disabledBorder: InputBorder.none,
                                      counterText: "",
                                      contentPadding:
                                          EdgeInsets.only(bottom: 3),
                                    ),
                                    maxLength: 3,
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.allow(
                                          RegExp(r'[0-9]')),
                                    ],
                                    // validator: (String text) {
                                    //   if (text == null ||
                                    //       text == "" ||
                                    //       int.parse(text) < 0) {
                                    //     return '0';
                                    //   }
                                    // },
                                  ),
                                ),
                                Container(
                                  // color: AppTheme.green80,
                                  width: width * 0.08,
                                  child: TextLabel(
                                      text: translate(
                                          "check_in_page.charger_energy.kwh"),
                                      fontSize: Utilities
                                          .sizeFontWithDesityForDisplay(
                                              context, AppFontSize.small),
                                      color: AppTheme
                                          .lightButtonTextChargingEnergy,
                                      overflow: TextOverflow.ellipsis),
                                ),
                              ],
                            )),
                        ElevatedButton(
                          style: buttonChangeEnergy,
                          onPressed: widget.onClickIncreaseChargingEnergy,
                          child: TextLabel(
                              text: "+10",
                              fontSize: Utilities.sizeFontWithDesityForDisplay(
                                  context, AppFontSize.title),
                              fontWeight: FontWeight.bold,
                              color: AppTheme.lightButtonTextChargingEnergy),
                        )
                      ],
                    ),
                  ),
                  Slider(
                      value: getValueSilder(),
                      min: widget.minValue,
                      max: widget.maxValue,
                      // divisions: 10,
                      activeColor: AppTheme.blueD,
                      inactiveColor: AppTheme.grayD1D5DB,
                      onChanged: (double newValue) {
                        widget.onSlideChangeChargingEnergy(newValue);
                        // debugPrint('asdasd');
                      },
                      semanticFormatterCallback: (double newValue) {
                        return '${newValue.round()} dollars';
                      })
                ],
              ))
        ],
      ),
    );
  }
}
