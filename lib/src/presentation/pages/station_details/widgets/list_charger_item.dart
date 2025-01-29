import 'package:flutter/material.dart';
import 'package:jupiter/src/apptheme.dart';
import 'package:jupiter/src/constant_value.dart';
import 'package:jupiter_api/domain/entities/charger_entity.dart';
import 'package:jupiter_api/domain/entities/station_details_entity.dart';
import 'package:jupiter/src/presentation/pages/station_details/widgets/list_connector.dart';
import 'package:jupiter/src/presentation/widgets/charger_information.dart';
import 'package:jupiter/src/utilities.dart';

class ListCharger extends StatefulWidget {
  ListCharger({
    super.key,
    required this.stationData,
    required this.charger,
  });

  final StationDetailEntity? stationData;
  final ChargerEntity? charger;
  @override
  State<ListCharger> createState() => _ListChargerState();
}

class _ListChargerState extends State<ListCharger> {
  Color colorStatus = AppTheme.gray9CA3AF;
  String imageConnector = '';
  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
          color: AppTheme.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppTheme.borderGray)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding:
                const EdgeInsets.only(left: 16, right: 16, top: 12, bottom: 4),
            child: ChargerInfomation(
              iconSize: Utilities.sizeFontWithDesityForDisplay(
                  context, AppFontSize.xxl),
              chargerStatus: '',
              chargerBrand:
                  '${widget.charger!.chargerName} - ${widget.charger!.chargerId}',
              chargerId: widget.charger?.chargerId ?? '',
              totalConnector: widget.charger?.totalConnector ?? 0,
            ),
          ),
          renderDivider(4, 4),
          Container(
            padding:
                const EdgeInsets.only(left: 12, right: 12, top: 8, bottom: 0),
            child: Column(
              children: widget.charger!.connector.map((connectorlist) {
                return Column(
                  children: [
                    ListConnecter(
                      stationData: widget.stationData,
                      charger: widget.charger,
                      connector: connectorlist,
                    ),
                    SizedBox(
                      height: 12,
                    )
                  ],
                );
              }).toList(),
            ),
          )
        ],
      ),
    );
  }

  Widget renderDivider(double top, double bottom) {
    return Container(
      height: 1,
      margin: EdgeInsets.only(top: top, bottom: bottom),
      color: AppTheme.borderGray,
    );
  }
}
