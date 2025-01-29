// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotiDataModel _$NotiDataModelFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'NotiDataModel',
      json,
      ($checkedConvert) {
        final val = NotiDataModel(
          title: $checkedConvert('title', (v) => v as String),
          body: $checkedConvert('body', (v) => v as String),
          readStatus: $checkedConvert('read_status', (v) => v as bool?),
          messageCreate: $checkedConvert('message_create', (v) => v as String?),
        );
        return val;
      },
      fieldKeyMap: const {
        'readStatus': 'read_status',
        'messageCreate': 'message_create'
      },
    );

Map<String, dynamic> _$NotiDataModelToJson(NotiDataModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'body': instance.body,
      'read_status': instance.readStatus,
      'message_create': instance.messageCreate,
    };
