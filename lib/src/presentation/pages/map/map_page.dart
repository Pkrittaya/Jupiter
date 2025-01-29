import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jupiter/src/apptheme.dart';
import 'package:jupiter/src/constant_value.dart';
import 'package:jupiter/src/jupiter_prefs_and_app_data.dart';
import 'package:jupiter/src/presentation/widgets/route_planner/route_planner_page.dart';
import 'package:jupiter_api/data/data_models/request/route_planning_latlng_data_form.dart';
import 'package:jupiter_api/data/data_models/request/route_planning_latlng_form.dart';
import 'package:jupiter_api/data/data_models/request/route_planning_location_form.dart';
import 'package:jupiter_api/data/data_models/request/route_planning_modifiers_form.dart';
import 'package:jupiter_api/domain/entities/connector_entity.dart';
import 'package:jupiter_api/domain/entities/favorite_route_point_entity.dart';
import 'package:jupiter_api/domain/entities/favorite_station_entity.dart';
import 'package:jupiter_api/domain/entities/route_planning_entity.dart';
import 'package:jupiter_api/domain/entities/search_station_entity.dart';
import 'package:jupiter_api/domain/entities/station_details_entity.dart';
import 'package:jupiter_api/domain/entities/station_entity.dart';
import 'package:jupiter/src/images_asset.dart';
import 'package:jupiter/src/presentation/pages/favorite/favorite_page.dart';
import 'package:jupiter/src/presentation/pages/map/cubit/map_cubit.dart';
import 'package:jupiter/src/presentation/pages/map/widgets/info_station_box.dart';
import 'package:jupiter/src/presentation/widgets/loading_page.dart';
import 'package:jupiter/src/presentation/widgets/search_app_bar_map.dart';
import '../../../firebase_log.dart';
import '../../../injection.dart';
import '../../../utilities.dart';
import 'widgets/image_marker.dart';
import 'package:flutter_polyline_points/src/utils/polyline_decoder.dart';

class MapPageWrapperProvider extends StatelessWidget {
  const MapPageWrapperProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<MapCubit>(),
      child: const MapPage(),
    );
  }
}

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => MapPageState();
}

class MapPageState extends State<MapPage> {
  // LatLng _lastestLatLng = const LatLng(0, 0);
  int clickIndex = 0;

  bool? favoriteStation = false;
  FavoriteStationEntity? favoriteStationEntity;
  List<String?> filterConnectorAC = [];
  List<String?> filterConnectorDC = [];
  List<GlobalKey> globalKeys = [];
  bool isCheckedACCHAdeMO = false;
  bool isCheckedACCS1 = false;
  bool isCheckedACCS2 = false;
  bool isCheckedChargerAvailable = false;
  bool isCheckedDCCHAdeMO = false;
  bool isCheckedDCCS1 = false;
  bool isCheckedDCCS2 = false;
  bool isCheckedDistance = false;
  bool isCheckedOpenService = false;
  bool keyboardIsOpen = true;
  bool loadingVisible = true;
  // BitmapDescriptor _avaliableIcon = BitmapDescriptor.defaultMarker;
  // BitmapDescriptor _occupiedIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor markerIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor markerIconRoute = BitmapDescriptor.defaultMarker;

  GlobalKey markerKey = GlobalKey();
  // MapState _currentState = MapInitial();
  bool stationBox = false;

  String statusMarker = '';
  String total = '';
  // List<FavoriteStationListEntity>? _stationList = List.empty(growable: true);

  List<Uint8List> uint8Marker = List.empty(growable: true);
  List<Uint8List> uint8MarkerRoute = List.empty(growable: true);

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  Position _currentLocation = Position(
    longitude: 0,
    latitude: 0,
    timestamp: new DateTime.now(),
    accuracy: 0,
    altitude: 0,
    heading: 0,
    speed: 0,
    speedAccuracy: 0,
    altitudeAccuracy: 0,
    headingAccuracy: 0,
  );
  Map<String, StationDetailEntity?> _detailInfo = {};
  final FocusNode _focus = FocusNode();
  static final LatLng _target = const LatLng(13.7563309, 100.5017651);
  final CameraPosition _initCamera = CameraPosition(
    target: _target,
    zoom: 14.4746,
  );

  String _lastestMarkerId = '';
  List<ConnectorEntity> _listConnector = List.empty(growable: true);
  List<StationEntity> _markerData = List.empty();
  List<Marker> _markers = [];
  bool isPermissionLocation = true;
  double defaultLatitude = 13.76483333;
  double defaultLongitude = 100.5382222;
  bool loadMarkerStation = false;

  // route polyline
  bool loadingRoute = true;
  PolylinePoints polylinePoints = PolylinePoints();
  Map<PolylineId, Polyline> polylines = {};
  bool routeVisible = false;
  LatLng _currentMapPosition = _target;
  Set<Marker> markerCameraMove = {};
  List<PolylineResult> resultsPolyline = [];
  String STATUS_OK = "ok";
  int checkMarkers = 0;

  RouteList routePolylines =
      RouteList(nameRoute: '', distance: 0, duration: 0, listRoute: [
    RouteForm(
        name: translate("map_page.route_planner.current_location"),
        latlng: LatLng(0, 0),
        hintInput: translate("map_page.route_planner.current_location"),
        stationId: '',
        markerId: ''),
    RouteForm(
        name: translate("map_page.route_planner.select_destination"),
        latlng: LatLng(0, 0),
        hintInput: translate("map_page.route_planner.select_destination"),
        stationId: '',
        markerId: '')
  ], pointsRoute: []);
  int indexRouteSelected = -1;
  Placemark placemark = Placemark();
  Completer<CameraPosition> cameraMoveCompleter = Completer<CameraPosition>();
  StationDetailEntity? detailSelect;

  JupiterPrefsAndAppData jupiterPrefsAndAppData = getIt();

  bool routeForFavorite = false;
  bool loadSelectStation = false;
  bool selectRoute = true;
  bool movePin = false;
  bool selectStation = false;
  String clickDefault = 'DEFAULT';
  String addLastRoute = 'ADDLAST';
  String addSelectRoute = 'ADDSELECT';
  String clickMarkerSelectStation = 'DEFAULT';
  bool loadingLocation = false;
  bool getRouteNavigate = false;
  bool hideCurrentLocation = false;

  @override
  void dispose() {
    jupiterPrefsAndAppData.routeFavorite = null;
    jupiterPrefsAndAppData.detailForRoute = null;
    jupiterPrefsAndAppData.navigateRoutePlanner = false;
    polylines.clear();
    loadingVisible = false;
    routeForFavorite = false;
    super.dispose();
  }

