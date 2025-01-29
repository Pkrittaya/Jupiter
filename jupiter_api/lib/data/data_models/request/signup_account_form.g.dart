// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signup_account_form.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignupAccountForm _$SignupAccountFormFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'SignupAccountForm',
      json,
      ($checkedConvert) {
        final val = SignupAccountForm(
          username: $checkedConvert('username', (v) => v as String),
          password: $checkedConvert('password', (v) => v as String),
          name: $checkedConvert('name', (v) => v as String),
          lastname: $checkedConvert('lastname', (v) => v as String),
          telphonenumber: $checkedConvert('telphonenumber', (v) => v as String),
          gender: $checkedConvert('gender', (v) => v as String),
          dateofbirth: $checkedConvert(
              'dateofbirth', (v) => DateTime.parse(v as String)),
          language: $checkedConvert('language', (v) => v as String),
          otpCode: $checkedConvert('otp_code', (v) => v as String),
          orgCode: $checkedConvert('org_code', (v) => v as String),
        );
        return val;
      },
      fieldKeyMap: const {'otpCode': 'otp_code', 'orgCode': 'org_code'},
    );

Map<String, dynamic> _$SignupAccountFormToJson(SignupAccountForm instance) =>
    <String, dynamic>{
      'username': instance.username,
      'password': instance.password,
      'name': instance.name,
      'lastname': instance.lastname,
      'telphonenumber': instance.telphonenumber,
      'gender': instance.gender,
      'dateofbirth': instance.dateofbirth.toIso8601String(),
      'language': instance.language,
      'otp_code': instance.otpCode,
      'org_code': instance.orgCode,
    };
