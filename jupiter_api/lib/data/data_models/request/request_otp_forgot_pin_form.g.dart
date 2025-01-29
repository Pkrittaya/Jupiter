// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_otp_forgot_pin_form.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestOtpForgotPinForm _$RequestOtpForgotPinFormFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      'RequestOtpForgotPinForm',
      json,
      ($checkedConvert) {
        final val = RequestOtpForgotPinForm(
          username: $checkedConvert('username', (v) => v as String),
          orgCode: $checkedConvert('org_code', (v) => v as String),
          telphoneNumber: $checkedConvert('telphonenumber', (v) => v as String),
          language: $checkedConvert('language', (v) => v as String),
        );
        return val;
      },
      fieldKeyMap: const {
        'orgCode': 'org_code',
        'telphoneNumber': 'telphonenumber'
      },
    );

Map<String, dynamic> _$RequestOtpForgotPinFormToJson(
        RequestOtpForgotPinForm instance) =>
    <String, dynamic>{
      'org_code': instance.orgCode,
      'username': instance.username,
      'telphonenumber': instance.telphoneNumber,
      'language': instance.language,
    };
