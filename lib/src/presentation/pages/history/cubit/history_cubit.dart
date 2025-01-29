import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:jupiter/src/injection.dart';
import 'package:jupiter/src/jupiter_prefs_and_app_data.dart';
import 'package:jupiter_api/data/data_models/request/history_booking_list_form.dart';

import 'package:jupiter_api/data/data_models/request/history_list_form.dart';
import 'package:jupiter_api/domain/entities/history_booking_list_entity.dart';

import 'package:jupiter_api/domain/entities/history_entity.dart';
import 'package:jupiter_api/domain/usecase/user_management_usecase.dart';

import '../../../../constant_value.dart';
import '../../../../utilities.dart';

part 'history_state.dart';

class HistoryCubit extends Cubit<HistoryState> {
  @FactoryMethod()
  final UserManagementUseCase _useCase;
  HistoryCubit(this._useCase) : super(HistoryInitial());
  JupiterPrefsAndAppData jupiterPrefsAndAppData = getIt();
  void loadHistoryList({
    String start_date = '',
    String end_date = '',
    String station_id = 'ALL',
  }) async {
    emit(HistoryLoadingStart());
    Utilities.requestAccessToken(_useCase, (
        {required accessToken, required deviceCode, required username}) async {
      final result = await _useCase.getHistoryList(
          accessToken,
          HistoryListForm(
            username: username,
            startDate: start_date,
            endDate: end_date,
            stationId: station_id,
            orgCode: ConstValue.orgCode,
          ));

      result.fold(
        (failure) {
          debugPrint("loadCreditCard Failure");
          emit(HistoryLoadingFailure());
        },
        (data) {
          debugPrint("loadCreditCard Cubit Success");

          emit(HistoryLoadingSuccess(data));
        },
      );
    }, "HistoryList");
  }

  void fetchHistoryBooking() async {
    emit(HistoryBookingLoadingStart());
    Utilities.requestAccessToken(_useCase, (
        {required accessToken, required deviceCode, required username}) async {
      final result = await _useCase.getHistoryBookingList(
        accessToken,
        HistoryBookingListForm(
            username: jupiterPrefsAndAppData.username ?? '',
            orgCode: ConstValue.orgCode),
      );
      result.fold(
        (failure) {
          emit(HistoryBookingLoadingFailure(failure.message));
        },
        (data) {
          emit(HistoryBookingLoadingSuccess(data));
        },
      );
    }, "HistoryBookingList");
  }
}
