import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:jupiter/src/constant_value.dart';
import 'package:jupiter_api/data/data_models/request/verify_card_form.dart';
import 'package:jupiter_api/domain/entities/verify_card_entity.dart';
import 'package:jupiter_api/domain/usecase/user_management_usecase.dart';

import '../../../../utilities.dart';

part 'payment_k_bank_state.dart';

class PaymentKBankCubit extends Cubit<PaymentKBankState> {
  @FactoryMethod()
  final UserManagementUseCase _useCase;
  PaymentKBankCubit(this._useCase) : super(PaymentKBankInitial());

  void verifyCard(String token) async {
    emit(PaymentKBankVerifyCardLoading());
    Utilities.requestAccessToken(_useCase, (
        {required accessToken, required deviceCode, required username}) async {
      final result = await _useCase.verifyCard(
          accessToken,
          VerifyCardForm(
              token: token, username: username, orgCode: ConstValue.orgCode));

      result.fold(
        (failure) {
          debugPrint("verifyCard Failure");
          emit(PaymentKBankVerifyCardLoadingFailure());
        },
        (data) {
          debugPrint("verifyCard Cubit Success");

          emit(PaymentKBankVerifyCardLoadingSuccess(data));
        },
      );
    }, "VerifyCard");
  }

  void resetState() {
    emit(PaymentKBankInitial());
  }
}
