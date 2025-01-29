// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verify_account_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VerifyAccountModel _$VerifyAccountModelFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'VerifyAccountModel',
      json,
      ($checkedConvert) {
        final val = VerifyAccountModel(
          message: $checkedConvert('message', (v) => v as String),
          otpRefNumber: $checkedConvert('otp_ref_number', (v) => v),
        );
        return val;
      },
      fieldKeyMap: const {'otpRefNumber': 'otp_ref_number'},
    );

Map<String, dynamic> _$VerifyAccountModelToJson(VerifyAccountModel instance) =>
    <String, dynamic>{
      'message': instance.message,
      'otp_ref_number': instance.otpRefNumber,
    };
