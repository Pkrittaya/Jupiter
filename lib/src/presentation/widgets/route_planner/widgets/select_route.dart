import 'dart:io';
import 'package:animated_styled_widget/animated_styled_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jupiter/src/apptheme.dart';
import 'package:jupiter/src/constant_value.dart';
import 'package:jupiter/src/images_asset.dart';
import 'package:jupiter/src/presentation/pages/map/map_page.dart';
import 'package:jupiter/src/presentation/widgets/custom_station_search/custom_station_search.dart';
import 'package:jupiter/src/presentation/widgets/route_planner/widgets/dash_line_vertical.dart';
import 'package:jupiter/src/presentation/widgets/route_planner/widgets/modal_detail_route.dart';
import 'package:jupiter/src/presentation/widgets/text_label.dart';
import 'package:jupiter/src/utilities.dart';
import 'package:jupiter_api/domain/entities/favorite_route_item_entity.dart';
import 'package:jupiter_api/domain/entities/search_station_entity.dart';

class SelectRouteBox extends StatefulWidget {
  const SelectRouteBox(
      {Key? key,
      required this.onCloseModalRoutePlanner,
      required this.onSetModalInRoutePlannerPage,
      required this.floatLocation,
      required this.floatFavorite,
      required this.routePolylines,
      required this.addListRoute,
      required this.selectRouteItem,
      required this.indexSelectItem,
      required this.onPressedAddMarker,
      required this.onSelectStation,
      required this.onActionFavorite,
      required this.routeNameController,
      required this.onDeleteRoute,
      required this.checkFavorite,
      required this.routeFavorite,
      required this.modalRouteDetail,
      required this.visibleDone,
      required this.onVisibleDone,
      required this.modalSaveRoute,
      required this.showRouteDetail,
      required this.onReorderPointItem,
      required this.scrollPosition,
      required this.setScrollPosition,
      required this.checkLoadingVisible,
      required this.checkAndSetClickButton})
      : super(key: key);

  final Function(bool) onCloseModalRoutePlanner;
  final Function(String, bool) onSetModalInRoutePlannerPage;
  final Widget floatLocation;
  final Widget floatFavorite;
  final RouteList routePolylines;
  final Function(RouteForm) addListRoute;
  final Function(int) selectRouteItem;
  final int indexSelectItem;
  final Function(String) onPressedAddMarker;
  final Function(SearchStationEntity) onSelectStation;
  final Function(String, String) onActionFavorite;
  final TextEditingController routeNameController;
  final Function(LatLng, int, String) onDeleteRoute;
  final bool checkFavorite;
  final FavoriteRouteItemEntity? routeFavorite;
  final Function(bool) modalRouteDetail;
  final bool visibleDone;
  final Function(bool) onVisibleDone;
  final Function() modalSaveRoute;
  final bool showRouteDetail;
  final Function(int, int) onReorderPointItem;
  final List<String> scrollPosition;
  final Function(double, String) setScrollPosition;
  final bool Function() checkLoadingVisible;
  final bool Function({bool? click}) checkAndSetClickButton;

  @override
  State<SelectRouteBox> createState() => _SelectRouteBoxState();
}

