// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signin_account_form.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignInAccountForm _$SignInAccountFormFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'SignInAccountForm',
      json,
      ($checkedConvert) {
        final val = SignInAccountForm(
          username: $checkedConvert('username', (v) => v as String),
          password: $checkedConvert('password', (v) => v as String),
          deviceCode: $checkedConvert('device_code', (v) => v as String),
          notificationToken:
              $checkedConvert('notification_token', (v) => v as String),
          language: $checkedConvert('language', (v) => v as String),
          orgCode: $checkedConvert('org_code', (v) => v as String),
        );
        return val;
      },
      fieldKeyMap: const {
        'deviceCode': 'device_code',
        'notificationToken': 'notification_token',
        'orgCode': 'org_code'
      },
    );

Map<String, dynamic> _$SignInAccountFormToJson(SignInAccountForm instance) =>
    <String, dynamic>{
      'org_code': instance.orgCode,
      'username': instance.username,
      'password': instance.password,
      'device_code': instance.deviceCode,
      'notification_token': instance.notificationToken,
      'language': instance.language,
    };
