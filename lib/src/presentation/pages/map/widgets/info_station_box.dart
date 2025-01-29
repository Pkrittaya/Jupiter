import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jupiter/src/constant_value.dart';
import 'package:jupiter/src/injection.dart';
import 'package:jupiter/src/jupiter_prefs_and_app_data.dart';
import 'package:jupiter_api/domain/entities/connect_type_power_entity.dart';
import 'package:jupiter_api/domain/entities/connector_entity.dart';
import 'package:jupiter_api/domain/entities/duration_entity.dart';
import 'package:jupiter/src/images_asset.dart';
import 'package:jupiter/src/presentation/pages/map/cubit/map_cubit.dart';
import 'package:jupiter/src/presentation/pages/map/widgets/page_image_indicator.dart';
import 'package:jupiter/src/presentation/pages/map/widgets/page_view_image.dart';
import 'package:jupiter_api/domain/entities/station_details_entity.dart';
import '../../../../apptheme.dart';
import '../../../../utilities.dart';
import '../../../widgets/index.dart';
import '../../station_details/station_details_page.dart';
import 'dart:math' as math;

class InfoStationBox extends StatefulWidget {
  InfoStationBox({
    super.key,
    // required this.context,
    // required this.stationId,
    required this.listConnector,
    required this.detail,
    required this.favoriteStation,
    this.onTapStationDetail,
    // required this.statusMarker,
    // required this.connectorAvailable,
    required this.isPermissionLocation,
    this.getNavigateRoutePlannerFromOtherPage,
  });

  // final BuildContext context;
  // final String stationId;
  final List<ConnectorEntity> listConnector;
  final StationDetailEntity? detail;
  // final String statusMarker;
  // final double connectorAvailable;
  final bool favoriteStation;
  final Function()? onTapStationDetail;
  final bool isPermissionLocation;
  final Function()? getNavigateRoutePlannerFromOtherPage;

  @override
  State<InfoStationBox> createState() => _InfoStationBoxState();
}

class _InfoStationBoxState extends State<InfoStationBox> {
  Color colorStatus = AppTheme.gray9CA3AF;
  String imageConnector = '';
  String durationFullTime = '23:59';
  PageController _pageController = new PageController(initialPage: 0);
  int activePage = 0;
  List<String> imageList = List.empty(growable: true);
  DateTime dateWeekNow = DateTime.now();
  List<DurationEntity> listduration = List.empty(growable: true);
  DurationEntity? chxDuration;
  JupiterPrefsAndAppData jupiterPrefsAndAppData = getIt();

  bool chxDurationForDay() {
    var status = false;
    var durationDay = chxDuration?.status ?? false;
    var durationTime = widget.detail?.statusOpening ?? false;
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
    var durationTime = widget.detail?.statusOpening ?? false;
    if (durationDay && durationTime) {
      text = ' • Close ${chxDuration?.end ?? ''}';
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
    int searchduration = listduration
        .indexWhere((item) => (item.index + 1) == dateWeekNow.weekday);
    if (searchduration >= 0) {
      chxDuration = listduration[searchduration];
    }
  }

  void onPageChanged(int page) {
    setState(() {
      activePage = page;
    });
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

  _addImageStation() {
    if (widget.detail?.images != null) {
      if (widget.detail!.images!.length != 0) {
        for (var i = 0; i < widget.detail!.images!.length; i++) {
          imageList.add(widget.detail!.images![i]);
        }
      } else {
        imageList.add('');
      }
    } else {
      imageList.add('');
    }
  }

  void onPressdSaveUpdateFavoriteStation(
      BuildContext widgetContext, String stationId, String stationName) {
    BlocProvider.of<MapCubit>(widgetContext)
        .updateFavorite(stationId: stationId, stationName: stationName);
  }

  void onPressedNavigation() {
    Utilities.mapNavigateTo(
        widget.detail?.position[0] ?? 0, widget.detail?.position[1] ?? 0);
  }

  Future<void> navigateStationDetailPage(context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => StationDetailPage(
          stationId: widget.detail?.stationId ?? '',
          fromMapPage: true,
        ),
      ),
    );
    if (jupiterPrefsAndAppData.navigateRoutePlanner) {
      (widget.getNavigateRoutePlannerFromOtherPage ?? () {})();
    }
  }

