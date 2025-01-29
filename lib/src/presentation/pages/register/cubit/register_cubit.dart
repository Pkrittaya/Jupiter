import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:jupiter/src/constant_value.dart';
import 'package:jupiter/src/injection.dart';
import 'package:jupiter/src/jupiter_prefs_and_app_data.dart';
import 'package:jupiter_api/data/data_models/request/add_ev_car_form.dart';
import 'package:jupiter_api/data/data_models/request/signin_account_form.dart';
import 'package:jupiter_api/data/data_models/request/signup_account_form.dart';
import 'package:jupiter_api/data/data_models/request/verify_account_form.dart';
import 'package:jupiter_api/domain/entities/car_master_entity.dart';
import 'package:jupiter_api/domain/entities/sign_up_entity.dart';
import 'package:jupiter_api/domain/entities/term_and_condition_entity.dart';
import 'package:jupiter_api/domain/entities/verify_account_entity.dart';
import 'package:jupiter_api/domain/usecase/user_management_usecase.dart';
import 'package:jupiter/src/utilities.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  @FactoryMethod()
  final UserManagementUseCase _useCase;
  RegisterCubit(this._useCase) : super(RegisterInitial());
  JupiterPrefsAndAppData jupiterPrefsAndAppData = getIt();
  void sendVerifyAccount({
    required String username,
    required String password,
    required String firstname,
    required String lastname,
    required String mobile,
    required String gender,
    required DateTime birthdate,
  }) async {
    emit(RegisterLoading());
    // await Future.delayed(const Duration(seconds: 5));
    bool? language = jupiterPrefsAndAppData.language;
    final verifyAccountForm = VerifyAccountForm(
        username: username,
        password: password,
        name: firstname,
        lastname: lastname,
        telphonenumber: mobile,
        gender: gender,
        dateofbirth: birthdate,
        orgCode: ConstValue.orgCode,
        language: language ?? false ? 'EN' : 'TH');

    final result = await _useCase.verifyAccount(verifyAccountForm);

    result.fold(
      (failure) {
        emit(VerifyAccountFailure(failure.message));
      },
      (data) {
        debugPrint("VeriAccount ${verifyAccountForm.telphonenumber}");
        emit(VerifyAccountSuccess(verifyAccountForm, data));
      },
    );
  }

  void getTermAndCondition() async {
    emit(RegisterLoading());
    final result = await _useCase.termAndCondition(ConstValue.orgCode);
    result.fold(
      (failure) {
        emit(TermAndConditionFailure(failure.message));
      },
      (data) {
        emit(TermAndConditionSuccess(data));
      },
    );
  }

  void signUp(SignupAccountForm? signupAccountForm) async {
    emit(RegisterLoading());
    final result = await _useCase.signUp(signupAccountForm!);
    result.fold(
      (failure) {
        emit(SignUpFailure(failure.message));
      },
      (data) {
        emit(SignUpSuccess(data));
      },
    );
  }

  void fetchLoadCarMaster() async {
    emit(GetCarMasterLoading());
    Utilities.requestAccessToken(_useCase, (
        {required accessToken, required deviceCode, required username}) async {
      final result = await _useCase.carMaster(accessToken, ConstValue.orgCode);
      result.fold(
        (failure) {
          emit(GetCarMasterFailure(failure.message));
        },
        (data) {
          emit(GetCarMasterSuccess(data));
        },
      );
    }, "GetCarMasterFromRegister");
  }

  void fetchAddCar({
    // required String brand,
    // required String model,
    required int vehicleNo,
    required String licensePlate,
    required String province,
    required bool defalut,
  }) async {
    emit(AddCarMasterLoading());

    Utilities.requestAccessToken(_useCase, (
        {required accessToken, required deviceCode, required username}) async {
      final result = await _useCase.addCar(
        accessToken,
        AddEvCarForm(
          username: username,
          vehicleNo: vehicleNo,
          licensePlate: licensePlate,
          province: province,
          defalut: defalut,
          orgCode: ConstValue.orgCode,
        ),
      );
      result.fold(
        (failure) {
          emit(AddCarMasterFailure(failure.message));
        },
        (data) {
          emit(AddCarMasterSuccess());
        },
      );
    }, "AddCarFromRegister");
  }

  void fetchLogin(SignInAccountForm signInAccountForm) async {
    emit(LoginLoading());
    final result = await _useCase.signIn(signInAccountForm);

    result.fold(
      (failure) {
        emit(LoginFailure(failure.message));
      },
      (data) {
        emit(LoginSuccess());
        jupiterPrefsAndAppData.saveRefreshToken(data.token.refreshToken);
        jupiterPrefsAndAppData
            .saveUsername(signInAccountForm.username.toLowerCase());
      },
    );
  }

  void registerFormReady() {
    emit(RegisterLoading());
    emit(TermAndConditionAccepted());
  }

  void resetStatetoInital() {
    emit(RegisterInitial());
  }
}
