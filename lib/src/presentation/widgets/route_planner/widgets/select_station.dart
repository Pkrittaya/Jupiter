import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jupiter/src/apptheme.dart';
import 'package:jupiter/src/constant_value.dart';
import 'package:jupiter/src/images_asset.dart';
import 'package:jupiter/src/presentation/pages/station_details/widgets/page_image_indicator.dart';
import 'package:jupiter/src/presentation/pages/station_details/widgets/page_view_image.dart';
import 'package:jupiter/src/presentation/widgets/index.dart';
import 'package:jupiter/src/utilities.dart';
import 'package:jupiter_api/domain/entities/connect_type_power_entity.dart';
import 'package:jupiter_api/domain/entities/duration_entity.dart';
import 'package:jupiter_api/domain/entities/station_details_entity.dart';

import 'dart:math' as math;

class SelectStation extends StatefulWidget {
  const SelectStation(
      {Key? key,
      required this.onSetModalInRoutePlannerPage,
      required this.onPressedAddMarker,
      required this.floatLocation,
      required this.detail,
      this.onTapStationDetail,
      required this.isPermissionLocation,
      required this.selectRouteItem})
      : super(key: key);

  final Function(String, bool) onSetModalInRoutePlannerPage;
  final Function(String) onPressedAddMarker;
  final Widget floatLocation;

  // detail station
  final StationDetailEntity? detail;
  final Function()? onTapStationDetail;
  final bool isPermissionLocation;
  final Function(int) selectRouteItem;

  @override
  State<SelectStation> createState() => _SelectStationState();
}

class _SelectStationState extends State<SelectStation> {
  // bool addLocation = false;

  PageController _pageController = new PageController(initialPage: 0);
  int activePage = 0;

  void onPageChanged(int page) {
    setState(() {
      activePage = page;
    });
  }

  // detail station
  Color colorStatus = AppTheme.gray9CA3AF;
  String imageConnector = '';
  DurationEntity? chxDuration;
  String durationFullTime = '23:59';
  List<String> imageList = List.empty(growable: true);

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

  List<String> imageStation() {
    imageList.clear();
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
    return imageList;
  }

  @override
  void initState() {
    super.initState();
  }

  String getTextTotalConnector() {
    return '${Utilities.getWordStatus(widget.detail?.statusMarker ?? 'N/A')} ${widget.detail?.connectorAvailable}/${widget.detail?.totalConnector}';
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 60,
          left: 20,
          child: InkWell(
            onTap: () {
              widget.onSetModalInRoutePlannerPage('SELECT_STATION', false);
            },
            child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                    color: AppTheme.black.withOpacity(0.7),
                    shape: BoxShape.circle),
                child: Center(
                  child: Icon(
                    Icons.close,
                    color: AppTheme.white,
                    size: 20,
                  ),
                )),
          ),
        ),
        Positioned(
          bottom: 130,
          left: 16,
          right: 16,
          child: Column(
            children: [
              Align(
                alignment: Alignment.bottomRight,
                child: widget.floatLocation,
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  width: MediaQuery.of(context).size.width,
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
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Opacity(
                            opacity: (widget.detail?.statusMarker ?? '') ==
                                    ConstValue.MAINTENANCE
                                ? 0.5
                                : 1,
                            child: Container(
                              height: 140,
                              child: Stack(
                                alignment: AlignmentDirectional.bottomEnd,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: PageViewImage(
                                      pageController: _pageController,
                                      onPageChanged: onPageChanged,
                                      imageList: imageStation(),
                                      isLoading: false,
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(bottom: 10),
                                    child: PageImageIndicator(
                                      imageList: imageStation(),
                                      pageController: _pageController,
                                      activePage: activePage,
                                      isLoading: false,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Visibility(
                            visible: (widget.detail?.statusMarker ?? '') ==
                                ConstValue.MAINTENANCE,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: AppTheme.brown.withOpacity(0.65),
                              ),
                              width: double.infinity,
                              height: 140,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.build_circle,
                                    size: 50,
                                    color: AppTheme.white,
                                  ),
                                  const SizedBox(height: 4),
                                  TextLabel(
                                    text: translate(
                                        'station_details_page.status_charger.maintenance'),
                                    fontSize:
                                        Utilities.sizeFontWithDesityForDisplay(
                                            context, AppFontSize.big),
                                    fontWeight: FontWeight.bold,
                                    color: AppTheme.white,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Stack(
                        children: [
                          Container(
                            padding: EdgeInsets.only(top: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                TextLabel(
                                  text: '${widget.detail?.stationName}',
                                  fontSize:
                                      Utilities.sizeFontWithDesityForDisplay(
                                          context, AppFontSize.large),
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme.pttBlue,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Row(
                                  children: [
                                    renderObjectLeft(),
                                    renderDivider(),
                                    renderObjectRight()
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      (widget.detail != null)
                          ? addLocation()
                          : SizedBox.shrink(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget renderObjectLeft() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextLabel(
            text: getTextTotalConnector(),
            fontSize: Utilities.sizeFontWithDesityForDisplay(
                context, AppFontSize.normal),
            fontWeight: FontWeight.bold,
            color: Utilities.getColorStatus(widget.detail?.statusMarker ?? ''),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Container(
                height: 40,
                width: MediaQuery.of(context).size.width * 0.39,
                child: (widget.detail?.connectorType.length != null)
                    ? ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: widget.detail?.connectorType.length,
                        itemBuilder: (BuildContext context, int index) {
                          ConnectorTypeAndPowerEntity connectorEntity =
                              widget.detail?.connectorType[index] ??
                                  ConnectorTypeAndPowerEntity(
                                      connectorType: '',
                                      connectorPowerType: '');
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  _checkTypeConnector(
                                      connectorEntity.connectorPowerType,
                                      connectorEntity.connectorType),
                                  width: 24,
                                ),
                                TextLabel(
                                  maxLines: 1,
                                  text: Utilities.nameConnecterType(
                                      connectorEntity.connectorPowerType,
                                      connectorEntity.connectorType),
                                  fontSize:
                                      Utilities.sizeFontWithDesityForDisplay(
                                          context, AppFontSize.mini),
                                  fontWeight: FontWeight.w400,
                                  // color: AppTheme.pttBlue,
                                )
                              ],
                            ),
                          );
                        },
                      )
                    : SizedBox.shrink(),
              )
            ],
          ),
        ],
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
        height: 50, child: VerticalDivider(color: AppTheme.gray9CA3AF));
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
                    context, AppFontSize.large),
              )
            : SizedBox.shrink(),
        ((chxDuration?.duration ?? '') != durationFullTime)
            ? TextLabel(
                color: AppTheme.black40,
                text: chxDurationForTime(),
                fontSize: Utilities.sizeFontWithDesityForDisplay(
                    context, AppFontSize.large),
              )
            : SizedBox.shrink(),
      ],
    );
  }

  Widget addLocation() {
    return InkWell(
      onTap: () {
        widget.onPressedAddMarker('SELECT_STATION');
        widget.onSetModalInRoutePlannerPage('SELECT_STATION', false);
      },
      child: Container(
        padding: EdgeInsets.all(10),
        width: double.infinity,
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              ImageAsset.ic_pin_marker_white,
              width: 16,
              height: 16,
            ),
            SizedBox(
              width: 10,
            ),
            TextLabel(
              text: translate("map_page.route_planner.add_location"),
              color: AppTheme.white,
              fontSize: Utilities.sizeFontWithDesityForDisplay(
                  context, AppFontSize.normal),
              fontWeight: FontWeight.w500,
            ),
          ],
        ),
      ),
    );
  }
}
