// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'send_email_forgot_password_form.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SendEmailForgotPasswordForm _$SendEmailForgotPasswordFormFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      'SendEmailForgotPasswordForm',
      json,
      ($checkedConvert) {
        final val = SendEmailForgotPasswordForm(
          email: $checkedConvert('email', (v) => v as String),
          language: $checkedConvert('language', (v) => v as String),
          orgCode: $checkedConvert('org_code', (v) => v as String),
        );
        return val;
      },
      fieldKeyMap: const {'orgCode': 'org_code'},
    );

Map<String, dynamic> _$SendEmailForgotPasswordFormToJson(
        SendEmailForgotPasswordForm instance) =>
    <String, dynamic>{
      'org_code': instance.orgCode,
      'email': instance.email,
      'language': instance.language,
    };
