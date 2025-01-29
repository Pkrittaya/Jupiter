import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:jupiter_api/data/data_models/request/object_empty_form.dart';
import 'package:jupiter_api/domain/entities/get_count_all_notification_entity.dart';
import 'package:jupiter_api/domain/usecase/user_management_usecase.dart';
import 'package:jupiter/src/utilities.dart';

part 'notification_home_page_state.dart';

class NotificationHomePageCubit extends Cubit<NotificationHomePageState> {
  @FactoryMethod()
  final UserManagementUseCase _useCase;
  NotificationHomePageCubit(this._useCase)
      : super(NotificationHomePageInitial());

  void loadCountAllNotificaton() async {
    emit(NotificationHomePageLoading());
    Utilities.requestAccessToken(_useCase, (
        {required accessToken, required deviceCode, required username}) async {
      final result = await _useCase.getCountAllNotification(
          accessToken, ObjectEmptyForm());
      result.fold(
        (failure) {
          debugPrint('NotificationList Failure');
          emit(NotificationHomePageFailure(failure.message));
        },
        (data) {
          debugPrint('NotificationList Cubit Success');
          emit(NotificationHomePageSuccess(data));
        },
      );
    }, 'CountAllNotificaton');
  }
}
