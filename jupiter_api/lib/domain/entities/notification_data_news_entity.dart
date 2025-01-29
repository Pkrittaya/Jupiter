import 'package:json_annotation/json_annotation.dart';

class NotificationNewsDataEntity {
  NotificationNewsDataEntity(
      {required this.notificationIndex,
      required this.messageType,
      required this.messageCreate,
      required this.messageTitle,
      required this.messageBody,
      required this.messageData,
      required this.linkInformation,
      required this.image,
      required this.statusRead});

  @JsonKey(name: 'notification_index')
  final int notificationIndex;
  @JsonKey(name: 'message_type')
  final String messageType;
  @JsonKey(name: 'message_create')
  final String messageCreate;
  @JsonKey(name: 'message_title')
  final String messageTitle;
  @JsonKey(name: 'message_body')
  final String messageBody;
  @JsonKey(name: 'message_data')
  final String messageData;
  @JsonKey(name: 'link_information')
  final String linkInformation;
  @JsonKey(name: 'image')
  final String image;
  @JsonKey(name: 'status_read')
  final bool statusRead;
}
