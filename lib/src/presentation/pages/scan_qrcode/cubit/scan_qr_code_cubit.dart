import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:jupiter_api/data/data_models/request/charger_information_form.dart';
import 'package:jupiter_api/domain/entities/charger_information_entity.dart';
import 'package:jupiter_api/domain/usecase/user_management_usecase.dart';

import '../../../../constant_value.dart';
import '../../../../utilities.dart';

part 'scan_qr_code_state.dart';

class ScanQrCodeCubit extends Cubit<ScanQrCodeState> {
  @FactoryMethod()
  final UserManagementUseCase _useCase;
  ScanQrCodeCubit(this._useCase) : super(ScanQrCodeInitial());

  Future<void> chargerInformation(String qrCodeResult) async {
    emit(ScanQrCodeLoading());
    Utilities.requestAccessToken(_useCase, (
        {required accessToken, required deviceCode, required username}) async {
      final result = await _useCase.chargerInformation(
          accessToken,
          ChargerInformationForm(
              username: username,
              qrCodeConnector: qrCodeResult,
              deviceCode: deviceCode,
              orgCode: ConstValue.orgCode));

      result.fold(
        (failure) {
          debugPrint("StationDetailsCubit Failure");
          emit(ScanQrCodeLoadChargerInformationFailure(failure.message));
        },
        (data) {
          debugPrint("StationDetailsCubit  Success");
          emit(ScanQrCodeLoadChargerInformationSuccess(data));
        },
      );
    }, "ChargerInfomation");
  }

  void reState() {
    emit(ScanQrCodeInitial());
  }
}
