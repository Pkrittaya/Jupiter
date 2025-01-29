import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:jupiter/src/injection.dart';
import 'package:jupiter/src/jupiter_prefs_and_app_data.dart';
import 'package:jupiter_api/data/data_models/request/change_password_form.dart';
import 'package:jupiter_api/data/data_models/request/request_otp_forgot_pin_form.dart';
import 'package:jupiter_api/data/data_models/request/username_and_orgcode_form.dart';
import 'package:jupiter_api/data/data_models/request/verify_otp_forgot_pin_form.dart';
import 'package:jupiter_api/domain/entities/profile_entity.dart';
import 'package:jupiter_api/domain/entities/request_otp_forgot_pin_entity.dart';
import 'package:jupiter_api/domain/usecase/user_management_usecase.dart';
import 'package:jupiter/src/utilities.dart';

import '../../../../constant_value.dart';

part 'update_password_state.dart';

class UpdatePasswordCubit extends Cubit<UpdatePasswordState> {
  final UserManagementUseCase _useCase;
  UpdatePasswordCubit(this._useCase) : super(UpdatePasswordInitial());
  JupiterPrefsAndAppData jupiterPrefsAndAppData = getIt();
  void fetchLoadProfile() async {
    emit(UpdatePasswordLoading());
    Utilities.requestAccessToken(_useCase, (
        {required accessToken, required deviceCode, required username}) async {
      final result = await _useCase.profile(
          accessToken,
          UsernameAndOrgCodeForm(
              username: username, orgCode: ConstValue.orgCode));
      result.fold(
        (failure) {
          emit(LoadProfileFailure(failure.message));
        },
        (data) {
          emit(LoadProfileSuccess(data));
        },
      );
    }, 'Profile');
  }

  void fetchVerifyOtpUpdatePassword(
      {required String telphoneNumber,
      required String otpCode,
      required String otpRefNumber}) async {
    emit(UpdatePasswordLoading());
    bool? language = jupiterPrefsAndAppData.language;
    Utilities.requestAccessToken(_useCase, (
        {required accessToken, required deviceCode, required username}) async {
      final result = await _useCase.verifyOtpForgotPin(VerifyOtpForgotPinForm(
          username: username,
          telphoneNumber: telphoneNumber,
          otpCode: otpCode,
          otpRefNumber: otpRefNumber,
          orgCode: ConstValue.orgCode,
          language: language ?? false ? 'EN' : 'TH'));
      result.fold(
        (failure) {
          emit(VerifyOtpFailure(failure.message));
        },
        (data) {
          emit(VerifyOtpSuccess());
        },
      );
    }, 'fetchVerifyOtpUpdatePassword');
  }

  void fetchRequestOtpUpdatePassword(String phoneNumber) async {
    emit(UpdatePasswordLoading());
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
          emit(RequestOtpFailure(failure.message));
        },
        (data) {
          emit(RequestOtpSuccess(data));
        },
      );
    }, 'fetchRequestOtpUpdatePassword');
  }

  void fetchUpdatePassword(String password, String newPassword) async {
    emit(UpdatePasswordLoading());
    Utilities.requestAccessToken(_useCase, (
        {required accessToken, required deviceCode, required username}) async {
      final result = await _useCase.changePassword(
        accessToken,
        ChangePasswordForm(
          token: accessToken,
          passwordCurrent: password,
          passwordNew: newPassword,
        ),
      );
      result.fold(
        (failure) {
          emit(UpdatePasswordFailure(failure.message));
        },
        (data) {
          emit(UpdatePasswordSuccess());
        },
      );
    }, 'fetchUpdatePassword');
  }

  void resetStateInitial() {
    emit(UpdatePasswordInitial());
  }
}
