// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'log_crash_device_info_form.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LogCrashDeviceInfoForm _$LogCrashDeviceInfoFormFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      'LogCrashDeviceInfoForm',
      json,
      ($checkedConvert) {
        final val = LogCrashDeviceInfoForm(
          deviceCode: $checkedConvert('device_code', (v) => v as String),
          platform: $checkedConvert('platform', (v) => v as String),
          model: $checkedConvert('model', (v) => v as String),
          osVersion: $checkedConvert('os_version', (v) => v as String),
          appVersion: $checkedConvert('app_version', (v) => v as String),
        );
        return val;
      },
      fieldKeyMap: const {
        'deviceCode': 'device_code',
        'osVersion': 'os_version',
        'appVersion': 'app_version'
      },
    );

Map<String, dynamic> _$LogCrashDeviceInfoFormToJson(
        LogCrashDeviceInfoForm instance) =>
    <String, dynamic>{
      'device_code': instance.deviceCode,
      'platform': instance.platform,
      'model': instance.model,
      'os_version': instance.osVersion,
      'app_version': instance.appVersion,
    };
