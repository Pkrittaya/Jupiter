import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:jupiter/src/constant_value.dart';
import 'package:jupiter_api/data/data_models/request/delete_ev_car_form.dart';
import 'package:jupiter_api/data/data_models/request/username_and_orgcode_form.dart';
import 'package:jupiter_api/domain/entities/car_entity.dart';
import 'package:jupiter_api/domain/usecase/user_management_usecase.dart';

import '../../../../utilities.dart';

part 'ev_information_state.dart';

class EvInformationCubit extends Cubit<EvInformationState> {
  @FactoryMethod()
  final UserManagementUseCase _useCase;
  EvInformationCubit(this._useCase) : super(EvInformationInitial());

  void loadCarList() async {
    emit(EvInformationCarLoading());

    Utilities.requestAccessToken(_useCase, (
        {required accessToken, required deviceCode, required username}) async {
      final result = await _useCase.carList(
          accessToken,
          UsernameAndOrgCodeForm(
              username: username, orgCode: ConstValue.orgCode));

      result.fold(
        (failure) {
          debugPrint('loadCreditCard Failure');
          emit(EvInformationCarLoadingFailure());
        },
        (data) {
          debugPrint('loadCreditCard Cubit Success');

          emit(EvInformationCarLoadingSuccess(data));
        },
      );
    }, 'CarList');
  }

  void deleteCar(CarEntity carEntity) async {
    emit(EvInformationCarDeleteStart());
    Utilities.requestAccessToken(_useCase, (
        {required accessToken, required deviceCode, required username}) async {
      final deleteEvForm = DeleteEvCarForm(
        username: username,
        orgCode: ConstValue.orgCode,
        // brand: carEntity.brand,
        // model: carEntity.model,
        vehicleNo: carEntity.vehicleNo,
        licensePlate: carEntity.licensePlate,
        province: carEntity.province,
      );
      final result = await _useCase.deleteCar(accessToken, deleteEvForm);

      result.fold(
        (failure) {
          debugPrint('Delete Car Failure');
          emit(EvInformationCarDeleteFailure(failure.message));
        },
        (data) {
          debugPrint('Delete Car Success');
          debugPrint('Delete Car Success $data');

          emit(EvInformationCarDeleteSuccess());
        },
      );
    }, 'Delete Car');
  }

  void resetCarCubit() async {
    emit(EvInformationInitial());
  }
}
