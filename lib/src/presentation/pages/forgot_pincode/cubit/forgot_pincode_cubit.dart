import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:jupiter/src/injection.dart';
import 'package:jupiter/src/jupiter_prefs_and_app_data.dart';
import 'package:jupiter_api/data/data_models/request/request_otp_forgot_pin_form.dart';
import 'package:jupiter_api/data/data_models/request/verify_otp_forgot_pin_form.dart';
import 'package:jupiter_api/domain/entities/request_otp_forgot_pin_entity.dart';
import 'package:jupiter_api/domain/usecase/user_management_usecase.dart';
import 'package:jupiter/src/utilities.dart';

import '../../../../constant_value.dart';

part 'forgot_pincode_state.dart';

class ForgotPincodeCubit extends Cubit<ForgotPincodeState> {
  @FactoryMethod()
  final UserManagementUseCase _useCase;
  ForgotPincodeCubit(this._useCase) : super(ForgotPincodeInitial());
  JupiterPrefsAndAppData jupiterPrefsAndAppData = getIt();
  void fetchVerifyOtpForgotPinCode(
      {required String telphoneNumber,
      required String otpCode,
      required String otpRefNumber}) async {
    emit(SendOtpVerifyToResetPinLoading());
    bool? language = jupiterPrefsAndAppData.language;
    Utilities.requestAccessToken(_useCase, (
        {required accessToken, required deviceCode, required username}) async {
      final result = await _useCase.verifyOtpForgotPin(
        VerifyOtpForgotPinForm(
          username: username,
          telphoneNumber: telphoneNumber,
          otpCode: otpCode,
          otpRefNumber: otpRefNumber,
          orgCode: ConstValue.orgCode,
          language: language ?? false ? 'EN' : 'TH',
        ),
      );
      result.fold(
        (failure) {
          debugPrint("fetchVerifyOtpForgotPinCode Failure");
          emit(SendOtpVerifyToResetPinFailure(failure.message));
        },
        (data) {
          debugPrint("fetchVerifyOtpForgotPinCode Cubit Success");
          emit(SendOtpVerifyToResetPinSuccess());
        },
      );
    }, "fetchVerifyOtpForgotPinCode");
  }

  void fetchRequestOtpForgotPinCode(String phoneNumber) async {
    emit(RequestOtpToResetPinLoading());
    bool? language = jupiterPrefsAndAppData.language;
    Utilities.requestAccessToken(_useCase, (
        {required accessToken, required deviceCode, required username}) async {
      final result = await _useCase.requestOtpForgotPin(RequestOtpForgotPinForm(
        telphoneNumber: phoneNumber,
        username: jupiterPrefsAndAppData.username ?? '',
        orgCode: ConstValue.orgCode,
        language: language ?? false ? 'EN' : 'TH',
      ));
      result.fold(
        (failure) {
          debugPrint("fetchRequestOtpForgotPinCode Failure");
          emit(RequestOtpToResetPinFailure(failure.message));
        },
        (data) {
          debugPrint("fetchRequestOtpForgotPinCode Cubit Success");
          emit(RequestOtpToResetPinSuccess(data));
        },
      );
    }, "fetchRequestOtpForgotPinCode");
  }

  void resetStateInitialForgotPin() {
    emit(ForgotPincodeInitial());
  }
}