class _SelectRouteBoxState extends State<SelectRouteBox> {
  bool visibleAdd = true;
  bool favorite = false;
  ScrollController scrollController = ScrollController();
  bool isActiveAccept = true;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(scrollControllerListen);
    getScrollPosition();
  }

  bool checkAddRouteItem(int select) {
    if (widget.routePolylines.listRoute[select].latlng == LatLng(0, 0)) {
      return false;
    } else {
      return true;
    }
  }

  void checkAddRoute() {
    int searchCoupon = widget.routePolylines.listRoute.indexWhere(
        (item) => (item.latlng.latitude == 0) && (item.latlng.longitude == 0));
    if (searchCoupon >= 0) {
      visibleAdd = false;
    } else {
      visibleAdd = true;
    }
    setState(() {});
  }

  void onPressedNavigation() {
    String address = '';
    if (Platform.isIOS) {
      String origin = 'saddr=';
      String dest = '&daddr=';
      String waypoints = '';

      // for (var point in widget.routePolylines.listRoute) {
      //   if (index == 0) {
      //     origin += '${point.latlng.latitude},${point.latlng.longitude}';
      //   } else if (index == widget.routePolylines.listRoute.length - 1) {
      //     dest += '${point.latlng.latitude},${point.latlng.longitude}';
      //   } else {
      //     if (index == 1) {
      //       waypoints +=
      //           '+to:${point.latlng.latitude},${point.latlng.longitude}';
      //     } else {
      //       waypoints +=
      //           '+to:${point.latlng.latitude},${point.latlng.longitude}';
      //     }
      //   }
      //   index++;
      // }

      if (widget.routePolylines.listRoute.length > 2) {
        int index = 0;
        for (var point in widget.routePolylines.listRoute) {
          if (index == 0) {
            origin += '${point.latlng.latitude},${point.latlng.longitude}';
          } else if (index == 1) {
            dest += '${point.latlng.latitude},${point.latlng.longitude}';
          } else {
            waypoints +=
                '+to:${point.latlng.latitude},${point.latlng.longitude}';
          }
          index++;
        }
      } else {
        int index = 0;
        for (var point in widget.routePolylines.listRoute) {
          if (index == 0) {
            origin += '${point.latlng.latitude},${point.latlng.longitude}';
          } else {
            dest += '${point.latlng.latitude},${point.latlng.longitude}';
          }
          index++;
        }
      }

      address = '$origin$dest$waypoints';
    } else {
      int index = 0;
      String origin = '&origin=';
      String dest = '';
      String waypoints = '';
      for (var point in widget.routePolylines.listRoute) {
        if (index == 0) {
          origin += '${point.latlng.latitude},${point.latlng.longitude}';
        } else if (index == widget.routePolylines.listRoute.length - 1) {
          dest += '${point.latlng.latitude},${point.latlng.longitude}';
        } else {
          if (index == 1) {
            waypoints +=
                '&waypoints=${point.latlng.latitude},${point.latlng.longitude}';
          } else {
            waypoints += '|${point.latlng.latitude},${point.latlng.longitude}';
          }
        }
        index++;
      }
      if (waypoints == '') {
        address = '$dest$origin';
      } else {
        address = '$dest$origin$waypoints';
      }
    }
    Utilities.mapRoutePolylinesNavigateTo(address);
    widget.checkAndSetClickButton(click: false);
  }

  void getScrollPosition() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      //ตรวจสอบค่าให้ไปที่ตำแหน่งที่เคยหยุดดูอยู่ใน modal เลือก route
      try {
        double valueScroll = double.parse('${widget.scrollPosition[0]}');
        if (valueScroll > 0) {
          if (scrollController.hasClients) {
            scrollController.animateTo(
              valueScroll + ((widget.scrollPosition[1] == 'LAST') ? 80 : 0),
              duration: Duration(microseconds: 500),
              curve: Curves.easeInOut,
            );
          }
        } else if (widget.routePolylines.listRoute.length == 3 ||
            widget.routePolylines.listRoute.length == 4) {
          if (scrollController.hasClients) {
            scrollController.animateTo(
              100,
              duration: Duration(microseconds: 500),
              curve: Curves.easeInOut,
            );
          }
        }
      } catch (e) {
        debugPrint('Error getScrollPosition : $e');
      }
    });
  }

  void scrollControllerListen() {
    if (scrollController.offset >=
            scrollController.position.maxScrollExtent - 20 &&
        isActiveAccept) {
      setState(() {
        isActiveAccept = false;
      });
    } else if (!isActiveAccept &&
        scrollController.offset <
            scrollController.position.maxScrollExtent - 20) {
      setState(() {
        isActiveAccept = true;
      });
    }

    widget.setScrollPosition(
        scrollController.offset, (!isActiveAccept) ? 'LAST' : 'TOP');
  }

  List<RouteForm> getListRoute(String type) {
    switch (type) {
      case 'children':
        return widget.routePolylines.listRoute.where((element) {
          return (element !=
                  widget.routePolylines
                      .listRoute[widget.routePolylines.listRoute.length - 1]) ||
              (element.latlng != LatLng(0, 0));
        }).toList();
      case 'footer':
        if (widget.routePolylines.listRoute.length < 0) {
          return [];
        } else {
          return widget.routePolylines.listRoute.where((element) {
            return (element ==
                    widget.routePolylines.listRoute[
                        widget.routePolylines.listRoute.length - 1]) &&
                ((widget
                        .routePolylines
                        .listRoute[widget.routePolylines.listRoute.length - 1]
                        .latlng) ==
                    LatLng(0, 0));
          }).toList();
        }

      default:
        return [];
    }
  }

  // void onReorderPointItem(int oldIndex, int newIndex) {
  //   List<RouteForm> newListRoute = widget.routePolylines.listRoute;
  //   int lastIndex = newListRoute.length - 1;
  //   int realNewIndex = newIndex - 1 < 0 ? 0 : newIndex;
  //   bool lastLatIndexIsZero = newListRoute[lastIndex].latlng.latitude == 0;
  //   bool lastLngIndexIsZero = newListRoute[lastIndex].latlng.longitude == 0;
  //   bool selectLatIndexIsZero = newListRoute[oldIndex].latlng.latitude == 0;
  //   bool selectLngIndexIsZero = newListRoute[oldIndex].latlng.longitude == 0;
  //   debugPrint('${oldIndex} : oldIndex');
  //   debugPrint('${realNewIndex} : newIndex');
  //   if (realNewIndex == lastIndex && lastLatIndexIsZero && lastLngIndexIsZero) {
  //     debugPrint('RETURN FOR EMPTY LATLNG LASTINDEX');
  //     return;
  //   } else if (selectLatIndexIsZero && selectLngIndexIsZero) {
  //     debugPrint('RETURN FOR EMPTY LATLNG SELECT');
  //     return;
  //   } else {
  //     debugPrint('CHANGE INDEX');
  //     final removeItem = newListRoute.removeAt(oldIndex);
  //     newListRoute.insert(realNewIndex, removeItem);
  //     setState(() {
  //       widget.routePolylines.listRoute = newListRoute;
  //     });
  //   }
  //   for (final item in widget.routePolylines.listRoute) {
  //     debugPrint('${item.name}');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
              child: Container(
                padding: EdgeInsets.only(
                    top: 16, left: 16, right: 16, bottom: visibleAdd ? 10 : 16),
                width: double.infinity,
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
                    _headerAndIconClose(),
                    const SizedBox(height: 8),
                    _routeDetail(),
                    _addLocationAndDone(),
                  ],
                ),
              ),
            ),
          ],
        ),
        Visibility(
          visible: !widget.showRouteDetail,
          child: Positioned(
            bottom: 110,
            left: 16,
            right: 16,
            child: Column(
              children: [
                Align(
                  alignment: Alignment.bottomRight,
                  child: widget.floatLocation,
                ),
                const SizedBox(height: 16),
                Align(
                  alignment: Alignment.bottomRight,
                  child: widget.floatFavorite,
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
        Visibility(
          visible: widget.showRouteDetail,
          child: ModalDetailRoute(
            onSaveRoute: widget.modalSaveRoute,
            routePolylines: widget.routePolylines,
            indexSelectItem: widget.indexSelectItem,
            checkFavorite: widget.checkFavorite,
            onActionFavorite: widget.onActionFavorite,
            routeFavorite: widget.routeFavorite,
            checkLoadingVisible: widget.checkLoadingVisible,
            checkAndSetClickButton: widget.checkAndSetClickButton,
          ),
        ),
      ],
    );
  }

  Widget _headerAndIconClose() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextLabel(
          text: widget.visibleDone
              ? translate("map_page.route_planner.select_your_route")
              : translate("map_page.route_planner.route"),
          fontWeight: FontWeight.bold,
          color: AppTheme.blueDark,
          fontSize: Utilities.sizeFontWithDesityForDisplay(
              context, AppFontSize.large),
        ),
        IconButton(
          icon: const Icon(Icons.close, color: AppTheme.black40),
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
          onPressed: () {
            if (!(widget.checkLoadingVisible())) {
              if (!(widget.checkAndSetClickButton())) {
                widget.checkAndSetClickButton(click: true);
                widget.onCloseModalRoutePlanner(false);
              }
            }
          },
        ),
      ],
    );
  }

  Widget _pointDetailInput() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      child: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (OverscrollIndicatorNotification overscroll) {
          overscroll.disallowIndicator();
          return true;
        },
        child: widget.visibleDone
            ? ReorderableListView(
                scrollController: scrollController,
                physics: ClampingScrollPhysics(),
                onReorder: widget.onReorderPointItem,
                children: (widget.routePolylines.listRoute.length < 0)
                    ? [SizedBox.square()]
                    // : widget.routePolylines.listRoute.mapIndexed((val, index) {
                    //     return _pointItem(index, val, '');
                    //   }).toList(),
                    : getListRoute('children').mapIndexed((val, index) {
                        return _pointItem(index, val, '');
                      }).toList(),
                footer: (getListRoute('footer').length > 0)
                    ? _pointItem(
                        (widget.routePolylines.listRoute.length - 1),
                        widget.routePolylines.listRoute[
                            widget.routePolylines.listRoute.length - 1],
                        '')
                    : SizedBox.shrink(),
              )
            : SingleChildScrollView(
                controller: scrollController,
                physics: ClampingScrollPhysics(),
                child: Column(
                    children: (widget.routePolylines.listRoute.length < 0)
                        ? [SizedBox.square()]
                        : widget.routePolylines.listRoute
                            .mapIndexed((val, index) {
                            return _pointItem(index, val, '');
                          }).toList()),
              ),
      ),
    );
  }

  Widget _pointDetailText() {
    String addressStart = widget.routePolylines.listRoute[0].name;
    String addressEnd = widget.routePolylines
        .listRoute[widget.routePolylines.listRoute.length - 1].name;
    // count จุดแวะ
    String stopRoute =
        '${widget.routePolylines.listRoute.length - 2} ${((widget.routePolylines.listRoute.length - 2) > 1) ? translate('map_page.route_planner.stops') : translate('map_page.route_planner.stop')}';
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
          border: Border.all(color: AppTheme.grayD1D5DB),
          borderRadius: BorderRadius.circular(10),
          color: AppTheme.white),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8, top: 10),
            child: DashLineVertical(
              height: (widget.routePolylines.listRoute.length < 4)
                  ? widget.routePolylines.listRoute.length * 40
                  : 3 * 40,
              color: AppTheme.black20,
            ),
          ),
          Column(children: [
            _pointItem(0, null, addressStart),
            (widget.routePolylines.listRoute.length >= 3)
                ? _pointItem(1, null, stopRoute)
                : SizedBox.shrink(),
            _pointItem(
                (widget.routePolylines.listRoute.length - 1), null, addressEnd)
          ]),
        ],
      ),
    );
  }

  Widget _pointItem(int index, RouteForm? val, String address) {
    if (widget.visibleDone) {
      bool checkDelete() {
        if (index == 0) {
          if (widget.routePolylines.listRoute.length > 2) {
            return true;
          } else {
            return false;
          }
        } else if (index != widget.routePolylines.listRoute.length - 1) {
          return true;
        } else {
          if (widget
                  .routePolylines
                  .listRoute[widget.routePolylines.listRoute.length - 1]
                  .latlng !=
              LatLng(0, 0)) {
            return true;
          } else {
            return false;
          }
        }
      }

      bool checkDrag() {
        if (index == (widget.routePolylines.listRoute.length - 1)) {
          if (widget
                  .routePolylines
                  .listRoute[widget.routePolylines.listRoute.length - 1]
                  .latlng !=
              LatLng(0, 0)) {
            return true;
          } else {
            return false;
          }
        } else {
          return true;
        }
      }

      return Padding(
        key: ValueKey(index),
        padding: EdgeInsets.symmetric(vertical: 8),
        child: Container(
          child: Row(
            children: [
              imagePin(index),
              const SizedBox(width: 16),
              Expanded(
                child: Container(
                    height: 48,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                        border: Border.all(color: AppTheme.grayD1D5DB),
                        borderRadius: BorderRadius.circular(200),
                        color: AppTheme.white),
                    child: InkWell(
                      onTap: () {
                        if (!(widget.checkLoadingVisible())) {
                          widget.selectRouteItem(index);
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return CustomStationSearch(
                                title: '',
                                routePlanner: true,
                                onSetModalInRoutePlannerPage:
                                    widget.onSetModalInRoutePlannerPage,
                                onPressedAddMarker: widget.onPressedAddMarker,
                                onSelectStation: widget.onSelectStation,
                                routePolylines: widget.routePolylines,
                                getScrollPosition: getScrollPosition);
                          }));
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: TextLabel(
                              text:
                                  '${checkAddRouteItem(index) ? val?.name : val?.hintInput}',
                              fontSize: Utilities.sizeFontWithDesityForDisplay(
                                  context, AppFontSize.normal),
                              color: checkAddRouteItem(index)
                                  ? AppTheme.black80
                                  : AppTheme.black40,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                          Row(
                            children: [
                              checkDelete()
                                  ? IconButton(
                                      onPressed: () async {
                                        if (!(widget.checkLoadingVisible())) {
                                          if (!(widget
                                              .checkAndSetClickButton())) {
                                            widget.checkAndSetClickButton(
                                                click: true);
                                            await widget.onDeleteRoute(
                                                val?.latlng ?? LatLng(0, 0),
                                                index,
                                                val?.markerId ?? '');

                                            widget.checkAndSetClickButton(
                                                click: false);
                                          }
                                        }
                                      },
                                      icon: Icon(
                                        Icons.close,
                                        color: AppTheme.black40,
                                      ),
                                    )
                                  : SizedBox.shrink(),
                              checkDrag()
                                  ? Padding(
                                      padding: const EdgeInsets.only(right: 8),
                                      child: SvgPicture.asset(
                                        ImageAsset.ic_drag_drop,
                                        width: 10,
                                        height: 10,
                                      ),
                                    )
                                  : SizedBox.shrink(),
                            ],
                          ),
                        ],
                      ),
                    )),
              ),
            ],
          ),
        ),
      );
    } else {
      return Padding(
        key: ValueKey(index),
        padding: EdgeInsets.symmetric(vertical: 3),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 8),
              child: imagePin(index),
            ),
            const SizedBox(width: 16),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Container(
                width: MediaQuery.of(context).size.width - 150,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextLabel(
                      text: '${address}',
                      color: AppTheme.black80,
                      fontSize: Utilities.sizeFontWithDesityForDisplay(
                          context, AppFontSize.little),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      textStyleHeight: 1.4,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }
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
        color: AppTheme.white,
        child: SvgPicture.asset(
          ImageAsset.ic_pin_home,
          width: widget.visibleDone ? 24 : 20,
          height: widget.visibleDone ? 24 : 20,
        ),
      );
    } else if (index != (widget.routePolylines.listRoute.length - 1)) {
      if (widget.visibleDone) {
        if (widget.routePolylines.listRoute.length >= 3) {
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
            height: 30,
            color: AppTheme.white,
            child: SvgPicture.asset(
              ImageAsset.ic_pin_stop,
              width: 24,
              height: 24,
            ),
          );
        }
      } else {
        return Container(
          height: widget.visibleDone ? 30 : 25,
          color: AppTheme.white,
          child: SvgPicture.asset(
            ImageAsset.ic_pin_stop,
            width: widget.visibleDone ? 24 : 20,
            height: widget.visibleDone ? 24 : 20,
          ),
        );
      }
    } else {
      return Container(
        height: widget.visibleDone ? 30 : 25,
        color: AppTheme.white,
        child: SvgPicture.asset(
          ImageAsset.ic_pin_dest_B,
          width: widget.visibleDone ? 24 : 20,
          height: widget.visibleDone ? 24 : 20,
        ),
      );
    }
  }

  Widget _addLocationAndDone() {
    return Padding(
      padding: EdgeInsets.only(top: (widget.visibleDone) ? 0 : 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          widget.visibleDone
              ? SizedBox(
                  width: MediaQuery.of(context).size.width * 0.1,
                )
              : InkWell(
                  onTap: () {
                    if (!(widget.checkLoadingVisible())) {
                      if (!(widget.checkAndSetClickButton())) {
                        widget.checkAndSetClickButton(click: true);
                        onPressedNavigation();
                      }
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.all(8),
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
                        SvgPicture.asset(
                          ImageAsset.ic_navigation,
                          width: 18,
                          height: 18,
                        ),
                        const SizedBox(width: 5),
                        TextLabel(
                          text: translate("map_page.route_planner.navigation"),
                          color: AppTheme.blueD,
                          fontSize: Utilities.sizeFontWithDesityForDisplay(
                              context, AppFontSize.normal),
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                  ),
                ),
          (widget.visibleDone &&
                  isActiveAccept &&
                  (widget.routePolylines.listRoute.length > 3))
              ? Container(
                  child: Icon(
                    Icons.arrow_downward,
                    color: AppTheme.blueDark,
                    size: 24,
                  ),
                )
              : SizedBox.shrink(),
          widget.visibleDone
              ? TextButton(
                  onPressed: () {
                    if (!(widget.checkLoadingVisible())) {
                      if (!(widget.checkAndSetClickButton())) {
                        widget.checkAndSetClickButton(click: true);
                        //เช็คค่า input ว่าง ช่อง 1 และ 2
                        if (widget.routePolylines.listRoute[0].latlng !=
                                LatLng(0, 0) &&
                            widget.routePolylines.listRoute[1].latlng !=
                                LatLng(0, 0)) {
                          // ถ้า list route = 10 ไม่ต้องลบค่าว่าง
                          int check = widget.routePolylines.listRoute
                              .indexWhere(
                                  (element) => element.latlng == LatLng(0, 0));
                          if (check >= 0) {
                            widget.onDeleteRoute(LatLng(0, 0), check, '');
                          }

                          //ตรวจสอบว่าเป็น เส้นทางโปรดหรือป่าว ถ้าใช่ให้เรียก api update
                          if (widget.routeFavorite != null) {
                            widget.onActionFavorite(
                                'UPDATE', '${widget.routePolylines.nameRoute}');
                          }

                          //แสดง รายละเอียดเส้นทาง
                          widget.modalRouteDetail(true);
                          //ปิดให้แก้ไขเส้นทาง (แสดงอย่างเดียว)
                          widget.onVisibleDone(false);
                          // setState(() {});
                        }

                        SchedulerBinding.instance
                            .addPostFrameCallback((_) async {
                          widget.checkAndSetClickButton(click: false);
                        });
                      }
                    }
                  },
                  child: TextLabel(
                    text: translate("map_page.route_planner.done"),
                    fontSize: AppFontSize.normal,
                    color: AppTheme.blueD,
                  ))
              : TextButton(
                  onPressed: () {
                    if (!(widget.checkLoadingVisible())) {
                      if (!(widget.checkAndSetClickButton())) {
                        widget.checkAndSetClickButton(click: true);
                        //ปิด รายละเอียดเส้นทาง
                        widget.modalRouteDetail(false);
                        //เปิด ให้แก้ไขเส้นทาง
                        widget.onVisibleDone(true);

                        //เช็คว่ามีเส้นทางถึง 10 หรือยัง
                        if (widget.routePolylines.listRoute.length < 10) {
                          //เช็คว่าถ้ามี input ที่ว่างอยู่แล้วไม่ต้อง add input เพิ่ม
                          int check = widget.routePolylines.listRoute
                              .indexWhere(
                                  (element) => element.latlng == LatLng(0, 0));
                          if (check >= 0) {
                          } else {
                            widget.addListRoute(RouteForm(
                                name: translate(
                                    "map_page.route_planner.select_destination"),
                                latlng: LatLng(0, 0),
                                hintInput: translate(
                                    "map_page.route_planner.select_destination"),
                                stationId: '',
                                markerId: ''));
                          }
                        }

                        SchedulerBinding.instance
                            .addPostFrameCallback((_) async {
                          widget.checkAndSetClickButton(click: false);
                        });

                        // setState(() {});
                      }
                    }
                  },
                  child: TextLabel(
                    text: translate("map_page.route_planner.edit"),
                    fontSize: AppFontSize.normal,
                    color: AppTheme.blueD,
                  ))
        ],
      ),
    );
  }

  Widget _routeDetail() {
    if (widget.visibleDone) {
      return Container(
        height: (widget.routePolylines.listRoute.length > 2) ? 200 : 130,
        child: Stack(
          children: [
            Positioned(
              left: 10,
              top: 24,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DashLineVertical(
                    height: widget.routePolylines.listRoute.length == 2
                        ? 80
                        : widget.routePolylines.listRoute.length <= 3
                            ? 140
                            : 180,
                    color: AppTheme.black20,
                  ),
                ],
              ),
            ),
            _pointDetailInput(),
          ],
        ),
      );
    } else {
      return _pointDetailText();
    }
  }
}
