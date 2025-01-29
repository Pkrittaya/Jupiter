part of 'notification_setting_cubit.dart';

abstract class NotiSettingState extends Equatable {
  NotiSettingState({
    this.notificationSetting,
    this.message,
  });
  final NotificationSettingEntity? notificationSetting;
  final String? message;
  @override
  List<Object> get props => [];
}

class NotiSettingInitial extends NotiSettingState {}

class NotiSettingLoading extends NotiSettingState {}

class SetNotiSettingSuccess extends NotiSettingState {}

class SetNotiSettingFailure extends NotiSettingState {
  SetNotiSettingFailure(String message) : super(message: message);
}

class GetNotiSettingSuccess extends NotiSettingState {
  GetNotiSettingSuccess(NotificationSettingEntity notificationSetting)
      : super(notificationSetting: notificationSetting);
}

class GetNotiSettingFailure extends NotiSettingState {
  GetNotiSettingFailure(String message) : super(message: message);
}
