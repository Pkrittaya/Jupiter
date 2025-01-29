import 'package:animated_styled_widget/animated_styled_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jupiter/src/apptheme.dart';
import 'package:jupiter/src/constant_value.dart';
import 'package:jupiter/src/images_asset.dart';
import 'package:jupiter/src/injection.dart';
import 'package:jupiter/src/jupiter_prefs_and_app_data.dart';
import 'package:jupiter/src/presentation/pages/map/map_page.dart';
import 'package:jupiter/src/presentation/widgets/route_planner/widgets/dash_line_vertical.dart';
import 'package:jupiter/src/presentation/widgets/text_label.dart';
import 'package:jupiter/src/utilities.dart';
import 'package:jupiter_api/domain/entities/favorite_route_item_entity.dart';

class ModalDetailRoute extends StatefulWidget {
  ModalDetailRoute(
      {Key? key,
      required this.onSaveRoute,
      required this.routePolylines,
      required this.indexSelectItem,
      required this.checkFavorite,
      required this.onActionFavorite,
      required this.routeFavorite,
      required this.checkLoadingVisible,
      required this.checkAndSetClickButton})
      : super(key: key);

  final Function() onSaveRoute;
  final RouteList routePolylines;
  final int indexSelectItem;
  final bool checkFavorite;
  final Function(String, String) onActionFavorite;
  final FavoriteRouteItemEntity? routeFavorite;
  final bool Function() checkLoadingVisible;
  final bool Function({bool? click}) checkAndSetClickButton;

  @override
  _ModalDetailRouteState createState() => _ModalDetailRouteState();
}

class _ModalDetailRouteState extends State<ModalDetailRoute> {
  JupiterPrefsAndAppData jupiterPrefsAndAppData = getIt();
  void alertConfirmDelete(BuildContext context) {
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    Utilities.alertTwoButtonAction(
      context: context,
      type: AppAlertType.WARNING,
      title: translate("map_page.route_planner.modal_detail.alert_title"),
      description: translate("map_page.route_planner.modal_detail.alert_desc"),
      textButtonLeft: translate("button.cancel"),
      textButtonRight: translate("button.confirm"),
      onPressButtonLeft: () {
        widget.checkAndSetClickButton(click: false);
        Navigator.of(context).pop();
      },
      onPressButtonRight: () {
        widget.checkAndSetClickButton(click: false);
        widget.onActionFavorite('DELETE', '${widget.routePolylines.nameRoute}');
        Navigator.of(context).pop();
      },
    );
    // });
  }

