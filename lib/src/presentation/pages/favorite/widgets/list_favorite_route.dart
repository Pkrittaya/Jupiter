import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jupiter/src/apptheme.dart';
import 'package:jupiter/src/constant_value.dart';
import 'package:jupiter/src/images_asset.dart';
import 'package:jupiter/src/injection.dart';
import 'package:jupiter/src/jupiter_prefs_and_app_data.dart';
import 'package:jupiter/src/presentation/widgets/route_planner/widgets/dash_line_vertical.dart';
import 'package:jupiter/src/presentation/widgets/text_label.dart';
import 'package:jupiter/src/utilities.dart';
import 'package:jupiter_api/domain/entities/favorite_route_item_entity.dart';
import 'package:jupiter_api/domain/entities/favorite_route_point_entity.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ListFavoriteRoute extends StatefulWidget {
  const ListFavoriteRoute(
      {Key? key,
      required this.routeList,
      required this.loading,
      this.fromMapPage,
      required this.onSlide})
      : super(key: key);

  final List<FavoriteRouteItemEntity> routeList;
  final bool loading;
  final bool? fromMapPage;
  final Function(BuildContext, String) onSlide;

  @override
  _ListFavoriteRouteState createState() => _ListFavoriteRouteState();
}

class _ListFavoriteRouteState extends State<ListFavoriteRoute> {
  JupiterPrefsAndAppData jupiterPrefsAndAppData = getIt();

