import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:jupiter/src/constant_value.dart';
import 'package:jupiter_api/data/data_models/request/check_status_fleet_form.dart';
import 'package:jupiter_api/data/data_models/request/confirm_transaction_fleet_form.dart';
import 'package:jupiter_api/data/data_models/request/list_payment_form.dart';
import 'package:jupiter_api/data/data_models/request/manage_charger_form.dart';
import 'package:jupiter_api/data/data_models/request/payment_charging_form.dart';
import 'package:jupiter_api/data/data_models/request/payment_type_form.dart';
import 'package:jupiter_api/data/data_models/request/status_charger_form.dart';
import 'package:jupiter_api/data/data_models/request/update_select_payment_form.dart';
import 'package:jupiter_api/domain/entities/charger_realtime_entity.dart';
import 'package:jupiter_api/domain/entities/check_status_entity.dart';
import 'package:jupiter_api/domain/usecase/user_management_usecase.dart';
import 'package:jupiter/src/utilities.dart';

part 'receipt_success_state.dart';

class ReceiptSuccessCubit extends Cubit<ReceiptSuccessState> {
  @FactoryMethod()
  final UserManagementUseCase _useCase;
  ReceiptSuccessCubit(this._useCase) : super(ReceiptSuccessInitial());

  void fetchConfirmTransaction({
    required String qrCodeData,
    required ChargerRealtimeEntity? chargerRealtimeEntity,
  }) async {
    emit(ConfirmTransactionLoading());
    Utilities.requestAccessToken(_useCase, (
        {required accessToken, required deviceCode, required username}) async {
      final result = await _useCase.confirmCharging(
          accessToken,
          ManageChargerForm(
            username: username,
            qrCodeConnector: qrCodeData,
            chargerId: chargerRealtimeEntity?.connector?.chargerId ?? '',
            connectorId: chargerRealtimeEntity?.connector?.connectorId ?? '',
            connectorIndex:
                chargerRealtimeEntity?.connector?.connectorIndex ?? 0,
            deviceCode: deviceCode,
            orgCode: ConstValue.orgCode,
          ));

      result.fold(
        (failure) {
          debugPrint('CONFIRM TRANSCATION FAILURE');
          emit(ConfirmTransactionFailure());
        },
        (data) {
          debugPrint('CONFIRM TRANSCATION SUCCESS');
          emit(ConfirmTransactionSuccess());
        },
      );
    }, 'ConfirmTransaction');
  }

  void fetchConfirmTransactionFleetOperation({
    required String qrCodeData,
    required ChargerRealtimeEntity? chargerRealtimeEntity,
    required int fleetNo,
    required String fleetType,
  }) async {
    emit(ConfirmTransactionLoading());
    Utilities.requestAccessToken(_useCase, (
        {required accessToken, required deviceCode, required username}) async {
      final result = await _useCase.confirmTransactionFleetOperation(
          accessToken,
          ConfirmTransactionFleetForm(
            qrCodeConnector: qrCodeData,
            chargerId: chargerRealtimeEntity?.connector?.chargerId ?? '',
            connectorId: chargerRealtimeEntity?.connector?.connectorId ?? '',
            connectorIndex:
                chargerRealtimeEntity?.connector?.connectorIndex ?? 0,
            deviceCode: deviceCode,
            fleetNo: fleetNo,
            fleetType: fleetType,
            orgCode: ConstValue.orgCode,
          ));

      result.fold(
        (failure) {
          debugPrint('CONFIRM TRANSCATION FLEET OPERATION FAILURE');
          emit(ConfirmTransactionFailure());
        },
        (data) {
          debugPrint('CONFIRM TRANSCATION FLEET OPERATION SUCCESS');
          emit(ConfirmTransactionSuccess());
        },
      );
    }, 'FetchConfirmTransactionFleetOperation');
  }

  void fetchConfirmTransactionFleetCard({
    required String qrCodeData,
    required ChargerRealtimeEntity? chargerRealtimeEntity,
    required int fleetNo,
    required String fleetType,
  }) async {
    emit(ConfirmTransactionLoading());
    Utilities.requestAccessToken(_useCase, (
        {required accessToken, required deviceCode, required username}) async {
      final result = await _useCase.confirmTransactionFleetCard(
          accessToken,
          ConfirmTransactionFleetForm(
            qrCodeConnector: qrCodeData,
            chargerId: chargerRealtimeEntity?.connector?.chargerId ?? '',
            connectorId: chargerRealtimeEntity?.connector?.connectorId ?? '',
            connectorIndex:
                chargerRealtimeEntity?.connector?.connectorIndex ?? 0,
            deviceCode: deviceCode,
            fleetNo: fleetNo,
            fleetType: fleetType,
            orgCode: ConstValue.orgCode,
          ));

      result.fold(
        (failure) {
          debugPrint('CONFIRM TRANSCATION FLEET CARD FAILURE');
          emit(ConfirmTransactionFailure());
        },
        (data) {
          debugPrint('CONFIRM TRANSCATION FLEET CARD SUCCESS');
          emit(ConfirmTransactionSuccess());
        },
      );
    }, 'FetchConfirmTransactionFleetCard');
  }

  void fetchCheckStatus() async {
    emit(ReceiptSuccessCheckStatusLoading());
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
          emit(ReceiptSuccessCheckStatusFailure());
        },
        (data) async {
          emit(ReceiptSuccessCheckStatusSuccess(data));
        },
      );
    }, 'CheckStatusCharging');
  }

  void fetchFleetOperationCheckStatus({
    required int fleetNo,
    required String fleetType,
    required String qrCode,
  }) async {
    emit(ReceiptSuccessCheckStatusLoading());
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
          emit(ReceiptSuccessCheckStatusFailure());
        },
        (data) async {
          emit(ReceiptSuccessCheckStatusSuccess(data));
        },
      );
    }, 'FetchFleetOperationCheckStatus');
  }

  void fetchFleetCardCheckStatus({
    required int fleetNo,
    required String fleetType,
    required String refCode,
  }) async {
    emit(ReceiptSuccessCheckStatusLoading());
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
          emit(ReceiptSuccessCheckStatusFailure());
        },
        (data) async {
          emit(ReceiptSuccessCheckStatusSuccess(data));
        },
      );
    }, 'FetchFleetCardCheckStatus');
  }

  void fetchResetToInital() async {
    emit(ReceiptSuccessInitial());
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

  void fetchUpdatePaymentCharging({required String qrCode}) async {
    emit(PaymentChargingLoading());
    Utilities.requestAccessToken(_useCase, (
        {required accessToken, required deviceCode, required username}) async {
      final result = await _useCase.paymentCharging(
          accessToken,
          PaymentChargingForm(
            username: username,
            qrCodeConnector: qrCode,
            deviceCode: deviceCode,
            orgCode: ConstValue.orgCode,
          ));

      result.fold(
        (failure) {
          emit(PaymentChargingFailure(failure.message));
        },
        (data) {
          emit(PaymentChargingSuccess());
        },
      );
    }, 'UpdatePaymentCharging');
  }

  void fetchResetCubitToInital() {
    emit(ChargingRealtimeInitial());
  }
}
