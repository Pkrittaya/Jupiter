// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:jupiter_api/data/data_models/request/check_status_fleet_form.dart';
import 'package:jupiter_api/data/data_models/request/list_payment_form.dart';
import 'package:jupiter_api/data/data_models/request/manage_charger_form.dart';
import 'package:jupiter_api/data/data_models/request/payment_type_form.dart';
import 'package:jupiter_api/data/data_models/request/remote_stop_fleet_form.dart';
import 'package:jupiter_api/data/data_models/request/status_charger_form.dart';
import 'package:jupiter_api/data/data_models/request/update_current_battery_form.dart';
import 'package:jupiter_api/data/data_models/request/update_select_payment_form.dart';
import 'package:jupiter_api/domain/entities/charger_realtime_entity.dart';
import 'package:jupiter_api/domain/entities/check_status_entity.dart';
import 'package:jupiter_api/domain/usecase/user_management_usecase.dart';
import 'package:jupiter/src/utilities.dart';

import '../../../../../constant_value.dart';

part 'charging_realtime_state.dart';

class ChargingRealtimeCubit extends Cubit<ChargingRealtimeState> {
  @FactoryMethod()
  final UserManagementUseCase _useCase;
  ChargingRealtimeCubit(this._useCase) : super(ChargingRealtimeInitial());

  void fetchCheckStatus() async {
    emit(ChargingCheckStatusLoading());
    Utilities.requestAccessToken(_useCase, (
        {required accessToken, required deviceCode, required username}) async {
      final result = await _useCase.statusCharging(
          accessToken,
          StatusChargerForm(
            deviceCode: deviceCode,
            username: username,
            orgCode: ConstValue.orgCode,
          ));

      result.fold(
        (failure) {
          emit(ChargingCheckStatusFailure());
        },
        (data) async {
          emit(ChargingCheckStatusSuccess(data));
        },
      );
    }, 'CheckStatusCharging');
  }

  void fetchCheckStatusFleetOperation({
    required int fleetNo,
    required String fleetType,
    required String qrCode,
  }) async {
    emit(ChargingCheckStatusLoading());
    Utilities.requestAccessToken(_useCase, (
        {required accessToken, required deviceCode, required username}) async {
      final result = await _useCase.checkStatusFleetOperation(
          accessToken,
          CheckStatusFleetForm(
            deviceCode: deviceCode,
            username: username,
            fleetNo: fleetNo,
            fleetType: fleetType,
            refCode: qrCode,
            orgCode: ConstValue.orgCode,
          ));

      result.fold(
        (failure) {
          emit(ChargingCheckStatusFailure());
        },
        (data) async {
          emit(ChargingCheckStatusSuccess(data));
        },
      );
    }, 'FetchCheckStatusFleetOperation');
  }

  void fetchCheckStatusFleetCard({
    required int fleetNo,
    required String fleetType,
    required String refCode,
  }) async {
    emit(ChargingCheckStatusLoading());
    Utilities.requestAccessToken(_useCase, (
        {required accessToken, required deviceCode, required username}) async {
      final result = await _useCase.checkStatusFleetCard(
          accessToken,
          CheckStatusFleetForm(
            deviceCode: deviceCode,
            username: username,
            fleetNo: fleetNo,
            fleetType: fleetType,
            refCode: refCode,
            orgCode: ConstValue.orgCode,
          ));

      result.fold(
        (failure) {
          emit(ChargingCheckStatusFailure());
        },
        (data) async {
          emit(ChargingCheckStatusSuccess(data));
        },
      );
    }, 'FetchCheckStatusFleetCard');
  }

  void fetchListPayment({required String qrCode}) async {
    emit(ChargingGetPaymentLoading());
    Utilities.requestAccessToken(_useCase, (
        {required accessToken, required deviceCode, required username}) async {
      final result = await _useCase.listPayment(
          accessToken,
          ListPaymentForm(
            username: username,
            qrCodeConnector: qrCode,
            deviceCode: deviceCode,
            orgCode: ConstValue.orgCode,
          ));

      result.fold(
        (failure) {
          emit(ChargingGetPaymentFailure());
        },
        (data) {
          emit(ChargingGetPaymentSuccess(data));
        },
      );
    }, 'GetListCreditCard');
  }

  void fetchUpdateSelectPayment(
      {required String qrCode,
      required PaymentTypeForm paymentSelected}) async {
    emit(ChargingUpdatePaymentLoading());
    Utilities.requestAccessToken(_useCase, (
        {required accessToken, required deviceCode, required username}) async {
      final result = await _useCase.updateSelectPayment(
          accessToken,
          UpdateSelectPaymentForm(
            username: username,
            qrCodeConnector: qrCode,
            deviceCode: deviceCode,
            payment: PaymentTypeForm(
                brand: paymentSelected.brand,
                display: paymentSelected.display,
                token: paymentSelected.token,
                type: paymentSelected.type,
                name: paymentSelected.name),
            orgCode: ConstValue.orgCode,
          ));

      result.fold(
        (failure) {
          emit(ChargingUpdatePaymentFailure(failure.message));
        },
        (data) {
          emit(ChargingUpdatePaymentSuccess());
        },
      );
    }, 'UpdateSelectedCreditCard');
  }

