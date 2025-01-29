// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verify_otp_forgot_pin_form.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VerifyOtpForgotPinForm _$VerifyOtpForgotPinFormFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      'VerifyOtpForgotPinForm',
      json,
      ($checkedConvert) {
        final val = VerifyOtpForgotPinForm(
          username: $checkedConvert('username', (v) => v as String),
          orgCode: $checkedConvert('org_code', (v) => v as String),
          telphoneNumber: $checkedConvert('telphonenumber', (v) => v as String),
          otpCode: $checkedConvert('otpcode', (v) => v as String),
          otpRefNumber: $checkedConvert('otp_ref_number', (v) => v as String),
          language: $checkedConvert('language', (v) => v as String),
        );
        return val;
      },
      fieldKeyMap: const {
        'orgCode': 'org_code',
        'telphoneNumber': 'telphonenumber',
        'otpCode': 'otpcode',
        'otpRefNumber': 'otp_ref_number'
      },
    );

Map<String, dynamic> _$VerifyOtpForgotPinFormToJson(
        VerifyOtpForgotPinForm instance) =>
    <String, dynamic>{
      'org_code': instance.orgCode,
      'username': instance.username,
      'telphonenumber': instance.telphoneNumber,
      'otpcode': instance.otpCode,
      'otp_ref_number': instance.otpRefNumber,
      'language': instance.language,
    };
