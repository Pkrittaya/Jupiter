import 'package:json_annotation/json_annotation.dart';

import 'notification_data_entity.dart';

class NotiEntity {
  NotiEntity({required this.notification, required this.notificationIndex});
  @JsonKey(name: 'notification')
  final NotiDataEntity notification;
  @JsonKey(name: 'notification_index')
  final int notificationIndex;
}
