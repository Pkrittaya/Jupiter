import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:jupiter/src/injection.dart';
import 'package:jupiter/src/jupiter_prefs_and_app_data.dart';
import 'package:jupiter_api/data/data_models/request/signin_account_form.dart';
import 'package:jupiter_api/domain/entities/sign_in_entity.dart';
import 'package:jupiter_api/domain/usecase/user_management_usecase.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  @FactoryMethod()
  final UserManagementUseCase _useCase;
  LoginCubit(this._useCase) : super(LoginInitial());
  JupiterPrefsAndAppData jupiterPrefsAndAppData = getIt();
  void signIn(SignInAccountForm signInAccountForm) async {
    emit(LoginLoading());
    final result = await _useCase.signIn(signInAccountForm);

    result.fold(
      (failure) {
        debugPrint("loginFailure");
        emit(LoginFailure(failure.message));
      },
      (data) {
        debugPrint("loginSuccess");
        emit(LoginSuccess(data));
        jupiterPrefsAndAppData.saveRefreshToken(data.token.refreshToken);
        jupiterPrefsAndAppData
            .saveUsername(signInAccountForm.username.toLowerCase());
      },
    );
  }

  void resetState() {
    emit(LoginInitial());
  }
}
