// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotiModel _$NotiModelFromJson(Map<String, dynamic> json) => $checkedCreate(
      'NotiModel',
      json,
      ($checkedConvert) {
        final val = NotiModel(
          notificationIndex:
              $checkedConvert('notification_index', (v) => v as int),
          notification: $checkedConvert('notification',
              (v) => NotiDataModel.fromJson(v as Map<String, dynamic>)),
        );
        return val;
      },
      fieldKeyMap: const {'notificationIndex': 'notification_index'},
    );

Map<String, dynamic> _$NotiModelToJson(NotiModel instance) => <String, dynamic>{
      'notification_index': instance.notificationIndex,
      'notification': instance.notification.toJson(),
    };