  @override
  void initState() {
    FirebaseLog.logPage(this);

    // askPermissionLocation();
    polylines.clear();
    loadingVisible = false;
    routeForFavorite = false;

    _goCurrentLocation();
    // initIcon();
    _markerData = List.empty();
    super.initState();
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  void getAllMarkerForFiltter(
      bool openService,
      bool chargerAvailable,
      bool distance,
      List<String?> connectorAC,
      List<String?> connectorDC) async {
    try {
      _currentLocation =
          await Utilities.getUserCurrentLocation(isAlertPermission: false);
      BlocProvider.of<MapCubit>(context).loadingAllMarker(
          openService,
          chargerAvailable,
          distance,
          connectorAC,
          connectorDC,
          _currentLocation.latitude,
          _currentLocation.longitude);
      setState(() {
        isPermissionLocation = true;
      });
    } catch (e) {
      try {
        BlocProvider.of<MapCubit>(context).loadingAllMarker(
            openService,
            chargerAvailable,
            distance,
            connectorAC,
            connectorDC,
            defaultLatitude,
            defaultLongitude);
      } catch (e) {
        setState(() {
          loadingVisible = false;
        });
      }
      setState(() {
        isPermissionLocation = false;
      });
    }
  }

  void loadingAllMarker(Position position) async {
    JupiterPrefsAndAppData jupiterPrefsAndAppData = getIt();
    String? filterRecommendedToMap =
        jupiterPrefsAndAppData.filterRecommendedToMap;
    try {
      if (filterRecommendedToMap != '' && filterRecommendedToMap != null) {
        filterConnectorAC = [];
        isCheckedOpenService = true;
        if (filterRecommendedToMap == 'nearMe') {
          isCheckedDistance = true;
        } else {
          filterConnectorDC = ["CS1", "CS2", "CHaDEMO"];
          isCheckedDCCS1 = true;
          isCheckedDCCS2 = true;
          isCheckedDCCHAdeMO = true;
        }
      }
      BlocProvider.of<MapCubit>(context).loadingAllMarker(
          isCheckedOpenService,
          isCheckedChargerAvailable,
          isCheckedDistance,
          filterConnectorAC,
          filterConnectorDC,
          position.latitude,
          position.longitude);
    } catch (e) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (loadingVisible) {
          setState(() {
            loadingVisible = false;
          });
          BlocProvider.of<MapCubit>(context).resetCubitMap();
        }
      });
    }
    jupiterPrefsAndAppData.removeFilterRecommendedToMap();
    // prefs.remove(ConstValue.filterRecommendedToMap);
  }

  void setGlobalKeys() {
    globalKeys.clear();
    for (var i = 0; i < _markerData.length; i++) {
      GlobalKey key = GlobalKey();
      globalKeys.add(key);
    }
  }

  getBitmaps(context) async {
    uint8Marker.clear();
    for (var i = 0; i < _markerData.length; i++) {
      Uint8List pngBytes = await Utilities.captureWidget(globalKeys[i], i);
      uint8Marker.add(pngBytes);
      if (i == (_markerData.length - 1)) {
        loadMarkerStation = false;
      }
    }
  }

  void addMarkerData() async {
    loadingVisible = true;
    var media = MediaQuery.of(context);
    var sizeRatio = media.devicePixelRatio;
    final _data = _markerData;
    _markers.clear();
    for (var i = 0; i < _data.length; i++) {
      var marker = _data[i];
      String markerId = marker.stationId;
      LatLng dataLatLng = Utilities.createPositionLatLng(marker.position);
      markerIcon = await Utilities.statusPinIcon(
          uint8Marker[i], (45 * sizeRatio).toInt());
      _markers.add(
        Marker(
          markerId: MarkerId(markerId),
          position: dataLatLng,
          draggable: true,
          onDragEnd: (value) {},
          icon: markerIcon,
          onTap: () {
            if (!routeVisible) {
              _lastestMarkerId = markerId;
              clickIndex = i;
              try {
                BlocProvider.of<MapCubit>(context).loadStationDetail(
                    marker.stationId,
                    _currentLocation.latitude,
                    _currentLocation.longitude);
              } catch (e) {
                try {
                  BlocProvider.of<MapCubit>(context).loadStationDetail(
                      marker.stationId, defaultLatitude, defaultLongitude);
                } catch (e) {
                  setState(() {
                    loadingVisible = false;
                  });
                }
              }
            } else {
              if (!movePin) {
                setState(() {
                  loadingVisible = true;
                });

                if (clickMarkerSelectStation == clickDefault ||
                    clickMarkerSelectStation == addLastRoute) {
                  loadSelectStation = true;
                  int inputRoute = routePolylines.listRoute
                      .where((item) => (item.latlng == LatLng(0, 0)))
                      .toList()
                      .length;
                  if (inputRoute > 0) {
                    try {
                      BlocProvider.of<MapCubit>(context).loadStationDetail(
                          marker.stationId,
                          _currentLocation.latitude,
                          _currentLocation.longitude);
                    } catch (e) {
                      setState(() {
                        loadingVisible = false;
                      });
                    }
                  }
                } else if (clickMarkerSelectStation == addSelectRoute) {
                  try {
                    BlocProvider.of<MapCubit>(context).loadStationDetail(
                        marker.stationId,
                        _currentLocation.latitude,
                        _currentLocation.longitude);
                  } catch (e) {
                    setState(() {
                      loadingVisible = false;
                    });
                  }
                } else {
                  setState(() {
                    loadingVisible = false;
                  });
                }
              }
            }
          },
        ),
      );
    }

    //***** route planner ***//
    if (jupiterPrefsAndAppData.routeFavorite != null) {
      //เช็คว่ามาจากหน้า Favorite หรือไม่
      await loadingRouteFromFavorite();
    } else if (jupiterPrefsAndAppData.navigateRoutePlanner == true) {
      //เช็คว่ามีการกดขอ route มาจากหน้าอื่นหรือไม่
      getNavigateRoutePlannerFromOtherPage();
    } else {
      setState(() {
        loadingVisible = false;
      });
    }
  }

  void addStationBox(String stationId) {
    StationDetailEntity? detail = _detailInfo[stationId];
    _listConnector.clear();
    if (detail?.charger != null) {
      for (var charger in detail!.charger) {
        for (var connector in charger.connector) {
          _listConnector.add(connector);
        }
      }
    }
    keyboardIsOpen = false;
    stationBox = true;
    setState(() {});
  }

  void loadingFilterMarker(
      bool? openService,
      bool? chargerAvailble,
      bool? distance,
      bool? accs1,
      bool? accs2,
      bool? ACCHAdeMO,
      bool? dccs1,
      bool? dccs2,
      bool? dcCHAdeMO) async {
    isCheckedOpenService = openService!;
    isCheckedChargerAvailable = chargerAvailble!;
    isCheckedDistance = distance!;
    isCheckedACCS1 = accs1!;
    if (accs1 == true) {
      filterConnectorAC.add('CS1');
    } else {
      filterConnectorAC.removeWhere((str) {
        return str == 'CS1';
      });
    }
    isCheckedACCS2 = accs2!;
    if (accs2 == true) {
      filterConnectorAC.add('CS2');
    } else {
      filterConnectorAC.removeWhere((str) {
        return str == 'CS2';
      });
    }
    isCheckedACCHAdeMO = ACCHAdeMO!;
    if (ACCHAdeMO == true) {
      filterConnectorAC.add('CHaDEMO');
    } else {
      filterConnectorAC.removeWhere((str) {
        return str == 'CHaDEMO';
      });
    }
    isCheckedDCCS1 = dccs1!;
    if (dccs1 == true) {
      filterConnectorDC.add('CS1');
    } else {
      filterConnectorDC.removeWhere((str) {
        return str == 'CS1';
      });
    }
    isCheckedDCCS2 = dccs2!;
    if (dccs2 == true) {
      filterConnectorDC.add('CS2');
    } else {
      filterConnectorDC.removeWhere((str) {
        return str == 'CS2';
      });
    }
    isCheckedDCCHAdeMO = dcCHAdeMO!;
    if (dcCHAdeMO == true) {
      filterConnectorDC.add('CHaDEMO');
    } else {
      filterConnectorDC.removeWhere((str) {
        return str == 'CHaDEMO';
      });
    }
    if (!loadingVisible) {
      setState(() {
        loadingVisible = true;
      });
    }
    getAllMarkerForFiltter(isCheckedOpenService, isCheckedChargerAvailable,
        isCheckedDistance, filterConnectorAC, filterConnectorDC);
    Navigator.of(context).pop();
  }

  void loadingFilterACMarker(bool? ac) async {
    filterConnectorAC.clear();
    filterConnectorDC.clear();
    if (ac == true) {
      filterConnectorAC.add('CS1');
      filterConnectorAC.add('CS2');
      filterConnectorAC.add('CHaDEMO');
      isCheckedACCS1 = true;
      isCheckedACCS2 = true;
      isCheckedACCHAdeMO = true;
      isCheckedDCCS1 = false;
      isCheckedDCCS2 = false;
      isCheckedDCCHAdeMO = false;
    } else {
      isCheckedACCS1 = false;
      isCheckedACCS2 = false;
      isCheckedACCHAdeMO = false;
      isCheckedDCCS1 = false;
      isCheckedDCCS2 = false;
      isCheckedDCCHAdeMO = false;
    }
    if (!loadingVisible) {
      setState(() {
        loadingVisible = true;
      });
    }
    getAllMarkerForFiltter(isCheckedOpenService, isCheckedChargerAvailable,
        isCheckedDistance, filterConnectorAC, filterConnectorDC);
  }

  void loadingFilterDCMarker(bool? dc) async {
    filterConnectorAC.clear();
    filterConnectorDC.clear();
    if (dc == true) {
      filterConnectorDC.add('CS1');
      filterConnectorDC.add('CS2');
      filterConnectorDC.add('CHaDEMO');
      isCheckedACCS1 = false;
      isCheckedACCS2 = false;
      isCheckedACCHAdeMO = false;
      isCheckedDCCS1 = true;
      isCheckedDCCS2 = true;
      isCheckedDCCHAdeMO = true;
    } else {
      isCheckedACCS1 = false;
      isCheckedACCS2 = false;
      isCheckedACCHAdeMO = false;
      isCheckedDCCS1 = false;
      isCheckedDCCS2 = false;
      isCheckedDCCHAdeMO = false;
    }
    if (!loadingVisible) {
      setState(() {
        loadingVisible = true;
      });
    }
    getAllMarkerForFiltter(isCheckedOpenService, isCheckedChargerAvailable,
        isCheckedDistance, filterConnectorAC, filterConnectorDC);
  }

  void loadingFilterOpenService(bool? openService) async {
    if (openService == true) {
      isCheckedOpenService = true;
    } else {
      isCheckedOpenService = false;
    }
    if (!loadingVisible) {
      setState(() {
        loadingVisible = true;
      });
    }
    getAllMarkerForFiltter(isCheckedOpenService, isCheckedChargerAvailable,
        isCheckedDistance, filterConnectorAC, filterConnectorDC);
  }

  void filterOpenService(bool? openService) {
    isCheckedOpenService = openService!;
    setState(() {});
  }

  void resetFilter() async {
    isCheckedOpenService = false;
    isCheckedChargerAvailable = false;
    isCheckedDistance = false;
    isCheckedACCS1 = false;
    isCheckedACCS2 = false;
    isCheckedACCHAdeMO = false;
    isCheckedDCCS1 = false;
    isCheckedDCCS2 = false;
    isCheckedDCCHAdeMO = false;
    filterConnectorAC.clear();
    filterConnectorDC.clear();
    if (!loadingVisible) {
      setState(() {
        loadingVisible = true;
      });
    }
    getAllMarkerForFiltter(isCheckedOpenService, isCheckedChargerAvailable,
        isCheckedDistance, filterConnectorAC, filterConnectorDC);
    Navigator.of(context).pop();
  }

  void onTapStationDetail() {
    stationBox = false;
    keyboardIsOpen = true;
    setState(() {});
  }

  Future<void> navigateToFavorite(context) async {
    await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return FavoriteStation(
        fromMapPage: true,
      );
    }));

    if (jupiterPrefsAndAppData.navigateRoutePlanner) {
      jupiterPrefsAndAppData.routeFavorite = null;
      getRouteNavigate = true;
      onCloseModalRoutePlanner(false);
      getNavigateRoutePlannerFromOtherPage();
      getRouteNavigate = false;
    } else if ((jupiterPrefsAndAppData.routeFavorite ?? null) != null) {
      jupiterPrefsAndAppData.navigateRoutePlanner = false;
      getRouteNavigate = true;
      onCloseModalRoutePlanner(false);
      routeForFavorite = true;
      if (!loadingVisible) {
        await loadingRouteFromFavorite();
      }
      getRouteNavigate = false;
    }
  }

  void navigateSearchStation(BuildContext context) async {
    if (jupiterPrefsAndAppData.navigateRoutePlanner) {
      getNavigateRoutePlannerFromOtherPage();
    } else if ((jupiterPrefsAndAppData.routeFavorite ?? null) != null) {
      routeForFavorite = true;
      if (!loadingVisible) {
        await loadingRouteFromFavorite();
      }
    }
  }

  //******** start route planner **********//
  bool checkLoadingVisible() {
    return loadingVisible ? true : false;
  }

  String getIconMarkerRoute(int index) {
    switch (index) {
      case 0:
        return ImageAsset.ic_marker_start;
      case 1:
        return ImageAsset.ic_marker_a;
      case 2:
        return ImageAsset.ic_marker_b;
      case 3:
        return ImageAsset.ic_marker_c;
      case 4:
        return ImageAsset.ic_marker_d;
      case 5:
        return ImageAsset.ic_marker_e;
      case 6:
        return ImageAsset.ic_marker_f;
      case 7:
        return ImageAsset.ic_marker_g;
      case 8:
        return ImageAsset.ic_marker_h;
      case 9:
        return ImageAsset.ic_marker_dest;
      default:
        return ImageAsset.ic_marker_dest;
    }
  }

  void setHideShowMarkerStation(bool visible) {
    try {
      if (visible) {
        for (var i = 0; i < _markers.length; i++) {
          if (!(_markers[i].markerId.value.startsWith('POLY_'))) {
            _markers[i] = _markers[i].copyWith(
              visibleParam: true,
            );
            // debugPrint('count : true $i');
          }
        }
      } else {
        for (var i = 0; i < _markers.length; i++) {
          if (!(_markers[i].markerId.value.startsWith('POLY_'))) {
            _markers[i] = _markers[i].copyWith(
              visibleParam: false,
            );
            // debugPrint('count : false $i');
          }
        }
      }

      if (routePolylines.listRoute.length == 10) {
        setState(() {});
      }
    } catch (e) {
      debugPrint('Error ${e}');
    }
  }

  void getNamePlaceFromLatLng() {
    placemarkFromCoordinates(
            _currentMapPosition.latitude, _currentMapPosition.longitude,
            localeIdentifier: 'th_TH')
        .then((placemarks) {
      if (placemarks.isNotEmpty) {
        placemark = placemarks[0];
        if (!loadingVisible) {
          setState(() {});
        }
      } else {
        placemark = Placemark();
        // alertNoLocation();
      }
      loadingLocation = false;
    }).catchError((e) {
      if (routeVisible) {
        setState(() {
          placemark = Placemark();
          loadingLocation = false;
        });
      }
    });
  }

  void getNavigateRoutePlannerFromOtherPage() async {
    loadingVisible = true;
    stationBox = false;
    keyboardIsOpen = true;
    onCloseModalRoutePlanner(true);
  }

  void whenNavigateFromStationDetail() {
    if (jupiterPrefsAndAppData.navigateRoutePlanner == true) {
      jupiterPrefsAndAppData.navigateRoutePlanner = false;
      if (routePolylines.listRoute[1].latlng == LatLng(0, 0)) {
        routePolylines.listRoute[1] = RouteForm(
            name: jupiterPrefsAndAppData.detailForRoute?.stationName ?? '',
            latlng: LatLng(
                jupiterPrefsAndAppData.detailForRoute?.position[0] ?? 0,
                jupiterPrefsAndAppData.detailForRoute?.position[1] ?? 0),
            hintInput: translate("map_page.route_planner.current_location"),
            stationId: jupiterPrefsAndAppData.detailForRoute?.stationId ?? '',
            markerId:
                'POLY_${LatLng(jupiterPrefsAndAppData.detailForRoute?.position[0] ?? 0, jupiterPrefsAndAppData.detailForRoute?.position[1] ?? 0)}');
        indexRouteSelected = 1;
        detailSelect = jupiterPrefsAndAppData.detailForRoute;
        jupiterPrefsAndAppData.detailForRoute = null;
        onPressedAddMarker('SELECT_STATION');
      }
    }
  }

  Future<void> loadingRouteFromFavorite() async {
    var media = MediaQuery.of(context);
    var sizeRatio = media.devicePixelRatio;
    try {
      if (jupiterPrefsAndAppData.routeFavorite != null) {
        int indexRoute = 0;
        //ทำเมื่อมี เส้นทาง มากกว่า 0
        if ((jupiterPrefsAndAppData.routeFavorite?.routePoint ?? []).length >
            0) {
          //กำหนดค่า input ที่จะใช้แสดงใน modal สำหรับเลือก route
          routePolylines = RouteList(
              nameRoute: jupiterPrefsAndAppData.routeFavorite?.routeName ?? '',
              distance:
                  (jupiterPrefsAndAppData.routeFavorite?.routeDistance ?? 0)
                      .toDouble(),
              duration:
                  (jupiterPrefsAndAppData.routeFavorite?.routeDuration ?? 0)
                      .toDouble(),
              listRoute: [],
              pointsRoute: []);

          //loop เส้นทางทั้งหมดจาก favorite
          for (FavoriteRoutePointEntity routePoint
              in (jupiterPrefsAndAppData.routeFavorite?.routePoint ?? [])) {
            String name = '';
            LatLng latLng = LatLng(0, 0);

            /**************** Start กำหนดชื่อกับ latlng **********************/
            if (routePoint.name == RoutePlanner.ROUTE_CURRENT) {
              name = translate("map_page.route_planner.current_location");
              await _getCurrentLocationForRoute();

              if (!hideCurrentLocation) {
                latLng = LatLng(
                    _currentLocation.latitude, _currentLocation.longitude);
              } else {
                GoogleMapController controller = await _controller.future;
                CameraPosition locationCamera = CameraPosition(
                  target: LatLng(routePoint.latitude, routePoint.longitude),
                  zoom: 14.4746,
                );
                controller.animateCamera(
                    CameraUpdate.newCameraPosition(locationCamera));
                latLng = LatLng(routePoint.latitude, routePoint.longitude);
              }
            } else if (routePoint.stationId != '') {
              name = routePoint.stationName;
              latLng = LatLng(routePoint.latitude, routePoint.longitude);
            } else {
              name = routePoint.name;
              latLng = LatLng(routePoint.latitude, routePoint.longitude);
            }
            /**************** End กำหนดชื่อกับ latlng **********************/

            /**************** start add marker ****************/
            // หา icon pin
            markerIconRoute = await Utilities.imagePinIcon(
                (26 * sizeRatio).toInt(), getIconMarkerRoute(indexRoute));

            //เพิ่ม markId = _DUPLICATE ให้ marker ที่มีชื่อซ้ำ
            String markerID = '';
            List<Marker> checkUniqueKey = _markers
                .where((item) =>
                    (item.markerId.value.contains("POLY_${latLng.toString()}")))
                .toList();

            if (checkUniqueKey.length > 0) {
              markerID =
                  'POLY_${latLng.toString()}_DUPLICATE${checkUniqueKey.length + 1}';
            } else {
              markerID = 'POLY_${latLng.toString()}';
            }

            //เพิ่มเส้นทางลง input route (modal สำหรับเลือก route)
            routePolylines.listRoute.add(RouteForm(
                name: '${name}',
                latlng: latLng,
                hintInput: (indexRoute == 0)
                    ? translate("map_page.route_planner.current_location")
                    : translate("map_page.route_planner.select_destination"),
                stationId: '${routePoint.stationId}',
                markerId: markerID));

            _markers.add(Marker(
                icon: markerIconRoute,
                consumeTapEvents: true,
                markerId: MarkerId(markerID),
                position: latLng,
                onTap: () {}));

            /**************** end add marker  ****************/
            indexRoute++;
          }
          //จบ loop

          //ปิดหมุดที่ไม่ใช่ route
          setHideShowMarkerStation(false);

          //เช็คถ้ามีขอเส้นทางมากกว่า 1 จุด
          List<RouteForm> listRoute = routePolylines.listRoute
              .where((element) => element.latlng != LatLng(0, 0))
              .toList();
          if (listRoute.length > 1) {
            await getDirections(listRoute);
          } else {
            polylines.clear();
          }
        }
        routeVisible = true;
      }
    } catch (e) {
      debugPrint('error $e');
    }
  }

  Future<void> setIconMarkerRoute(
      {required bool isGetNewDirection, required bool isDeleteRoute}) async {
    var media = MediaQuery.of(context);
    var sizeRatio = media.devicePixelRatio;

    _markers.removeWhere((element) => element.markerId.value.contains("POLY_"));

    int index = 0;
    List<RouteForm> listMark = routePolylines.listRoute
        .where((element) => element.latlng != LatLng(0, 0))
        .toList();
    for (var marker in listMark) {
      // หา icon ใหม่
      markerIconRoute = await Utilities.imagePinIcon(
          (26 * sizeRatio).toInt(), getIconMarkerRoute(index));

      Marker newMarker = Marker(
        markerId: MarkerId(marker.markerId),
        position: marker.latlng,
        icon: markerIconRoute,
      );

      _markers.add(newMarker);
      index++;

      /// เช็ค darg and drop
      if (isGetNewDirection && index == listMark.length) {
        List<RouteForm> listRoute = routePolylines.listRoute
            .where((element) => element.latlng != LatLng(0, 0))
            .toList();
        await getDirections(listRoute);
      }

      /// เช็ค ลบ route
      if (isDeleteRoute && (index == listMark.length || listMark.length == 1)) {
        //เพิ่ม route input ว่าง
        if (routePolylines.listRoute.length < 10) {
          //เช็คว่ามี input ที่ว่างแล้วหรือยัง ถ้ายังให้เพิ่ม
          int check = routePolylines.listRoute
              .indexWhere((element) => element.latlng == LatLng(0, 0));
          if (check < 0) {
            addListRoute(RouteForm(
                name: translate("map_page.route_planner.select_destination"),
                latlng: LatLng(0, 0),
                hintInput:
                    translate("map_page.route_planner.select_destination"),
                stationId: '',
                markerId: ''));
          }
        }
        List<RouteForm> listRoute = routePolylines.listRoute
            .where((element) => element.latlng != LatLng(0, 0))
            .toList();
        if (listRoute.length > 1) {
          getDirections(listRoute);
        } else {
          polylines.clear();
        }
      }
    }
  }

  Future<bool> onDelectRoute(LatLng latLng, int index, String markerId) async {
    if (latLng == LatLng(0, 0)) {
      routePolylines.listRoute.removeAt(index);
      if (routePolylines.listRoute.length < 2) {
        addListRoute(RouteForm(
            name: translate("map_page.route_planner.select_destination"),
            latlng: LatLng(0, 0),
            hintInput: translate("map_page.route_planner.select_destination"),
            stationId: '',
            markerId: ''));
      }
    } else {
      routePolylines.listRoute.removeAt(index);
      _markers.removeWhere((element) => (element.markerId.value == markerId));
      await setIconMarkerRoute(isGetNewDirection: false, isDeleteRoute: true);
    }
    setState(() {});
    return true;
  }

  void onSelectStation(SearchStationEntity detail) {
    detailSelect = null;
    // try {
    //   BlocProvider.of<MapCubit>(context).loadStationDetail(detail.stationId,
    //       _currentLocation.latitude, _currentLocation.longitude);
    // } catch (e) {}

    detailSelect = StationDetailEntity(
      stationId: detail.stationId,
      stationName: detail.stationName,
      facility: [],
      position: detail.position,
      address: '',
      eta: detail.eta,
      distance: detail.distance,
      openingHours: [],
      images: [],
      statusOpening: detail.statusOpening,
      totalConnector: detail.totalConnector,
      connectorAvailable: detail.connectorAvailable,
      connectorType: detail.connectorType,
      statusMarker: '',
      charger: [],
      favorite: false,
      lowPriorityTariff: false,
    );

    try {
      _getCameraPosition(LatLng(detailSelect?.position[0] ?? defaultLatitude,
          detailSelect?.position[1] ?? defaultLongitude));
    } catch (e) {}
    // setState(() {
    //   loadingVisible = false;
    //   clickMarkerSelectStation = addSelectRoute;
    // });

    onPressedAddMarker('SELECT_STATION');

    Navigator.of(context).pop();
  }

  void addListRoute(RouteForm latLng) {
    routePolylines.listRoute.add(latLng);
    if (routePolylines.listRoute.length >= 3) {
      for (var index = 0; index < routePolylines.listRoute.length; index++) {
        var route = routePolylines.listRoute[index];
        if ((index > 0) && (index < routePolylines.listRoute.length - 1)) {
          if ((route.latlng.latitude == 0) && (route.latlng.longitude == 0)) {
            routePolylines.listRoute[index].name = 'Select Stop Point';
          }
        }
      }
    }
    setState(() {});
  }

  void selectRouteItem(int select) {
    indexRouteSelected = select;
    setState(() {});
  }

  Future<void> onReorderPointItem(int oldIndex, int newIndex) async {
    List<RouteForm> newListRoute = routePolylines.listRoute;
    int lastIndex = newListRoute.length - 1;
    int realNewIndex = oldIndex > newIndex
        ? newIndex
        : newIndex - 1 >= 0
            ? newIndex - 1
            : 0;
    bool lastLatIndexIsZero = newListRoute[lastIndex].latlng.latitude == 0;
    bool lastLngIndexIsZero = newListRoute[lastIndex].latlng.longitude == 0;
    bool selectLatIndexIsZero = newListRoute[oldIndex].latlng.latitude == 0;
    bool selectLngIndexIsZero = newListRoute[oldIndex].latlng.longitude == 0;
    debugPrint('${oldIndex} : oldIndex');
    debugPrint('${realNewIndex} : newIndex');
    if (realNewIndex == lastIndex && lastLatIndexIsZero && lastLngIndexIsZero) {
      debugPrint('RETURN FOR EMPTY LATLNG LASTINDEX');
      return;
    } else if (selectLatIndexIsZero && selectLngIndexIsZero) {
      debugPrint('RETURN FOR EMPTY LATLNG SELECT');
      return;
    } else {
      debugPrint('CHANGE INDEX');
      final removeItem = newListRoute.removeAt(oldIndex);
      newListRoute.insert(realNewIndex, removeItem);
      routePolylines.listRoute = newListRoute;
      setIconMarkerRoute(isGetNewDirection: true, isDeleteRoute: false);
    }
  }

  void onCloseModalRoutePlanner(bool value) async {
    routeVisible = value;
    if (value == false) {
      _markers.removeWhere((element) => (element.markerId)
          .toString()
          .toUpperCase()
          .contains('POLY_'.toUpperCase()));
      indexRouteSelected = -1;
      routePolylines =
          RouteList(nameRoute: '', distance: 0, duration: 0, listRoute: [
        RouteForm(
            name: translate("map_page.route_planner.current_location"),
            latlng: LatLng(0, 0),
            hintInput: translate("map_page.route_planner.current_location"),
            stationId: '',
            markerId: ''),
        RouteForm(
            name: translate("map_page.route_planner.select_destination"),
            latlng: LatLng(0, 0),
            hintInput: translate("map_page.route_planner.select_destination"),
            stationId: '',
            markerId: '')
      ], pointsRoute: []);
      try {
        polylines.clear();
      } catch (e) {
        debugPrint('error $e');
      }
      if (!getRouteNavigate) {
        jupiterPrefsAndAppData.routeFavorite = null;
      }
      getRouteNavigate = false;
      clickMarkerSelectStation = clickDefault;

      setHideShowMarkerStation(true);
      setState(() {});
    } else {
      indexRouteSelected = 0;
      loadingVisible = true;
      onPressedAddMarker('CURRENT_LOCATION');
    }
  }

  void onPressedAddMarker(String type) async {
    //รูป marker
    var media = MediaQuery.of(context);
    var sizeRatio = media.devicePixelRatio;

    //แบ่ง case การเลือก route แต่ละประเภท
    switch (type) {
      case 'CURRENT_LOCATION':
        await _getCurrentLocationForRoute();

        //ชื่อในช่อง input
        if (!hideCurrentLocation) {
          routePolylines.listRoute[indexRouteSelected].name =
              translate("map_page.route_planner.current_location");
        } else {
          routePolylines.listRoute[indexRouteSelected].name =
              '${_currentLocation.latitude},${_currentLocation.longitude}';
        }

        markerIconRoute = await Utilities.imagePinIcon(
            (26 * sizeRatio).toInt(), getIconMarkerRoute(indexRouteSelected));
        setRouteInFormInput(
            LatLng(_currentLocation.latitude, _currentLocation.longitude));

        break;
      case 'SELECT_STATION':
        LatLng latLngStationSelect =
            Utilities.createPositionLatLng(detailSelect?.position ?? []);
        //เช็คถ้าเลือก input route ตัวสุดท้าย
        if (clickMarkerSelectStation == addLastRoute) {
          indexRouteSelected = routePolylines.listRoute.length - 1;
          // clickMarkerSelectStation = clickDefault;
        }
        if (latLngStationSelect == LatLng(0, 0)) {
          alertNoLocation();
        } else {
          //ชื่อในช่อง input
          routePolylines.listRoute[indexRouteSelected].name =
              detailSelect?.stationName ?? '';
          routePolylines.listRoute[indexRouteSelected].stationId =
              detailSelect?.stationId ?? '';
          markerIconRoute = await Utilities.imagePinIcon(
              (26 * sizeRatio).toInt(), getIconMarkerRoute(indexRouteSelected));
          setRouteInFormInput(LatLng(
              latLngStationSelect.latitude, latLngStationSelect.longitude));
        }

        clickMarkerSelectStation = clickDefault;

        break;
      default:
        //MOVEPIN
        if (LatLng(
                _currentMapPosition.latitude, _currentMapPosition.longitude) ==
            LatLng(0, 0)) {
          alertNoLocation();
        } else {
          if (placemark != Placemark()) {
            if (placemark.street == '') {
              routePolylines.listRoute[indexRouteSelected].name =
                  '${_currentMapPosition.latitude},${_currentMapPosition.longitude}';
            } else {
              routePolylines.listRoute[indexRouteSelected].name =
                  '${placemark.street}';
            }
          } else {
            routePolylines.listRoute[indexRouteSelected].name = '';
            alertNoLocation();
          }
          markerIconRoute = await Utilities.imagePinIcon(
              (26 * sizeRatio).toInt(), getIconMarkerRoute(indexRouteSelected));
          setRouteInFormInput(LatLng(
              _currentMapPosition.latitude, _currentMapPosition.longitude));
        }

        break;
    }
  }

  setRouteInFormInput(latLng) async {
    _markers.removeWhere((element) => element.markerId.value.contains(
        'POLY_${routePolylines.listRoute[indexRouteSelected].latlng}'));
    routePolylines.listRoute[indexRouteSelected].latlng = latLng;
    if (routePolylines.listRoute.length < 10) {
      int indexRoute = routePolylines.listRoute
          .indexWhere((item) => item.latlng == LatLng(0, 0));
      if (indexRoute >= 0) {
      } else {
        addListRoute(RouteForm(
            name: translate("map_page.route_planner.select_destination"),
            latlng: LatLng(0, 0),
            hintInput: translate("map_page.route_planner.select_destination"),
            stationId: '',
            markerId: ''));
      }
    }

    String markerID = '';
    List<Marker> checkUniqueKey = _markers
        .where((item) =>
            (item.markerId.value.contains("POLY_${latLng.toString()}")))
        .toList();

    if (checkUniqueKey.length > 0) {
      markerID =
          'POLY_${latLng.toString()}_DUPLICATE${checkUniqueKey.length + 1}';
    } else {
      markerID = 'POLY_${latLng.toString()}';
    }
    routePolylines.listRoute[indexRouteSelected].markerId = markerID;
    _markers.add(Marker(
        icon: markerIconRoute,
        consumeTapEvents: true,
        markerId: MarkerId(markerID),
        position: latLng,
        onTap: () {}));

    List<RouteForm> listRoute = routePolylines.listRoute
        .where((element) => element.latlng != LatLng(0, 0))
        .toList();

    if (listRoute.length > 1) {
      getDirections(listRoute);
    } else {
      polylines.clear();
    }
    whenNavigateFromStationDetail();
    setState(() {
      loadingVisible = false;
    });
  }

  getDirections(List<RouteForm> listRoute) async {
    List<RoutePlanningLocationForm> intermediates = [];
    int index = 0;
    for (var route in listRoute) {
      if (index != 0) {
        if (index != (listRoute.length - 1)) {
          if (listRoute.length > 2) {
            intermediates.add(RoutePlanningLocationForm(
                location: RoutePlanningLatLngForm(
                    latLng: RoutePlanningLatLngDataForm(
                        latitude: route.latlng.latitude,
                        longitude: route.latlng.longitude))));
          }
        }
      }
      index++;
    }

    RoutePlanningLocationForm origin = RoutePlanningLocationForm(
        location: RoutePlanningLatLngForm(
            latLng: RoutePlanningLatLngDataForm(
                latitude: listRoute.first.latlng.latitude,
                longitude: listRoute.first.latlng.longitude)));
    RoutePlanningLocationForm destination = RoutePlanningLocationForm(
        location: RoutePlanningLatLngForm(
            latLng: RoutePlanningLatLngDataForm(
                latitude: listRoute.last.latlng.latitude,
                longitude: listRoute.last.latlng.longitude)));

    String travelMode = 'DRIVE';
    String routingPreference = 'TRAFFIC_AWARE';
    bool computeAlternativeRoutes = false;
    RoutePlanningModifiersForm routeModifiers = RoutePlanningModifiersForm(
        avoidTolls: false, avoidHighways: false, avoidFerries: false);
    String languageCode = 'th_TH';

    try {
      BlocProvider.of<MapCubit>(context).getRoutePlanner(
          origin,
          destination,
          intermediates,
          travelMode,
          routingPreference,
          computeAlternativeRoutes,
          routeModifiers,
          languageCode);
    } catch (e) {}
  }

  addPolyLine(List<LatLng> polylineCoordinates) async {
    setState(() {
      polylines.clear();
    });
    PolylineId id = PolylineId("POLY");
    Polyline polyline = Polyline(
      polylineId: id,
      color: AppTheme.blueD,
      points: polylineCoordinates,
      width: 6,
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        polylines[id] = polyline;
        loadingVisible = false;
        routeForFavorite = false;
      });
    });
  }

  PolylineResult getRouteBetweenCoordinates(
      RoutePlanningEntity? dataRoutePlanner) {
    try {
      List<RoutePlanningDataModelEntity> routeList =
          dataRoutePlanner?.routes ?? [];
      int distance = 0;
      int duration = 0;
      routePolylines.pointsRoute = [];
      for (var route in routeList) {
        for (var legs in route.legs) {
          distance += legs.distanceMeters;
          int wordDuration = 0;
          try {
            wordDuration = int.parse('${(legs.duration).replaceAll("s", "")}');
          } catch (e) {}

          duration += wordDuration;

          routePolylines.pointsRoute.add(DurationAndDistance(
              distance: legs.distanceMeters, duration: wordDuration));
        }

        int wordDurationValue = 0;
        try {
          wordDurationValue =
              int.parse('${(route.legs[0].duration).replaceAll("s", "")}');
        } catch (e) {}

        resultsPolyline.add(PolylineResult(
            points: PolylineDecoder.run(route.polyline.encodedPolyline),
            errorMessage: "",
            status: STATUS_OK,
            distance: '',
            distanceValue: route.legs[0].distanceMeters,
            overviewPolyline: route.polyline.encodedPolyline,
            durationValue: wordDurationValue,
            endAddress: '',
            startAddress: '',
            duration: ''));
      }

      routePolylines.distance = distance / 1000;
      routePolylines.duration = duration.toDouble();
      debugPrint('${routePolylines.distance} ${routePolylines.duration}');
      debugPrint('-------------------------');
      return resultsPolyline.isNotEmpty
          ? resultsPolyline[resultsPolyline.length - 1]
          : PolylineResult(errorMessage: "No result found");
    } catch (e) {
      rethrow;
    }
  }

  void onSetModalInRoutePlannerPage(String type, bool value) {
    if (type == 'SELECT_ROUTE') {
      selectRoute = value;
      movePin = !value;
      selectStation = !value;
    } else if (type == 'MOVEPIN') {
      selectRoute = !value;
      movePin = value;
      if (value) {
        setHideShowMarkerStation(false);
      } else {
        setHideShowMarkerStation(true);
      }
    } else if (type == 'SELECT_STATION') {
      selectRoute = !value;
      if (!value) {
        movePin = false;
      } else {
        movePin = !value;
      }
      selectStation = value;
    } else {
      movePin = false;
      selectRoute = false;
      selectStation = false;
    }
    setState(() {});
  }

  void alertNoLocation() {
    Utilities.alertOneButtonAction(
      context: context,
      type: AppAlertType.DEFAULT,
      isForce: true,
      title: translate('alert_not_found_location.title'),
      description: translate('alert_not_found_location.description'),
      textButton: translate('button.try_again'),
      onPressButton: () {
        Navigator.of(context).pop();
      },
    );
  }

  void _onCameraMove(CameraPosition position) {
    _currentMapPosition = position.target;
    if (routeVisible) {
      if (!loadingLocation) {
        setState(() {
          loadingLocation = true;
        });
      }
    }
  }

  void _onMapCreated(GoogleMapController controller) async {
    _controller.complete(controller);
    try {
      getNamePlaceFromLatLng();
    } catch (e) {
      placemark = Placemark();
      debugPrint('Error _onMapCreated : $e');
    }
  }

  void _onCameraIdle() async {
    if (routeVisible) {
      placemark = Placemark();
      try {
        getNamePlaceFromLatLng();
      } catch (e) {
        placemark = Placemark();
        loadingLocation = false;
        debugPrint('Error _onCameraIdle : $e');
        alertNoLocation();
      }
    }
  }

  Future<void> _goCurrentLocation() async {
    // if (!loadMarkerRoute) {
    //   WidgetsBinding.instance.addPostFrameCallback((_) async {
    //     debugPrint('start getBitmapsRoute');
    //     await getBitmapsRoute(context, globalKeysRoute);
    //     loadMarkerRoute = true;
    //   });
    // }
    final GoogleMapController controller = await _controller.future;
    try {
      _currentLocation = await Utilities.getUserCurrentLocation();
      CameraPosition currentLocationCamera = CameraPosition(
        target: LatLng(_currentLocation.latitude, _currentLocation.longitude),
        zoom: 14.4746,
      );
      controller
          .animateCamera(CameraUpdate.newCameraPosition(currentLocationCamera));
      loadingAllMarker(_currentLocation);
      setState(() {
        isPermissionLocation = true;
      });
    } catch (e) {
      try {
        _currentLocation = Position(
          longitude: defaultLongitude,
          latitude: defaultLatitude,
          timestamp: new DateTime.now(),
          accuracy: 0,
          altitude: 0,
          heading: 0,
          speed: 0,
          speedAccuracy: 0,
          altitudeAccuracy: 0,
          headingAccuracy: 0,
        );
        CameraPosition currentLocationCamera = CameraPosition(
          target: LatLng(_currentLocation.latitude, _currentLocation.longitude),
          zoom: 14.4746,
        );
        controller.animateCamera(
            CameraUpdate.newCameraPosition(currentLocationCamera));
        loadingAllMarker(_currentLocation);
        setState(() {
          isPermissionLocation = false;
          isCheckedDistance = false;
        });
      } catch (e) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (loadingVisible) {
            setState(() {
              loadingVisible = false;
            });
            BlocProvider.of<MapCubit>(context).resetCubitMap();
          }
        });
      }
    }
  }

  Future<void> _getCurrentLocationForRoute() async {
    GoogleMapController controller = await _controller.future;
    try {
      _currentLocation = await Utilities.getUserCurrentLocation();
      CameraPosition currentLocationCamera = CameraPosition(
        target: LatLng(_currentLocation.latitude, _currentLocation.longitude),
        zoom: 14.4746,
      );
      controller
          .animateCamera(CameraUpdate.newCameraPosition(currentLocationCamera));
      hideCurrentLocation = false;
    } catch (e) {
      hideCurrentLocation = true;
      _currentLocation = Position(
        longitude: defaultLongitude,
        latitude: defaultLatitude,
        timestamp: new DateTime.now(),
        accuracy: 0,
        altitude: 0,
        heading: 0,
        speed: 0,
        speedAccuracy: 0,
        altitudeAccuracy: 0,
        headingAccuracy: 0,
      );
      CameraPosition currentLocationCamera = CameraPosition(
        target: LatLng(_currentLocation.latitude, _currentLocation.longitude),
        zoom: 14.4746,
      );
      controller
          .animateCamera(CameraUpdate.newCameraPosition(currentLocationCamera));
    }
  }

  Future<void> _getCameraPosition(LatLng latlng) async {
    GoogleMapController controller = await _controller.future;
    try {
      _currentLocation = await Utilities.getUserCurrentLocation();
      CameraPosition locationCamera = CameraPosition(
        target: latlng,
        zoom: 14.4746,
      );
      controller.animateCamera(CameraUpdate.newCameraPosition(locationCamera));
      hideCurrentLocation = false;
    } catch (e) {
      hideCurrentLocation = true;
      _currentLocation = Position(
        longitude: defaultLongitude,
        latitude: defaultLatitude,
        timestamp: new DateTime.now(),
        accuracy: 0,
        altitude: 0,
        heading: 0,
        speed: 0,
        speedAccuracy: 0,
        altitudeAccuracy: 0,
        headingAccuracy: 0,
      );
      CameraPosition locationCamera = CameraPosition(
        target: latlng,
        zoom: 14.4746,
      );
      controller.animateCamera(CameraUpdate.newCameraPosition(locationCamera));
    }
  }

  //******** end route planner **********//

  void actionMapLoading() {
    debugPrint('MapLoading');
    stationBox = false;
    keyboardIsOpen = true;
    if (!loadingVisible) {
      setState(() {
        loadingVisible = true;
      });
    }
  }

  void actionMapLoadMarkerSuccess(state) {
    debugPrint('MapLoadMarkerSuccess');
    if (loadingVisible) {
      setState(() {
        _markerData = state.markerData!;
      });
      if (_markerData.length > 0) {
        loadMarkerStation = true;
        setGlobalKeys();
        WidgetsBinding.instance.addPostFrameCallback((_) async {
          await getBitmaps(context);
          addMarkerData();
        });
      } else {
        _markers.clear();
        setState(() {
          loadingVisible = false;
        });
      }
    }
  }

  void actionMapLoadMarkerFailure() {
    debugPrint('MapLoadMarkerFailure');
    if (loadingVisible) {
      setState(() {
        loadingVisible = false;
      });
      Utilities.alertOneButtonAction(
        context: context,
        type: AppAlertType.DEFAULT,
        isForce: true,
        title: translate('alert.title.default'),
        description: translate('alert.description.default'),
        textButton: translate('button.try_again'),
        onPressButton: () {
          Navigator.of(context).pop();
        },
      );
    }
  }

  void actionMapLoadStationDetailSuccess(state) {
    if (loadingVisible) {
      if (!routeVisible) {
        debugPrint('MapLoadStationDetailSuccess');
        _detailInfo[_lastestMarkerId] = state.stationDetail;
        setState(() {
          favoriteStation = _detailInfo[_lastestMarkerId]?.favorite;
          _detailInfo = _detailInfo;
          loadingVisible = false;
        });
        // addInfoWindow(_lastestMarkerId, _lastestLatLng);
        addStationBox(_lastestMarkerId);
      } else {
        detailSelect = state.stationDetail;
        try {
          _getCameraPosition(LatLng(
              detailSelect?.position[0] ?? defaultLatitude,
              detailSelect?.position[1] ?? defaultLongitude));
        } catch (e) {}
        if (loadSelectStation) {
          setState(() {
            loadingVisible = false;
            selectRoute = false;
            movePin = false;
            selectStation = true;
            loadSelectStation = false;
            clickMarkerSelectStation = addLastRoute;
          });
        } else {
          setState(() {
            loadingVisible = false;
            clickMarkerSelectStation = addSelectRoute;
          });
        }
      }
    }
  }

  void actionMapLoadStationDetailFailure() {
    debugPrint('MapLoadStationDetailFailure');
    if (loadingVisible) {
      setState(() {
        loadingVisible = false;
      });
      Utilities.alertOneButtonAction(
        context: context,
        type: AppAlertType.DEFAULT,
        isForce: true,
        title: translate('alert.title.default'),
        description: translate('alert.description.default'),
        textButton: translate('button.try_again'),
        onPressButton: () {
          Navigator.of(context).pop();
        },
      );
    }
  }

  void actionFavoriteStationAddSuccess() {
    if (favoriteStation == true) {
      setState(() {
        favoriteStation = false;
      });
      Utilities.alertAfterSaveAction(
        context: context,
        type: AppAlertType.SUCCESS,
        text:
            translate('alert_after_save.save_success.delete_favorite_station'),
      );
    } else {
      setState(() {
        favoriteStation = true;
      });
      Utilities.alertAfterSaveAction(
        context: context,
        type: AppAlertType.SUCCESS,
        text: translate('alert_after_save.save_success.add_favorite_station'),
      );
    }
  }

  void actionFavoriteStationAddFailure() {
    // ScaffoldMessenger.of(context).showSnackBar(
    //   const SnackBar(content: Text('Cannot save data !!!')),
    // );
    Utilities.alertAfterSaveAction(
      context: context,
      type: AppAlertType.WARNING,
      time: 5,
      text: translate('alert_after_save.save_failure.add_favorite_station'),
    );
  }

  void actionDefault() {
    setState(() {
      loadingVisible = false;
    });
  }

  void actionRoutePlannerLoading() {
    if (!loadingVisible) {
      setState(() {
        loadingVisible = true;
      });
    }
  }

  void actionRoutePlannerSuccess(state) async {
    if (loadingVisible) {
      RoutePlanningEntity? dataRoutePlanner = state.data!;
      List<LatLng> polylineCoordinates = [];
      try {
        PolylineResult result =
            await getRouteBetweenCoordinates(dataRoutePlanner ?? null);
        if (result.points.isNotEmpty) {
          result.points.forEach((PointLatLng point) {
            polylineCoordinates.add(LatLng(point.latitude, point.longitude));
          });
          addPolyLine(polylineCoordinates);
        } else {
          debugPrint(result.errorMessage);
          setState(() {
            loadingVisible = false;
          });
        }
      } catch (e) {
        setState(() {
          loadingVisible = false;
          routeForFavorite = false;
        });
      }
    }
  }

  void actionRoutePlannerFailure(state) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (loadingVisible) {
        setState(() {
          loadingVisible = false;
          routeForFavorite = false;
        });
        Utilities.alertOneButtonAction(
          context: context,
          type: AppAlertType.DEFAULT,
          isForce: true,
          title: translate('alert.title.default'),
          description: state.message ?? translate('alert.description.default'),
          textButton: translate('button.try_again'),
          onPressButton: () {
            BlocProvider.of<MapCubit>(context).resetCubitMap();
            Navigator.of(context).pop();
          },
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // endDrawer: const FilterMapStation(),
      body: BlocListener<MapCubit, MapState>(
        listener: (context, state) {
          switch (state.runtimeType) {
            case MapLoading:
              actionMapLoading();
              break;
            case MapLoadMarkerSuccess:
              actionMapLoadMarkerSuccess(state);
              break;
            case MapLoadMarkerFailure:
              actionMapLoadMarkerFailure();
              break;
            case MapLoadStationDetailSuccess:
              actionMapLoadStationDetailSuccess(state);
              break;
            case MapLoadStationDetailFailure:
              actionMapLoadStationDetailFailure();
              break;
            case FavoriteStationAddLoading:
              break;
            case FavoriteStationAddSuccess:
              actionFavoriteStationAddSuccess();
              break;
            case FavoriteStationAddFailure:
              actionFavoriteStationAddFailure();
              break;
            case RoutePlannerLoading:
              actionRoutePlannerLoading();
              break;
            case RoutePlannerSuccess:
              actionRoutePlannerSuccess(state);
              break;
            case RoutePlannerFailure:
              actionRoutePlannerFailure(state);
              break;
            default:
              actionDefault();
              break;
          }
        },
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  ImageMarker(
                    stationData: _markerData,
                    globalKeys: globalKeys,
                    loadMarkerStation: loadMarkerStation,
                  ),
                  _markers.length > 0
                      ? GoogleMap(
                          mapType: MapType.normal,
                          initialCameraPosition: _initCamera,
                          onMapCreated: _onMapCreated,
                          zoomControlsEnabled: false,
                          myLocationEnabled: true,
                          myLocationButtonEnabled: false,
                          markers: _markers.toSet(),
                          polylines: Set<Polyline>.of(polylines.values),
                          onTap: (position) {
                            if (!routeVisible) {
                              stationBox = false;
                              keyboardIsOpen = true;
                              setState(() {});
                            }
                          },
                          onCameraMove: _onCameraMove,
                          onCameraIdle: () {
                            _onCameraIdle();
                            debugPrint('onCameraIdle');
                          },
                          onCameraMoveStarted: () {
                            debugPrint('onCameraMoveStarted');
                          })
                      : GoogleMap(
                          mapType: MapType.normal,
                          initialCameraPosition: _initCamera,
                          onMapCreated: _onMapCreated,
                          zoomControlsEnabled: false,
                          myLocationEnabled: true,
                          myLocationButtonEnabled: false,
                          onTap: (position) {
                            stationBox = false;
                            keyboardIsOpen = true;
                            setState(() {});
                          },
                          onCameraMove: _onCameraMove,
                          onCameraIdle: () {}),
                  Visibility(
                    visible: !routeVisible,
                    child: SearchAppBarMap(
                        isButton: true,
                        search: false,
                        focus: _focus,
                        onChangedApply: loadingFilterMarker,
                        onchangeReset: resetFilter,
                        onchangeAC: loadingFilterACMarker,
                        onchangeDC: loadingFilterDCMarker,
                        onchangeOpenServiceMap: loadingFilterOpenService,
                        isCheckedDistance: isCheckedDistance,
                        isCheckedOpenService: isCheckedOpenService,
                        isCheckedChargerAvailable: isCheckedChargerAvailable,
                        isCheckedACCS1: isCheckedACCS1,
                        isCheckedACCS2: isCheckedACCS2,
                        isCheckedACCHAdeMO: isCheckedACCHAdeMO,
                        isCheckedDCCS1: isCheckedDCCS1,
                        isCheckedDCCS2: isCheckedDCCS2,
                        isCheckedDCCHAdeMO: isCheckedDCCHAdeMO,
                        filterConnectorAC: filterConnectorAC,
                        filterConnectorDC: filterConnectorDC,
                        isPermissionLocation: isPermissionLocation,
                        navigateSearchStation: navigateSearchStation),
                  ),
                  Visibility(
                    visible: stationBox && !loadingVisible,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: 465,
                        child: InfoStationBox(
                          detail: _detailInfo[_lastestMarkerId],
                          listConnector: _listConnector,
                          favoriteStation: favoriteStation!,
                          onTapStationDetail: onTapStationDetail,
                          isPermissionLocation: isPermissionLocation,
                          getNavigateRoutePlannerFromOtherPage:
                              getNavigateRoutePlannerFromOtherPage,
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: routeVisible && (_markers.length > 0),
                    child: RoutePlannerPage(
                        onCloseModalRoutePlanner: onCloseModalRoutePlanner,
                        onPressedAddMarker: onPressedAddMarker,
                        floatLocation: floatLocation(),
                        floatFavorite: floatFavorite(),
                        onSelectStation: onSelectStation,
                        routePolylines: routePolylines,
                        addListRoute: addListRoute,
                        selectRouteItem: selectRouteItem,
                        indexSelectItem: indexRouteSelected,
                        detail: detailSelect,
                        onDeleteRoute: onDelectRoute,
                        onReorderPointItem: onReorderPointItem,
                        setHideShowMarkerStation: setHideShowMarkerStation,
                        onSetModalInRoutePlannerPage:
                            onSetModalInRoutePlannerPage,
                        selectRoute: selectRoute,
                        movePin: movePin,
                        selectStation: selectStation,
                        placemark: placemark,
                        currentMapPosition: _currentMapPosition,
                        loadingLocation: loadingLocation,
                        checkLoadingVisible: checkLoadingVisible),
                  ),
                  LoadingPage(visible: loadingVisible)
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: const _CustomFloatingActionButtonLocation(),
      floatingActionButton: Visibility(
        visible: keyboardIsOpen,
        child: Visibility(
          visible: !routeVisible,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              floatLocation(),
              const SizedBox(height: 16),
              floatFavorite(),
              const SizedBox(height: 16),
              FloatingActionButton(
                heroTag: 'floatRoutePlanner',
                onPressed: () {
                  if (!loadingVisible && !routeForFavorite) {
                    onCloseModalRoutePlanner(true);
                  }
                },
                backgroundColor: AppTheme.white,
                child: SvgPicture.asset(
                  ImageAsset.ic_route_planner,
                  width: 40,
                  height: 40,
                ),
              ),
              SizedBox(height: Platform.isIOS ? 16 : 0),
            ],
          ),
        ),
      ),
    );
  }

  Widget floatLocation() {
    return FloatingActionButton(
      heroTag: 'floatLocation',
      onPressed: () {
        if (!loadingVisible && !routeForFavorite) {
          if (routeVisible) {
            _getCurrentLocationForRoute();
          } else {
            _goCurrentLocation();
          }
        }
      },
      backgroundColor: AppTheme.white,
      child: SvgPicture.asset(
        ImageAsset.ic_location,
        width: 28,
        height: 28,
      ),
    );
  }

  Widget floatFavorite() {
    return FloatingActionButton(
      heroTag: 'floatFavorite',
      onPressed: () {
        if (!loadingVisible && !routeForFavorite) {
          navigateToFavorite(context);
        }
      },
      backgroundColor: AppTheme.white,
      child: SvgPicture.asset(
        ImageAsset.ic_map_favorite,
        width: 40,
        height: 40,
      ),
    );
  }
}

class _CustomFloatingActionButtonLocation extends FloatingActionButtonLocation {
  const _CustomFloatingActionButtonLocation();
  @override
  Offset getOffset(ScaffoldPrelayoutGeometry scaffoldGeometry) {
    final double fabX = (scaffoldGeometry.scaffoldSize.width -
            scaffoldGeometry.floatingActionButtonSize.width) -
        16;
    final double fabY = (scaffoldGeometry.scaffoldSize.height -
            scaffoldGeometry.floatingActionButtonSize.height) -
        116;
    return Offset(fabX, fabY);
  }
}

class RouteList {
  RouteList({
    required this.nameRoute,
    required this.distance,
    required this.duration,
    required this.listRoute,
    required this.pointsRoute,
  });
  String nameRoute;
  double distance;
  double duration;
  List<RouteForm> listRoute;
  List<DurationAndDistance> pointsRoute;
}

class RouteForm {
  RouteForm(
      {required this.name,
      required this.latlng,
      required this.hintInput,
      required this.stationId,
      required this.markerId});
  String name;
  LatLng latlng;
  String hintInput;
  String stationId = '';
  String markerId = '';
}

class DurationAndDistance {
  DurationAndDistance({required this.distance, required this.duration});
  int distance;
  int duration;
}
