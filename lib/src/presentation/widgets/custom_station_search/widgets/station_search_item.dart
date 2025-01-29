import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:jupiter/src/injection.dart';
import 'package:jupiter/src/jupiter_prefs_and_app_data.dart';
import 'package:jupiter/src/presentation/pages/map/map_page.dart';
import 'package:jupiter/src/presentation/widgets/image_network_jupiter.dart';
import 'package:jupiter_api/domain/entities/connect_type_power_entity.dart';
import 'package:jupiter_api/domain/entities/reserve_slot_entity.dart';
import 'package:jupiter_api/domain/entities/search_station_entity.dart';
import 'package:jupiter/src/images_asset.dart';
import '../../../../apptheme.dart';
import '../../../../constant_value.dart';
import '../../../../utilities.dart';
import '../../../pages/station_details/station_details_page.dart';
import '../../text_label.dart';
import 'dart:math' as math;

class StationSearchItem extends StatefulWidget {
  StationSearchItem(
      {super.key,
      this.searchStationEntity,
      required this.currentLocation,
      this.routePlanner,
      this.onSetModalInRoutePlannerPage,
      this.selectRouteItem,
      this.onSelectStation,
      this.checkClickStation});
  final SearchStationEntity? searchStationEntity;
  final Position currentLocation;

  // route planner
  final bool? routePlanner;
  final Function(String, bool)? onSetModalInRoutePlannerPage;
  final Function(RouteForm)? selectRouteItem;
  final Function(SearchStationEntity)? onSelectStation;
  final bool Function()? checkClickStation;

  @override
  State<StationSearchItem> createState() => _StationSearchItemState();
}

class _StationSearchItemState extends State<StationSearchItem> {
  Color colorStatus = AppTheme.gray9CA3AF;
  List<ConnectorTypeAndPowerEntity> result = [];
  bool checkStation = false;
  String imageConnector = '';
  JupiterPrefsAndAppData jupiterPrefsAndAppData = getIt();
  DateTime dateWeekNow = DateTime.now();
  List<ReserveSlotEntity> listduration = List.empty(growable: true);
  ReserveSlotEntity? chxDuration;
  SearchStationEntity detailNull = SearchStationEntity(
    stationId: '',
    stationName: '',
    position: [],
    eta: '',
    distance: '',
    openingHours: [],
    statusOpening: false,
    chargerStatus: '',
    connectorAvailable: 0,
    totalConnector: 0,
    images: '',
    connectorType: [],
  );

  bool chxDurationForDay() {
    checkDuration();
    var status = false;
    var durationDay = chxDuration?.status ?? false;
    var durationTime = widget.searchStationEntity?.statusOpening ?? false;
    if (durationDay && durationTime) {
      status = true;
    } else {
      status = false;
    }
    return status;
  }

