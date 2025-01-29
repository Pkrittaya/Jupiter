import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jupiter/src/constant_value.dart';
import 'package:jupiter/src/injection.dart';
import 'package:jupiter/src/jupiter_prefs_and_app_data.dart';
import 'package:jupiter/src/presentation/pages/map/map_page.dart';
import 'package:jupiter/src/presentation/widgets/route_planner/cubit/route_planner_cubit.dart';
import 'package:jupiter/src/presentation/widgets/route_planner/widgets/move_pin.dart';
import 'package:jupiter/src/presentation/widgets/route_planner/widgets/save_route.dart';
import 'package:jupiter/src/presentation/widgets/route_planner/widgets/select_route.dart';
import 'package:jupiter/src/presentation/widgets/route_planner/widgets/select_station.dart';
import 'package:jupiter/src/utilities.dart';
import 'package:jupiter_api/data/data_models/request/add_fovorite_route_point_form.dart';
import 'package:jupiter_api/domain/entities/favorite_route_item_entity.dart';
import 'package:jupiter_api/domain/entities/favorite_route_point_entity.dart';
import 'package:jupiter_api/domain/entities/search_station_entity.dart';
import 'package:jupiter_api/domain/entities/station_details_entity.dart';

class RoutePlannerPage extends StatefulWidget {
  const RoutePlannerPage(
      {Key? key,
      required this.onCloseModalRoutePlanner,
      required this.onPressedAddMarker,
      required this.floatLocation,
      required this.floatFavorite,
      required this.onSelectStation,
      required this.routePolylines,
      required this.addListRoute,
      required this.selectRouteItem,
      required this.indexSelectItem,
      this.detail,
      required this.onDeleteRoute,
      required this.onReorderPointItem,
      required this.setHideShowMarkerStation,
      required this.onSetModalInRoutePlannerPage,
      required this.selectRoute,
      required this.movePin,
      required this.selectStation,
      required this.placemark,
      required this.currentMapPosition,
      required this.loadingLocation,
      required this.checkLoadingVisible})
      : super(key: key);

  final Function(bool) onCloseModalRoutePlanner;
  final Function(String) onPressedAddMarker;
  final Widget floatLocation;
  final Widget floatFavorite;
  final Function(SearchStationEntity) onSelectStation;
  final RouteList routePolylines;
  final Function(RouteForm) addListRoute;
  final Function(int) selectRouteItem;
  final int indexSelectItem;
  final StationDetailEntity? detail;
  final Function(LatLng, int, String) onDeleteRoute;
  final Function(int, int) onReorderPointItem;
  final Function(bool) setHideShowMarkerStation;
  final Function(String, bool) onSetModalInRoutePlannerPage;
  final bool selectRoute;
  final bool movePin;
  final bool selectStation;
  final Placemark placemark;
  final LatLng currentMapPosition;
  final bool loadingLocation;
  final bool Function() checkLoadingVisible;

  @override
  State<RoutePlannerPage> createState() => _RoutePlannerPageState();
}

class _RoutePlannerPageState extends State<RoutePlannerPage> {
  bool loadingVisible = false;
  TextEditingController routeNameController = TextEditingController();
  bool checkFavorite = false;
  JupiterPrefsAndAppData jupiterPrefsAndAppData = getIt();
  FavoriteRouteItemEntity? routeFavorite;
  bool visibleDone = true;
  bool showRouteDetail = false;
  List<String> scrollPosition = ['0', 'TOP'];
  bool statusSave = true;
  bool checkButton = false;

  void setScrollPosition(double position, String type) {
    scrollPosition[0] = '$position';
    scrollPosition[1] = '$type';
  }

