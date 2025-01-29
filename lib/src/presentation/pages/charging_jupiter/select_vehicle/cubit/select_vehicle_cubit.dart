import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:jupiter/src/constant_value.dart';
import 'package:jupiter/src/utilities.dart';
import 'package:jupiter_api/data/data_models/request/add_ev_car_charging_form.dart';
import 'package:jupiter_api/data/data_models/request/car_select_fleet_form.dart';
import 'package:jupiter_api/data/data_models/request/fleet_no_form.dart';
import 'package:jupiter_api/domain/entities/list_car_select_fleet_entity.dart';
import 'package:jupiter_api/domain/usecase/user_management_usecase.dart';

part 'select_vehicle_state.dart';

class SelectVehicleCubit extends Cubit<SelectVehicleState> {
  @FactoryMethod()
  final UserManagementUseCase _useCase;
  SelectVehicleCubit(this._useCase) : super(SelectVehicleInitial());

  void fetchSaveVehicle(
      {required int fleetNo,
      required String qrCodeConnector,
      required CarSelectFleetForm carSelect}) async {
    emit(SelectVehicleLoading());
    Utilities.requestAccessToken(_useCase, (
        {required accessToken, required deviceCode, required username}) async {
      final result = await _useCase.addVehicleChargingFleetOperation(
          accessToken,
          ConstValue.orgCode,
          AddCarChargingForm(
              fleetNo: fleetNo,
              qrCodeConnector: qrCodeConnector,
              carSelect: carSelect));
      result.fold(
        (failure) {
          emit(SaveVehicleFailure(failure.message));
        },
        (data) {
          emit(SaveVehicleSuccess());
        },
      );
    }, 'SaveVehicle');
  }

  void loadingVehicleForFleet(int fleetNo) async {
    emit(SelectVehicleLoading());
    Utilities.requestAccessToken(_useCase, (
        {required accessToken, required deviceCode, required username}) async {
      final result = await _useCase.listVehicleChargingFleetOperation(
          accessToken, ConstValue.orgCode, FleetNoForm(fleetNo: fleetNo));

      result.fold(
        (failure) {
          debugPrint('recommendedStation Failure');
          emit(LoadVehicleFailure(failure.message));
        },
        (data) {
          debugPrint('recommendedStation Cubit Success');
          emit(LoadVehicleSuccess(data));
        },
      );
    }, 'LoadingVehicleForFleet');
  }

  void resetSelectVehicleToInitialState() async {
    emit(SelectVehicleInitial());
  }
}
