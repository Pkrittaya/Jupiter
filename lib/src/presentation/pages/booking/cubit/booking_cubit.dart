import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:jupiter_api/data/data_models/request/create_reserve_form.dart';
import 'package:jupiter_api/data/data_models/request/get_list_reserve_form.dart';
import 'package:jupiter_api/data/data_models/request/username_and_orgcode_form.dart';
import 'package:jupiter_api/domain/entities/credit_card_entity.dart';
import 'package:jupiter_api/domain/entities/get_list_reserve_entity.dart';
import 'package:jupiter_api/domain/entities/reserve_receipt_entity.dart';
import 'package:jupiter_api/domain/usecase/user_management_usecase.dart';
import 'package:jupiter/src/utilities.dart';

import '../../../../constant_value.dart';

part 'booking_state.dart';

class BookingCubit extends Cubit<BookingState> {
  BookingCubit(this._useCase) : super(BookingInitial());

  @FactoryMethod()
  final UserManagementUseCase _useCase;

  void fetchListReserveFromDate({
    required String stationId,
    required String chargerId,
    required String connectorId,
    required String connectorQrCode,
    required String date,
  }) async {
    emit(BookingListLoading());
    Utilities.requestAccessToken(_useCase, (
        {required accessToken, required deviceCode, required username}) async {
      final result = await _useCase.listReserve(
          accessToken,
          GetListReserveForm(
            stationId: stationId,
            chargerId: chargerId,
            connectorId: connectorId,
            qrCodeConnector: connectorQrCode,
            date: date,
            orgCode: ConstValue.orgCode,
          ),
          ConstValue.orgCode);
      result.fold(
        (failure) {
          emit(BookingListFailure(failure.message));
        },
        (data) {
          emit(BookingListSuccess(data));
        },
      );
    }, 'GetListReserveFromDate');
  }

  void fetchCreateReserve({
    required CreateReserveForm createReserveForm,
  }) async {
    emit(BookingCreateReserveLoading());
    Utilities.requestAccessToken(_useCase, (
        {required accessToken, required deviceCode, required username}) async {
      final result = await _useCase.createReserve(
          accessToken, createReserveForm, ConstValue.orgCode);
      result.fold(
        (failure) {
          emit(BookingCreateReserveFailure(failure.message));
        },
        (data) {
          emit(BookingCreateReserveSuccess(data));
        },
      );
    }, 'CreateReserve');
  }

  void fetchLoadCreditCardList() async {
    emit(BookingGetPaymentLoading());
    Utilities.requestAccessToken(_useCase, (
        {required accessToken, required deviceCode, required username}) async {
      final result = await _useCase.creditCardList(
          accessToken,
          UsernameAndOrgCodeForm(
              username: username, orgCode: ConstValue.orgCode));
      result.fold(
        (failure) {
          emit(BookingGetPaymentFailure(failure.message));
        },
        (data) {
          emit(BookingGetPaymentSuccess(data));
        },
      );
    }, "CreditCardList");
  }

  void resetInitialBookingState() {
    emit(BookingInitial());
  }
}
