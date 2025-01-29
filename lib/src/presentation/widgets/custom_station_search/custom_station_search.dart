import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:geolocator/geolocator.dart';
import 'package:jupiter/src/apptheme.dart';
import 'package:jupiter/src/constant_value.dart';
import 'package:jupiter/src/presentation/pages/map/map_page.dart';
import 'package:jupiter/src/presentation/widgets/unfocus_area.dart';
import 'package:jupiter_api/domain/entities/finding_station_entity.dart';
import 'package:jupiter_api/domain/entities/search_station_entity.dart';
import 'package:jupiter/src/images_asset.dart';
import 'package:jupiter/src/injection.dart';
import 'package:jupiter/src/presentation/widgets/button_close_keyboard.dart';
import 'package:jupiter/src/presentation/widgets/custom_app_bar_with_search/cubit/custom_app_bar_with_search_cubit.dart';
import 'package:jupiter/src/presentation/widgets/loading_page.dart';
import 'package:jupiter/src/presentation/widgets/search_app_bar_map.dart';
import 'package:jupiter/src/presentation/widgets/text_label.dart';
import 'package:jupiter/src/utilities.dart';
import 'widgets/station_search_item.dart';

class CustomStationSearchWrapperProvider extends StatelessWidget {
  const CustomStationSearchWrapperProvider({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<CustomAppBarWithSearchCubit>(),
      child: CustomStationSearch(
        title: '',
      ),
    );
  }
}

// ignore: must_be_immutable
class CustomStationSearch extends StatefulWidget {
  CustomStationSearch(
      {super.key,
      required this.title,
      this.routePlanner,
      this.onSetModalInRoutePlannerPage,
      this.onPressedAddMarker,
      this.onSelectStation,
      this.routePolylines,
      this.getScrollPosition});
  final String title;

  // route planner
  final bool? routePlanner;
  final Function(String, bool)? onSetModalInRoutePlannerPage;
  final Function(String)? onPressedAddMarker;
  final Function(SearchStationEntity)? onSelectStation;
  final RouteList? routePolylines;
  final Function()? getScrollPosition;

  @override
  State<StatefulWidget> createState() => _CustomStationSearchState();
}

class _CustomStationSearchState extends State<CustomStationSearch> {
  final searchController = TextEditingController();

  final FocusNode _focus = FocusNode();
  bool _listViewVisible = false;
  // late double _useSize;
  double defaultLatitude = 13.76483333;
  double defaultLongitude = 100.5382222;
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
  FindingStationEntity? findingStationEntity;
  bool loadingVisible = true;
  EdgeInsets? viewInsets;
  String? _searchText = '';

  bool pageFilter = true;
  List<SearchStationEntity>? _stationList =
      List.empty(growable: true); // use show
  List<SearchStationEntity>? _stationListFull =
      List.empty(growable: true); // kept list all
  List<SearchStationEntity>? _stationListFilter =
      List.empty(growable: true); // use filter not included search

  final searchControl = TextEditingController();
  bool filterStatus = false;
  bool moreFilter = false;

  double heightRoute = 0;
  bool checkClickCurrentLocation = false;
  bool hideCurrentLocation = false;

  bool? isCheckedDistance = false;
  bool? isCheckedOpenService = false;
  bool? isCheckedChargerAvailable = false;

  bool? isCheckedACCS1 = false;
  bool? isCheckedACCS2 = false;
  bool? isCheckedACCHAdeMO = false;
  bool? isCheckedDCCS1 = false;
  bool? isCheckedDCCS2 = false;
  bool? isCheckedDCCHAdeMO = false;

  List<String?>? filterConnectorAC = [];
  List<String?>? filterConnectorDC = [];

