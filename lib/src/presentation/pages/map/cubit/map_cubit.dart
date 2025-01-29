import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:jupiter_api/data/data_models/request/route_planning_data_form.dart';
import 'package:jupiter_api/data/data_models/request/route_planning_form.dart';
import 'package:jupiter_api/data/data_models/request/route_planning_location_form.dart';
import 'package:jupiter_api/data/data_models/request/route_planning_modifiers_form.dart';
import 'package:jupiter_api/data/data_models/request/station_detail_form.dart';
import 'package:jupiter_api/data/data_models/request/station_form.dart';
import 'package:jupiter_api/data/data_models/request/update_favorite_station_form.dart';
import 'package:jupiter_api/domain/entities/connector_type_entity.dart';
import 'package:jupiter_api/domain/entities/favorite_station_entity.dart';
import 'package:jupiter_api/domain/entities/route_planning_entity.dart';
import 'package:jupiter_api/domain/entities/station_details_entity.dart';
import 'package:jupiter_api/domain/entities/station_entity.dart';
import 'package:jupiter/src/utilities.dart';
import 'package:jupiter_api/domain/usecase/user_management_usecase.dart';

import '../../../../constant_value.dart';

part 'map_state.dart';

class MapCubit extends Cubit<MapState> {
  @FactoryMethod()
  final UserManagementUseCase _useCase;
  MapCubit(this._useCase) : super(MapInitial());

  void loadingAllMarker(
      bool filterOpenService,
      bool filterChargerAvailble,
      bool filterDistance,
      List<String?> filterConnectorAC,
      List<String?> filterConnectorDC,
      double latitude,
      double longitude) async {
    emit(MapLoading());
    Utilities.requestAccessToken(_useCase, (
        {required accessToken, required deviceCode, required username}) async {
      final result = await _useCase.listAllMarkerStations(
          accessToken,
          StationForm(
              filterOpenService: filterOpenService,
              filterChargerAvailble: filterChargerAvailble,
              filterDistance: filterDistance,
              filterConnectorAC: filterConnectorAC,
              filterConnectorDC: filterConnectorDC,
              latitude: latitude,
              longitude: longitude,
              orgCode: ConstValue.orgCode));

      result.fold(
        (failure) {
          debugPrint("listAllMarkerStations Failure");
          emit(MapLoadMarkerFailure());
        },
        (data) {
          debugPrint("listAllMarkerStations Cubit Success");
          emit(MapLoadMarkerSuccess(data));
        },
      );
    }, "ListAllMarkerStations");
  }

  void loadFilterMap() async {
    emit(FilterLoading());
    Utilities.requestAccessToken(_useCase, (
        {required accessToken, required deviceCode, required username}) async {
      final result = await _useCase.filterMapType(
        accessToken,
      );

      result.fold(
        (failure) {
          debugPrint("loadStationDetail Failure");
          emit(FilterLoadFailure());
        },
        (data) {
          debugPrint("loadStationDetail Cubit Success");
          emit(FilterLoadSuccess(data));
        },
      );
    }, "FilterMapType");
  }

  void loadStationDetail(
      String stationId, double latitude, double longitude) async {
    emit(MapLoading());
    Utilities.requestAccessToken(_useCase, (
        {required accessToken, required deviceCode, required username}) async {
      debugPrint("requestAccessToken Cubit Sucess");
      debugPrint("StationDetailForm $stationId");
      debugPrint("StationDetailForm $latitude");
      debugPrint("StationDetailForm $longitude");
      final result = await _useCase.stationDetail(
          accessToken,
          StationDetailForm(
            stationId: stationId,
            latitude: latitude,
            longitude: longitude,
            username: username,
            orgCode: ConstValue.orgCode,
          ));

      result.fold(
        (failure) {
          debugPrint("loadStationDetail Failure");
          emit(MapLoadStationDetailFailure());
        },
        (data) {
          debugPrint("loadStationDetail Cubit Success");
          emit(MapLoadStationDetailSuccess(data));
        },
      );
    }, "StationDetail");
  }

  void updateFavorite({
    required String stationId,
    required String stationName,
  }) async {
    emit(FavoriteStationAddLoading());

    Utilities.requestAccessToken(_useCase, (
        {required accessToken, required deviceCode, required username}) async {
      final result = await _useCase.updateFavoriteStation(
        accessToken,
        UpdateFavoriteStationForm(
          username: username,
          stationId: stationId,
          stationName: stationName,
          orgCode: ConstValue.orgCode,
        ),
      );

      result.fold(
        (failure) {
          debugPrint("Update Favorite Failure");
          emit(FavoriteStationAddFailure());
        },
        (data) {
          debugPrint("Update Favorite Cubit Success");

          emit(FavoriteStationAddSuccess());
        },
      );
    }, "UpdateFavoriteMap");
  }

  void getRoutePlanner(
    // String origin,
    // String destination,
    // String mode,
    // String waypoints,
    // bool avoidHighways,
    // bool avoidTolls,
    // bool avoidFerries,
    RoutePlanningLocationForm origin,
    RoutePlanningLocationForm destination,
    List<RoutePlanningLocationForm> intermediates,
    String travelMode,
    String routingPreference,
    bool computeAlternativeRoutes,
    RoutePlanningModifiersForm routeModifiers,
    String languageCode,
  ) async {
    emit(RoutePlannerLoading());
    Utilities.requestAccessToken(_useCase, (
        {required accessToken, required deviceCode, required username}) async {
      final result = await _useCase.getRoutePlanning(
          accessToken,
          // RoutePlanningForm(
          //     origin: origin,
          //     destination: destination,
          //     mode: mode,
          //     waypoints: waypoints,
          //     avoidHighways: avoidHighways,
          //     avoidTolls: avoidTolls,
          //     avoidFerries: avoidFerries)

          RoutePlanningForm(
              data: RoutePlanningDataForm(
            origin: origin,
            destination: destination,
            intermediates: intermediates,
            travelMode: travelMode,
            routingPreference: routingPreference,
            computeAlternativeRoutes: computeAlternativeRoutes,
            routeModifiers: routeModifiers,
            languageCode: languageCode,
          )));

      result.fold(
        (failure) {
          debugPrint("getRoutePlanner Failure");
          emit(RoutePlannerFailure(failure.message));
        },
        (data) {
          debugPrint("getRoutePlanner Cubit Success");
          emit(RoutePlannerSuccess(data));
        },
      );
    }, "GetRoutePlanner");
  }

  void resetCubitMap() {
    emit(MapInitial());
  }
}
