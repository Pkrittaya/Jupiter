// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verify_account_form.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VerifyAccountForm _$VerifyAccountFormFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'VerifyAccountForm',
      json,
      ($checkedConvert) {
        final val = VerifyAccountForm(
          username: $checkedConvert('username', (v) => v as String),
          password: $checkedConvert('password', (v) => v as String),
          name: $checkedConvert('name', (v) => v as String),
          lastname: $checkedConvert('lastname', (v) => v as String),
          telphonenumber: $checkedConvert('telphonenumber', (v) => v as String),
          gender: $checkedConvert('gender', (v) => v as String),
          dateofbirth: $checkedConvert(
              'dateofbirth', (v) => DateTime.parse(v as String)),
          orgCode: $checkedConvert('org_code', (v) => v as String),
          language: $checkedConvert('language', (v) => v as String),
        );
        return val;
      },
      fieldKeyMap: const {'orgCode': 'org_code'},
    );

Map<String, dynamic> _$VerifyAccountFormToJson(VerifyAccountForm instance) =>
    <String, dynamic>{
      'username': instance.username,
      'password': instance.password,
      'name': instance.name,
      'lastname': instance.lastname,
      'telphonenumber': instance.telphonenumber,
      'gender': instance.gender,
      'dateofbirth': instance.dateofbirth.toIso8601String(),
      'org_code': instance.orgCode,
      'language': instance.language,
    };
