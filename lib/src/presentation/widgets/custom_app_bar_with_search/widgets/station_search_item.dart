import 'package:flutter/material.dart';
import 'package:jupiter_api/domain/entities/search_station_entity.dart';
import '../../../../apptheme.dart';
import '../../../../utilities.dart';
import '../../../pages/station_details/station_details_page.dart';
import '../../text_label.dart';
import 'dart:math' as math;

class StationSearchItem extends StatelessWidget {
  const StationSearchItem({
    super.key,
    this.searchStationEntity,
  });

  final SearchStationEntity? searchStationEntity;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55,
      child: ListTile(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => StationDetailPage(
                  stationId: searchStationEntity?.stationId ?? '',
                ),
                // Pass the arguments as part of the RouteSettings. The
                // DetailScreen reads the arguments from these settings.
                // settings: RouteSettings(
                //   arguments: todos[index],
                // ),
              ),
            );
          },
          leading: Icon(
            Icons.ev_station,
            size: 32,
            color: Utilities.getColorStatus(
              searchStationEntity?.chargerStatus ?? '',
            ),
          ),
          title: Container(
            padding: const EdgeInsets.all(8),
            height: 60,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: TextLabel(
                    text: searchStationEntity?.stationName ?? '',
                    fontSize:
                        Utilities.sizeFontWithDesityForDisplay(context, 18),
                    fontWeight: FontWeight.bold,
                    color: AppTheme.darkBlue,
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      Transform.rotate(
                        angle: 40 * math.pi / 180,
                        child: const Icon(
                          Icons.navigation,
                          color: AppTheme.black40,
                          size: 14,
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Flexible(
                          child: TextLabel(
                        color: AppTheme.black40,
                        text:
                            '${searchStationEntity?.distance} (${searchStationEntity?.eta})',
                        fontSize:
                            Utilities.sizeFontWithDesityForDisplay(context, 14),
                      )),
                      const SizedBox(
                        width: 16,
                      ),
                      const Icon(
                        Icons.access_time_filled,
                        color: AppTheme.black40,
                        size: 14,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Flexible(
                          child: TextLabel(
                        color: AppTheme.black40,
                        // text: searchStationEntity?.openDuration ?? '',
                        text: '-',
                        fontSize:
                            Utilities.sizeFontWithDesityForDisplay(context, 14),
                      ))
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
