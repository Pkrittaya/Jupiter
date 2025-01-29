import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:jupiter_api/data/data_models/request/delete_card_payment_form.dart';
import 'package:jupiter_api/data/data_models/request/set_default_card_form.dart';
import 'package:jupiter_api/domain/entities/credit_card_entity.dart';
import 'package:jupiter_api/domain/usecase/user_management_usecase.dart';
import 'package:jupiter/src/utilities.dart';

import '../../../../constant_value.dart';

part 'payment_detail_state.dart';

class PaymentDetailCubit extends Cubit<PaymentDetailState> {
  @FactoryMethod()
  final UserManagementUseCase _useCase;
  PaymentDetailCubit(this._useCase) : super(PaymentDetailInitial());

  void fetchSetDefaultCard(
      {required String cardHashing, required bool defalut}) async {
    emit(PaymentSetDefaultCardLoading());
    Utilities.requestAccessToken(_useCase, (
        {required accessToken, required deviceCode, required username}) async {
      final result = await _useCase.setDefaultCard(
        accessToken,
        SetDefaultCardForm(
          username: username,
          cardHashing: cardHashing,
          defalut: defalut,
          orgCode: ConstValue.orgCode,
        ),
      );
      result.fold(
        (failure) {
          debugPrint("fetchSetDefaultCard Failure");
          emit(PaymentSetDefaultCardFailure(failure.message));
        },
        (data) {
          debugPrint("fetchSetDefaultCard Cubit Success");
          emit(PaymentSetDefaultCardSuccess());
        },
      );
    }, "SetDefaultCard");
  }

  void fetchDeleteCreditCard(CreditCardEntity creditCard) async {
    emit(PaymentCreditCardDeleteStart());
    Utilities.requestAccessToken(_useCase, (
        {required accessToken, required deviceCode, required username}) async {
      final result = await _useCase.deletePaymentCard(
        accessToken,
        DeleteCardPaymentForm(
          username: username,
          cardHashing: creditCard.cardHashing,
          orgCode: ConstValue.orgCode,
        ),
      );
      result.fold(
        (failure) {
          debugPrint("DeleteCreditCard Failure");
          emit(PaymentCreditCardDeleteFailure(failure.message));
        },
        (data) {
          debugPrint("DeleteCreditCard Cubit Success");
          emit(PaymentCreditCardDeleteSuccess());
        },
      );
    }, "DeleteCreditCard");
  }

  void resetStateToInitial() async {
    emit(PaymentDetailInitial());
  }
}
