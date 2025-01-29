// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_news_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationNewsModel _$NotificationNewsModelFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      'NotificationNewsModel',
      json,
      ($checkedConvert) {
        final val = NotificationNewsModel(
          numberReadStatus:
              $checkedConvert('number_read_status', (v) => v as int),
          dataNotification: $checkedConvert(
              'data_notification',
              (v) => (v as List<dynamic>)
                  .map((e) => NotificationNewsDataModel.fromJson(
                      e as Map<String, dynamic>))
                  .toList()),
        );
        return val;
      },
      fieldKeyMap: const {
        'numberReadStatus': 'number_read_status',
        'dataNotification': 'data_notification'
      },
    );

Map<String, dynamic> _$NotificationNewsModelToJson(
        NotificationNewsModel instance) =>
    <String, dynamic>{
      'number_read_status': instance.numberReadStatus,
      'data_notification':
          instance.dataNotification.map((e) => e.toJson()).toList(),
    };
