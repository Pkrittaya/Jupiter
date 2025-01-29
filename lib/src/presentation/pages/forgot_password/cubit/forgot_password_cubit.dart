import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:jupiter/src/injection.dart';
import 'package:jupiter/src/jupiter_prefs_and_app_data.dart';
import 'package:jupiter_api/data/data_models/request/send_email_forgot_password_form.dart';
import 'package:jupiter_api/data/data_models/request/verify_email_form.dart';
import 'package:jupiter_api/domain/usecase/user_management_usecase.dart';

import '../../../../constant_value.dart';

part 'forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  @FactoryMethod()
  final UserManagementUseCase _useCase;
  ForgotPasswordCubit(this._useCase) : super(ForgotPasswordInitial());
  JupiterPrefsAndAppData jupiterPrefsAndAppData = getIt();

  void fetchSendEmailToResetPassword(String email) async {
    emit(ForgotPasswordSendEmailLoading());

    bool? language = jupiterPrefsAndAppData.language;
    final result =
        await _useCase.sendEmailForgotPassword(SendEmailForgotPasswordForm(
      email: email,
      language: language ?? false ? 'EN' : 'TH',
      orgCode: ConstValue.orgCode,
    ));
    result.fold(
      (failure) {
        emit(ForgotPasswordSendEmailFailure(failure.message));
      },
      (data) {
        emit(ForgotPasswordSendEmailSuccess());
      },
    );
  }

  void fetchSendEmailToVerify(String email) async {
    emit(ForgotPasswordSendEmailLoading());
    bool? language = jupiterPrefsAndAppData.language;
    final result = await _useCase.verifyEmail(VerifyEmailForm(
      username: email,
      orgCode: ConstValue.orgCode,
      language: language ?? false ? 'EN' : 'TH',
    ));
    result.fold(
      (failure) {
        emit(VerifySendEmailFailure(failure.message));
      },
      (data) {
        emit(VerifySendEmailSuccess());
      },
    );
  }
}
