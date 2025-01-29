import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:jupiter_api/data/data_models/request/add_ev_car_form.dart';
import 'package:jupiter_api/data/data_models/request/edit_ev_car_form.dart';
import 'package:jupiter_api/domain/entities/car_master_entity.dart';
import 'package:jupiter_api/domain/usecase/user_management_usecase.dart';

import '../../../../constant_value.dart';
import '../../../../utilities.dart';

part 'ev_information_add_state.dart';

class EvInformationAddCubit extends Cubit<EvInformationAddState> {
  EvInformationAddCubit(this._useCase) : super(EvInformationAddInitial());

  @FactoryMethod()
  final UserManagementUseCase _useCase;

  void loadCarMaster() async {
    emit(EvLoadCarMasterLoading());

    Utilities.requestAccessToken(_useCase, (
        {required accessToken, required deviceCode, required username}) async {
      final result = await _useCase.carMaster(accessToken, ConstValue.orgCode);

      result.fold(
        (failure) {
          debugPrint("carMaster Failure");
          emit(EvLoadCarMasterFailure());
        },
        (data) {
          debugPrint("carMaster Cubit Success");

          emit(EvLoadCarMasterSuccess(data));
        },
      );
    }, "CarMaster");
  }

  void addCar({
    // required String brand,
    // required String model,
    required int vehicleNo,
    required String licensePlate,
    required String province,
    required bool defalut,
  }) async {
    emit(EvInformationAddLoading());

    Utilities.requestAccessToken(_useCase, (
        {required accessToken, required deviceCode, required username}) async {
      final result = await _useCase.addCar(
        accessToken,
        AddEvCarForm(
          username: username,
          vehicleNo: vehicleNo,
          licensePlate: licensePlate,
          province: province,
          defalut: defalut,
          orgCode: ConstValue.orgCode,
        ),
      );

      result.fold(
        (failure) {
          debugPrint("addCar Failure");
          emit(EvInformationAddFailure(failure.message));
        },
        (data) {
          debugPrint("addCar Cubit Success");

          emit(EvInformationAddSuccess());
        },
      );
    }, "AddCar");
  }

  void editCar({
    // required String brand,
    // required String model,
    required int vehicleNoCurrent,
    required int vehicleNo,
    required String licensePlateCurrent,
    required String licensePlate,
    required String provinceCurrent,
    required String province,
    required bool defalut,
  }) async {
    emit(EvInformationEditLoading());
    Utilities.requestAccessToken(_useCase, (
        {required accessToken, required deviceCode, required username}) async {
      final result = await _useCase.editCar(
        accessToken,
        EditEvCarForm(
          username: username,
          vehicleNoCurrent: vehicleNoCurrent,
          vehicleNo: vehicleNo,
          licensePlateCurrent: licensePlateCurrent,
          licensePlate: licensePlate,
          provinceCurrent: provinceCurrent,
          province: province,
          defalut: defalut,
          orgCode: ConstValue.orgCode,
        ),
      );

      result.fold(
        (failure) {
          debugPrint("editCar Failure");
          emit(EvInformationEditFailure(failure.message));
        },
        (data) {
          debugPrint("editCar Cubit Success");

          emit(EvInformationEditSuccess());
        },
      );
    }, "EditCar");
  }

  void resetState() {
    emit(EvInformationAddInitial());
  }
}
