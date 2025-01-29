part of 'notification_cubit.dart';

abstract class NotiState extends Equatable {
  NotiState({this.notificationList, this.message, this.notificationNewsList});
  final ListNotificationEntity? notificationList;
  final NotificationNewsEntity? notificationNewsList;
  final String? message;
  @override
  List<Object> get props => [];
}

class NotiInitial extends NotiState {}

class NotiLoading extends NotiState {}

class NotiSuccess extends NotiState {
  NotiSuccess(ListNotificationEntity? notificationList)
      : super(notificationList: notificationList);
}

class NotiFailure extends NotiState {
  NotiFailure(String message) : super(message: message);
}

class NotiNewsSuccess extends NotiState {
  NotiNewsSuccess(NotificationNewsEntity? notificationNewsList)
      : super(notificationNewsList: notificationNewsList);
}

class NotiNewsFailure extends NotiState {
  NotiNewsFailure(String message) : super(message: message);
}

class DeleteNotiLoading extends NotiState {}

class DeleteNotiSuccess extends NotiState {}

class DeleteNotiFailure extends NotiState {
  DeleteNotiFailure(String message) : super(message: message);
}

class ActiveNotiSuccess extends NotiState {}

class ActiveNotiFailure extends NotiState {
  ActiveNotiFailure(String message) : super(message: message);
}
