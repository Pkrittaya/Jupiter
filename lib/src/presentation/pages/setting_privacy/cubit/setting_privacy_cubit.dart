import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:jupiter_api/data/data_models/request/set_language_form.dart';
import 'package:jupiter_api/domain/usecase/user_management_usecase.dart';
import 'package:jupiter/src/utilities.dart';

part 'setting_privacy_state.dart';

class SettingPrivacyCubit extends Cubit<SettingPrivacyState> {
  @FactoryMethod()
  final UserManagementUseCase _useCase;
  SettingPrivacyCubit(this._useCase) : super(SettingPrivacyInitial());

  void setLanguage(String language) async {
    emit(SettingPrivacyLoading());
    Utilities.requestAccessToken(_useCase, (
        {required accessToken, required deviceCode, required username}) async {
      final result = await _useCase.setLanguage(accessToken,
          SetLanguageForm(deviceCode: deviceCode, language: language));
      result.fold(
        (failure) {
          emit(SettingPrivacyFailure(failure.message));
        },
        (data) {
          emit(SettingPrivacySuccess());
        },
      );
    }, "SetLanguageFromSettingPrivacy");
  }

  void resetStatetoInital() {
    emit(SettingPrivacyInitial());
  }
}
