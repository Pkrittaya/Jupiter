import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:geolocator/geolocator.dart';
import 'package:jupiter/src/apptheme.dart';
import 'package:jupiter/src/constant_value.dart';
import 'package:jupiter/src/presentation/pages/station_details/widgets/charger_loading.dart';
import 'package:jupiter_api/domain/entities/charger_entity.dart';
import 'package:jupiter_api/domain/entities/facility_entity.dart';
import 'package:jupiter_api/domain/entities/favorite_station_entity.dart';
import 'package:jupiter_api/domain/entities/station_details_entity.dart';
import 'package:jupiter/src/injection.dart';
import 'package:jupiter/src/presentation/pages/station_details/widgets/divider_for_station.dart';
import 'package:jupiter/src/presentation/pages/station_details/widgets/facility.dart';
import 'package:jupiter/src/presentation/pages/station_details/widgets/list_charger_item.dart';
import 'package:jupiter/src/presentation/pages/station_details/widgets/page_image_indicator.dart';
import 'package:jupiter/src/presentation/pages/station_details/widgets/page_view_image.dart';
import 'package:jupiter/src/presentation/pages/station_details/widgets/station_detail_item.dart';
import 'package:jupiter/src/presentation/pages/station_details/widgets/station_name.dart';
import 'package:jupiter/src/presentation/widgets/index.dart';
import 'package:jupiter/src/utilities.dart';
import '../../../firebase_log.dart';
import 'cubit/station_details_cubit.dart';
import 'widgets/arrow_back_at_appbar.dart';
import 'widgets/button_at_bottom.dart';

class StationDetailArguments {
  StationDetailArguments({
    required this.stationId,
  });
  final String stationId;
}

class StationDetailWrapperProvider extends StatelessWidget {
  const StationDetailWrapperProvider({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<StationDetailsCubit>(),
      child: const StationDetailPage(
        stationId: '',
      ),
    );
  }
}

class StationDetailPage extends StatefulWidget {
  const StationDetailPage({
    super.key,
    required this.stationId,
    this.fromMapPage,
  });
  final String stationId;
  final bool? fromMapPage;
  @override
  State<StationDetailPage> createState() => _StationDetailPageState();
}

class _StationDetailPageState extends State<StationDetailPage> {
  StationDetailEntity? _stationDetailEntity;
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
  bool loading = true;
  bool loadingFavorite = false;

  ScrollController scrollController = ScrollController();
  List<FacilityEntity> listFac = [];
  bool? favoriteStation = false;
  FavoriteStationEntity? favoriteStationEntity;
  List<Widget> widgetCharger = [];
  List<Widget> widgetConnector = [];
  PageController _pageController = new PageController(initialPage: 0);
  int activePage = 0;
  bool isPermissionLocation = true;

