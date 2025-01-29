// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'status_charger_form.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StatusChargerForm _$StatusChargerFormFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'StatusChargerForm',
      json,
      ($checkedConvert) {
        final val = StatusChargerForm(
          orgCode: $checkedConvert('org_code', (v) => v as String),
          username: $checkedConvert('username', (v) => v as String),
          deviceCode: $checkedConvert('device_code', (v) => v as String),
        );
        return val;
      },
      fieldKeyMap: const {'orgCode': 'org_code', 'deviceCode': 'device_code'},
    );

Map<String, dynamic> _$StatusChargerFormToJson(StatusChargerForm instance) =>
    <String, dynamic>{
      'org_code': instance.orgCode,
      'username': instance.username,
      'device_code': instance.deviceCode,
    };
