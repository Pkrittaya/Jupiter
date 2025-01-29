// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_notification_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListNotificationModel _$ListNotificationModelFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      'ListNotificationModel',
      json,
      ($checkedConvert) {
        final val = ListNotificationModel(
          numberReadStatus:
              $checkedConvert('number_read_status', (v) => v as int),
          dataNotification: $checkedConvert(
              'data_notification',
              (v) => (v as List<dynamic>)
                  .map((e) => NotiModel.fromJson(e as Map<String, dynamic>))
                  .toList()),
        );
        return val;
      },
      fieldKeyMap: const {
        'numberReadStatus': 'number_read_status',
        'dataNotification': 'data_notification'
      },
    );

Map<String, dynamic> _$ListNotificationModelToJson(
        ListNotificationModel instance) =>
    <String, dynamic>{
      'number_read_status': instance.numberReadStatus,
      'data_notification':
          instance.dataNotification.map((e) => e.toJson()).toList(),
    };
