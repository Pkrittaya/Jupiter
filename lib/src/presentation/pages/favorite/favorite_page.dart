import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:geolocator/geolocator.dart';
import 'package:jupiter/src/constant_value.dart';
import 'package:jupiter/src/presentation/pages/favorite/widgets/list_favorite_route.dart';
import 'package:jupiter_api/domain/entities/favorite_route_item_entity.dart';
import 'package:jupiter_api/domain/entities/favorite_station_list_entily.dart';
import 'package:jupiter_api/domain/entities/favorite_station_entity.dart';
import 'package:jupiter/src/presentation/pages/favorite/cubit/favorite_cubit.dart';
import 'package:jupiter/src/presentation/pages/favorite/widgets/list_favorite.dart';
import 'package:jupiter/src/presentation/widgets/custom_app_bar_with_search/cubit/custom_app_bar_with_search_cubit.dart';
import 'package:jupiter/src/presentation/widgets/text_label.dart';
import '../../../apptheme.dart';
import '../../../firebase_log.dart';
import '../../../injection.dart';
import '../../../utilities.dart';

class FavoriteStationWrapperProvider extends StatelessWidget {
  const FavoriteStationWrapperProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<CustomAppBarWithSearchCubit>(),
      child: FavoriteStation(),
    );
  }
}

class FavoriteStation extends StatefulWidget {
  const FavoriteStation({
    Key? key,
    this.fromMapPage,
  }) : super(key: key);

  final bool? fromMapPage;

  @override
  State<StatefulWidget> createState() => _FavoriteStationState();
}

