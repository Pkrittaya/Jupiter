// ignore_for_file: unused_field
import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:geolocator/geolocator.dart';
import 'package:jupiter/src/apptheme.dart';
import 'package:jupiter/src/constant_value.dart';
import 'package:jupiter/src/jupiter_prefs_and_app_data.dart';
import 'package:jupiter_api/domain/entities/advertisement_entity.dart';
import 'package:jupiter_api/domain/entities/has_charging_fleet_card_entity.dart';
import 'package:jupiter_api/domain/entities/list_data_permission_entity.dart';
import 'package:jupiter_api/domain/entities/profile_entity.dart';
import 'package:jupiter_api/domain/entities/recommended_station_entity.dart';
import 'package:jupiter/src/images_asset.dart';
import 'package:jupiter/src/injection.dart';
import 'package:jupiter/src/presentation/pages/home/cubit/advertisement_home_page_cubit.dart';
import 'package:jupiter/src/presentation/pages/home/cubit/home_cubit.dart';
import 'package:jupiter/src/presentation/pages/home/cubit/notification_home_page_cubit.dart';
import 'package:jupiter/src/presentation/pages/home/cubit/recommended_station_cubit.dart';
import 'package:jupiter/src/presentation/pages/home/widgets/appbar_home.dart';
import 'package:jupiter/src/presentation/pages/home/widgets/list_news_item.dart';
import 'package:jupiter/src/presentation/pages/home/widgets/recommended_station.dart';
import 'package:jupiter/src/presentation/widgets/index.dart';
import 'package:jupiter/src/utilities.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../firebase_log.dart';
import '../../../route_names.dart';
import 'widgets/icon_menu_item.dart';

class MoreMenuItemDataForFleet {
  MoreMenuItemDataForFleet(
    this.leadingIconAsset,
    this.name,
    this.trailingIcon,
    this.pageName,
    this.isCharging,
  );

  final bool isCharging;
  final String leadingIconAsset;
  final String name;
  final String pageName;
  final IconData trailingIcon;
}

