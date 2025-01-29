// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'username_and_orgcode_form.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UsernameAndOrgCodeForm _$UsernameAndOrgCodeFormFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      'UsernameAndOrgCodeForm',
      json,
      ($checkedConvert) {
        final val = UsernameAndOrgCodeForm(
          username: $checkedConvert('username', (v) => v as String),
          orgCode: $checkedConvert('org_code', (v) => v as String),
        );
        return val;
      },
      fieldKeyMap: const {'orgCode': 'org_code'},
    );

Map<String, dynamic> _$UsernameAndOrgCodeFormToJson(
        UsernameAndOrgCodeForm instance) =>
    <String, dynamic>{
      'org_code': instance.orgCode,
      'username': instance.username,
    };