  String convertHoursAndMinutes(int time) {
    String text = '';
    int minutes = int.parse('${(time / 60).toStringAsFixed(0)}');

    int days = minutes ~/ (24 * 60);
    int remainingHours = (minutes % (24 * 60)) ~/ 60;
    int remainingMinutes = minutes % 60;

    if (days == 0) {
      if (remainingHours == 0) {
        text = '$remainingMinutes ${translate("map_page.route_planner.min")}';
      } else {
        text =
            '$remainingHours ${translate("map_page.route_planner.hr")} $remainingMinutes ${translate("map_page.route_planner.min")}';
      }
    } else {
      if (remainingHours == 0) {
        text =
            '$days ${translate("map_page.route_planner.day")} $remainingMinutes ${translate("map_page.route_planner.min")}';
      } else {
        text =
            '$days ${translate("map_page.route_planner.day")} $remainingHours ${translate("map_page.route_planner.hr")} $remainingMinutes ${translate("map_page.route_planner.min")}';
      }
    }
    return text;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableActuator(
      child: DraggableScrollableSheet(
        initialChildSize:
            (widget.routePolylines.listRoute.length < 3) ? 0.45 : 0.55,
        minChildSize: 0.25,
        maxChildSize: 0.9,
        builder: (BuildContext context, ScrollController scrollController) {
          return NotificationListener<OverscrollIndicatorNotification>(
              onNotification: (OverscrollIndicatorNotification overscroll) {
                overscroll.disallowIndicator();
                return true;
              },
              child: SingleChildScrollView(
                controller: scrollController,
                child: Stack(
                  children: [
                    Container(
                        height: MediaQuery.of(context).size.height * 0.9,
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
                        child: Padding(
                          padding: MediaQuery.of(context).viewInsets,
                          child: Container(
                            padding: const EdgeInsets.fromLTRB(25, 25, 25, 0),
                            child: NotificationListener<
                                    OverscrollIndicatorNotification>(
                                onNotification: (OverscrollIndicatorNotification
                                    overscroll) {
                                  overscroll.disallowIndicator();
                                  return true;
                                },
                                child: Column(
                                  children: [
                                    _headerAndIconClose(),
                                    const SizedBox(height: 8),
                                    _distanceRoute(),
                                    const SizedBox(height: 8),
                                    Expanded(
                                      child: SingleChildScrollView(
                                        child: _routeSeeDetail(),
                                      ),
                                    ),
                                    const SizedBox(height: 130),
                                  ],
                                )),
                          ),
                        )),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppTheme.black20,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          width: 60,
                          height: 4,
                        ),
                      ),
                    ),
                  ],
                ),
              ));
        },
      ),
    );
  }

  Widget _headerAndIconClose() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: TextLabel(
            text: (widget.routeFavorite != null)
                ? widget.routePolylines.nameRoute
                : translate("map_page.route_planner.route_detail"),
            fontWeight: FontWeight.bold,
            color: AppTheme.blueDark,
            fontSize: Utilities.sizeFontWithDesityForDisplay(
                context, AppFontSize.large),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        _bottonFavorite()
      ],
    );
  }

  Widget _bottonFavorite() {
    int check = widget.routePolylines.listRoute.indexWhere(
      (element) => element.latlng == LatLng(0, 0),
    );
    if (check >= 0) {
      return SizedBox.shrink();
    } else {
      return Container(
          width: 24,
          height: 24,
          child: InkWell(
              onTap: () {
                if (!(widget.checkLoadingVisible())) {
                  if (!(widget.checkAndSetClickButton())) {
                    widget.checkAndSetClickButton(click: true);
                    if (jupiterPrefsAndAppData.routeFavorite != null) {
                      alertConfirmDelete(context);
                    } else {
                      widget.onSaveRoute();
                      widget.checkAndSetClickButton(click: false);
                    }
                  }
                }
              },
              child: SvgPicture.asset(
                (jupiterPrefsAndAppData.routeFavorite != null)
                    ? ImageAsset.ic_heart_select
                    : ImageAsset.ic_heart,
                width: 18,
                colorFilter: ColorFilter.mode(
                    (jupiterPrefsAndAppData.routeFavorite != null)
                        ? AppTheme.blueD
                        : AppTheme.gray9CA3AF,
                    BlendMode.srcIn),
              )));
    }
  }

  Widget _distanceRoute() {
    double distance = widget.routePolylines.distance;
    String duration =
        convertHoursAndMinutes(widget.routePolylines.duration.toInt());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextLabel(
          text: translate("map_page.route_planner.distance"),
          color: AppTheme.black40,
          fontSize: Utilities.sizeFontWithDesityForDisplay(
              context, AppFontSize.large),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            TextLabel(
              text:
                  '${distance.toStringAsFixed(1)} ${translate("map_page.route_planner.km")}',
              color: AppTheme.black,
              fontSize: Utilities.sizeFontWithDesityForDisplay(
                  context, AppFontSize.normallarge),
            ),
            SizedBox(width: 10),
            TextLabel(
              text: '($duration)',
              color: AppTheme.black60,
              fontSize: Utilities.sizeFontWithDesityForDisplay(
                  context, AppFontSize.large),
            ),
          ],
        ),
      ],
    );
  }

  Widget imagePin(int index) {
    List<String> wordRoute = [
      'A',
      'B',
      'C',
      'D',
      'E',
      'F',
      'G',
      'H',
      'I',
      'J',
      'K',
      'L',
      'M',
      'N',
      'O',
      'P',
      'Q',
      'R',
      'S',
      'T',
      'U',
      'V',
      'W',
      'X',
      'Y',
      'Z'
    ];

    if (index == 0) {
      return Container(
        alignment: Alignment.topCenter,
        padding: EdgeInsets.only(left: 3),
        color: AppTheme.white,
        child: SvgPicture.asset(
          ImageAsset.ic_pin_current,
          width: 24,
          height: 24,
        ),
      );
    } else if (index != (widget.routePolylines.listRoute.length - 1)) {
      return Container(
          width: 24,
          height: 24,
          decoration:
              BoxDecoration(color: AppTheme.blueD, shape: BoxShape.circle),
          child: Center(
            child: TextLabel(
              text: wordRoute[index - 1],
              fontSize: AppFontSize.mini,
              color: AppTheme.white,
            ),
          ));
    } else {
      return Container(
        color: AppTheme.white,
        // padding: EdgeInsets.only(bottom: 8),
        child: SvgPicture.asset(
          ImageAsset.ic_pin_dest_B,
          width: 24,
          height: 24,
        ),
      );
    }
  }

  Widget _routeSeeDetail() {
    return Column(
        children: (widget.routePolylines.listRoute.length < 0)
            ? [SizedBox.square()]
            : widget.routePolylines.listRoute.mapIndexed((val, index) {
                return _routeItemSeeDetail(index, val.name);
              }).toList());
  }

  Widget _routeItemSeeDetail(int index, String address) {
    bool checkDistance = false;
    String distance = '';
    try {
      if (index < (widget.routePolylines.pointsRoute.length)) {
        String countDistance =
            '${(widget.routePolylines.pointsRoute[index].distance / 1000).toStringAsFixed(1)}';
        String countDuration = convertHoursAndMinutes(
            widget.routePolylines.pointsRoute[index].duration);

        distance =
            '${countDistance} ${translate("map_page.route_planner.km")} (${countDuration})';
        checkDistance = true;
      } else {
        checkDistance = false;
      }
    } catch (e) {
      checkDistance = false;
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(top: 8),
              width: 24,
              child: imagePin(index),
            ),
            const SizedBox(
              width: 16,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width - 130,
                    child: TextLabel(
                      text: '$address',
                      color: AppTheme.black80,
                      fontSize: Utilities.sizeFontWithDesityForDisplay(
                          context, AppFontSize.normal),
                      textStyleHeight: 1.25,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        checkDistance
            ? Row(
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 8),
                    width: 24,
                    height: 40,
                    child: DashLineVertical(
                      height: 35,
                      color: AppTheme.black20,
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  TextLabel(
                    text: '$distance',
                    color: AppTheme.black60,
                    fontSize: Utilities.sizeFontWithDesityForDisplay(
                        context, AppFontSize.normal),
                  ),
                ],
              )
            : SizedBox.shrink(),
      ],
    );
  }
}