class _FavoriteStationState extends State<FavoriteStation>
    with SingleTickerProviderStateMixin {
  FavoriteStationEntity? favoriteStationEntity;
  bool loadingVisible = true;
  final searchController = TextEditingController();
  EdgeInsets? viewInsets;
  late TabController _tabController;
  int _selectedTab = 0;

  Position currentLocation = Position(
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

  List<FavoriteStationListEntity> stationList = List.empty(growable: true);

  List<FavoriteRouteItemEntity>? routeFavoriteEntity;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    FirebaseLog.logPage(this);
    initialTabController();
    findStationAll();
    super.initState();
  }

  void initialTabController() {
    _tabController = TabController(vsync: this, length: 2);
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        setState(() {
          _selectedTab = _tabController.index;
          loadingVisible = true;
        });
        findStationAll();
      }
    });
  }

  void findStationAll() async {
    BlocProvider.of<FavoriteStationCubit>(context).resetToInitialState();
    try {
      if (_selectedTab == 0) {
        currentLocation = await Utilities.getUserCurrentLocation();
        BlocProvider.of<FavoriteStationCubit>(context)
            .loadFavorite(currentLocation.latitude, currentLocation.longitude);
      } else {
        BlocProvider.of<FavoriteStationCubit>(context).loadFavoriteRoute();
      }
    } catch (e) {
      try {
        if (_selectedTab == 0) {
          BlocProvider.of<FavoriteStationCubit>(context)
              .loadFavorite(13.76483333, 100.5382222);
        } else {
          BlocProvider.of<FavoriteStationCubit>(context).loadFavoriteRoute();
        }
      } catch (e) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (loadingVisible) {
            setState(() {
              loadingVisible = false;
            });
            BlocProvider.of<FavoriteStationCubit>(context)
                .resetToInitialState();
          }
        });
      }
    }
  }

  void confirmDeleteStation(
      BuildContext context, String stationId, String stationName) {
    Utilities.alertTwoButtonAction(
      context: context,
      type: AppAlertType.WARNING,
      title: translate("favorite_page.modal_delete.title"),
      description: translate("favorite_page.modal_delete.desc_station"),
      textButtonLeft: translate("button.cancel"),
      textButtonRight: translate("button.confirm"),
      onPressButtonLeft: () {
        Navigator.of(context).pop();
      },
      onPressButtonRight: () {
        BlocProvider.of<FavoriteStationCubit>(context).deleteFavoriteStation(
            stationId: stationId, stationName: stationName);
        Navigator.of(context).pop();
      },
    );
  }

  void confirmDeleteRoute(BuildContext context, String routeName) {
    Utilities.alertTwoButtonAction(
      context: context,
      type: AppAlertType.WARNING,
      title: translate("favorite_page.modal_delete.title"),
      description: translate("favorite_page.modal_delete.desc_route"),
      textButtonLeft: translate("button.cancel"),
      textButtonRight: translate("button.confirm"),
      onPressButtonLeft: () {
        Navigator.of(context).pop();
      },
      onPressButtonRight: () {
        BlocProvider.of<FavoriteStationCubit>(context)
            .deleteFavoriteRoute(routeName: routeName);
        Navigator.of(context).pop();
      },
    );
  }

  void onPressedBackButton() {
    Navigator.of(context).pop();
  }

  void actionFavoriteStationLoading() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!loadingVisible) {
        setState(() {
          loadingVisible = true;
        });
      }
    });
  }

  void actionFavoriteStationFailure() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (loadingVisible) {
        setState(() {
          loadingVisible = false;
        });
      }
    });
  }

  void actionFavoriteStationSuccess(state) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      debugPrint('FavoriteStationSuccess');
      if (loadingVisible) {
        setState(() {
          favoriteStationEntity = state.favoriteStationEntity;
          stationList =
              favoriteStationEntity?.stationList ?? List.empty(growable: true);
          loadingVisible = false;
        });
      }
    });
  }

  void actionFavoriteRouteFailure() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (loadingVisible) {
        setState(() {
          loadingVisible = false;
        });
      }
    });
  }

  void actionFavoriteRouteSuccess(state) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      debugPrint('FavoriteRoutePlannerSuccess');
      if (loadingVisible) {
        setState(() {
          routeFavoriteEntity = state.listFavoriteRouteEntity;
          loadingVisible = false;
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
            Navigator.of(context).pop();
          },
        );
      }
    });
  }

  void actionDeleteFavoriteRouteSuccess() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (loadingVisible) {
        BlocProvider.of<FavoriteStationCubit>(context).loadFavoriteRoute();
      }
    });
  }

  void actionDeleteFavoriteStationFailure(state) {
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
            Navigator.of(context).pop();
          },
        );
      }
    });
  }

  void actionDeleteFavoriteStationSuccess() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (loadingVisible) {
        try {
          currentLocation = await Utilities.getUserCurrentLocation();
          BlocProvider.of<FavoriteStationCubit>(context).loadFavorite(
              currentLocation.latitude, currentLocation.longitude);
        } catch (e) {
          BlocProvider.of<FavoriteStationCubit>(context)
              .loadFavorite(13.76483333, 100.5382222);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppTheme.white,
        iconTheme: const IconThemeData(
          color: AppTheme.blueDark, //change your color here
        ),
        leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: AppTheme.blueDark),
            onPressed: onPressedBackButton),
        centerTitle: true,
        title: TextLabel(
          text: translate('app_title.favorite'),
          color: AppTheme.blueDark,
          fontSize: Utilities.sizeFontWithDesityForDisplay(
              context, AppFontSize.title),
          fontWeight: FontWeight.bold,
        ),
      ),
      body: Container(child:
          BlocBuilder<FavoriteStationCubit, FavoriteStationState>(
              builder: (context, state) {
        switch (state.runtimeType) {
          case FavoriteStationLoading:
            actionFavoriteStationLoading();
            break;
          case FavoriteStationSuccess:
            actionFavoriteStationSuccess(state);
            break;
          case FavoriteStationFailure:
            actionFavoriteStationFailure();
            break;
          case FavoriteRouteSuccess:
            actionFavoriteRouteSuccess(state);
            break;
          case FavoriteRouteFailure:
            actionFavoriteRouteFailure();
            break;
          case DeleteFavoriteRouteSuccess:
            actionDeleteFavoriteRouteSuccess();
            break;
          case DeleteFavoriteRouteFailure:
            actionDeleteFavoriteRouteFailure(state);
            break;
          case DeleteFavoriteStationSuccess:
            actionDeleteFavoriteStationSuccess();
            break;
          case DeleteFavoriteStationFailure:
            actionDeleteFavoriteStationFailure(state);
            break;
          default:
            break;
        }
        return DefaultTabController(
          length: 2,
          child: Column(
            children: <Widget>[
              Material(
                child: TabBar(
                  unselectedLabelColor: AppTheme.white,
                  indicatorColor: AppTheme.blueDark,
                  controller: _tabController,
                  labelPadding: const EdgeInsets.all(0.0),
                  tabs: [
                    Tab(
                      child: SizedBox.expand(
                        child: Container(
                          child: Center(
                            child: TextLabel(
                              text: translate("favorite_page.station"),
                              color: (_selectedTab == 0
                                  ? AppTheme.blueDark
                                  : AppTheme.gray9CA3AF),
                              fontSize: Utilities.sizeFontWithDesityForDisplay(
                                  context, AppFontSize.large),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          decoration: BoxDecoration(color: AppTheme.white),
                        ),
                      ),
                    ),
                    Tab(
                      child: SizedBox.expand(
                        child: Container(
                          child: Center(
                            child: TextLabel(
                              text: translate("favorite_page.route"),
                              color: (_selectedTab == 1
                                  ? AppTheme.blueDark
                                  : AppTheme.gray9CA3AF),
                              fontSize: Utilities.sizeFontWithDesityForDisplay(
                                  context, AppFontSize.large),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          decoration: BoxDecoration(color: AppTheme.white),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  physics: NeverScrollableScrollPhysics(),
                  controller: _tabController,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 16),
                      child: ListFavorite(
                        stationList: stationList,
                        currentLocation: currentLocation,
                        loading: loadingVisible,
                        onSlide: confirmDeleteStation,
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 16, horizontal: 22),
                      child: ListFavoriteRoute(
                        routeList: routeFavoriteEntity ?? [],
                        loading: loadingVisible,
                        fromMapPage: widget.fromMapPage,
                        onSlide: confirmDeleteRoute,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      })),
    );
  }
}