  @override
  void initState() {
    FirebaseLog.logPage(this);
    super.initState();
    initialLoading();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> initialLoading() async {
    BlocProvider.of<StationDetailsCubit>(context).resetInitialStationState();
    try {
      _currentLocation = await Utilities.getUserCurrentLocation();
      BlocProvider.of<StationDetailsCubit>(context).loadStationDetail(
        widget.stationId,
        _currentLocation.latitude,
        _currentLocation.longitude,
      );
      isPermissionLocation = true;
    } catch (e) {
      try {
        BlocProvider.of<StationDetailsCubit>(context)
            .loadStationDetail(widget.stationId, 13.76483333, 100.5382222);
      } catch (e) {
        BlocProvider.of<StationDetailsCubit>(context)
            .resetInitialStationState();
        Navigator.of(context).pop();
      }
      isPermissionLocation = false;
    }
  }

  void generateWidgetCharger() {
    if (_stationDetailEntity!.charger.length > 0) {
      for (var charger in _stationDetailEntity!.charger) {
        ChargerEntity? chargerEntity = charger;
        widgetCharger.add(ListCharger(
          stationData: _stationDetailEntity,
          charger: chargerEntity,
        ));
        widgetConnector.clear();
      }
    }
  }

  void onPressedBack() {
    Navigator.of(context).pop();
  }

  void onPageChanged(int page) {
    setState(() {
      activePage = page;
    });
  }

  void actionStationDetailLoading() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!loading) {
        setState(() {
          loading = true;
        });
      }
    });
  }

  void actionStationDetailSuccess(state) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (loading) {
        widgetCharger.clear();
        widgetConnector.clear();
        setState(() {
          loading = false;
          _stationDetailEntity = state.stationDetailEntity;
          listFac = _stationDetailEntity?.facility ?? [];
          favoriteStation = _stationDetailEntity!.favorite;
        });
        generateWidgetCharger();
      }
    });
  }

  void actionStationDetailFailure() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (loading) {
        setState(() {
          loading = false;
        });
      }
    });
  }

  void actionFavoriteStationAddLoading() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!loadingFavorite) {
        setState(() {
          loadingFavorite = true;
        });
      }
    });
  }

  void actionFavoriteStationAddSuccess() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (loadingFavorite) {
        if (favoriteStation == true) {
          favoriteStation = false;
          Utilities.alertAfterSaveAction(
              context: context,
              type: AppAlertType.SUCCESS,
              text: translate(
                  'alert_after_save.save_success.delete_favorite_station'));
        } else {
          favoriteStation = true;
          Utilities.alertAfterSaveAction(
              context: context,
              type: AppAlertType.SUCCESS,
              text: translate(
                  'alert_after_save.save_success.add_favorite_station'));
        }
        setState(() {
          loadingFavorite = false;
        });
      }
    });
  }

  void actionFavoriteStationAddFailure() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (loadingFavorite) {
        setState(() {
          loadingFavorite = false;
        });
        // ScaffoldMessenger.of(context).showSnackBar(
        //   const SnackBar(content: Text('Cannot save data !!!')),
        // );
        Utilities.alertAfterSaveAction(
            context: context,
            type: AppAlertType.WARNING,
            time: 5,
            text: translate(
                'alert_after_save.save_failure.add_favorite_station'));
      }
    });
  }

  void actionDefault() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (loading) {
        setState(() {
          loading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        initialLoading();
      },
      child: Scaffold(
        backgroundColor: AppTheme.white,
        body: BlocBuilder<StationDetailsCubit, StationDetailsState>(
          builder: (context, state) {
            switch (state.runtimeType) {
              case StationDetailsLoading:
                actionStationDetailLoading();
                break;
              case StationDetailsSuccess:
                actionStationDetailSuccess(state);
                break;
              case StationDetailsFailure:
                actionStationDetailFailure();
                break;
              case FavoriteStationAddLoading:
                actionFavoriteStationAddLoading();
                break;
              case FavoriteStationAddSuccess:
                actionFavoriteStationAddSuccess();
                break;
              case FavoriteStationAddFailure:
                actionFavoriteStationAddFailure();
                break;
              default:
                break;
            }
            return Stack(
              children: [
                PageViewImage(
                  pageController: _pageController,
                  onPageChanged: onPageChanged,
                  imageList: _stationDetailEntity?.images ?? [],
                  isLoading: loading,
                ),
                Container(
                  padding: EdgeInsets.only(top: 200),
                  child: NotificationListener<OverscrollIndicatorNotification>(
                    onNotification:
                        (OverscrollIndicatorNotification overscroll) {
                      overscroll.disallowIndicator();
                      return true;
                    },
                    child: SingleChildScrollView(
                      physics: ClampingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics(),
                      ),
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.fromLTRB(
                                16, 60, 16, Platform.isAndroid ? 100 : 105),
                            color: AppTheme.white,
                            child: Column(
                              children: [
                                StationDetail(
                                  stationDetailEntity: _stationDetailEntity,
                                  isPermissionLocation: isPermissionLocation,
                                  isLoading: loading,
                                ),
                                const SizedBox(height: 12),
                                DividerForStation(top: 8, bottom: 12),
                                Container(
                                  child: Column(
                                    children: [
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: TextLabel(
                                          text: translate(
                                              'station_details_page.charger'),
                                          color: AppTheme.blueDark,
                                          fontSize: Utilities
                                              .sizeFontWithDesityForDisplay(
                                                  context, AppFontSize.large),
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      !loading
                                          ? Column(
                                              children:
                                                  widgetCharger.map((charger) {
                                                return Column(
                                                  children: [
                                                    charger,
                                                    SizedBox(height: 12)
                                                  ],
                                                );
                                              }).toList(),
                                            )
                                          : ChargerLoading(),
                                      listFac.length > 0 && !loading
                                          ? DividerForStation(
                                              top: 8, bottom: 12)
                                          : SizedBox.square(),
                                      listFac.length > 0 && !loading
                                          ? Facility(data: listFac)
                                          : SizedBox.square(),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                StationName(
                  stationDetailEntity: _stationDetailEntity,
                  isLoading: loading,
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 130, 0, 0),
                  child: PageImageIndicator(
                    imageList: _stationDetailEntity?.images ?? [],
                    pageController: _pageController,
                    activePage: activePage,
                    isLoading: loading,
                  ),
                ),
                ButtonAtBottom(
                  stationDetailEntity: _stationDetailEntity,
                  fromMapPage: widget.fromMapPage,
                  isLoading: loading,
                ),
                ArrowBackAtAppBar(
                    stationDetailEntity: _stationDetailEntity,
                    favoriteStation: favoriteStation!,
                    onPressedBack: onPressedBack,
                    isLoading: loading,
                    loadingFavorite: loadingFavorite),
              ],
            );
          },
        ),
      ),
    );
  }
}
