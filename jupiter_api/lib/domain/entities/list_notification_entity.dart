import 'package:json_annotation/json_annotation.dart';

import 'notification_entity.dart';

class ListNotificationEntity {
  ListNotificationEntity({
    required this.numberReadStatus,
    required this.dataNotification,
  });
  @JsonKey(name: 'number_read_status')
  final int numberReadStatus;
  @JsonKey(name: 'data_notification')
  final List<NotiEntity> dataNotification;
}
