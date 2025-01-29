import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:jupiter_api/data/data_models/request/delete_favotite_route_form.dart';
import 'package:jupiter_api/data/data_models/request/favorite_station_form.dart';
import 'package:jupiter_api/data/data_models/request/update_favorite_station_form.dart';
import 'package:jupiter_api/data/data_models/request/username_and_orgcode_form.dart';
import 'package:jupiter_api/domain/entities/favorite_route_item_entity.dart';
import 'package:jupiter_api/domain/entities/favorite_station_entity.dart';
import 'package:jupiter_api/domain/usecase/user_management_usecase.dart';
import '../../../../constant_value.dart';
import '../../../../utilities.dart';

part 'favorite_state.dart';

class FavoriteStationCubit extends Cubit<FavoriteStationState> {
  FavoriteStationCubit(this._useCase) : super(FavoriteStationInitial());

  @FactoryMethod()
  final UserManagementUseCase _useCase;

  void loadFavorite(double latitude, double longitude) async {
    emit(FavoriteStationLoading());
    Utilities.requestAccessToken(_useCase, (
        {required accessToken, required deviceCode, required username}) async {
      final result = await _useCase.favoriteStation(
          accessToken,
          FavoriteStationForm(
              username: username,
              latitude: latitude,
              longitude: longitude,
              orgCode: ConstValue.orgCode));
      result.fold(
        (failure) {
          debugPrint("FavoriteStation Failure");
          emit(FavoriteStationFailure());
        },
        (data) {
          debugPrint("FavoriteStation Cubit Success");
          emit(FavoriteStationSuccess(data));
        },
      );
    }, "FavoriteStation");
  }

  void loadFavoriteRoute() async {
    emit(FavoriteStationLoading());
    Utilities.requestAccessToken(_useCase, (
        {required accessToken, required deviceCode, required username}) async {
      final result = await _useCase.favoriteRoute(
          accessToken,
          UsernameAndOrgCodeForm(
              username: username, orgCode: ConstValue.orgCode));
      result.fold(
        (failure) {
          debugPrint("FavoriteStation Failure");
          emit(FavoriteRouteFailure());
        },
        (data) {
          debugPrint("FavoriteStation Cubit Success");
          emit(FavoriteRouteSuccess(data));
        },
      );
    }, "FavoriteStation");
  }

  void deleteFavoriteRoute({
    required String routeName,
  }) async {
    emit(FavoriteStationLoading());
    Utilities.requestAccessToken(_useCase, (
        {required accessToken, required deviceCode, required username}) async {
      final result = await _useCase.deleteFavoriteRoute(
          accessToken,
          DeleteFavoriteRouteForm(
            routeName: routeName,
          ));
      result.fold(
        (failure) {
          debugPrint("deleteFavoriteRoute Failure");
          emit(DeleteFavoriteRouteFailure(failure.message));
        },
        (data) {
          debugPrint("deleteFavoriteRoute Cubit Success");
          emit(DeleteFavoriteRouteSuccess());
        },
      );
    }, "DeleteFavoriteRoute");
  }

  void deleteFavoriteStation({
    required String stationId,
    required String stationName,
  }) async {
    emit(FavoriteStationLoading());

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
          emit(DeleteFavoriteStationFailure(failure.message));
        },
        (data) {
          debugPrint("Update Favorite Cubit Success");

          emit(DeleteFavoriteStationSuccess());
        },
      );
    }, "DeleteFavoriteStation");
  }

  void resetToInitialState() async {
    emit(FavoriteStationInitial());
  }
}
