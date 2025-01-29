import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jupiter/src/apptheme.dart';
import 'package:jupiter/src/constant_value.dart';
import 'package:jupiter_api/domain/entities/charger_entity.dart';
import 'package:jupiter_api/domain/entities/connector_entity.dart';
import 'package:jupiter_api/domain/entities/station_details_entity.dart';
import 'package:jupiter/src/images_asset.dart';
import 'package:jupiter/src/presentation/pages/booking/reserve/booking_page.dart';
import 'package:jupiter/src/presentation/widgets/text_label.dart';
import 'package:jupiter/src/utilities.dart';

class ListConnecter extends StatefulWidget {
  ListConnecter({
    super.key,
    required this.stationData,
    required this.charger,
    required this.connector,
  });
  final StationDetailEntity? stationData;
  final ChargerEntity? charger;
  final ConnectorEntity? connector;
  @override
  State<ListConnecter> createState() => _ListConnecterState();
}

class _ListConnecterState extends State<ListConnecter> {
  String imageConnector = '';

  void onPressedBookingNow() {
    if (widget.connector?.connectorStatusActive != null &&
        widget.connector?.connectorStatusActive != ConstValue.MAINTENANCE &&
        widget.connector!.reserveStatus) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BookingPage(
            stationData: widget.stationData,
            charger: widget.charger,
            connector: widget.connector,
          ),
        ),
      );
    }
  }

  Color checkColorOtherFromStatus(String checkStatus) {
    switch (checkStatus) {
      case 'offline':
        return AppTheme.gray9CA3AF;
      default:
        return AppTheme.blueDark;
    }
  }

  _checkTypeConnector(connectPower, connectType) {
    switch (connectPower) {
      case 'AC':
        if (connectType == 'CS1') {
          imageConnector = ImageAsset.ic_ac_cs1;
        } else if (connectType == 'CS2') {
          imageConnector = ImageAsset.ic_ac_cs2;
        } else {
          imageConnector = ImageAsset.ic_ac_chadeMO;
        }
        break;
      case 'DC':
        if (connectType == 'CS1') {
          imageConnector = ImageAsset.ic_dc_cs1;
        } else if (connectType == 'CS2') {
          imageConnector = ImageAsset.ic_dc_cs2;
        } else {
          imageConnector = ImageAsset.ic_dc_chadeMO;
        }
        break;
      default:
        imageConnector = ImageAsset.ic_ac_chadeMO;
        break;
    }
    return imageConnector;
  }

  checkPositionConnector(position) {
    String text;
    switch (position) {
      case 'L':
        text = translate('check_in_page.charger_data.left');
        break;
      case 'R':
        text = translate('check_in_page.charger_data.right');
        break;
      default:
        text = translate('check_in_page.charger_data.middle');
        break;
    }
    return text;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppTheme.white,
      child: InkWell(
        highlightColor: AppTheme.black5,
        borderRadius: BorderRadius.circular(12),
        onTap: onPressedBookingNow,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.175,
                  child: Column(
                    children: [
                      SvgPicture.asset(
                        _checkTypeConnector(
                            widget.connector!.connectorPowerType,
                            widget.connector!.connectorType),
                        width: 30,
                        color: Utilities.getColorStatus(
                            '${widget.connector!.connectorStatusActive}'),
                      ),
                      const SizedBox(height: 4),
                      TextLabel(
                        fontWeight: FontWeight.w400,
                        fontSize: Utilities.sizeFontWithDesityForDisplay(
                            context, AppFontSize.small),
                        text:
                            '${Utilities.getWordStatus(widget.connector?.connectorStatusActive ?? 'N/A')}',
                        color: Utilities.getColorStatus(
                            '${widget.connector!.connectorStatusActive}'),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        TextLabel(
                            color: checkColorOtherFromStatus(
                                widget.connector?.connectorStatusActive ?? ''),
                            // text:'${chargerEntity?.chargerType} - ${connector?.connectorType}',
                            text: Utilities.nameConnecterType(
                                '${widget.connector!.connectorPowerType}',
                                '${widget.connector!.connectorType}'),
                            fontSize: Utilities.sizeFontWithDesityForDisplay(
                                context, AppFontSize.normal),
                            fontWeight: FontWeight.bold),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.only(left: 2, right: 2),
                          decoration: BoxDecoration(
                            color: checkColorOtherFromStatus(
                                widget.connector?.connectorStatusActive ?? ''),
                            borderRadius: BorderRadius.circular(2),
                            border: Border.all(
                              color: checkColorOtherFromStatus(
                                  widget.connector?.connectorStatusActive ??
                                      ''),
                            ),
                          ),
                          child: TextLabel(
                              fontSize: Utilities.sizeFontWithDesityForDisplay(
                                  context, AppFontSize.mini),
                              text: checkPositionConnector(
                                  widget.connector!.connectorPosition),
                              fontWeight: FontWeight.w400,
                              color: AppTheme.white),
                        ),
                      ],
                    ),
                    TextLabel(
                      fontWeight: FontWeight.w400,
                      fontSize: Utilities.sizeFontWithDesityForDisplay(
                          context, AppFontSize.normal),
                      text:
                          '${widget.connector!.connectorPower} • ${widget.connector!.connectorPrice}',
                      color: AppTheme.black40,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                widget.connector!.reserveStatus
                    ? Row(
                        children: [
                          TextLabel(
                            fontWeight: FontWeight.w400,
                            fontSize: Utilities.sizeFontWithDesityForDisplay(
                                context, AppFontSize.large),
                            text: translate('station_details_page.book'),
                            color: AppTheme.black40,
                          ),
                          const SizedBox(width: 4),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 12,
                            color: AppTheme.black40,
                          )
                        ],
                      )
                    : SizedBox(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
