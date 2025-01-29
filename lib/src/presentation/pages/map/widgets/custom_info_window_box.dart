import 'package:flutter/material.dart';
import 'package:jupiter_api/domain/entities/connector_entity.dart';
import 'package:jupiter/src/presentation/pages/map/widgets/triangle_painter.dart';
import 'package:jupiter_api/domain/entities/station_details_entity.dart';

import '../../../../apptheme.dart';

import '../../../../utilities.dart';
import '../../../widgets/index.dart';
import '../../station_details/station_details_page.dart';
import 'dart:math' as math;

import 'info_window_connector_item.dart';

class CustomInfoWindowBox extends StatelessWidget {
  const CustomInfoWindowBox({
    super.key,
    required this.context,
    required this.stationId,
    required this.listConnector,
    required this.detail,
  });

  final BuildContext context;
  final String stationId;
  final List<ConnectorEntity> listConnector;
  final StationDetailEntity? detail;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        debugPrint("Info window tap");
        // Navigator.pushNamed(context, RouteNames.station_details);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => StationDetailPage(
              stationId: stationId,
            ),
            // Pass the arguments as part of the RouteSettings. The
            // DetailScreen reads the arguments from these settings.
            // settings: RouteSettings(
            //   arguments: todos[index],
            // ),
          ),
        );
      },
      child: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: AppTheme.white,
                borderRadius: BorderRadius.circular(5),
              ),
              width: double.infinity,
              height: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    TextLabel(
                      text: detail?.stationName ?? '',
                      fontSize:
                          Utilities.sizeFontWithDesityForDisplay(context, 16),
                      fontWeight: FontWeight.bold,
                      color: AppTheme.darkBlue,
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
                          Expanded(
                              child: TextLabel(
                            color: AppTheme.black40,
                            text: "${detail?.distance} (${detail?.eta})",
                            fontSize: Utilities.sizeFontWithDesityForDisplay(
                                context, 12),
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
                          // Expanded(
                          //     child: TextLabel(
                          //   color: AppTheme.black40,
                          //   text: detail?.openDuration ?? '24 hrs',
                          //   fontSize: Utilities.sizeFontWithDesityForDisplay(
                          //       context, 12),
                          // ))
                        ],
                      ),
                    ),
                    GridView.builder(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 80,
                                childAspectRatio: 3.5,
                                crossAxisSpacing: 8,
                                mainAxisSpacing: 8),
                        itemCount: listConnector.length,
                        itemBuilder: (BuildContext ctx, index) {
                          ConnectorEntity connectorEntity =
                              listConnector[index];
                          return InfoWindowConnectorItem(
                            connectorEntity: connectorEntity,
                          );
                        }),
                  ],
                ),
              ),
            ),
          ),
          CustomPaint(
            size: const Size(20, 10),
            painter: TrianglePainter(
              strokeColor: AppTheme.white,
              strokeWidth: 10,
              paintingStyle: PaintingStyle.fill,
            ),
          ),
        ],
      ),
    );
  }
}
