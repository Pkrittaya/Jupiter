import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:jupiter/src/apptheme.dart';
import 'package:jupiter/src/constant_value.dart';
import 'package:jupiter/src/injection.dart';
import 'package:jupiter/src/jupiter_prefs_and_app_data.dart';
import 'package:jupiter/src/presentation/widgets/image_network_jupiter.dart';
import 'package:jupiter_api/domain/entities/connect_type_power_entity.dart';
import 'package:jupiter_api/domain/entities/duration_entity.dart';
import 'package:jupiter_api/domain/entities/favorite_station_list_entily.dart';
import 'package:jupiter/src/images_asset.dart';
import 'package:jupiter/src/presentation/pages/favorite/cubit/favorite_cubit.dart';
import 'dart:math' as math;
import 'package:jupiter/src/presentation/pages/station_details/station_details_page.dart';
import 'package:jupiter/src/presentation/widgets/text_label.dart';
import 'package:jupiter/src/utilities.dart';

// ignore: must_be_immutable
class StationFavoriteItem extends StatelessWidget {
  StationFavoriteItem({
    super.key,
    this.StationEntity,
    required this.currentLocation,
  });

  final FavoriteStationListEntity? StationEntity;
  final Position currentLocation;

  JupiterPrefsAndAppData jupiterPrefsAndAppData = getIt();
  DateTime dateWeekNow = DateTime.now();
  List<DurationEntity> listduration = List.empty(growable: true);
  DurationEntity? chxDuration;

  bool chxDurationForDay() {
    var status = false;
    var durationDay = chxDuration?.status ?? false;
    var durationTime = StationEntity?.statusOpening ?? false;
    if (durationDay && durationTime) {
      status = true;
    } else {
      status = false;
    }
    return status;
  }

  String chxDurationForTime() {
    var text = '';
    var durationDay = chxDuration?.status ?? false;
    var durationTime = StationEntity?.statusOpening ?? false;
    if (durationDay && durationTime) {
      text = 'Close ${chxDuration?.end ?? ''}';
    } else if (durationDay && !durationTime) {
      text = 'Close ${chxDuration?.end ?? ''}';
    } else if (!durationDay && durationTime) {
      text = 'Close';
    } else if (!durationDay && !durationTime) {
      text = 'Close';
    }
    return text;
  }

  checkDuration() {
    if (StationEntity?.openingHours != null) {
      listduration = StationEntity!.openingHours;
      int searchduration = listduration
          .indexWhere((item) => (item.index + 1) == dateWeekNow.weekday);
      if (searchduration >= 0) {
        chxDuration = listduration[searchduration];
      }
    }
  }

