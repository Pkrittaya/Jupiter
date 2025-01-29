import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:jupiter_api/data/data_models/request/username_and_orgcode_form.dart';
import 'package:jupiter_api/domain/entities/credit_card_entity.dart';
import 'package:jupiter_api/domain/usecase/user_management_usecase.dart';
import 'package:jupiter/src/utilities.dart';

import '../../../../constant_value.dart';

part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  @FactoryMethod()
  final UserManagementUseCase _useCase;
  PaymentCubit(this._useCase) : super(PaymentInitial());

  void loadCreditCardList() async {
    emit(PaymentCreditCardLoading());
    Utilities.requestAccessToken(_useCase, (
        {required accessToken, required deviceCode, required username}) async {
      final result = await _useCase.creditCardList(
          accessToken,
          UsernameAndOrgCodeForm(
              username: username, orgCode: ConstValue.orgCode));
      result.fold(
        (failure) {
          debugPrint("loadCreditCard Failure");
          emit(PaymentCreditCardLoadingFailure());
        },
        (data) {
          debugPrint("loadCreditCard Cubit Success");
          emit(PaymentCreditCardLoadingSuccess(data));
        },
      );
    }, "CreditCardList");
  }
}
