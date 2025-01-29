import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:jupiter/src/constant_value.dart';
import 'package:jupiter_api/data/data_models/request/check_status_fleet_form.dart';
import 'package:jupiter_api/data/data_models/request/fleet_charger_form.dart';
import 'package:jupiter_api/data/data_models/request/fleet_detail_card_form.dart';
import 'package:jupiter_api/data/data_models/request/fleet_no_form.dart';
import 'package:jupiter_api/data/data_models/request/history_fleet_card_form.dart';
import 'package:jupiter_api/data/data_models/request/verify_fleet_card_form.dart';
import 'package:jupiter_api/domain/entities/check_status_entity.dart';
import 'package:jupiter_api/domain/entities/fleet_card_info_entity.dart';
import 'package:jupiter_api/domain/entities/fleet_card_item_entity.dart';
import 'package:jupiter_api/domain/entities/fleet_operation_info_entity.dart';
import 'package:jupiter_api/domain/entities/fleet_operation_item_entity.dart';
import 'package:jupiter_api/domain/entities/history_fleet_entity.dart';
import 'package:jupiter_api/domain/entities/llst_charger_fleet_card_entity.dart';
import 'package:jupiter_api/domain/entities/llst_charger_fleet_operation_entity.dart';
import 'package:jupiter_api/domain/entities/llst_station_fleet_card_entity.dart';
import 'package:jupiter_api/domain/entities/llst_station_fleet_operation_entity.dart';
import 'package:jupiter_api/domain/usecase/user_management_usecase.dart';
import 'package:jupiter/src/utilities.dart';

part 'fleet_state.dart';

class FleetCubit extends Cubit<FleetState> {
  @FactoryMethod()
  final UserManagementUseCase _useCase;
  FleetCubit(this._useCase) : super(FleetInitial());

  void fetchListFleetCard() async {
    emit(FleetLoading());
    Utilities.requestAccessToken(_useCase, (
        {required accessToken, required deviceCode, required username}) async {
      final result =
          await _useCase.listFleetCard(accessToken, ConstValue.orgCode);
      result.fold(
        (failure) {
          emit(FleetCardListLoadingFailure(failure.message));
        },
        (data) {
          emit(FleetCardListLoadingSuccess(data));
        },
      );
    }, 'GetListFleetCard');
  }

  void fetchListFleetOperation() async {
    emit(FleetLoading());
    Utilities.requestAccessToken(_useCase, (
        {required accessToken, required deviceCode, required username}) async {
      final result =
          await _useCase.listFleetOperation(accessToken, ConstValue.orgCode);
      result.fold(
        (failure) {
          emit(FleetOperationListLoadingFailure(failure.message));
        },
        (data) {
          emit(FleetOperationListLoadingSuccess(data));
        },
      );
    }, 'GetListFleetOperation');
  }

  void fetchFleetCardDetail({
    required int fleetNo,
    required String fleetCardNo,
  }) async {
    emit(FleetLoading());
    Utilities.requestAccessToken(_useCase, (
        {required accessToken, required deviceCode, required username}) async {
      final result = await _useCase.fleetCardInfo(
          accessToken,
          FleetDetailCardForm(fleetNo: fleetNo, fleetCardNo: fleetCardNo),
          ConstValue.orgCode);
      result.fold(
        (failure) {
          emit(FleetCardDetailFailure(failure.message));
        },
        (data) {
          emit(FleetCardDetailSuccess(data));
        },
      );
    }, 'FleetCardDetail');
  }

  void fetchFleetOperationDetail({required int fleetNo}) async {
    emit(FleetLoading());
    Utilities.requestAccessToken(_useCase, (
        {required accessToken, required deviceCode, required username}) async {
      final result = await _useCase.fleetOperationInfo(
          accessToken, FleetNoForm(fleetNo: fleetNo), ConstValue.orgCode);
      result.fold(
        (failure) {
          emit(FleetOperationDetailFailure(failure.message));
        },
        (data) {
          emit(FleetOperationDetailSuccess(data));
        },
      );
    }, 'FleetOperationDetail');
  }

  void fetchFleetCardStation({required int fleetNo}) async {
    emit(FleetTabLoading());
    Utilities.requestAccessToken(_useCase, (
        {required accessToken, required deviceCode, required username}) async {
      final result = await _useCase.fleetCardStation(
          accessToken, FleetNoForm(fleetNo: fleetNo), ConstValue.orgCode);
      result.fold(
        (failure) {
          emit(FleetCardStationFailure(failure.message));
        },
        (data) {
          emit(FleetCardStationSuccess(data));
        },
      );
    }, 'FleetCardStation');
  }

