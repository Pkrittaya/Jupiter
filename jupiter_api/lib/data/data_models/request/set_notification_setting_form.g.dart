// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'set_notification_setting_form.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SetNotificationSettingForm _$SetNotificationSettingFormFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      'SetNotificationSettingForm',
      json,
      ($checkedConvert) {
        final val = SetNotificationSettingForm(
          notificationSystem:
              $checkedConvert('notification_system', (v) => v as bool),
          notificationNews:
              $checkedConvert('notification_news', (v) => v as bool),
        );
        return val;
      },
      fieldKeyMap: const {
        'notificationSystem': 'notification_system',
        'notificationNews': 'notification_news'
      },
    );

Map<String, dynamic> _$SetNotificationSettingFormToJson(
        SetNotificationSettingForm instance) =>
    <String, dynamic>{
      'notification_system': instance.notificationSystem,
      'notification_news': instance.notificationNews,
    };
