// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signout_account_form.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignOutAccountForm _$SignOutAccountFormFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'SignOutAccountForm',
      json,
      ($checkedConvert) {
        final val = SignOutAccountForm(
          username: $checkedConvert('username', (v) => v as String),
          deviceCode: $checkedConvert('device_code', (v) => v as String),
          orgCode: $checkedConvert('org_code', (v) => v as String),
          language: $checkedConvert('language', (v) => v as String),
        );
        return val;
      },
      fieldKeyMap: const {'deviceCode': 'device_code', 'orgCode': 'org_code'},
    );

Map<String, dynamic> _$SignOutAccountFormToJson(SignOutAccountForm instance) =>
    <String, dynamic>{
      'org_code': instance.orgCode,
      'username': instance.username,
      'device_code': instance.deviceCode,
      'language': instance.language,
    };
