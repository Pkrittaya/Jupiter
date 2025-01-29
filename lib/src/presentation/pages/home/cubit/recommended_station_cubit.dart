import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:jupiter_api/data/data_models/request/recommended_station_form.dart';
import 'package:jupiter_api/domain/entities/recommended_station_entity.dart';
import 'package:jupiter_api/domain/usecase/user_management_usecase.dart';
import 'package:jupiter/src/utilities.dart';

import '../../../../constant_value.dart';

part 'recommended_station_state.dart';

class RecommendedStationCubit extends Cubit<RecommendedStationState> {
  @FactoryMethod()
  final UserManagementUseCase _useCase;
  RecommendedStationCubit(this._useCase) : super(RecommendedStationInitial());

  void loadingRecommendedStation(
      bool filterOpenService,
      bool filterDistance,
      List<String?> filterConnectorDC,
      double latitude,
      double longitude) async {
    emit(RecommendedStationLoading());
    Utilities.requestAccessToken(_useCase, (
        {required accessToken, required deviceCode, required username}) async {
      final result = await _useCase.recommendedStation(
          accessToken,
          RecommendedStationForm(
              filterOpenService: filterOpenService,
              filterDistance: filterDistance,
              filterConnectorDC: filterConnectorDC,
              latitude: latitude,
              longitude: longitude,
              orgCode: ConstValue.orgCode));

      result.fold(
        (failure) {
          debugPrint('recommendedStation Failure');
          emit(RecommendedStationFailure());
        },
        (data) {
          debugPrint('recommendedStation Cubit Success');
          emit(RecommendedStationSuccess(data));
        },
      );
    }, 'RecommendedStation');
  }

  void resetRecommendedStatioToInitialState() async {
    emit(RecommendedStationInitial());
  }
}