  _checkTypeConnector(connectPower, connectType) {
    String imageConnector = '';
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

  _onTapStationDetail(context) {
    _navigateAndLoadFavorite(context);
  }

  String getTextTotalConnector() {
    return '${Utilities.getWordStatus(StationEntity!.chargerStatus)} ${StationEntity!.connectorAvailable}/${StationEntity!.totalConnector}';
  }

  Future<void> _navigateAndLoadFavorite(context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => StationDetailPage(
          stationId: StationEntity?.stationId ?? '',
        ),
      ),
    );
    if (jupiterPrefsAndAppData.navigateRoutePlanner) {
      Navigator.of(context).pop();
      Future.delayed(const Duration(milliseconds: 50), () {
        (jupiterPrefsAndAppData.onTapIndex ?? () {})(1);
      });
    } else {
      try {
        BlocProvider.of<FavoriteStationCubit>(context)
            .loadFavorite(currentLocation.latitude, currentLocation.longitude);
      } catch (e) {
        try {
          BlocProvider.of<FavoriteStationCubit>(context)
              .loadFavorite(13.76483333, 100.5382222);
        } catch (e) {
          BlocProvider.of<FavoriteStationCubit>(context).resetToInitialState();
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 145,
      child: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Material(
                color: AppTheme.white,
                child: InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: () {
                    _onTapStationDetail(context);
                  },
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: AppTheme.black5,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        margin: const EdgeInsets.only(left: 16, right: 12),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: SizedBox.fromSize(
                            child: StationEntity!.images == ''
                                ? Image.asset(
                                    ImageAsset.img_station_search_png,
                                    width: 110,
                                    height: double.infinity,
                                    fit: BoxFit.cover,
                                  )
                                : ImageNetworkJupiter(
                                    url: StationEntity!.images,
                                    fit: BoxFit.cover,
                                    width: 110,
                                    height: double.infinity,
                                  ),
                            // Image.network(
                            //     StationEntity!.images,
                            //     width: 110,
                            //     height: double.infinity,
                            //     fit: BoxFit.cover,
                            //   ),
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.55,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            TextLabel(
                              text: getTextTotalConnector(),
                              fontSize: Utilities.sizeFontWithDesityForDisplay(
                                  context, AppFontSize.little),
                              fontWeight: FontWeight.bold,
                              color: Utilities.getColorStatus(
                                  StationEntity!.chargerStatus),
                            ),
                            TextLabel(
                              text: StationEntity?.stationName ?? '',
                              fontSize: Utilities.sizeFontWithDesityForDisplay(
                                  context, AppFontSize.normal),
                              fontWeight: FontWeight.bold,
                              color: AppTheme.pttBlue,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            renderDurationAndDistance(context),
                            Expanded(
                              child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: StationEntity!.connectorType.length,
                                itemBuilder: (BuildContext context, int index) {
                                  ConnectorTypeAndPowerEntity connectorEntity =
                                      StationEntity!.connectorType[index];
                                  return Container(
                                    width: 45,
                                    alignment: Alignment.centerLeft,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(
                                          _checkTypeConnector(
                                              connectorEntity
                                                  .connectorPowerType,
                                              connectorEntity.connectorType),
                                          width: 24,
                                        ),
                                        TextLabel(
                                          maxLines: 1,
                                          text: Utilities.nameConnecterType(
                                              connectorEntity
                                                  .connectorPowerType,
                                              connectorEntity.connectorType),
                                          fontSize: Utilities
                                              .sizeFontWithDesityForDisplay(
                                                  context, AppFontSize.mini),
                                          fontWeight: FontWeight.w400,
                                          // color: AppTheme.pttBlue,
                                        )
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget renderDurationAndDistance(BuildContext context) {
    checkDuration();
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        durationItem(context),
        (currentLocation.latitude > 0 && currentLocation.longitude > 0)
            ? etaAndDistance(context)
            : SizedBox.shrink(),
      ],
    );
  }

  Widget durationItem(BuildContext context) {
    return Row(
      children: [
        (chxDurationForDay())
            ? TextLabel(
                color: AppTheme.green,
                text: 'Open',
                fontSize: Utilities.sizeFontWithDesityForDisplay(
                    context, AppFontSize.normal),
              )
            : SizedBox.shrink(),
        (chxDurationForDay())
            ? TextLabel(
                color: AppTheme.black40,
                text: ' • ',
                fontSize: Utilities.sizeFontWithDesityForDisplay(
                    context, AppFontSize.normal),
              )
            : SizedBox.shrink(),
        TextLabel(
          color: AppTheme.black40,
          text: chxDurationForTime(),
          fontSize: Utilities.sizeFontWithDesityForDisplay(
              context, AppFontSize.normal),
        ),
      ],
    );
  }

  Widget etaAndDistance(BuildContext context) {
    return Expanded(
      child: Row(
        children: [
          SizedBox(
            width: 5,
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Transform.rotate(
              angle: 40 * math.pi / 180,
              child: const Icon(
                Icons.navigation,
                color: AppTheme.black40,
                size: 16,
              ),
            ),
          ),
          Expanded(
              child: TextLabel(
            color: AppTheme.black40,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            text:
                "${StationEntity?.distance ?? '0'} • ${StationEntity?.eta ?? '0'}",
            fontSize: Utilities.sizeFontWithDesityForDisplay(
                context, AppFontSize.little),
          )),
        ],
      ),
    );
  }
}
