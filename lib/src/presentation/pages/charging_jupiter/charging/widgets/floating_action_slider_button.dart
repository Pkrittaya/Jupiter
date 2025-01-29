import 'dart:math';

import 'package:animated_styled_widget/animated_styled_widget.dart';
import 'package:flutter/material.dart';

import 'package:jupiter/src/apptheme.dart';
import 'package:jupiter/src/constant_value.dart';
import 'package:jupiter/src/presentation/widgets/button_progress.dart';
import 'package:jupiter/src/utilities.dart';
import 'package:slider_button/slider_button.dart';

class FloatingActionSliderButton extends StatelessWidget {
  final String label;
  final Future<bool?> Function() action;
  final Widget? icon;

  final double buttonSize;
  final bool disable;
  final bool processReady;

  final AlignmentGeometry alignLabel;
  final Color backgroundColor;
  final Color baseColor;
  final Color buttonColor;
  final Color highlightedColor;

  const FloatingActionSliderButton({
    Key? key,
    required this.action,
    required this.label,
    this.icon,
    this.buttonSize = 56,
    this.disable = false,
    this.processReady = false,
    this.alignLabel = Alignment.center,
    this.backgroundColor = AppTheme.white,
    this.baseColor = AppTheme.white,
    this.buttonColor = AppTheme.white,
    this.highlightedColor = AppTheme.darkBlue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      key: UniqueKey(),
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(
          horizontal: width * 0.08, vertical: height * 0.022),
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border(
          top: BorderSide(width: 1, color: AppTheme.borderGray),
        ),
      ),
      child: processReady
          ? Container(
              decoration: const BoxDecoration(
                color: AppTheme.red,
                shape: BoxShape.circle,
              ),
              child: ButtonProgress(
                visible: true,
                width: (buttonSize - 10).toPXLength,
                height: (buttonSize - 10).toPXLength,
                borderWidth: 6,
                boxDecorationColor: AppTheme.red,
                gradient: const SweepGradient(startAngle: pi, colors: [
                  AppTheme.white,
                  AppTheme.white,
                  AppTheme.white,
                  AppTheme.white,
                ]),
                child: const SizedBox(),
              ),
            )
          : disable
              ? Container(
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    color: AppTheme.black40,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Stack(
                    alignment: Alignment.centerLeft,
                    children: <Widget>[
                      Container(
                        alignment: alignLabel,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 24.0),
                          child: Text(
                            label,
                            style: TextStyle(
                              color: AppTheme.white,
                              fontWeight: FontWeight.w700,
                              fontSize: Utilities.sizeFontWithDesityForDisplay(
                                  context, AppFontSize.superlarge),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(
                          left:
                              (MediaQuery.of(context).size.height * 0.08) / 10,
                        ),
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.075,
                          width: MediaQuery.of(context).size.height * 0.075,
                          decoration: BoxDecoration(
                            color: buttonColor,
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Center(child: icon),
                        ),
                      ),
                    ],
                  ),
                )
              : SliderButton(
                  width: MediaQuery.of(context).size.width * 0.83,
                  buttonSize: MediaQuery.of(context).size.height * 0.075 < 60
                      ? MediaQuery.of(context).size.height * 0.075
                      : 60,
                  alignLabel: Alignment.center,
                  backgroundColor: AppTheme.red,
                  baseColor: AppTheme.white,
                  highlightedColor: AppTheme.darkBlue,
                  action: action,
                  label: Text(
                    label,
                    style: TextStyle(
                      color: AppTheme.darkBlue,
                      fontWeight: FontWeight.w700,
                      fontSize: Utilities.sizeFontWithDesityForDisplay(
                          context, AppFontSize.superlarge),
                    ),
                  ),
                  icon: icon,
                ),
    );
  }
}
