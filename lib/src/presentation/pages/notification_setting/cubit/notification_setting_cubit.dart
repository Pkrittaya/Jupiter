import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:jupiter_api/data/data_models/request/object_empty_form.dart';
import 'package:jupiter_api/data/data_models/request/set_notification_setting_form.dart';
import 'package:jupiter_api/domain/entities/notification_setting_entity.dart';
import 'package:jupiter_api/domain/usecase/user_management_usecase.dart';
import 'package:jupiter/src/utilities.dart';

part 'notification_setting_state.dart';

class NotiSettingCubit extends Cubit<NotiSettingState> {
  @FactoryMethod()
  final UserManagementUseCase _useCase;
  NotiSettingCubit(this._useCase) : super(NotiSettingInitial());

  void setNotificationSetting({
    required bool notificationSystem,
    required bool notificationNews,
  }) async {
    emit(NotiSettingLoading());
    Utilities.requestAccessToken(_useCase, (
        {required accessToken, required deviceCode, required username}) async {
      final result = await _useCase.setNotificationSetting(
          accessToken,
          SetNotificationSettingForm(
              notificationSystem: notificationSystem,
              notificationNews: notificationNews));
      result.fold(
        (failure) {
          debugPrint("SetNotificationSetting Failure");
          emit(SetNotiSettingFailure(failure.message));
        },
        (data) {
          debugPrint("SetNotificationSetting Cubit Success");
          emit(SetNotiSettingSuccess());
        },
      );
    }, "SetNotificationSetting");
  }

  void getNotificationSetting() async {
    emit(NotiSettingLoading());
    Utilities.requestAccessToken(_useCase, (
        {required accessToken, required deviceCode, required username}) async {
      final result =
          await _useCase.getNotificationSetting(accessToken, ObjectEmptyForm());
      result.fold(
        (failure) {
          debugPrint("GetNotificationSetting Failure");
          emit(GetNotiSettingFailure(failure.message));
        },
        (data) {
          debugPrint("GetNotificationSetting Cubit Success");
          emit(GetNotiSettingSuccess(data));
        },
      );
    }, "GetNotificationSetting");
  }

  void resetStateInitial() {
    emit(NotiSettingInitial());
  }
}