  void checkrouteFavorite() {
    if (jupiterPrefsAndAppData.routeFavorite != null) {
      checkFavorite = true;
      routeFavorite = jupiterPrefsAndAppData.routeFavorite;
      visibleDone = false;
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        modalRouteDetail(true);
      });
    }
  }

  void onVisibleDone(bool visible) {
    visibleDone = visible;
    widget.setHideShowMarkerStation(visible);
  }

  void modalRouteDetail(bool visible) {
    if (visible) {
      showRouteDetail = true;
    } else {
      showRouteDetail = false;
    }
    setState(() {
      showRouteDetail;
    });
  }

  void modalSaveRoute() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: false,
      isDismissible: false,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(12))),
      builder: (BuildContext context) {
        return ModalSaveRoute(
            onActionFavorite: onActionFavorite,
            routeNameController: routeNameController);
      },
    ).whenComplete(() {
      routeNameController.text = '';
    });
  }

  void onActionFavorite(String type, String routeName) {
    switch (type) {
      case 'ADD':
        List<AddFavoriteRoutePointForm> routePoint = [];
        int index = 1;
        for (var route in widget.routePolylines.listRoute) {
          routePoint.add(AddFavoriteRoutePointForm(
              name: (route.name ==
                      translate("map_page.route_planner.current_location"))
                  ? RoutePlanner.ROUTE_CURRENT
                  : route.name,
              pointNo: index,
              latitude: route.latlng.latitude,
              longitude: route.latlng.longitude,
              stationId: route.stationId));
          index++;
        }

        widget.routePolylines.nameRoute = routeNameController.text;

        BlocProvider.of<RoutePlannerCubit>(context).addFavoriteRoute(
            routeName: routeNameController.text,
            routeDistance: widget.routePolylines.distance.round(),
            routeDuration: widget.routePolylines.duration.round(),
            routePoint: routePoint);
        break;
      case 'UPDATE':
        if (routeName == '') {
          routeName = widget.routePolylines.nameRoute;
        }
        List<AddFavoriteRoutePointForm> routePoint = [];
        int index = 1;
        for (var route in widget.routePolylines.listRoute) {
          routePoint.add(AddFavoriteRoutePointForm(
              name: (route.name ==
                      translate("map_page.route_planner.current_location"))
                  ? RoutePlanner.ROUTE_CURRENT
                  : route.name,
              pointNo: index,
              latitude: route.latlng.latitude,
              longitude: route.latlng.longitude,
              stationId: route.stationId));
          index++;
        }

        BlocProvider.of<RoutePlannerCubit>(context).updateFavoriteRoute(
            routeNameNew: routeName,
            routeName: routeName,
            routeDistance: widget.routePolylines.distance.round(),
            routeDuration: widget.routePolylines.duration.round(),
            routePoint: routePoint);
        break;
      case 'DELETE':
        if (routeName == '') {
          routeName = widget.routePolylines.nameRoute;
        }
        BlocProvider.of<RoutePlannerCubit>(context)
            .deleteFavoriteRoute(routeName: routeName);

        break;
      default:
    }
  }

  bool checkAndSetClickButton({bool? click}) {
    if (click == null) {
      return checkButton;
    } else {
      setState(() {
        checkButton = click;
      });
      return checkButton;
    }
  }

  void actionRoutePlannerLoading() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!loadingVisible) {
        setState(() {
          loadingVisible = true;
        });
      }
    });
  }

  void actionDeleteFavoriteRouteFailure(state) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (loadingVisible) {
        setState(() {
          loadingVisible = false;
        });
        Utilities.alertOneButtonAction(
          context: context,
          type: AppAlertType.DEFAULT,
          isForce: true,
          title: translate('alert.title.default'),
          description: state.message ?? translate('alert.description.default'),
          textButton: translate('button.try_again'),
          onPressButton: () {
            BlocProvider.of<RoutePlannerCubit>(context).resetStateInitial();
            Navigator.of(context).pop();
          },
        );
      }
    });
  }

  void actionDeleteFavoriteRouteSuccess() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (loadingVisible) {
        jupiterPrefsAndAppData.routeFavorite = null;
        routeFavorite = null;
        widget.routePolylines.nameRoute = '';
        setState(() {
          loadingVisible = false;
          checkFavorite = false;
        });
      }
    });
  }

  void actionAddFavoriteRouteFailure(state) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (loadingVisible) {
        setState(() {
          loadingVisible = false;
        });
        Utilities.alertOneButtonAction(
          context: context,
          type: AppAlertType.DEFAULT,
          isForce: true,
          title: translate('alert.title.default'),
          description: state.message ?? translate('alert.description.default'),
          textButton: translate('button.try_again'),
          onPressButton: () {
            BlocProvider.of<RoutePlannerCubit>(context).resetStateInitial();
            Navigator.of(context).pop();
          },
        );
      }
    });
  }

  void actionAddFavoriteRouteSuccess() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (loadingVisible) {
        Navigator.of(context).pop();
        List<FavoriteRoutePointEntity> routePoint = [];
        int index = 1;
        for (var route in widget.routePolylines.listRoute) {
          routePoint.add(FavoriteRoutePointEntity(
              name: (route.name ==
                      translate("map_page.route_planner.current_location"))
                  ? RoutePlanner.ROUTE_CURRENT
                  : route.name,
              pointNo: index,
              latitude: route.latlng.latitude,
              longitude: route.latlng.longitude,
              stationId: '',
              stationName: ''));
          index++;
        }
        jupiterPrefsAndAppData.routeFavorite = FavoriteRouteItemEntity(
            routeName: widget.routePolylines.nameRoute,
            routeDistance: widget.routePolylines.distance.round(),
            routeDuration: widget.routePolylines.duration.round(),
            routePoint: routePoint);
        routeFavorite = jupiterPrefsAndAppData.routeFavorite;
        setState(() {
          loadingVisible = false;
          checkFavorite = true;
          statusSave = true;
        });
      }
    });
  }

  void actionUpdateFavoriteRouteFailure(state) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (loadingVisible) {
        setState(() {
          loadingVisible = false;
        });
        Utilities.alertOneButtonAction(
          context: context,
          type: AppAlertType.DEFAULT,
          isForce: true,
          title: translate('alert.title.default'),
          description: state.message ?? translate('alert.description.default'),
          textButton: translate('button.try_again'),
          onPressButton: () {
            BlocProvider.of<RoutePlannerCubit>(context).resetStateInitial();
            Navigator.of(context).pop();
          },
        );
      }
    });
  }

  void actionUpdateFavoriteRouteSuccess() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (loadingVisible) {
        List<FavoriteRoutePointEntity> routePoint = [];
        int index = 1;
        for (var route in widget.routePolylines.listRoute) {
          routePoint.add(FavoriteRoutePointEntity(
              name: (route.name ==
                      translate('map_page.route_planner.current_location'))
                  ? RoutePlanner.ROUTE_CURRENT
                  : route.name,
              pointNo: index,
              latitude: route.latlng.latitude,
              longitude: route.latlng.longitude,
              stationId: '',
              stationName: ''));
          index++;
        }
        jupiterPrefsAndAppData.routeFavorite = FavoriteRouteItemEntity(
            routeName: (jupiterPrefsAndAppData.routeFavorite != null)
                ? (jupiterPrefsAndAppData.routeFavorite?.routeName ?? '')
                : routeNameController.text,
            routeDistance: widget.routePolylines.distance.round(),
            routeDuration: widget.routePolylines.duration.round(),
            routePoint: routePoint);
        setState(() {
          loadingVisible = false;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    checkrouteFavorite();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Visibility(
            visible: (widget.selectRoute),
            child: BlocBuilder<RoutePlannerCubit, RoutePlannerState>(
                builder: (context, state) {
              switch (state.runtimeType) {
                case RoutePlannerLoading:
                  actionRoutePlannerLoading();
                  break;
                case DeleteFavoriteRouteSuccess:
                  actionDeleteFavoriteRouteSuccess();
                  break;
                case DeleteFavoriteRouteFailure:
                  actionDeleteFavoriteRouteFailure(state);
                  break;
                case AddFavoriteRouteSuccess:
                  actionAddFavoriteRouteSuccess();
                  break;
                case AddFavoriteRouteFailure:
                  actionAddFavoriteRouteFailure(state);
                  break;
                case UpdateFavoriteRouteSuccess:
                  actionUpdateFavoriteRouteSuccess();
                  break;
                case UpdateFavoriteRouteFailure:
                  actionUpdateFavoriteRouteFailure(state);
                  break;
                default:
                  break;
              }
              return SelectRouteBox(
                onCloseModalRoutePlanner: widget.onCloseModalRoutePlanner,
                onSetModalInRoutePlannerPage:
                    widget.onSetModalInRoutePlannerPage,
                floatLocation: widget.floatLocation,
                floatFavorite: widget.floatFavorite,
                routePolylines: widget.routePolylines,
                addListRoute: widget.addListRoute,
                selectRouteItem: widget.selectRouteItem,
                indexSelectItem: widget.indexSelectItem,
                onPressedAddMarker: widget.onPressedAddMarker,
                onSelectStation: widget.onSelectStation,
                onActionFavorite: onActionFavorite,
                routeNameController: routeNameController,
                onDeleteRoute: widget.onDeleteRoute,
                checkFavorite: checkFavorite,
                routeFavorite: jupiterPrefsAndAppData.routeFavorite,
                modalRouteDetail: modalRouteDetail,
                visibleDone: visibleDone,
                onVisibleDone: onVisibleDone,
                modalSaveRoute: modalSaveRoute,
                showRouteDetail: showRouteDetail,
                onReorderPointItem: widget.onReorderPointItem,
                scrollPosition: scrollPosition,
                setScrollPosition: setScrollPosition,
                checkLoadingVisible: widget.checkLoadingVisible,
                checkAndSetClickButton: checkAndSetClickButton,
              );
            })),
        Visibility(
          visible: widget.movePin,
          child: MovePin(
            onSetModalInRoutePlannerPage: widget.onSetModalInRoutePlannerPage,
            onPressedAddMarker: widget.onPressedAddMarker,
            floatLocation: widget.floatLocation,
            placemark: widget.placemark,
            currentMapPosition: widget.currentMapPosition,
            loadingLocation: widget.loadingLocation,
          ),
        ),
        Visibility(
          visible: widget.selectStation,
          child: SelectStation(
              onSetModalInRoutePlannerPage: widget.onSetModalInRoutePlannerPage,
              onPressedAddMarker: widget.onPressedAddMarker,
              floatLocation: widget.floatLocation,
              detail: widget.detail,
              isPermissionLocation: true,
              selectRouteItem: widget.selectRouteItem),
        )
      ],
    );
  }
}