  String chxDurationForTime() {
    checkDuration();
    var text = '';
    var durationDay = chxDuration?.status ?? false;
    var durationTime = widget.searchStationEntity?.statusOpening ?? false;
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

  // void groupEmployeesByCountryAndCity(
  //     List<ConnectorTypeAndPowerEntity> Connector) {
  //   final groups = groupBy(connectorType, (ConnectorTypeAndPowerEntity e) {
  //     return '';
  //   });

  //   print(groups);
  // }

//   main(List<String> args) {
//   var data = [
//     {"title": 'Avengers', "release_date": '10/01/2019'},
//     {"title": 'Creed', "release_date": '10/01/2019'},
//     {"title": 'Jumanji', "release_date": '30/10/2019'},
//   ];

//   var newMap = groupBy(data, (Map obj) => obj['release_date']);

//   print(newMap);
// }

  checkDuration() {
    if (widget.searchStationEntity?.openingHours != null) {
      debugPrint(
          'searchStationEntity : ${widget.searchStationEntity?.stationName}');
      listduration = widget.searchStationEntity!.openingHours;
      int searchduration = listduration
          .indexWhere((item) => (item.index + 1) == dateWeekNow.weekday);
      if (searchduration >= 0) {
        chxDuration = listduration[searchduration];
      }
    }
  }

  Future<void> _navigateStationDetailPage(context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => StationDetailPage(
          stationId: widget.searchStationEntity?.stationId ?? '',
        ),
      ),
    );
    if (jupiterPrefsAndAppData.navigateRoutePlanner) {
      Navigator.of(context).pop();
    }
  }

  void onClickStation() {
    // if ((widget.routePlanner ?? false) == true) {
    // func ตรวจสอบหากมีการกดปุ่มอื่นเช่น เลือกตำแหน่งปัจจุบันหรือเลือกบนแผนที่
    if (!(widget.checkClickStation ??
        () {
          return false;
        })()) {
      (widget.onSelectStation ??
          () {})(widget.searchStationEntity ?? detailNull);
      // (widget.onSetModalInRoutePlannerPage ?? () {})('SELECT_STATION', true);
      // Navigator.of(context).pop();
    }
    // } else {
    //   _navigateStationDetailPage(context);
    // }
  }

  @override
  void initState() {
    super.initState();
    checkDuration();
  }

  String getTextTotalConnector() {
    return '${Utilities.getWordStatus(widget.searchStationEntity!.chargerStatus)} ${widget.searchStationEntity!.connectorAvailable}/${widget.searchStationEntity!.totalConnector}';
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: ((widget.routePlanner ?? false) == true) ? 100 : 145,
      child: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Material(
                color: AppTheme.white,
                child: ((widget.routePlanner ?? false) == true)
                    ? InkWell(
                        borderRadius: BorderRadius.circular(16),
                        onTap: () {
                          onClickStation();
                        },
                        child: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: AppTheme.black5,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              margin:
                                  const EdgeInsets.only(left: 16, right: 12),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(4),
                                  child: SizedBox.fromSize(
                                    child: widget.searchStationEntity!.images ==
                                            ''
                                        ? Image.asset(
                                            ImageAsset.img_station_search_png,
                                            width: 65,
                                            height: double.infinity,
                                            fit: BoxFit.cover,
                                          )
                                        : ImageNetworkJupiter(
                                            url: widget
                                                .searchStationEntity!.images,
                                            width: 65,
                                            height: double.infinity,
                                            fit: BoxFit.cover,
                                          ),
                                  )),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.67,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  TextLabel(
                                    text: widget
                                            .searchStationEntity?.stationName ??
                                        '',
                                    fontSize:
                                        Utilities.sizeFontWithDesityForDisplay(
                                            context, AppFontSize.normal),
                                    fontWeight: FontWeight.bold,
                                    color: AppTheme.pttBlue,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: 5),
                                  Expanded(
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: widget.searchStationEntity!
                                          .connectorType.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        ConnectorTypeAndPowerEntity
                                            connectorEntity = widget
                                                .searchStationEntity!
                                                .connectorType[index];
                                        return Container(
                                          width: 40,
                                          alignment: Alignment.center,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Expanded(
                                                child: SvgPicture.asset(
                                                  _checkTypeConnector(
                                                      connectorEntity
                                                          .connectorPowerType,
                                                      connectorEntity
                                                          .connectorType),
                                                  width: 20,
                                                  // height: 24,
                                                  // colorFilter: ColorFilter.mode(AppTheme.pttBlue, BlendMode.srcIn),
                                                ),
                                              ),
                                              TextLabel(
                                                maxLines: 1,
                                                text:
                                                    Utilities.nameConnecterType(
                                                        connectorEntity
                                                            .connectorPowerType,
                                                        connectorEntity
                                                            .connectorType),
                                                fontSize: Utilities
                                                    .sizeFontWithDesityForDisplay(
                                                        context,
                                                        AppFontSize.little),
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
                      )
                    : InkWell(
                        borderRadius: BorderRadius.circular(16),
                        onTap: () {
                          _navigateStationDetailPage(context);
                        },
                        child: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: AppTheme.black5,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              margin:
                                  const EdgeInsets.only(left: 16, right: 12),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(4),
                                  child: SizedBox.fromSize(
                                    child: widget.searchStationEntity!.images ==
                                            ''
                                        ? Image.asset(
                                            ImageAsset.img_station_search_png,
                                            width: 110,
                                            height: double.infinity,
                                            fit: BoxFit.cover,
                                          )
                                        : ImageNetworkJupiter(
                                            url: widget
                                                .searchStationEntity!.images,
                                            width: 110,
                                            height: double.infinity,
                                            fit: BoxFit.cover,
                                          ),
                                    // Image.network(
                                    //     widget.searchStationEntity!.images,
                                    //     width: 110,
                                    //     height: double.infinity,
                                    //     fit: BoxFit.cover,
                                    //   )
                                  )),
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
                                    fontSize:
                                        Utilities.sizeFontWithDesityForDisplay(
                                            context, AppFontSize.little),
                                    fontWeight: FontWeight.bold,
                                    color: Utilities.getColorStatus(widget
                                            .searchStationEntity
                                            ?.chargerStatus ??
                                        ''),
                                  ),
                                  TextLabel(
                                    text: widget
                                            .searchStationEntity?.stationName ??
                                        '',
                                    fontSize:
                                        Utilities.sizeFontWithDesityForDisplay(
                                            context, AppFontSize.normal),
                                    fontWeight: FontWeight.bold,
                                    color: AppTheme.pttBlue,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  renderDurationAndDistance(),
                                  SizedBox(height: 5),
                                  Expanded(
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: widget.searchStationEntity!
                                          .connectorType.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        ConnectorTypeAndPowerEntity
                                            connectorEntity = widget
                                                .searchStationEntity!
                                                .connectorType[index];
                                        return Container(
                                          width: 40,
                                          alignment: Alignment.center,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Expanded(
                                                child: SvgPicture.asset(
                                                  _checkTypeConnector(
                                                      connectorEntity
                                                          .connectorPowerType,
                                                      connectorEntity
                                                          .connectorType),
                                                  width: 20,
                                                  // height: 24,
                                                  // colorFilter: ColorFilter.mode(AppTheme.pttBlue, BlendMode.srcIn),
                                                ),
                                              ),
                                              TextLabel(
                                                maxLines: 1,
                                                text:
                                                    Utilities.nameConnecterType(
                                                        connectorEntity
                                                            .connectorPowerType,
                                                        connectorEntity
                                                            .connectorType),
                                                fontSize: Utilities
                                                    .sizeFontWithDesityForDisplay(
                                                        context,
                                                        AppFontSize.little),
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
                        )),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget renderDurationAndDistance() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        durationItem(),
        (widget.currentLocation.latitude > 0 &&
                widget.currentLocation.longitude > 0)
            ? etaAndDistance(context)
            : SizedBox.shrink(),
      ],
    );
  }

  Widget durationItem() {
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
                "${widget.searchStationEntity?.distance ?? '0'} • ${widget.searchStationEntity?.eta ?? '0'}",
            fontSize: Utilities.sizeFontWithDesityForDisplay(
                context, AppFontSize.little),
          )),
        ],
      ),
    );
  }
}
