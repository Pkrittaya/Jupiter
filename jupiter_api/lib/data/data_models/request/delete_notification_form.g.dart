// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delete_notification_form.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeleteNotificationForm _$DeleteNotificationFormFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      'DeleteNotificationForm',
      json,
      ($checkedConvert) {
        final val = DeleteNotificationForm(
          notificationOperator:
              $checkedConvert('notification_operator', (v) => v as String),
          notificationIndex:
              $checkedConvert('notification_index', (v) => v as int),
          notificationType:
              $checkedConvert('notification_type', (v) => v as String),
        );
        return val;
      },
      fieldKeyMap: const {
        'notificationOperator': 'notification_operator',
        'notificationIndex': 'notification_index',
        'notificationType': 'notification_type'
      },
    );

Map<String, dynamic> _$DeleteNotificationFormToJson(
        DeleteNotificationForm instance) =>
    <String, dynamic>{
      'notification_operator': instance.notificationOperator,
      'notification_index': instance.notificationIndex,
      'notification_type': instance.notificationType,
    };
