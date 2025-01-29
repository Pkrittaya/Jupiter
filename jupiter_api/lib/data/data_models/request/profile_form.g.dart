// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_form.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileForm _$ProfileFormFromJson(Map<String, dynamic> json) => $checkedCreate(
      'ProfileForm',
      json,
      ($checkedConvert) {
        final val = ProfileForm(
          username: $checkedConvert('username', (v) => v as String),
          orgCode: $checkedConvert('org_code', (v) => v as String),
          name: $checkedConvert('name', (v) => v as String),
          lastname: $checkedConvert('lastname', (v) => v as String),
          gender: $checkedConvert('gender', (v) => v as String),
          dateofbirth: $checkedConvert('dateofbirth', (v) => v as String),
          telphonenumber: $checkedConvert('telphonenumber', (v) => v as String),
        );
        return val;
      },
      fieldKeyMap: const {'orgCode': 'org_code'},
    );

Map<String, dynamic> _$ProfileFormToJson(ProfileForm instance) =>
    <String, dynamic>{
      'org_code': instance.orgCode,
      'username': instance.username,
      'name': instance.name,
      'lastname': instance.lastname,
      'gender': instance.gender,
      'dateofbirth': instance.dateofbirth,
      'telphonenumber': instance.telphonenumber,
    };
