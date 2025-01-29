import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jupiter/src/constant_value.dart';
import 'package:jupiter/src/utilities.dart';

import '../../../../../apptheme.dart';
import '../../../../widgets/index.dart';
// import 'row_with_text_and_box_text.dart';

class ChargerDeviceData extends StatelessWidget {
  const ChargerDeviceData({
    super.key,
    required this.charger_name,
    required this.total_connector,
    required this.connector_index,
  });

  final String charger_name;
  final String total_connector;
  final String connector_index;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(
          Icons.ev_station,
          color: AppTheme.blueDark,
          size: 35,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 2, left: 2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextLabel(
                text: charger_name,
                fontSize: Utilities.sizeFontWithDesityForDisplay(
                    context, AppFontSize.normal),
                fontWeight: FontWeight.w700,
                color: AppTheme.blueDark,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(
                height: 4,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextLabel(
                    text:
                        "${translate("check_in_page.check_in_device.id")} : ${connector_index}",
                    fontSize: Utilities.sizeFontWithDesityForDisplay(
                        context, AppFontSize.small),
                    fontWeight: FontWeight.w400,
                    color: AppTheme.black40,
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  TextLabel(
                    text:
                        "${translate("check_in_page.check_in_device.socket")} : ${total_connector}",
                    fontSize: Utilities.sizeFontWithDesityForDisplay(
                        context, AppFontSize.small),
                    fontWeight: FontWeight.w400,
                    color: AppTheme.black40,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
