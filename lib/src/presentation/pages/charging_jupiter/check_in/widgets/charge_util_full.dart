import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jupiter/src/constant_value.dart';
import 'package:jupiter/src/utilities.dart';
import 'dart:math' as math;

import '../../../../../apptheme.dart';
import '../../../../widgets/index.dart';

class ChargeUntilFull extends StatelessWidget {
  const ChargeUntilFull({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Transform.rotate(
            angle: 90 * math.pi / 180,
            child: Icon(
              Icons.battery_charging_full,
              size: 50,
              color: AppTheme.black40,
            ),
          ),
          TextLabel(
            text: translate("check_in_page.advanced_options.charge_full"),
            fontSize: Utilities.sizeFontWithDesityForDisplay(
                context, AppFontSize.big),
            fontWeight: FontWeight.w700,
            color: AppTheme.black40,
          )
        ],
      ),
    );
  }
}
