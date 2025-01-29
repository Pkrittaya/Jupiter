import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jupiter/src/apptheme.dart';
import 'package:jupiter/src/constant_value.dart';
import 'package:jupiter_api/domain/entities/connector_entity.dart';
import 'package:jupiter_api/domain/entities/station_details_entity.dart';
import 'package:jupiter/src/images_asset.dart';
import 'package:jupiter/src/presentation/widgets/text_label.dart';
import 'package:jupiter/src/utilities.dart';

class BookingStationName extends StatefulWidget {
  const BookingStationName({
    super.key,
    this.stationData,
    this.connector,
  });

  final ConnectorEntity? connector;
  final StationDetailEntity? stationData;

  @override
  State<BookingStationName> createState() => _BookingStationNameState();
}

class _BookingStationNameState extends State<BookingStationName> {
  String getConnectorType(String connectPower, String connectType) {
    switch (connectPower) {
      case 'AC':
        if (connectType == 'CS1') {
          return ImageAsset.ic_ac_cs1;
        } else if (connectType == 'CS2') {
          return ImageAsset.ic_ac_cs2;
        } else {
          return ImageAsset.ic_ac_chadeMO;
        }
      case 'DC':
        if (connectType == 'CS1') {
          return ImageAsset.ic_dc_cs1;
        } else if (connectType == 'CS2') {
          return ImageAsset.ic_dc_cs2;
        } else {
          return ImageAsset.ic_dc_chadeMO;
        }
      default:
        return ImageAsset.ic_ac_chadeMO;
    }
  }

  String checkPositionConnector(String position) {
    switch (position) {
      case 'L':
        return translate('check_in_page.charger_data.left');
      case 'R':
        return translate('check_in_page.charger_data.right');
      default:
        return translate('check_in_page.charger_data.middle');
    }
  }

  Widget renderStationName() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.7,
            child: TextLabel(
              text: '${widget.stationData?.stationName}',
              color: AppTheme.blueDark,
              fontSize: Utilities.sizeFontWithDesityForDisplay(
                  context, AppFontSize.normal),
              fontWeight: FontWeight.bold,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.125,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // TextLabel(
                //   text: '${widget.stationData?.distance}',
                //   color: AppTheme.black40,
                //   fontSize: Utilities.sizeFontWithDesityForDisplay(
                //       context, AppFontSize.small),
                //   overflow: TextOverflow.ellipsis,
                //   maxLines: 1,
                // ),
                // SizedBox(width: 4),
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(200),
                    color: AppTheme.blueD,
                  ),
                  child: SvgPicture.asset(
                    ImageAsset.ic_route,
                    width: 14,
                    height: 14,
                    color: AppTheme.white,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget renderConnector() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      getConnectorType(widget.connector!.connectorPowerType,
                          widget.connector!.connectorType),
                      width: 30,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      TextLabel(
                        color: AppTheme.blueDark,
                        text: Utilities.nameConnecterType(
                            widget.connector!.connectorPowerType,
                            widget.connector!.connectorType),
                        fontSize: Utilities.sizeFontWithDesityForDisplay(
                            context, AppFontSize.normal),
                        fontWeight: FontWeight.bold,
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.only(left: 2, right: 2),
                        decoration: BoxDecoration(
                          color: AppTheme.blueDark,
                          borderRadius: BorderRadius.circular(2),
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
                        context, AppFontSize.little),
                    text:
                        '${widget.connector!.connectorPower} • ${widget.connector!.connectorPrice}',
                    color: AppTheme.black40,
                  ),
                ],
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextLabel(
                fontWeight: FontWeight.w400,
                fontSize: Utilities.sizeFontWithDesityForDisplay(
                    context, AppFontSize.small),
                text:
                    '${Utilities.getWordStatus(widget.connector?.connectorStatusActive ?? 'N/A')}',
                color: Utilities.getColorStatus(
                    widget.connector?.connectorStatusActive ?? 'N/A'),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget renderDivider() {
    return Container(
      height: 1,
      color: AppTheme.borderGray,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      decoration: BoxDecoration(
        color: AppTheme.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          width: 1,
          color: AppTheme.borderGray,
        ),
      ),
      child: Column(
        children: [
          renderStationName(),
          renderDivider(),
          renderConnector(),
        ],
      ),
    );
  }
}