  @override
  void initState() {
    super.initState();
    listduration = widget.detail!.openingHours;
    _addImageStation();
    checkDuration();
  }

  String getTextTotalConnector() {
    return '${Utilities.getWordStatus(widget.detail?.statusMarker ?? 'N/A')} ${widget.detail?.connectorAvailable}/${widget.detail?.totalConnector}';
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.onTapStationDetail!();
        navigateStationDetailPage(context);
      },
      child: Padding(
        padding: EdgeInsets.only(left: 10, right: 10, bottom: 140),
        child: Container(
          decoration: BoxDecoration(
            color: AppTheme.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: AppTheme.black.withOpacity(0.5),
                blurRadius: 8,
                offset: Offset(0, 0),
              ),
            ],
          ),
          width: double.infinity,
          height: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Stack(
                  alignment: AlignmentDirectional.bottomEnd,
                  children: [
                    PageViewImage(
                      pageController: _pageController,
                      onPageChanged: onPageChanged,
                      imageList: imageList,
                      stationStatus: widget.detail?.statusMarker ?? '',
                    ),
                    Container(
                      padding: EdgeInsets.only(bottom: 10),
                      child: PageImageIndicator(
                        imageList: imageList,
                        pageController: _pageController,
                        activePage: activePage,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: Stack(
                    children: [
                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            TextLabel(
                              text: widget.detail?.stationName ?? '',
                              fontSize: Utilities.sizeFontWithDesityForDisplay(
                                  context, AppFontSize.large),
                              fontWeight: FontWeight.bold,
                              color: AppTheme.pttBlue,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Expanded(
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4),
                                child: Row(
                                  children: [
                                    renderObjectLeft(),
                                    renderDivider(),
                                    renderObjectRight(),
                                  ],
                                ),
                              ),
                            ),
                            addLocation(),
                          ],
                        ),
                      ),
                      buttonFavorite()
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget renderObjectLeft() {
    return Expanded(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextLabel(
              text: getTextTotalConnector(),
              fontSize: Utilities.sizeFontWithDesityForDisplay(
                  context, AppFontSize.big),
              fontWeight: FontWeight.bold,
              color:
                  Utilities.getColorStatus(widget.detail?.statusMarker ?? ''),
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: widget.detail!.connectorType.length,
                itemBuilder: (BuildContext context, int index) {
                  ConnectorTypeAndPowerEntity connectorEntity =
                      widget.detail!.connectorType[index];
                  return Container(
                    width: 40,
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          _checkTypeConnector(
                              connectorEntity.connectorPowerType,
                              connectorEntity.connectorType),
                          width: 24,
                          height: 24,
                        ),
                        TextLabel(
                          maxLines: 1,
                          text: Utilities.nameConnecterType(
                              connectorEntity.connectorPowerType,
                              connectorEntity.connectorType),
                          fontSize: Utilities.sizeFontWithDesityForDisplay(
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
    );
  }

  Widget renderObjectRight() {
    return Expanded(
      child: Container(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          renderDuration(),
          (widget.isPermissionLocation)
              ? Row(
                  children: [
                    Transform.rotate(
                      angle: 40 * math.pi / 180,
                      child: const Icon(
                        Icons.navigation,
                        color: AppTheme.black40,
                        size: 14,
                      ),
                    ),
                    TextLabel(
                      color: AppTheme.black40,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      text:
                          "${widget.detail?.distance} • ${widget.detail?.eta}",
                      fontSize: Utilities.sizeFontWithDesityForDisplay(
                          context, AppFontSize.normal),
                    )
                  ],
                )
              : SizedBox.shrink()
        ],
      )),
    );
  }

  Widget renderDivider() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: VerticalDivider(color: AppTheme.gray9CA3AF),
    );
  }

  Widget renderDuration() {
    return Row(
      children: [
        (chxDurationForDay())
            ? TextLabel(
                color: AppTheme.green,
                text: ((chxDuration?.duration ?? '') == durationFullTime)
                    ? 'Open 24 Hours'
                    : 'Open',
                fontSize: Utilities.sizeFontWithDesityForDisplay(
                    context, AppFontSize.big),
              )
            : SizedBox.shrink(),
        ((chxDuration?.duration ?? '') != durationFullTime)
            ? TextLabel(
                color: AppTheme.black40,
                text: chxDurationForTime(),
                fontSize: Utilities.sizeFontWithDesityForDisplay(
                    context, AppFontSize.big),
              )
            : SizedBox.shrink(),
      ],
    );
  }

  Widget buttonFavorite() {
    return Align(
      alignment: Alignment.topRight,
      child: Container(
          width: 24,
          height: 24,
          child: InkWell(
              onTap: () {
                onPressdSaveUpdateFavoriteStation(context,
                    widget.detail!.stationId, widget.detail!.stationName);
              },
              // elevation: 2.0,
              // fillColor: AppTheme.white,
              // shape: const CircleBorder(),
              child: SvgPicture.asset(
                widget.favoriteStation
                    ? ImageAsset.ic_heart_select
                    : ImageAsset.ic_heart,
                width: 18,
                colorFilter: ColorFilter.mode(
                    widget.favoriteStation
                        ? AppTheme.blueD
                        : AppTheme.gray9CA3AF,
                    BlendMode.srcIn),
              ))),
    );
  }

  Widget addLocation() {
    return Container(
      padding: const EdgeInsets.only(top: 6),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              jupiterPrefsAndAppData.detailForRoute = widget.detail;
              jupiterPrefsAndAppData.navigateRoutePlanner = true;
              (widget.getNavigateRoutePlannerFromOtherPage ?? () {})();
            },
            child: Row(
              children: [
                Container(
                  height: 32,
                  decoration: BoxDecoration(
                    color: AppTheme.blueD,
                    border: Border.all(color: AppTheme.blueD, width: 1),
                    borderRadius: BorderRadius.all(Radius.circular(200)),
                    boxShadow: [
                      BoxShadow(
                        color: AppTheme.gray9CA3AF,
                        offset: Offset(0, 0),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 8,
                      ),
                      SvgPicture.asset(
                        ImageAsset.ic_navigate_route,
                        width: 20,
                        height: 20,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      TextLabel(
                        text: translate('map_page.route_planner.route'),
                        color: AppTheme.white,
                        fontSize: Utilities.sizeFontWithDesityForDisplay(
                            context, AppFontSize.normal),
                        fontWeight: FontWeight.w500,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 14,
          ),
          InkWell(
            onTap: () {
              onPressedNavigation();
            },
            child: Row(
              children: [
                Container(
                  height: 32,
                  decoration: BoxDecoration(
                    color: AppTheme.white,
                    border: Border.all(color: AppTheme.blueD, width: 1),
                    borderRadius: BorderRadius.all(Radius.circular(200)),
                    boxShadow: [
                      BoxShadow(
                        color: AppTheme.gray9CA3AF,
                        offset: Offset(0, 0),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 8,
                      ),
                      SvgPicture.asset(
                        ImageAsset.ic_navigation,
                        width: 20,
                        height: 20,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      TextLabel(
                        text: translate(
                            'station_details_page.button.get_direction'),
                        color: AppTheme.blueD,
                        fontSize: Utilities.sizeFontWithDesityForDisplay(
                            context, AppFontSize.normal),
                        fontWeight: FontWeight.w500,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
