// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_data_news_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationNewsDataModel _$NotificationNewsDataModelFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      'NotificationNewsDataModel',
      json,
      ($checkedConvert) {
        final val = NotificationNewsDataModel(
          notificationIndex:
              $checkedConvert('notification_index', (v) => v as int),
          messageType: $checkedConvert('message_type', (v) => v as String),
          messageCreate: $checkedConvert('message_create', (v) => v as String),
          messageTitle: $checkedConvert('message_title', (v) => v as String),
          messageBody: $checkedConvert('message_body', (v) => v as String),
          messageData: $checkedConvert('message_data', (v) => v as String),
          linkInformation:
              $checkedConvert('link_information', (v) => v as String),
          image: $checkedConvert('image', (v) => v as String),
          statusRead: $checkedConvert('status_read', (v) => v as bool),
        );
        return val;
      },
      fieldKeyMap: const {
        'notificationIndex': 'notification_index',
        'messageType': 'message_type',
        'messageCreate': 'message_create',
        'messageTitle': 'message_title',
        'messageBody': 'message_body',
        'messageData': 'message_data',
        'linkInformation': 'link_information',
        'statusRead': 'status_read'
      },
    );

Map<String, dynamic> _$NotificationNewsDataModelToJson(
        NotificationNewsDataModel instance) =>
    <String, dynamic>{
      'notification_index': instance.notificationIndex,
      'message_type': instance.messageType,
      'message_create': instance.messageCreate,
      'message_title': instance.messageTitle,
      'message_body': instance.messageBody,
      'message_data': instance.messageData,
      'link_information': instance.linkInformation,
      'image': instance.image,
      'status_read': instance.statusRead,
    };
