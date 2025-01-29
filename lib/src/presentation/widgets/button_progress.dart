import 'dart:math';

import 'package:animated_styled_widget/animated_styled_widget.dart';
import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

class ButtonProgress extends StatelessWidget {
  const ButtonProgress({
    Key? key,
    required this.child,
    this.onTap,
    this.visible = false,
    this.width,
    this.height,
    this.borderWidth,
    this.gradient,
    this.boxDecorationColor = Colors.white,
    this.finish = false,
  }) : super(key: key);

  final Widget child;
  final Function()? onTap;
  final bool visible;
  final bool finish;

  final Dimension? width;
  final Dimension? height;

  final double? borderWidth;
  final SweepGradient? gradient;
  final Color boxDecorationColor;

  @override
  Widget build(BuildContext context) {
    if (!visible) {
      return const SizedBox();
    }
    DynamicBorderSide startBorder = DynamicBorderSide(
      width: borderWidth ?? 10,
      begin: 0.toPercentLength,
      end: 0.toPercentLength,
      color: boxDecorationColor,
      gradient: gradient ??
          const SweepGradient(startAngle: pi, colors: [
            Colors.lightBlue,
            Colors.lightBlueAccent,
            Colors.blue,
            Colors.blueAccent,
          ]),
      strokeCap: StrokeCap.round,
      strokeJoin: StrokeJoin.round,
    );
    DynamicBorderSide middleBorder = DynamicBorderSide(
      width: borderWidth ?? 10,
      begin: 0.toPercentLength,
      end: 50.toPercentLength,
      shift: 50.toPercentLength,
      color: boxDecorationColor,
      gradient: gradient ??
          const SweepGradient(startAngle: pi, colors: [
            Colors.lightBlue,
            Colors.lightBlueAccent,
            Colors.blue,
            Colors.blueAccent,
          ]),
      strokeCap: StrokeCap.round,
      strokeJoin: StrokeJoin.round,
    );
    DynamicBorderSide endBorder = DynamicBorderSide(
      width: borderWidth ?? 10,
      begin: 100.toPercentLength,
      end: 100.toPercentLength,
      shift: 100.toPercentLength,
      color: boxDecorationColor,
      gradient: gradient ??
          const SweepGradient(startAngle: pi, colors: [
            Colors.lightBlue,
            Colors.lightBlueAccent,
            Colors.blue,
            Colors.blueAccent,
          ]),
      strokeCap: StrokeCap.round,
      strokeJoin: StrokeJoin.round,
    );

    DynamicBorderSide finishBorder = DynamicBorderSide(
      width: borderWidth ?? 10,
      begin: 0.toPercentLength,
      end: 100.toPercentLength,
      shift: 0.toPercentLength,
      color: boxDecorationColor,
      gradient: gradient ??
          const SweepGradient(startAngle: pi, colors: [
            Colors.lightBlue,
            Colors.lightBlueAccent,
            Colors.blue,
            Colors.blueAccent,
          ]),
      strokeCap: StrokeCap.round,
      strokeJoin: StrokeJoin.round,
    );

    return ExplicitAnimatedStyledContainer(
      style: Style(
        alignment: Alignment.center,
        childAlignment: Alignment.center,
        width: width ?? 100.toPXLength,
        height: height ?? 100.toPXLength,
        // padding: const EdgeInsets.symmetric(vertical: 20),
        backgroundDecoration: BoxDecoration(color: boxDecorationColor),
        shapeBorder: CircleShapeBorder(border: startBorder),
      ),
      localAnimations: {
        AnimationTrigger.visible: MultiAnimationSequence(
          //TODO Btn Progress Check
          control: finish ? Control.play : Control.loop,
          // control: finish
          //     ? CustomAnimationControl.play
          //     : CustomAnimationControl.loop,
          sequences: finish
              ? {
                  AnimationProperty.shapeBorder:
                      AnimationSequence<MorphableShapeBorder>()
                        ..add(
                          duration: const Duration(milliseconds: 1000),
                          value: CircleShapeBorder(border: finishBorder),
                        )
                }
              : {
                  AnimationProperty.shapeBorder:
                      AnimationSequence<MorphableShapeBorder>()
                        ..add(
                          duration: const Duration(milliseconds: 1000),
                          value: CircleShapeBorder(border: middleBorder),
                        )
                        ..add(
                          duration: const Duration(milliseconds: 1000),
                          value: CircleShapeBorder(border: endBorder),
                        ),
                },
        ),
      },
      onTap: onTap,
      child: child,
    );
  }
}
