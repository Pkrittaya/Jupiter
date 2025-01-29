// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'active_notification_form.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActiveNotificationForm _$ActiveNotificationFormFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      'ActiveNotificationForm',
      json,
      ($checkedConvert) {
        final val = ActiveNotificationForm(
          notificationIndex:
              $checkedConvert('notification_index', (v) => v as int),
          notificationType:
              $checkedConvert('notification_type', (v) => v as String),
        );
        return val;
      },
      fieldKeyMap: const {
        'notificationIndex': 'notification_index',
        'notificationType': 'notification_type'
      },
    );

Map<String, dynamic> _$ActiveNotificationFormToJson(
        ActiveNotificationForm instance) =>
    <String, dynamic>{
      'notification_index': instance.notificationIndex,
      'notification_type': instance.notificationType,
    };
