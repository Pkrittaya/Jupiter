// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verify_card_form.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VerifyCardForm _$VerifyCardFormFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'VerifyCardForm',
      json,
      ($checkedConvert) {
        final val = VerifyCardForm(
          token: $checkedConvert('token', (v) => v as String),
          username: $checkedConvert('username', (v) => v as String),
          orgCode: $checkedConvert('org_code', (v) => v as String),
        );
        return val;
      },
      fieldKeyMap: const {'orgCode': 'org_code'},
    );

Map<String, dynamic> _$VerifyCardFormToJson(VerifyCardForm instance) =>
    <String, dynamic>{
      'org_code': instance.orgCode,
      'username': instance.username,
      'token': instance.token,
    };
