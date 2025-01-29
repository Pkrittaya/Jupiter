// ignore_for_file: unused_field

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:jupiter_api/domain/entities/check_status_entity.dart';
import 'package:jupiter_api/domain/usecase/user_management_usecase.dart';

part 'status_charging_state.dart';

class StatusChargingCubit extends Cubit<StatusChargingState> {
  @FactoryMethod()
  final UserManagementUseCase _useCase;
  StatusChargingCubit(this._useCase) : super(StatusChargingInitial());

  void statusCharging(CheckStatusEntity? checkStatusEntity) {
    debugPrint("statusCharging setting in mainmenu");

    if (checkStatusEntity?.chargingStatus ?? false) {
      emit(StatusCharging(checkStatusEntity));
      debugPrint("statusCharging charge");
    } else {
      emit(StatusChargingInitial());
      debugPrint("statusCharging not charge");
    }
  }

  void loadingCheckStatus() {
    emit(StatusChargingLoading());
  }

  void resetState() {
    emit(StatusChargingInitial());
  }
}
