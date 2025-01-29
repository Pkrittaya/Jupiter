// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_otp_forgot_pin_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestOtpForgotPinModel _$RequestOtpForgotPinModelFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      'RequestOtpForgotPinModel',
      json,
      ($checkedConvert) {
        final val = RequestOtpForgotPinModel(
          message: $checkedConvert('message', (v) => v as String),
          otpRefNumber: $checkedConvert('otp_ref_number', (v) => v as String),
        );
        return val;
      },
      fieldKeyMap: const {'otpRefNumber': 'otp_ref_number'},
    );

Map<String, dynamic> _$RequestOtpForgotPinModelToJson(
        RequestOtpForgotPinModel instance) =>
    <String, dynamic>{
      'message': instance.message,
      'otp_ref_number': instance.otpRefNumber,
    };
