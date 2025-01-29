// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_setting_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationSettingModel _$NotificationSettingModelFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      'NotificationSettingModel',
      json,
      ($checkedConvert) {
        final val = NotificationSettingModel(
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

Map<String, dynamic> _$NotificationSettingModelToJson(
        NotificationSettingModel instance) =>
    <String, dynamic>{
      'notification_system': instance.notificationSystem,
      'notification_news': instance.notificationNews,
    };