  @override
  void initState() {
    _focus.hasFocus;
    _focus.addListener(_onFocusChange);
    findStationAll();

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      // Status bar color
      statusBarColor: Colors.transparent,
      // // Status bar brightness (optional)
      statusBarIconBrightness: Brightness.light, // For Android (dark icons)
      statusBarBrightness: Brightness.light, // For iOS (dark icons)
    ));

    if (widget.routePlanner == true) {
      heightRoute = 130;
    }

    super.initState();
  }

  @override
  void dispose() {
    _focus.dispose();
    super.dispose();
  }

  int countCurrentLocation() {
    if (widget.routePolylines != null) {
      int count = 0;
      if (!hideCurrentLocation) {
        count = (widget.routePolylines?.listRoute ?? [])
            .where((item) => (item.name ==
                translate("map_page.route_planner.current_location")))
            .toList()
            .length;
        if (count < 2) {
        } else {
          heightRoute = 65;
        }
      } else {
        count = 3;
        heightRoute = 65;
      }

      return count;
    } else {
      return 0;
    }
  }

  List<SearchStationEntity> searchStation(List<SearchStationEntity>? list) {
    var stationList;
    try {
      stationList = list!.where((element) {
        return element.stationName
            .toLowerCase()
            .contains(searchControl.text.toLowerCase());
      }).toList();
    } catch (e) {
      stationList = [];
    }

    return stationList;
  }

  void checkFilter(
      bool? openService,
      bool? chargerAvailble,
      bool? distance,
      bool? accs1,
      bool? accs2,
      bool? ACCHAdeMO,
      bool? dccs1,
      bool? dccs2,
      bool? dcCHAdeMO,
      List<SearchStationEntity>? filtered) {
    if (openService ?? false) {
      filtered = filtered!.where((item) {
        return ((item.chargerStatus == 'available') ||
            (item.chargerStatus == 'occupied'));
      }).toList();
    }

    if (chargerAvailble ?? false) {
      filtered = filtered!.where((item) {
        return ((item.chargerStatus == 'available'));
      }).toList();
    }

    List<SearchStationEntity>? listtype = [];
    if (accs1 == true ||
        accs2 == true ||
        ACCHAdeMO == true ||
        dccs1 == true ||
        dccs2 == true ||
        dcCHAdeMO == true) {
      for (var i = 0; i < filtered!.length; i++) {
        for (var y = 0; y < filtered[i].connectorType.length; y++) {
          if (accs1 == true) {
            if (filtered[i].connectorType[y].connectorPowerType == 'AC' &&
                filtered[i].connectorType[y].connectorType == 'CS1') {
              listtype.add(filtered[i]);
            }
          }

          if (accs2 == true) {
            if (filtered[i].connectorType[y].connectorPowerType == 'AC' &&
                filtered[i].connectorType[y].connectorType == 'CS2') {
              listtype.add(filtered[i]);
            }
          }

          if (ACCHAdeMO == true) {
            if (filtered[i].connectorType[y].connectorPowerType == 'AC' &&
                filtered[i].connectorType[y].connectorType == 'CHaDEMO') {
              listtype.add(filtered[i]);
            }
          }

          if (dccs1 == true) {
            if (filtered[i].connectorType[y].connectorPowerType == 'DC' &&
                filtered[i].connectorType[y].connectorType == 'CS1') {
              listtype.add(filtered[i]);
            }
          }
          if (dccs2 == true) {
            if (filtered[i].connectorType[y].connectorPowerType == 'DC' &&
                filtered[i].connectorType[y].connectorType == 'CS2') {
              listtype.add(filtered[i]);
            }
          }
          if (dcCHAdeMO == true) {
            if (filtered[i].connectorType[y].connectorPowerType == 'DC' &&
                filtered[i].connectorType[y].connectorType == 'CHaDEMO') {
              listtype.add(filtered[i]);
            }
          }
        }
      }

      filtered = listtype;
    }
    filtered = Set.of(filtered!).toList();

    //-------set value filter-------//
    isCheckedACCS1 = accs1;
    isCheckedACCS2 = accs2;
    isCheckedACCHAdeMO = ACCHAdeMO;
    isCheckedDCCS1 = dccs1;
    isCheckedDCCS2 = dccs2;
    isCheckedDCCHAdeMO = dcCHAdeMO;
    //-------set value filter-------//

    _stationList = filtered;
    if (distance == true) {
      /** แปลง String เป็น int แล้ว sort ระยะทาง **/
      _stationList!.sort((a, b) =>
          int.parse(a.distance.replaceAll(RegExp('[^0-9]'), '')).compareTo(
              int.parse(b.distance.replaceAll(RegExp('[^0-9]'), ''))));
    } else {
      _stationList = filtered;
    }
  }

  void _onFocusChange() {
    debugPrint("Focus: ${_focus.hasFocus.toString()}");
    debugPrint("Focus: Bottom ${MediaQuery.of(context).devicePixelRatio}");
    _listViewVisible = true;
    if (_focus.hasFocus) {
      // (MediaQuery.of(context).devicePixelRatio * 188);
      // findStationAll();
    } else {
      // _useSize = widget.appBarHeight;
    }
    setState(() {});
  }

  void findStationAll() async {
    _stationList = List.empty(growable: true);
    _stationListFull = List.empty(growable: true);
    _stationListFilter = List.empty(growable: true);
    try {
      try {
        _currentLocation = await Utilities.getUserCurrentLocation();
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
      }

      BlocProvider.of<CustomAppBarWithSearchCubit>(context)
          .findStation(_currentLocation.latitude, _currentLocation.longitude);
    } catch (e) {
      try {
        BlocProvider.of<CustomAppBarWithSearchCubit>(context)
            .findStation(defaultLatitude, defaultLongitude);
      } catch (e) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (loadingVisible) {
            setState(() {
              loadingVisible = false;
            });
            BlocProvider.of<CustomAppBarWithSearchCubit>(context)
                .resetCustomAppBarWithSearchCubit();
          }
        });
      }
    }
  }

  void onChangedfindStation(value) {
    List<SearchStationEntity>? filtered;

    if (value == '') {
      _stationList = _stationListFull;
      _stationListFilter = _stationListFull;
      filtered = _stationListFull;
    } else {
      filtered = searchStation(_stationListFull);
    }

    checkFilter(
        isCheckedOpenService,
        isCheckedChargerAvailable,
        isCheckedDistance,
        isCheckedACCS1,
        isCheckedACCS2,
        isCheckedACCHAdeMO,
        isCheckedDCCS1,
        isCheckedDCCS2,
        isCheckedDCCHAdeMO,
        filtered);

    // if (value == '') {
    //   // _stationListFilter = _stationListFull;
    //   // _stationList = _stationListFull;
    //   _stationList = _stationListFull;
    //   checkFilter(
    //       widget.isCheckedOpenService,
    //       widget.isCheckedChargerAvailable,
    //       widget.isCheckedDistance,
    //       widget.isCheckedACCS1,
    //       widget.isCheckedACCS2,
    //       widget.isCheckedACCHAdeMO,
    //       widget.isCheckedDCCS1,
    //       widget.isCheckedDCCS2,
    //       widget.isCheckedDCCHAdeMO,
    //       _stationList);
    //   _stationListFilter = _stationListFull;
    // } else {
    //   _stationListFilter = _stationList;
    // }

    // _stationListFilter = _stationList;

    if (value != '') {
      _listViewVisible = true;
    }
    setState(() {});
  }

  void onPressedfindStation() {
    _focus.unfocus();
    searchControl.text = '';
    _stationList = _stationListFull;
    checkFilter(
        isCheckedOpenService,
        isCheckedChargerAvailable,
        isCheckedDistance,
        isCheckedACCS1,
        isCheckedACCS2,
        isCheckedACCHAdeMO,
        isCheckedDCCS1,
        isCheckedDCCS2,
        isCheckedDCCHAdeMO,
        _stationList);
    _stationListFilter = _stationListFull;
    _listViewVisible = false;
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
    bool? dcCHAdeMO,
  ) async {
    //-------set value filter-------//
    filterConnectorAC!.clear();
    filterConnectorDC!.clear();
    isCheckedOpenService = openService;
    isCheckedChargerAvailable = chargerAvailble;
    isCheckedDistance = distance;
    //-------set value filter-------//
    var filtered = _stationListFilter;

    checkFilter(openService, chargerAvailble, distance, accs1, accs2, ACCHAdeMO,
        dccs1, dccs2, dcCHAdeMO, filtered);

    if (searchControl.text != '') {
      _stationList = searchStation(_stationList);
    }

    if (_stationList!.length == 0) {
      _listViewVisible = false;
    } else {
      _listViewVisible = true;
    }
    filterStatus = true;
    setState(() {});
    if (!moreFilter) {
      Navigator.of(context).pop();
    }
    moreFilter = false;
  }

  void loadingFilterAC(bool? ac) async {
    //-------set value filter-------//
    filterConnectorAC!.clear();
    filterConnectorDC!.clear();
    //-------set value filter-------//
    if (ac == true) {
      //-------set value filter-------//
      filterConnectorAC!.add('CS1');
      filterConnectorAC!.add('CS2');
      filterConnectorAC!.add('CHaDEMO');
      isCheckedACCS1 = true;
      isCheckedACCS2 = true;
      isCheckedACCHAdeMO = true;
      isCheckedDCCS1 = false;
      isCheckedDCCS2 = false;
      isCheckedDCCHAdeMO = false;
      //-------set value filter-------//
    } else {
      //-------set value filter-------//
      isCheckedACCS1 = false;
      isCheckedACCS2 = false;
      isCheckedACCHAdeMO = false;
      isCheckedDCCS1 = false;
      isCheckedDCCS2 = false;
      isCheckedDCCHAdeMO = false;
      filterConnectorAC!.clear();
      //-------set value filter-------//
    }
    moreFilter = true;
    loadingFilterMarker(
      isCheckedOpenService,
      isCheckedChargerAvailable,
      isCheckedDistance,
      isCheckedACCS1,
      isCheckedACCS2,
      isCheckedACCHAdeMO,
      isCheckedDCCS1,
      isCheckedDCCS2,
      isCheckedDCCHAdeMO,
    );
  }

  void loadingFilterDC(bool? dc) async {
    //-------set value filter-------//
    filterConnectorAC!.clear();
    filterConnectorDC!.clear();
    //-------set value filter-------//
    if (dc == true) {
      //-------set value filter-------//
      filterConnectorDC!.add('CS1');
      filterConnectorDC!.add('CS2');
      filterConnectorDC!.add('CHaDEMO');
      isCheckedACCS1 = false;
      isCheckedACCS2 = false;
      isCheckedACCHAdeMO = false;
      isCheckedDCCS1 = true;
      isCheckedDCCS2 = true;
      isCheckedDCCHAdeMO = true;
      //-------set value filter-------//
    } else {
      //-------set value filter-------//
      isCheckedACCS1 = false;
      isCheckedACCS2 = false;
      isCheckedACCHAdeMO = false;
      isCheckedDCCS1 = false;
      isCheckedDCCS2 = false;
      isCheckedDCCHAdeMO = false;
      //-------set value filter-------//
    }

    moreFilter = true;
    loadingFilterMarker(
      isCheckedOpenService,
      isCheckedChargerAvailable,
      isCheckedDistance,
      isCheckedACCS1,
      isCheckedACCS2,
      isCheckedACCHAdeMO,
      isCheckedDCCS1,
      isCheckedDCCS2,
      isCheckedDCCHAdeMO,
    );
  }

  void loadingFilterOpenService(bool? openService) async {
    moreFilter = true;

    loadingFilterMarker(
      openService,
      isCheckedChargerAvailable,
      isCheckedDistance,
      isCheckedACCS1,
      isCheckedACCS2,
      isCheckedACCHAdeMO,
      isCheckedDCCS1,
      isCheckedDCCS2,
      isCheckedDCCHAdeMO,
    );
  }

  void resetFilter() async {
    //-------set value filter-------//
    isCheckedOpenService = false;
    isCheckedChargerAvailable = false;
    isCheckedDistance = false;
    isCheckedACCS1 = false;
    isCheckedACCS2 = false;
    isCheckedACCHAdeMO = false;
    isCheckedDCCS1 = false;
    isCheckedDCCS2 = false;
    isCheckedDCCHAdeMO = false;
    filterConnectorAC!.clear();
    filterConnectorDC!.clear();
    //-------set value filter-------//
    _stationList = _stationListFilter;
    if (searchControl.text != '') {
      _stationList = searchStation(_stationList);
    }
    setState(() {});
    Navigator.of(context).pop();
  }

  void acitonCustomAppBarWithSearchLoading() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!loadingVisible) {
        setState(() {
          loadingVisible = true;
        });
      }
    });
  }

  void acitonFindingStationSuccess(state) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (filterStatus == false) {
        findingStationEntity = state.findingStationEntity;
        if (_searchText == '') {
          setState(() {
            _stationList = findingStationEntity?.stationList;
            _stationListFull = findingStationEntity?.stationList;
            _stationListFilter = findingStationEntity?.stationList;
            loadingVisible = false;
          });
          // });
        } else {
          setState(() {
            loadingVisible = false;
            filterStatus == true;
            _stationList = findingStationEntity?.stationList;
            _stationListFull = findingStationEntity?.stationList;
            _stationListFilter = findingStationEntity?.stationList;
          });
        }
      }
      if (loadingVisible) {
        setState(() {
          loadingVisible = false;
        });
      }
    });
  }

  void acitonFindingStationFailure(state) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (loadingVisible) {
        setState(() {
          loadingVisible = false;
        });
        // Utilities.alertOneButtonAction(
        //   context: context,
        //   type: AppAlertType.DEFAULT,
        //   isForce: true,
        //   title: translate('alert.title.default'),
        //   description: state.message ?? translate('alert.description.default'),
        //   textButton: translate('button.try_again'),
        //   onPressButton: () {
        //     BlocProvider.of<CustomAppBarWithSearchCubit>(context)
        //         .resetCustomAppBarWithSearchCubit();
        //     Navigator.of(context).pop();
        //   },
        // );
      }
    });
  }

  bool checkClickStation() {
    return checkClickCurrentLocation ? true : false;
  }

  void acitonDefault() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        loadingVisible = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return UnfocusArea(
      child: Stack(
        children: [
          Scaffold(
            backgroundColor: AppTheme.white,
            body: Stack(
              children: [
                NotificationListener<OverscrollIndicatorNotification>(
                  onNotification: (OverscrollIndicatorNotification overscroll) {
                    overscroll.disallowIndicator();
                    return true;
                  },
                  child: SingleChildScrollView(
                    physics: const NeverScrollableScrollPhysics(),
                    child: MultiBlocListener(
                      listeners: [
                        BlocListener<CustomAppBarWithSearchCubit,
                            CustomAppBarWithSearchState>(
                          listener: (context, state) {
                            switch (state.runtimeType) {
                              case CustomAppBarWithSearchLoading:
                                acitonCustomAppBarWithSearchLoading();
                                break;
                              case FindingStationSuccess:
                                acitonFindingStationSuccess(state);
                                break;
                              case FindingStationFailure:
                                acitonFindingStationFailure(state);
                                break;
                              default:
                                acitonDefault();
                                break;
                            }
                          },
                        )
                      ],
                      child: Column(
                        children: [
                          SearchAppBarMap(
                            isButton: false,
                            search: true,
                            focus: _focus,
                            stationText: _searchText,
                            onChanged: onChangedfindStation,
                            onPressed: onPressedfindStation,
                            searchController: searchControl,
                            onChangedApply: loadingFilterMarker,
                            onchangeReset: resetFilter,
                            onchangeAC: loadingFilterAC,
                            onchangeDC: loadingFilterDC,
                            onchangeOpenServiceMap: loadingFilterOpenService,
                            isCheckedDistance: isCheckedDistance,
                            isCheckedOpenService: isCheckedOpenService,
                            isCheckedChargerAvailable:
                                isCheckedChargerAvailable,
                            isCheckedACCS1: isCheckedACCS1,
                            isCheckedACCS2: isCheckedACCS2,
                            isCheckedACCHAdeMO: isCheckedACCHAdeMO,
                            isCheckedDCCS1: isCheckedDCCS1,
                            isCheckedDCCS2: isCheckedDCCS2,
                            isCheckedDCCHAdeMO: isCheckedDCCHAdeMO,
                            filterConnectorAC: filterConnectorAC,
                            filterConnectorDC: filterConnectorDC,
                            pageFilter: pageFilter,
                            isPermissionLocation:
                                (_currentLocation.latitude > 0 &&
                                        _currentLocation.longitude > 0)
                                    ? true
                                    : false,
                          ),
                          Container(
                            color: AppTheme.black5,
                            padding: EdgeInsets.only(bottom: 12),
                          ),
                          (widget.routePlanner == true)
                              ? routePlanner()
                              : SizedBox.shrink(),
                          (widget.routePlanner == true)
                              ? Container(
                                  color: AppTheme.black5,
                                  padding: EdgeInsets.only(bottom: 12))
                              : SizedBox.shrink(),
                          renderListStation(),
                        ],
                      ),
                    ),
                  ),
                ),
                ButtonCloseKeyboard(contextPage: context),
              ],
            ),
          ),
          LoadingPage(visible: loadingVisible)
        ],
      ),
    );
  }

  Widget renderListStation() {
    if (_listViewVisible &&
        _stationList != null &&
        _stationList!.length > 0 &&
        !loadingVisible) {
      return Container(
        height: MediaQuery.of(context).viewInsets.bottom <= 0
            ? (MediaQuery.of(context).size.height - 162) - heightRoute
            : ((MediaQuery.of(context).size.height - 162) -
                (MediaQuery.of(context).viewInsets.bottom - 30) -
                heightRoute),
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
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  height: 1,
                  color: AppTheme.borderGray,
                ),
              ),
              itemBuilder: (BuildContext context, int indexListView) {
                SearchStationEntity? searchStationEntity =
                    _stationList?[indexListView];

                return StationSearchItem(
                    searchStationEntity: searchStationEntity,
                    currentLocation: _currentLocation,
                    routePlanner: widget.routePlanner,
                    onSetModalInRoutePlannerPage:
                        widget.onSetModalInRoutePlannerPage,
                    onSelectStation: widget.onSelectStation,
                    checkClickStation: checkClickStation);
              },
              itemCount: _stationList?.length ?? 0,
            ),
          ),
        ),
      );
    } else if (loadingVisible) {
      return Container();
    } else {
      return Container(
        height: MediaQuery.of(context).size.height - 162 - heightRoute,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              ImageAsset.img_map_empty,
              width: 130,
              height: 130,
            ),
            const SizedBox(height: 8),
            TextLabel(
              text: translate('empty.history'),
              fontSize: Utilities.sizeFontWithDesityForDisplay(
                  context, AppFontSize.superlarge),
              color: AppTheme.black40,
            ),
            const SizedBox(height: 8),
          ],
        ),
      );
    }
  }

  Widget routePlanner() {
    return Container(
      height: heightRoute,
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      color: AppTheme.white,
      child: Column(children: [
        // Current Location
        (countCurrentLocation() < 2)
            ? InkWell(
                onTap: () {
                  if (!checkClickCurrentLocation) {
                    checkClickCurrentLocation = true;
                    (widget.onPressedAddMarker ?? () {})('CURRENT_LOCATION');
                    (widget.getScrollPosition ?? () {})();
                    (widget.onSetModalInRoutePlannerPage ?? () {})(
                        'SELECT_ROUTE', true);
                    Future.delayed(Duration(milliseconds: 500), () async {
                      Navigator.of(context).pop();
                    });
                  }
                },
                child: Row(
                  children: [
                    Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                            color: AppTheme.blueLight, shape: BoxShape.circle),
                        child: Center(
                          child: SvgPicture.asset(
                            ImageAsset.ic_location,
                            width: 24,
                            height: 24,
                          ),
                        )),
                    SizedBox(
                      width: 10,
                    ),
                    TextLabel(
                        text: translate(
                            'map_page.route_planner.current_location'),
                        fontSize: AppFontSize.normal,
                        color: AppTheme.black60),
                  ],
                ),
              )
            : SizedBox.shrink(),
        (countCurrentLocation() < 2)
            ? Container(
                margin: const EdgeInsets.symmetric(vertical: 12),
                height: 1,
                color: AppTheme.borderGray,
              )
            : SizedBox.shrink(),
        // Select on Map
        InkWell(
          onTap: () {
            if (!checkClickCurrentLocation) {
              checkClickCurrentLocation = true;
              (widget.onSetModalInRoutePlannerPage ?? () {})('MOVEPIN', true);
              Navigator.pop(context);
            }
          },
          child: Row(
            children: [
              Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                      color: AppTheme.blueLight, shape: BoxShape.circle),
                  child: Center(
                    child: SvgPicture.asset(
                      ImageAsset.ic_pin_marker,
                      width: 24,
                      height: 24,
                    ),
                  )),
              SizedBox(
                width: 10,
              ),
              TextLabel(
                  text: translate('map_page.map_filter.select_map'),
                  fontSize: AppFontSize.normal,
                  color: AppTheme.black60)
            ],
          ),
        )
      ]),
    );
  }
}
