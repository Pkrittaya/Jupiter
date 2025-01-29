import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:jupiter_api/data/data_models/request/active_notification_form.dart';
import 'package:jupiter_api/data/data_models/request/delete_notification_form.dart';
import 'package:jupiter_api/data/data_models/request/object_empty_form.dart';
import 'package:jupiter_api/domain/entities/list_notification_entity.dart';
import 'package:jupiter_api/domain/entities/notification_news.dart';
import 'package:jupiter_api/domain/usecase/user_management_usecase.dart';
import 'package:jupiter/src/utilities.dart';

part 'notification_state.dart';

class NotiCubit extends Cubit<NotiState> {
  @FactoryMethod()
  final UserManagementUseCase _useCase;
  NotiCubit(this._useCase) : super(NotiInitial());

  void loadNotificationList() async {
    emit(NotiLoading());
    Utilities.requestAccessToken(_useCase, (
        {required accessToken, required deviceCode, required username}) async {
      final result = await _useCase.listNotification(accessToken);
      result.fold(
        (failure) {
          debugPrint("NotificationList Failure");
          emit(NotiFailure(failure.message));
        },
        (data) {
          debugPrint("NotificationList Cubit Success");
          emit(NotiSuccess(data));
        },
      );
    }, "NotificationList");
  }

  void loadNotificationNewsList() async {
    emit(NotiLoading());
    Utilities.requestAccessToken(_useCase, (
        {required accessToken, required deviceCode, required username}) async {
      final result =
          await _useCase.listNotificationNews(accessToken, ObjectEmptyForm());
      result.fold(
        (failure) {
          debugPrint("NotificationNewsList Failure");
          emit(NotiNewsFailure(failure.message));
        },
        (data) {
          debugPrint("NotificationNewsList Cubit Success");
          emit(NotiNewsSuccess(data));
        },
      );
    }, "NotificationNewsList");
  }

  void deleteNotification({
    required String notificationOperator,
    required int notificationIndex,
    required String notificationType,
  }) async {
    emit(DeleteNotiLoading());
    Utilities.requestAccessToken(_useCase, (
        {required accessToken, required deviceCode, required username}) async {
      final result = await _useCase.deleteNotification(
          accessToken,
          DeleteNotificationForm(
              notificationOperator: notificationOperator,
              notificationIndex: notificationIndex,
              notificationType: notificationType));
      result.fold(
        (failure) {
          debugPrint("deleteNotification Failure");
          emit(DeleteNotiFailure(failure.message));
        },
        (data) {
          debugPrint("deleteNotification Cubit Success");
          emit(DeleteNotiSuccess());
        },
      );
    }, "DeleteNotification");
  }

  void activeNotification({
    required int notificationIndex,
    required String notificationType,
  }) async {
    emit(NotiLoading());
    Utilities.requestAccessToken(_useCase, (
        {required accessToken, required deviceCode, required username}) async {
      final result = await _useCase.activeNotification(
          accessToken,
          ActiveNotificationForm(
              notificationIndex: notificationIndex,
              notificationType: notificationType));
      result.fold(
        (failure) {
          debugPrint("activeNotification Failure");
          emit(ActiveNotiFailure(failure.message));
        },
        (data) {
          debugPrint("activeNotification Cubit Success");
          emit(ActiveNotiSuccess());
        },
      );
    }, "ActiveNotification");
  }

  void resetStateInitial() {
    emit(NotiInitial());
  }
}
