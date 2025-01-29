part of 'notification_home_page_cubit.dart';

abstract class NotificationHomePageState extends Equatable {
  const NotificationHomePageState({
    this.notificationList,
    this.message,
  });

  final CountAllNotificationEntity? notificationList;
  final String? message;

  @override
  List<Object> get props => [];
}

class NotificationHomePageInitial extends NotificationHomePageState {}

class NotificationHomePageLoading extends NotificationHomePageState {}

class NotificationHomePageSuccess extends NotificationHomePageState {
  NotificationHomePageSuccess(CountAllNotificationEntity? notificationList)
      : super(notificationList: notificationList);
}

class NotificationHomePageFailure extends NotificationHomePageState {
  NotificationHomePageFailure(String message) : super(message: message);
}