  void fetchUpdateCurrentBattery({
    required String qrCode,
    required int currentBattery,
    required bool fleetStatus,
    required int fleetNo,
  }) async {
    emit(ChargingUpdateBatteryLoading());
    Utilities.requestAccessToken(_useCase, (
        {required accessToken, required deviceCode, required username}) async {
      final result = await _useCase.updateCurrentBattery(
          accessToken,
          UpdateCurrentBatteryForm(
            username: username,
            qrCodeConnector: qrCode,
            deviceCode: deviceCode,
            currentBattery: currentBattery,
            fleetStatus: fleetStatus,
            fleetNo: fleetNo,
            orgCode: ConstValue.orgCode,
          ));

      result.fold(
        (failure) {
          emit(ChargingUpdateBatteryFailure(failure.message));
        },
        (data) {
          emit(ChargingUpdateBatterySuccess());
        },
      );
    }, 'UpdateCurrentBattery');
  }

  void fetchStopCharging({
    required String qrCode,
    required ChargerRealtimeEntity? chargerRealtimeEntity,
  }) async {
    emit(ChargingStopChargingLoading());
    Utilities.requestAccessToken(_useCase, (
        {required accessToken, required deviceCode, required username}) async {
      final result = await _useCase.stopCharging(
          accessToken,
          ManageChargerForm(
            username: username,
            qrCodeConnector: qrCode,
            chargerId: chargerRealtimeEntity?.connector?.chargerId ?? '',
            connectorId: chargerRealtimeEntity?.connector?.connectorId ?? '',
            connectorIndex:
                chargerRealtimeEntity?.connector?.connectorIndex ?? 0,
            deviceCode: deviceCode,
            orgCode: ConstValue.orgCode,
          ));

      result.fold(
        (failure) {
          debugPrint('STOP CHARGING FAILED');
          emit(ChargingStopChargingFailure(failure.message));
        },
        (data) {
          debugPrint('STOP CHARGING SUCCESS');
          emit(ChargingStopChargingSuccess());
        },
      );
    }, 'StopCharging');
  }

  void fleetStopChargingOperation({
    required String qrCode,
    required ChargerRealtimeEntity? chargerRealtimeEntity,
    required int fleetNo,
    required String fleetType,
  }) async {
    emit(ChargingStopChargingLoading());
    Utilities.requestAccessToken(_useCase, (
        {required accessToken, required deviceCode, required username}) async {
      final result = await _useCase.remoteStopFleetOperation(
        accessToken,
        RemoteStopFleetForm(
          username: username,
          qrCodeConnector: qrCode,
          chargerId: chargerRealtimeEntity?.connector?.chargerId ?? '',
          connectorId: chargerRealtimeEntity?.connector?.connectorId ?? '',
          connectorIndex: chargerRealtimeEntity?.connector?.connectorIndex ?? 0,
          deviceCode: deviceCode,
          fleetNo: fleetNo,
          fleetType: fleetType,
          orgCode: ConstValue.orgCode,
        ),
      );
      result.fold(
        (failure) {
          debugPrint('FLEET OPERATION STOP CHARGING FAILED');
          emit(ChargingStopChargingFailure(failure.message));
        },
        (data) {
          debugPrint('FLEET OPERATION STOP CHARGING SUCCESS');
          emit(ChargingStopChargingSuccess());
        },
      );
    }, 'FleetStopChargingOperation');
  }

  void fleetStopChargingCard({
    required String qrCode,
    required ChargerRealtimeEntity? chargerRealtimeEntity,
    required int fleetNo,
    required String fleetType,
  }) async {
    emit(ChargingStopChargingLoading());
    Utilities.requestAccessToken(_useCase, (
        {required accessToken, required deviceCode, required username}) async {
      final result = await _useCase.remoteStopFleetCard(
        accessToken,
        RemoteStopFleetForm(
          username: username,
          qrCodeConnector: qrCode,
          chargerId: chargerRealtimeEntity?.connector?.chargerId ?? '',
          connectorId: chargerRealtimeEntity?.connector?.connectorId ?? '',
          connectorIndex: chargerRealtimeEntity?.connector?.connectorIndex ?? 0,
          deviceCode: deviceCode,
          fleetNo: fleetNo,
          fleetType: fleetType,
          orgCode: ConstValue.orgCode,
        ),
      );
      result.fold(
        (failure) {
          debugPrint('FLEET CARD STOP CHARGING FAILED');
          emit(ChargingStopChargingFailure(failure.message));
        },
        (data) {
          debugPrint('FLEET CARD STOP CHARGING SUCCESS');
          emit(ChargingStopChargingSuccess());
        },
      );
    }, 'FleetStopChargingCard');
  }

  void fetchResetCubitToInital() {
    emit(ChargingRealtimeInitial());
  }
}