class HomePageWrapperProvider extends StatelessWidget {
  const HomePageWrapperProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<HomeCubit>(),
      child: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
    this.onTapIndex,
  });

  final Function(int)? onTapIndex;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int activePage = 0;
  bool addFleetCard = false;
  bool addFleetOperation = false;
  AdvertisementEntity? advertisementEntity;
  bool goToFleetOperation = false;
  bool isLoadingAdvertisement = true;
  List<MoreMenuItemDataForFleet> menuDatas = [
    MoreMenuItemDataForFleet(
      ImageAsset.ic_vehicle,
      translate('more_menu_item.vehicle'),
      Icons.arrow_forward_ios,
      RouteNames.ev_information,
      false,
    ),
    MoreMenuItemDataForFleet(
      ImageAsset.ic_favorite,
      translate('more_menu_item.favorite'),
      Icons.arrow_forward_ios,
      RouteNames.favorite,
      false,
    ),
    MoreMenuItemDataForFleet(
      ImageAsset.ic_payment,
      translate('more_menu_item.payment'),
      Icons.arrow_forward_ios,
      RouteNames.payment,
      false,
    ),
    MoreMenuItemDataForFleet(
      ImageAsset.ic_coupon,
      translate('more_menu_item.coupon'),
      Icons.arrow_forward_ios,
      RouteNames.coupon,
      false,
    ),
  ];

  double moreMenuHeight = 110;
  double moreMenuHeightDefault = 110;
  ProfileEntity? profileEntity;
  bool refreshRecommend = false;
  bool reloadHasChargingFleet = false;
  ScrollController scrollController = ScrollController();
  bool showbtn = true;

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

  bool _loadingMenu = true;
  bool _loadingRecommend = false;
  PageController _pageController = new PageController(initialPage: 0);
  // ABOUT FLEET
  ListDataPermissionEntity? _permissionEntity;
  List<RecommendedStationEntity> _stationData = List.empty();
  bool clickButton = false;
  JupiterPrefsAndAppData jupiterPrefsAndAppData = getIt();
  Timer? timer;

  @override
  void initState() {
    FirebaseLog.logPage(this);
    getAdvertisement();
    getNotification();
    getPermissonFleet();
    getRecommendedStation();
    jupiterPrefsAndAppData.onTapIndex = widget.onTapIndex;
    super.initState();
  }

  @override
  void dispose() {
    try {
      debugPrint('CANCEL TIMER HOME PAGE');
      timer?.cancel();
    } catch (e) {}
    super.dispose();
  }

  void getAdvertisement() {
    BlocProvider.of<AdvertisementHomePageCubit>(context).loadAdvertisement();
  }

  void onRefreshPage() {
    try {
      debugPrint('CANCEL TIMER HOME PAGE');
      timer?.cancel();
    } catch (e) {}
    setState(() {
      moreMenuHeight = moreMenuHeightDefault;
      reloadHasChargingFleet = true;
      refreshRecommend = true;
      activePage = 0;
      onCheckClick(check: false, click: false);
    });
    resetMenu();
    getAdvertisement();
    getNotification();
    getPermissonFleet();
    getRecommendedStation();
    Utilities.getCheckStatusCharging(context);
  }

  void onRefreshPageForFleet() {
    getNotification();
    resetMenu();
    if (_permissionEntity?.permission?.fleetOperationPermission == true) {
      BlocProvider.of<HomeCubit>(context).fetchHasChargingFleetOperation();
    } else {
      if (_permissionEntity?.permission?.fleetCardPermission == true)
        BlocProvider.of<HomeCubit>(context).fetchHasChargingFleetCard();
      else
        BlocProvider.of<HomeCubit>(context).resetHomeCubit();
    }
  }

  void autoSlideBanner() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if ((advertisementEntity?.announcement.length ?? 1) <= 1) {
        return;
      } else {
        timer = Timer.periodic(Duration(seconds: 5), (timer) {
          if (!isLoadingAdvertisement) {
            int newIndex = activePage + 1;
            if ((activePage + 1) >=
                (advertisementEntity?.announcement.length ?? 1)) {
              newIndex = 0;
            }
            _pageController.animateToPage(newIndex,
                duration: Duration(milliseconds: 500), curve: Curves.ease);
          }
        });
      }
    });
  }

  void setHeightMenuForFleet() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (moreMenuHeight == moreMenuHeightDefault && menuDatas.length > 4) {
        setState(() {
          moreMenuHeight = moreMenuHeightDefault * 2;
        });
      }
    });
  }

  void onPageChanged(int page) {
    setState(() {
      activePage = page;
    });
  }

  Future<void> onPressButtonNoti() async {
    if (!onCheckClick()) {
      Navigator.of(context).pushNamed(RouteNames.notification);
    }
  }

  void resetMenu() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (menuDatas.length > 4) {
        setState(() {
          addFleetCard = false;
          addFleetOperation = false;
          moreMenuHeight = moreMenuHeightDefault;
          menuDatas = [
            MoreMenuItemDataForFleet(
              ImageAsset.ic_vehicle,
              translate('more_menu_item.vehicle'),
              Icons.arrow_forward_ios,
              RouteNames.ev_information,
              false,
            ),
            MoreMenuItemDataForFleet(
              ImageAsset.ic_favorite,
              translate('more_menu_item.favorite'),
              Icons.arrow_forward_ios,
              RouteNames.favorite,
              false,
            ),
            MoreMenuItemDataForFleet(
              ImageAsset.ic_payment,
              translate('more_menu_item.payment'),
              Icons.arrow_forward_ios,
              RouteNames.payment,
              false,
            ),
            MoreMenuItemDataForFleet(
              ImageAsset.ic_coupon,
              translate('more_menu_item.coupon'),
              Icons.arrow_forward_ios,
              RouteNames.coupon,
              false,
            ),
          ];
        });
      }
    });
  }

  void getRecommendedStation() async {
    if (mounted) {
      try {
        BlocProvider.of<RecommendedStationCubit>(context)
            .resetRecommendedStatioToInitialState();
        _loadingRecommend = true;
        _currentLocation = await Utilities.getUserCurrentLocation();
        BlocProvider.of<RecommendedStationCubit>(context)
            .loadingRecommendedStation(true, true, [],
                _currentLocation.latitude, _currentLocation.longitude);
      } catch (e) {
        getRecommendedStationCatch();
      }
    }
  }

  void getRecommendedStationCatch() {
    try {
      if (mounted) {
        BlocProvider.of<RecommendedStationCubit>(context)
            .resetRecommendedStatioToInitialState();
        _loadingRecommend = true;
        if (_currentLocation.latitude > 0 && _currentLocation.longitude > 0) {
          BlocProvider.of<RecommendedStationCubit>(context)
              .loadingRecommendedStation(true, true, [],
                  _currentLocation.latitude, _currentLocation.longitude);
        } else {
          BlocProvider.of<RecommendedStationCubit>(context)
              .loadingRecommendedStation(true, false, ["CS1", "CS2", "CHaDEMO"],
                  13.76483333, 100.5382222);
        }
      }
    } catch (e) {
      _loadingRecommend = false;
    }
  }

  void getNotification() {
    BlocProvider.of<NotificationHomePageCubit>(context)
        .loadCountAllNotificaton();
  }

  void getPermissonFleet() {
    BlocProvider.of<HomeCubit>(context).fetchPermissonFleet();
  }

  void onTapMenuItem(String pageName) {
    if (!onCheckClick()) {
      onCheckClick(check: false, click: true);
      checkPushPageAboutFleet(pageName);
    }
  }

  void checkPushPageAboutFleet(String pageName) {
    try {
      SchedulerBinding.instance.addPostFrameCallback((_) async {
        onCheckClick(check: false, click: false);
        dynamic result = await Navigator.of(context).pushNamed(pageName);
        if (pageName == RouteNames.fleet_card ||
            pageName == RouteNames.fleet_operation) {
          if (result != null) {
            goToFleetOperation = result['isGotoFleetOperation'];
          }
          onRefreshPageForFleet();
        }
      });
    } catch (e) {
      debugPrint('error: $e');
      SchedulerBinding.instance.addPostFrameCallback((_) async {
        onCheckClick(check: false, click: false);
      });
    }
  }

  void checkGoToFleetOperation() {
    if (goToFleetOperation == true) {
      goToFleetOperation = false;
      Future.delayed(const Duration(milliseconds: 100), () {
        onTapMenuItem(RouteNames.fleet_operation);
      });
    }
  }

  bool onCheckClick({bool check = true, bool click = false}) {
    // ตรวจสอบอย่างเดียว
    if (check) {
      return clickButton;
    } else {
      // set ค่า
      if (click) {
        return clickButton = true;
      } else {
        return clickButton = false;
      }
    }
  }

  void actionHomeLoading() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_loadingMenu) {
        setState(() {
          _loadingMenu = true;
        });
      }
    });
  }

  void actionHomeGetPermissionFleetSuccess(state) {
    _permissionEntity = state.permissionEntity;
    if (_permissionEntity?.permission?.fleetCardPermission == true ||
        _permissionEntity?.permission?.fleetOperationPermission == true) {
      if (_permissionEntity?.permission?.fleetOperationPermission == true) {
        BlocProvider.of<HomeCubit>(context).fetchHasChargingFleetOperation();
      } else {
        if (_permissionEntity?.permission?.fleetCardPermission == true)
          BlocProvider.of<HomeCubit>(context).fetchHasChargingFleetCard();
        else
          BlocProvider.of<HomeCubit>(context).resetHomeCubit();
      }
    } else {
      BlocProvider.of<HomeCubit>(context).resetHomeCubit();
    }
  }

  void actionHomeGetPermissionFleetFailure(state) {
    BlocProvider.of<HomeCubit>(context).resetHomeCubit();
  }

  void actionHomeHasChargingFleetOperationSuccess(state) {
    reloadHasChargingFleet = false;
    HasChargingFleetEntity? resData = state.hasChargingFleetEntity;
    if (!addFleetOperation) {
      menuDatas.add(
        MoreMenuItemDataForFleet(
          ImageAsset.ic_fleet_operation,
          translate('more_menu_item.fleet_operation'),
          Icons.arrow_forward_ios,
          RouteNames.fleet_operation,
          resData?.chargingStatus ?? false,
        ),
      );
      setHeightMenuForFleet();
      addFleetOperation = true;
    }
    if (_permissionEntity?.permission?.fleetCardPermission == true) {
      BlocProvider.of<HomeCubit>(context).fetchHasChargingFleetCard();
    } else {
      BlocProvider.of<HomeCubit>(context).resetHomeCubit();
    }
  }

  void actionHomeHasChargingFleetOperationFailure(state) {
    reloadHasChargingFleet = false;
    if (!addFleetOperation) {
      menuDatas.add(
        MoreMenuItemDataForFleet(
          ImageAsset.ic_fleet_operation,
          translate('more_menu_item.fleet_operation'),
          Icons.arrow_forward_ios,
          RouteNames.fleet_operation,
          false,
        ),
      );
      setHeightMenuForFleet();
      addFleetOperation = true;
    }
    if (_permissionEntity?.permission?.fleetCardPermission == true) {
      BlocProvider.of<HomeCubit>(context).fetchHasChargingFleetCard();
    } else {
      BlocProvider.of<HomeCubit>(context).resetHomeCubit();
    }
  }

  void actionHomeHasChargingFleetCardSuccess(state) {
    reloadHasChargingFleet = false;
    HasChargingFleetEntity? resData = state.hasChargingFleetEntity;
    if (!addFleetCard) {
      menuDatas.add(
        MoreMenuItemDataForFleet(
          ImageAsset.ic_fleet_card,
          translate('more_menu_item.fleet_card'),
          Icons.arrow_forward_ios,
          RouteNames.fleet_card,
          resData?.chargingStatus ?? false,
        ),
      );
      setHeightMenuForFleet();
      addFleetCard = true;
    }
    BlocProvider.of<HomeCubit>(context).resetHomeCubit();
  }

  void actionHomeHasChargingFleetCardFailure(state) {
    reloadHasChargingFleet = false;
    if (!addFleetCard) {
      menuDatas.add(
        MoreMenuItemDataForFleet(
          ImageAsset.ic_fleet_card,
          translate('more_menu_item.fleet_card'),
          Icons.arrow_forward_ios,
          RouteNames.fleet_card,
          false,
        ),
      );
      setHeightMenuForFleet();
      addFleetCard = true;
    }
    BlocProvider.of<HomeCubit>(context).resetHomeCubit();
  }

  void actionHomeResetCubit() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_loadingMenu) {
        setState(() {
          _loadingMenu = false;
        });
        checkGoToFleetOperation();
      }
    });
  }

  void actionRecommendedStationLoading() {
    debugPrint('MapLoading');
    _loadingRecommend = true;
  }

  void actionRecommendedStationSuccess(state) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_loadingRecommend) {
        debugPrint('MapLoadMarkerSuccess');
        setState(() {
          _loadingRecommend = false;
          refreshRecommend = false;
          _stationData = state.recommendedStation!;
        });
      }
      BlocProvider.of<RecommendedStationCubit>(context)
          .resetRecommendedStatioToInitialState();
    });
  }

  void actionRecommendedStationFailure() {
    debugPrint('MapLoadMarkerFailure');
    refreshRecommend = false;
    if (_loadingRecommend) {
      _loadingRecommend = false;
      SchedulerBinding.instance.addPostFrameCallback((_) {
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
      });
    }
  }

  void actionAdvertisementHomePageLoading() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!isLoadingAdvertisement) {
        setState(() {
          isLoadingAdvertisement = true;
        });
      }
    });
  }

  void actionAdvertisementHomePageFailure() async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (isLoadingAdvertisement) {
        setState(() {
          isLoadingAdvertisement = false;
        });
      }
    });
  }

  void actionAdvertisementHomePageSuccess(state) async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (isLoadingAdvertisement) {
        setState(() {
          isLoadingAdvertisement = false;
          advertisementEntity = state.advertisementEntity;
        });
        autoSlideBanner();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppTheme.white,
              AppTheme.blueLight,
            ],
          ),
        ),
        child: RefreshIndicator(
          onRefresh: () async {
            onRefreshPage();
          },
          child: Stack(
            children: [
              NotificationListener<OverscrollIndicatorNotification>(
                onNotification: (OverscrollIndicatorNotification overscroll) {
                  overscroll.disallowIndicator();
                  return true;
                },
                child: ListView(
                  physics: ClampingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics(),
                  ),
                  padding: EdgeInsets.zero,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppBarHomePage(
                          activePage: activePage,
                          pageController: _pageController,
                          onPageChanged: onPageChanged,
                          onPressButtonNoti: onPressButtonNoti,
                        ),
                        const SizedBox(height: 16),
                        BlocBuilder<HomeCubit, HomeState>(
                          builder: (context, state) {
                            switch (state.runtimeType) {
                              case HomeLoading:
                                actionHomeLoading();
                                break;
                              case HomeGetPermissionFleetSuccess:
                                actionHomeGetPermissionFleetSuccess(state);
                                break;
                              case HomeGetPermissionFleetFailure:
                                actionHomeGetPermissionFleetFailure(state);
                                break;
                              case HomeHasChargingFleetCardSuccess:
                                actionHomeHasChargingFleetCardSuccess(state);
                                break;
                              case HomeHasChargingFleetCardFailure:
                                actionHomeHasChargingFleetCardFailure(state);
                                break;
                              case HomeHasChargingFleetOperationSuccess:
                                actionHomeHasChargingFleetOperationSuccess(
                                    state);
                                break;
                              case HomeHasChargingFleetOperationFailure:
                                actionHomeHasChargingFleetOperationFailure(
                                    state);
                                break;
                              case HomeInitial:
                                actionHomeResetCubit();
                                break;
                            }
                            return Container(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              height: moreMenuHeight,
                              child: GridView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 4,
                                  mainAxisExtent: moreMenuHeightDefault,
                                ),
                                itemCount: menuDatas.length,
                                itemBuilder:
                                    (BuildContext context, indexListView) {
                                  MoreMenuItemDataForFleet menuItemData =
                                      menuDatas[indexListView];
                                  return IconMenuItem(
                                    menuItemData: menuItemData,
                                    isLoading: _loadingMenu,
                                    onTap: () {
                                      onTapMenuItem(menuItemData.pageName);
                                    },
                                  );
                                },
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 16),
                        BlocBuilder<RecommendedStationCubit,
                            RecommendedStationState>(builder: (context, state) {
                          switch (state.runtimeType) {
                            case RecommendedStationLoading:
                              actionRecommendedStationLoading();
                              break;
                            case RecommendedStationFailure:
                              actionRecommendedStationFailure();
                              break;
                            case RecommendedStationSuccess:
                              actionRecommendedStationSuccess(state);
                              break;
                          }
                          return RecommendedStation(
                            listStation: _stationData,
                            loading: _loadingRecommend,
                            latitude: _currentLocation.latitude,
                            longitude: _currentLocation.longitude,
                            refreshRecommend: refreshRecommend,
                            onTapIndex: widget.onTapIndex ?? (index) {},
                            onCheckClick: onCheckClick,
                          );
                        }),
                        Padding(
                          padding: const EdgeInsets.only(left: 16),
                          child: TextLabel(
                            text: translate('home_page.news'),
                            fontSize: Utilities.sizeFontWithDesityForDisplay(
                                context, AppFontSize.superlarge),
                            color: AppTheme.blueDark,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 8),
                        BlocBuilder<AdvertisementHomePageCubit,
                            AdvertisementHomePageState>(
                          builder: (context, state) {
                            switch (state.runtimeType) {
                              case AdvertisementHomePageLoading:
                                actionAdvertisementHomePageLoading();
                                break;
                              case AdvertisementHomePageFailure:
                                actionAdvertisementHomePageFailure();
                                break;
                              case AdvertisementHomePageSuccess:
                                actionAdvertisementHomePageSuccess(state);
                                break;
                            }
                            return isLoadingAdvertisement
                                ? Skeletonizer.zone(
                                    child: Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 12),
                                      height: 140,
                                      width: MediaQuery.of(context).size.width,
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            const SizedBox(width: 12),
                                            Bone.square(
                                              size: 110,
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            const SizedBox(width: 12),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Bone.text(words: 2),
                                                    const SizedBox(height: 8),
                                                    Bone.text(words: 1)
                                                  ],
                                                ),
                                                Bone.text(words: 1),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                : Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    child: SingleChildScrollView(
                                      child: ListNewsItem(
                                        advertisementEntity:
                                            advertisementEntity,
                                        onCheckClick: onCheckClick,
                                      ),
                                    ),
                                  );
                          },
                        ),
                        const SizedBox(height: 16),
                        Container(
                          height: Platform.isIOS ? 110 : 80,
                          width: double.infinity,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
