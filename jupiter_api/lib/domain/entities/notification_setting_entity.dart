import 'package:json_annotation/json_annotation.dart';

class NotificationSettingEntity {
  NotificationSettingEntity(
      {required this.notificationSystem, required this.notificationNews});
  @JsonKey(name: 'notification_system')
  final bool notificationSystem;
  @JsonKey(name: 'notification_news')
  final bool notificationNews;
}
