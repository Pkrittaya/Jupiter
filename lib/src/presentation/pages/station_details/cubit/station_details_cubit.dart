import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:jupiter_api/data/data_models/request/station_detail_form.dart';
import 'package:jupiter_api/data/data_models/request/update_favorite_station_form.dart';
import 'package:jupiter_api/domain/entities/favorite_station_entity.dart';
import 'package:jupiter_api/domain/entities/station_details_entity.dart';
import 'package:jupiter_api/domain/usecase/user_management_usecase.dart';

import '../../../../constant_value.dart';
import '../../../../utilities.dart';

part 'station_details_state.dart';

class StationDetailsCubit extends Cubit<StationDetailsState> {
  @FactoryMethod()
  final UserManagementUseCase _useCase;
  StationDetailsCubit(this._useCase) : super(StationDetailsInitial());

  void loadStationDetail(
      String stationId, double latitude, double longitude) async {
    debugPrint("StationDetailPage Loading ");
    emit(StationDetailsLoading());

    // await Future.delayed(const Duration(seconds: 2));

    Utilities.requestAccessToken(_useCase, (
        {required accessToken, required deviceCode, required username}) async {
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
          debugPrint("StationDetailsCubit Failure");
          emit(StationDetailsFailure());
        },
        (data) {
          debugPrint("StationDetailsCubit  Success");
          emit(StationDetailsSuccess(data));
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
    }, "UpdateFavoriteStationDetail");
  }

  void resetInitialStationState() {
    emit(StationDetailsInitial());
  }
}
