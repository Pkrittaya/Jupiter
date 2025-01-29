// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'log_crash_form.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LogCrashForm _$LogCrashFormFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'LogCrashForm',
      json,
      ($checkedConvert) {
        final val = LogCrashForm(
          orgCode: $checkedConvert('org_code', (v) => v as String),
          username: $checkedConvert('username', (v) => v as String),
          title: $checkedConvert('title', (v) => v as String),
          message: $checkedConvert('message', (v) => v as String),
          stack: $checkedConvert('stack', (v) => v as String),
          deviceInfo: $checkedConvert(
              'device_info',
              (v) =>
                  LogCrashDeviceInfoForm.fromJson(v as Map<String, dynamic>)),
        );
        return val;
      },
      fieldKeyMap: const {'orgCode': 'org_code', 'deviceInfo': 'device_info'},
    );

Map<String, dynamic> _$LogCrashFormToJson(LogCrashForm instance) =>
    <String, dynamic>{
      'org_code': instance.orgCode,
      'username': instance.username,
      'title': instance.title,
      'message': instance.message,
      'stack': instance.stack,
      'device_info': instance.deviceInfo.toJson(),
    };
