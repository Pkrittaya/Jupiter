// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verify_email_form.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VerifyEmailForm _$VerifyEmailFormFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'VerifyEmailForm',
      json,
      ($checkedConvert) {
        final val = VerifyEmailForm(
          language: $checkedConvert('language', (v) => v as String),
          username: $checkedConvert('username', (v) => v as String),
          orgCode: $checkedConvert('org_code', (v) => v as String),
        );
        return val;
      },
      fieldKeyMap: const {'orgCode': 'org_code'},
    );

Map<String, dynamic> _$VerifyEmailFormToJson(VerifyEmailForm instance) =>
    <String, dynamic>{
      'org_code': instance.orgCode,
      'username': instance.username,
      'language': instance.language,
    };
