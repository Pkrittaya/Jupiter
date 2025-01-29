import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:jupiter_api/data/data_models/request/history_booking_detail_form.dart';
import 'package:jupiter_api/data/data_models/request/history_detail_form.dart';
import 'package:jupiter_api/domain/entities/history_booking_detail_entity.dart';
import 'package:jupiter_api/domain/entities/history_detail_entity.dart';
import 'package:jupiter_api/domain/usecase/user_management_usecase.dart';

import '../../../../constant_value.dart';
import '../../../../utilities.dart';

part 'history_detail_state.dart';

class HistoryDetailCubit extends Cubit<HistoryDetailState> {
  @FactoryMethod()
  final UserManagementUseCase _useCase;
  HistoryDetailCubit(this._useCase) : super(HistoryDetailInitial());

  void loadHistoryDetail({required String transaction_id}) async {
    emit(HistoryDetailLoadingStart());
    Utilities.requestAccessToken(_useCase, (
        {required accessToken, required deviceCode, required username}) async {
      final result = await _useCase.getHistoryDetail(
        accessToken,
        HistoryDetailForm(
          username: username,
          transaction: transaction_id,
          orgCode: ConstValue.orgCode,
        ),
      );

      result.fold(
        (failure) {
          debugPrint('loadHistoryDetail Failure');
          emit(HistoryDetailLoadingFailure());
        },
        (data) {
          debugPrint('loadHistoryDetail Cubit Success');

          emit(HistoryDetailLoadingSuccess(data));
        },
      );
    }, 'HistoryDetail');
  }

  void fetchLoadHistoryBookingDetail({required int reserveOn}) async {
    emit(HistoryBookingDetailLoadingStart());
    Utilities.requestAccessToken(_useCase, (
        {required accessToken, required deviceCode, required username}) async {
      final result = await _useCase.getHistoryBookingDetail(
        accessToken,
        HistoryBookingDetailForm(
          username: username,
          reserveOn: reserveOn,
          orgCode: ConstValue.orgCode,
        ),
      );
      result.fold(
        (failure) {
          debugPrint('HistoryBookingDetail Failure');
          emit(HistoryBookingDetailLoadingFailure());
        },
        (data) {
          debugPrint('HistoryBookingDetail Cubit Success');
          emit(HistoryBookingDetailLoadingSuccess(data));
        },
      );
    }, 'HistoryBookingDetail');
  }
}
