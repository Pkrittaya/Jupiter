// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_access_key_form.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestAccessKeyForm _$RequestAccessKeyFormFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      'RequestAccessKeyForm',
      json,
      ($checkedConvert) {
        final val = RequestAccessKeyForm(
          username: $checkedConvert('username', (v) => v as String),
          refreshToken: $checkedConvert('refresh_token', (v) => v as String),
          deviceCode: $checkedConvert('device_code', (v) => v as String),
          orgCode: $checkedConvert('org_code', (v) => v as String),
        );
        return val;
      },
      fieldKeyMap: const {
        'refreshToken': 'refresh_token',
        'deviceCode': 'device_code',
        'orgCode': 'org_code'
      },
    );

Map<String, dynamic> _$RequestAccessKeyFormToJson(
        RequestAccessKeyForm instance) =>
    <String, dynamic>{
      'org_code': instance.orgCode,
      'username': instance.username,
      'refresh_token': instance.refreshToken,
      'device_code': instance.deviceCode,
    };
