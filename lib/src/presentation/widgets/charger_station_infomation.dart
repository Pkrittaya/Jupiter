import 'package:flutter/material.dart';
import 'package:jupiter/src/presentation/widgets/text_label.dart';

import '../../apptheme.dart';

class ChargerStationInfomation extends StatelessWidget {
  const ChargerStationInfomation({
    super.key,
    required this.stationName,
    required this.chargerName,
    required this.chargerId,
    required this.totolConnector,
  });
  final String stationName;
  final String chargerName;
  final String chargerId;
  final int totolConnector;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(
          Icons.ev_station,
          size: 46,
          color: AppTheme.darkBlue,
        ),
        const SizedBox(
          width: 8,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextLabel(
              text: stationName,
              fontSize: 20,
              color: AppTheme.darkBlue,
            ),
            TextLabel(
              text: chargerName,
              fontSize: 18,
              color: AppTheme.pttBlue,
            ),
            Row(
              children: [
                TextLabel(
                  color: AppTheme.black40,
                  text: "ID : $chargerId",
                  fontSize: 16,
                ),
                SizedBox(
                  width: 8,
                ),
                TextLabel(
                  color: AppTheme.black40,
                  text: "Socket : $totolConnector",
                  fontSize: 16,
                ),
              ],
            )
          ],
        )
      ],
    );
  }
}
