import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jupiter/src/constant_value.dart';
import 'package:jupiter/src/images_asset.dart';
import 'package:jupiter/src/utilities.dart';

import '../../../../../apptheme.dart';
import '../../../../widgets/index.dart';
import 'row_with_text_and_box_text.dart';

class ChargerData extends StatelessWidget {
  const ChargerData(
      {super.key,
      required this.charger_name,
      required this.charger_type,
      required this.total_connector,
      required this.station_id,
      required this.charger_id,
      required this.owener,
      required this.connector_id,
      required this.connector_index,
      required this.connector_type,
      required this.connector_position,
      required this.connector_status_active});

  final String charger_name;
  final String charger_type;
  final String total_connector;
  final String station_id;
  final String charger_id;
  final String owener;
  final String connector_id;
  final String connector_index;
  final String connector_type;
  final String connector_position;
  final String connector_status_active;

  renderPosition(String position) {
    switch (position) {
      case 'M':
        return translate('check_in_page.charger_data.middle');
      case 'L':
        return translate('check_in_page.charger_data.left');
      case 'R':
        return translate('check_in_page.charger_data.right');
      default:
        return translate('check_in_page.charger_data.left');
    }
  }

  renderStatus(String status) {
    switch (status) {
      case 'preparing':
        return translate('check_in_page.status_charger.pairing');
      // NOT ACTIVE
      case 'occupied':
        return translate('check_in_page.status_charger.occupied');
      case 'charging':
        return translate('check_in_page.status_charger.available');
      case 'available':
        return translate('check_in_page.status_charger.available');
      case 'suspendedev':
        return translate('check_in_page.status_charger.available');
      case 'suspendedevse':
        return translate('check_in_page.status_charger.available');
      case 'finishing':
        return translate('check_in_page.status_charger.available');
      case 'reserved':
        return translate('check_in_page.status_charger.available');
      default:
        return translate('check_in_page.status_charger.available');
    }
  }

  colorFromStatus(String status) {
    switch (status) {
      case 'preparing':
        return AppTheme.green;
      case 'charging':
        return AppTheme.green;
      // NOT ACTIVE
      case 'occupied':
        return AppTheme.red;
      case 'available':
        return AppTheme.yellowPending;
      case 'suspendedev':
        return AppTheme.yellowPending;
      case 'suspendedevse':
        return AppTheme.yellowPending;
      case 'finishing':
        return AppTheme.yellowPending;
      case 'reserved':
        return AppTheme.yellowPending;
      default:
        return AppTheme.yellowPending;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        renderRowOne(context),
        const SizedBox(height: 4),
        renderRowTwo(context)
      ],
    );
  }

  Widget renderRowTwo(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 2),
                child: SvgPicture.asset(
                  ImageAsset.ic_ev_type,
                  width: 22,
                  height: 22,
                ),
              ),
              const SizedBox(width: 8),
              RowWithTextAndBoxText(
                // widthBase: width * 0.39,
                text: '${charger_type} ${connector_type}',
                textBox: renderPosition(connector_position),
                textColor: AppTheme.blueDark,
                textSize: Utilities.sizeFontWithDesityForDisplay(
                    context, AppFontSize.big),
                textWeight: FontWeight.w700,
                textBoxSize: Utilities.sizeFontWithDesityForDisplay(
                    context, AppFontSize.mini),
                textBoxWeight: FontWeight.w400,
                textBoxColor: AppTheme.white,
                boxColor: AppTheme.blueDark,
              ),
            ],
          ),
          Expanded(child: SizedBox()),
          RowWithTextAndBoxText(
            text: translate('check_in_page.charger_data.status'),
            textBox: renderStatus(connector_status_active),
            textColor: AppTheme.black40,
            textSize: Utilities.sizeFontWithDesityForDisplay(
                context, AppFontSize.small),
            textWeight: FontWeight.w400,
            textBoxSize: Utilities.sizeFontWithDesityForDisplay(
                context, AppFontSize.small),
            textBoxWeight: FontWeight.w400,
            textBoxColor: AppTheme.white,
            boxColor: colorFromStatus(connector_status_active),
          ),
        ],
      ),
    );
  }

  Widget renderRowOne(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(
            Icons.ev_station,
            color: AppTheme.blueDark,
            size: 28,
          ),
          const SizedBox(width: 4),
          Container(
             width: (MediaQuery.of(context).size.width) - 64,
            child: TextLabel(
              text: charger_name,
              fontSize: Utilities.sizeFontWithDesityForDisplay(
                  context, AppFontSize.superlarge),
              fontWeight: FontWeight.w700,
              color: AppTheme.blueDark,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
