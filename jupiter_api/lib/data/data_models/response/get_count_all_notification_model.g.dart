// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_count_all_notification_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CountAllNotificationModel _$CountAllNotificationModelFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      'CountAllNotificationModel',
      json,
      ($checkedConvert) {
        final val = CountAllNotificationModel(
          numberReadStatus:
              $checkedConvert('number_read_status', (v) => v as int),
        );
        return val;
      },
      fieldKeyMap: const {'numberReadStatus': 'number_read_status'},
    );

Map<String, dynamic> _$CountAllNotificationModelToJson(
        CountAllNotificationModel instance) =>
    <String, dynamic>{
      'number_read_status': instance.numberReadStatus,
    };