  void fetchFleetOperationStation({required int fleetNo}) async {
    emit(FleetTabLoading());
    Utilities.requestAccessToken(_useCase, (
        {required accessToken, required deviceCode, required username}) async {
      final result = await _useCase.fleetOperationStation(
          accessToken, FleetNoForm(fleetNo: fleetNo), ConstValue.orgCode);
      result.fold(
        (failure) {
          emit(FleetOperationStationFailure(failure.message));
        },
        (data) {
          emit(FleetOperationStationSuccess(data));
        },
      );
    }, 'FleetOperationStation');
  }

  void fetchCheckStatusFleetCard(
      {required int fleetNo, required String refCode}) async {
    emit(FleetCheckStatusLoading());
    Utilities.requestAccessToken(_useCase, (
        {required accessToken, required deviceCode, required username}) async {
      final result = await _useCase.checkStatusFleetCard(
          accessToken,
          CheckStatusFleetForm(
            deviceCode: deviceCode,
            username: username,
            fleetNo: fleetNo,
            fleetType: FleetType.CARD,
            refCode: refCode,
            orgCode: ConstValue.orgCode,
          ));

      result.fold(
        (failure) {
          emit(FleetCheckStatusFailure(failure.message));
        },
        (data) async {
          emit(FleetCheckStatusSuccess(data));
        },
      );
    }, 'FetchCheckStatusFleetCard');
  }

  void fetchGetHistoryFleetCardList(
      {required int fleetNo, required String refCode}) async {
    emit(FleetTabLoading());
    Utilities.requestAccessToken(_useCase, (
        {required accessToken, required deviceCode, required username}) async {
      final result = await _useCase.getHistoryFleetCardList(
        accessToken,
        ConstValue.orgCode,
        HistoryFleetCardForm(fleetNo: fleetNo, refCode: refCode),
      );

      result.fold(
        (failure) {
          emit(FleetHistoryListFailure(failure.message));
        },
        (data) async {
          emit(FleetHistoryListSuccess(data));
        },
      );
    }, 'FetchGetHistoryFleetCardList');
  }

  void fetchGetHistoryFleetOperationList({
    required int fleetNo,
  }) async {
    emit(FleetTabLoading());
    Utilities.requestAccessToken(_useCase, (
        {required accessToken, required deviceCode, required username}) async {
      final result = await _useCase.getHistoryFleetOperationList(
          accessToken, fleetNo, ConstValue.orgCode);

      result.fold(
        (failure) {
          emit(FleetHistoryListFailure(failure.message));
        },
        (data) async {
          emit(FleetHistoryListSuccess(data));
        },
      );
    }, 'fetchGetHistoryFleetOperationList');
  }

  void verifyFleetCard(
      {required String cardNo, required String expiredDate}) async {
    emit(FleetVerifyLoading());

    Utilities.requestAccessToken(_useCase, (
        {required accessToken, required deviceCode, required username}) async {
      final result = await _useCase.verifyFleetCard(
        accessToken,
        VerifyFleetCardForm(cardNo: cardNo, expiredDate: expiredDate),
        ConstValue.orgCode,
      );

      result.fold(
        (failure) {
          emit(FleetVerifyFailure(failure.message));
        },
        (data) {
          emit(FleetVerifySuccess());
        },
      );
    }, "VerifyFleetCard");
  }

  void fetchFleetCardCharger(
      {required int fleetNo, required String stationId}) async {
    emit(FleetChargerLoading());
    Utilities.requestAccessToken(_useCase, (
        {required accessToken, required deviceCode, required username}) async {
      final result = await _useCase.fleetCardCharger(
          accessToken,
          FleetChargerForm(fleetNo: fleetNo, stationId: stationId),
          ConstValue.orgCode);
      result.fold(
        (failure) {
          emit(FleetCardChargerFailure(failure.message));
        },
        (data) {
          emit(FleetCardChargerSuccess(data));
        },
      );
    }, 'FleetCardCharger');
  }

  void fetchFleetOperationCharger(
      {required int fleetNo, required String stationId}) async {
    emit(FleetChargerLoading());
    Utilities.requestAccessToken(_useCase, (
        {required accessToken, required deviceCode, required username}) async {
      final result = await _useCase.fleetOperationCharger(
          accessToken,
          FleetChargerForm(fleetNo: fleetNo, stationId: stationId),
          ConstValue.orgCode);
      result.fold(
        (failure) {
          emit(FleetOperationChargerFailure(failure.message));
        },
        (data) {
          emit(FleetOperationChargerSuccess(data));
        },
      );
    }, 'FleetOperationCharger');
  }

  void resetStateFleet() {
    emit(FleetInitial());
  }
}
