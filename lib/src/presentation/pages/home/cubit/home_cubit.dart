import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:jupiter_api/domain/entities/has_charging_fleet_card_entity.dart';
import 'package:jupiter_api/domain/entities/list_data_permission_entity.dart';
import 'package:jupiter_api/domain/usecase/user_management_usecase.dart';

import '../../../../utilities.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  @FactoryMethod()
  final UserManagementUseCase _useCase;
  HomeCubit(this._useCase) : super(HomeInitial());

  void fetchPermissonFleet() async {
    emit(HomeLoading());
    Utilities.requestAccessToken(_useCase, (
        {required accessToken, required deviceCode, required username}) async {
      final result = await _useCase.permissionFleet(accessToken);
      result.fold(
        (failure) {
          debugPrint('fetchPermissonFleet Failure');
          emit(HomeGetPermissionFleetFailure(failure.message));
        },
        (data) {
          debugPrint('fetchPermissonFleet Cubit Success');
          emit(HomeGetPermissionFleetSuccess(data));
        },
      );
    }, 'fetchPermissonFleet');
  }

  void fetchHasChargingFleetCard() async {
    emit(HomeLoading());
    Utilities.requestAccessToken(_useCase, (
        {required accessToken, required deviceCode, required username}) async {
      final result = await _useCase.checkHasChargingFleetCard(accessToken);
      result.fold(
        (failure) {
          debugPrint('fetchHasChargingFleetCard Failure');
          emit(HomeHasChargingFleetCardFailure(failure.message));
        },
        (data) {
          debugPrint('fetchHasChargingFleetCard Cubit Success');
          emit(HomeHasChargingFleetCardSuccess(data));
        },
      );
    }, 'fetchHasChargingFleetCard');
  }

  void fetchHasChargingFleetOperation() async {
    emit(HomeLoading());
    Utilities.requestAccessToken(_useCase, (
        {required accessToken, required deviceCode, required username}) async {
      final result = await _useCase.checkHasChargingFleetOperation(accessToken);
      result.fold(
        (failure) {
          debugPrint('fetchHasChargingFleetOperation Failure');
          emit(HomeHasChargingFleetOperationFailure(failure.message));
        },
        (data) {
          debugPrint('fetchHasChargingFleetOperation Cubit Success');
          emit(HomeHasChargingFleetOperationSuccess(data));
        },
      );
    }, 'fetchHasChargingFleetOperation');
  }

  void resetHomeCubit() {
    emit(HomeInitial());
  }
}
