// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'only_org_form.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OnlyOrgForm _$OnlyOrgFormFromJson(Map<String, dynamic> json) => $checkedCreate(
      'OnlyOrgForm',
      json,
      ($checkedConvert) {
        final val = OnlyOrgForm(
          orgCode: $checkedConvert('org_code', (v) => v as String),
        );
        return val;
      },
      fieldKeyMap: const {'orgCode': 'org_code'},
    );

Map<String, dynamic> _$OnlyOrgFormToJson(OnlyOrgForm instance) =>
    <String, dynamic>{
      'org_code': instance.orgCode,
    };
