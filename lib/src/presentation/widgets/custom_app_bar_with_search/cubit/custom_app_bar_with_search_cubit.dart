import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:jupiter_api/data/data_models/request/finding_station_form.dart';
import 'package:jupiter_api/domain/entities/finding_station_entity.dart';
import 'package:jupiter_api/domain/usecase/user_management_usecase.dart';

import '../../../../constant_value.dart';
import '../../../../utilities.dart';

part 'custom_app_bar_with_search_state.dart';

class CustomAppBarWithSearchCubit extends Cubit<CustomAppBarWithSearchState> {
  @FactoryMethod()
  final UserManagementUseCase _useCase;
  CustomAppBarWithSearchCubit(this._useCase)
      : super(CustomAppBarWithSearchInitial());

  void findStation(double latitude, double longitude) async {
    emit(CustomAppBarWithSearchLoading());
    Utilities.requestAccessToken(_useCase, (
        {required accessToken, required deviceCode, required username}) async {
      final result = await _useCase.findingStation(
          accessToken,
          FindingStationForm(
              latitude: latitude,
              longitude: longitude,
              orgCode: ConstValue.orgCode));

      result.fold(
        (failure) {
          debugPrint("findStation Cubit Failure");
          emit(FindingStationFailure(failure.message));
        },
        (data) {
          debugPrint("findStation Cubit Success");
          debugPrint("findStation Cubit ${data.stationList.length}");
          emit(FindingStationSuccess(data));
        },
      );
    }, "FindingStation");
  }

  void resetCustomAppBarWithSearchCubit() {
    emit(CustomAppBarWithSearchInitial());
  }
}