  @override
  Widget build(BuildContext context) {
    if (widget.routeList.length > 0 && !widget.loading) {
      return Container(
        color: AppTheme.white,
        child: MediaQuery.removePadding(
          context: context,
          removeTop: true,
          child: NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (OverscrollIndicatorNotification overscroll) {
              overscroll.disallowIndicator();
              return true;
            },
            child: ListView.separated(
              separatorBuilder: (context, index) => Container(
                height: 1,
                color: AppTheme.borderGray,
                margin: const EdgeInsets.only(bottom: 16),
              ),
              itemCount: widget.routeList.length,
              itemBuilder: (BuildContext context, int indexListView) {
                FavoriteRouteItemEntity route = widget.routeList[indexListView];
                return Slidable(
                  key: Key(route.routeName),
                  endActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    extentRatio:
                        80 * 100 / MediaQuery.of(context).size.width / 100,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          widget.onSlide(context, route.routeName);
                        },
                        style: ElevatedButton.styleFrom(
                          shape: CircleBorder(),
                          backgroundColor: Colors.red,
                          padding: EdgeInsets.all(10),
                        ),
                        child: const Icon(
                          Icons.delete,
                          color: Colors.white,
                          size: 25,
                        ),
                      ),
                    ],
                  ),
                  child: routeItem(route),
                );
              },
            ),
          ),
        ),
      );
    } else if (widget.loading) {
      const int item = 3;
      return Container(
        color: AppTheme.white,
        child: MediaQuery.removePadding(
          context: context,
          removeTop: true,
          child: NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (OverscrollIndicatorNotification overscroll) {
              overscroll.disallowIndicator();
              return true;
            },
            child: ListView.separated(
              separatorBuilder: (context, index) => Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Container(
                  height: 1,
                  color: AppTheme.borderGray,
                ),
              ),
              physics: NeverScrollableScrollPhysics(),
              itemCount: item,
              itemBuilder: (BuildContext context, int indexListView) {
                return Skeletonizer(
                  child: Container(
                    margin: const EdgeInsets.only(top: 6),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Bone.text(words: 2),
                        const SizedBox(height: 16),
                        Padding(
                          padding: const EdgeInsets.only(left: 4),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Bone.circle(size: 26),
                              const SizedBox(width: 12),
                              Bone.text(words: 2),
                            ],
                          ),
                        ),
                        const SizedBox(height: 12),
                        Padding(
                          padding: const EdgeInsets.only(left: 4),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Bone.circle(size: 26),
                              const SizedBox(width: 12),
                              Bone.text(words: 3),
                            ],
                          ),
                        ),
                        const SizedBox(height: 12),
                        Padding(
                          padding: const EdgeInsets.only(left: 4),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Bone.circle(size: 26),
                              const SizedBox(width: 12),
                              Bone.text(words: 2),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      );
    } else {
      return Container(
        height: MediaQuery.of(context).size.height * 0.8,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              ImageAsset.img_default_empty,
              width: 150,
              height: 150,
            ),
            TextLabel(
              text: translate('empty.favorite'),
              fontSize: Utilities.sizeFontWithDesityForDisplay(
                  context, AppFontSize.superlarge),
              color: AppTheme.black40,
            )
          ],
        ),
      );
    }
  }

  Widget routeItem(FavoriteRouteItemEntity route) {
    return InkWell(
      onTap: () {
        debugPrint('${widget.fromMapPage}');
        if (!(widget.fromMapPage ?? false)) {
          Navigator.of(context).pop();
          Future.delayed(const Duration(milliseconds: 50), () {
            jupiterPrefsAndAppData.routeFavorite = route;
            (jupiterPrefsAndAppData.onTapIndex ?? () {})(1);
          });
        } else {
          Navigator.of(context).pop();
          jupiterPrefsAndAppData.routeFavorite = route;
        }
      },
      child: Container(
        padding: EdgeInsets.only(bottom: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextLabel(
              text: '${(route.routeName)}',
              fontSize: Utilities.sizeFontWithDesityForDisplay(
                  context, AppFontSize.superlarge),
              color: AppTheme.blueDark,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),
            routePointList(route.routePoint),
          ],
        ),
      ),
    );
  }

  Widget routePointList(List<FavoriteRoutePointEntity> routePoint) {
    String addressStart = (routePoint[0].stationId != '')
        ? routePoint[0].stationName
        : routePoint[0].name;
    String addressEnd = (routePoint[routePoint.length - 1].stationId != '')
        ? routePoint[routePoint.length - 1].stationName
        : routePoint[routePoint.length - 1].name;
    String stopRoute =
        '${routePoint.length - 2} ${((routePoint.length - 2) > 1) ? translate('map_page.route_planner.stops') : translate('map_page.route_planner.stop')} ';
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      routePointDetail(0, addressStart, routePoint),
      Container(
        width: 28,
        child: DashLineVertical(
          height: 16,
          color: AppTheme.black20,
        ),
      ),
      (routePoint.length >= 3)
          ? routePointDetail(1, stopRoute, routePoint)
          : const SizedBox(),
      (routePoint.length >= 3)
          ? Container(
              width: 28,
              child: DashLineVertical(
                height: 16,
                color: AppTheme.black20,
              ),
            )
          : const SizedBox(),
      routePointDetail((routePoint.length - 1), addressEnd, routePoint)
    ]);
  }

  Widget routePointDetail(
      int index, String address, List<FavoriteRoutePointEntity> routePoint) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 28,
            height: 36,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                imagePin(index, routePoint),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.75,
                  child: TextLabel(
                    text:
                        '${(address == RoutePlanner.ROUTE_CURRENT) ? translate("map_page.route_planner.current_location") : address}',
                    color: AppTheme.black80,
                    fontSize: Utilities.sizeFontWithDesityForDisplay(
                        context, AppFontSize.normal),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget imagePin(int index, List<FavoriteRoutePointEntity> routePoint) {
    if (index == 0) {
      return SvgPicture.asset(
        ImageAsset.ic_pin_current,
        width: 24,
        height: 24,
      );
    } else if (index != (routePoint.length - 1)) {
      return SvgPicture.asset(
        ImageAsset.ic_pin_stop,
        width: 24,
        height: 24,
      );
    } else {
      return SvgPicture.asset(
        ImageAsset.ic_pin_dest_B,
        width: 24,
        height: 24,
      );
    }
  }
}
