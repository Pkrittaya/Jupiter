import 'package:json_annotation/json_annotation.dart';
import 'package:jupiter_api/domain/entities/notification_data_news_entity.dart';

class NotificationNewsEntity {
  NotificationNewsEntity(
      {required this.numberReadStatus, required this.dataNotification});
  @JsonKey(name: 'number_read_status')
  final int numberReadStatus;
  @JsonKey(name: 'data_notification')
  final List<NotificationNewsDataEntity> dataNotification;
}
