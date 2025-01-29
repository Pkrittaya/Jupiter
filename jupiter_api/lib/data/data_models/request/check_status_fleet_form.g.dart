// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_status_fleet_form.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckStatusFleetForm _$CheckStatusFleetFormFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      'CheckStatusFleetForm',
      json,
      ($checkedConvert) {
        final val = CheckStatusFleetForm(
          orgCode: $checkedConvert('org_code', (v) => v as String),
          username: $checkedConvert('username', (v) => v as String),
          deviceCode: $checkedConvert('device_code', (v) => v as String),
          fleetNo: $checkedConvert('fleet_no', (v) => v as int),
          fleetType: $checkedConvert('fleet_type', (v) => v as String),
          refCode: $checkedConvert('ref_code', (v) => v as String),
        );
        return val;
      },
      fieldKeyMap: const {
        'orgCode': 'org_code',
        'deviceCode': 'device_code',
        'fleetNo': 'fleet_no',
        'fleetType': 'fleet_type',
        'refCode': 'ref_code'
      },
    );

Map<String, dynamic> _$CheckStatusFleetFormToJson(
        CheckStatusFleetForm instance) =>
    <String, dynamic>{
      'org_code': instance.orgCode,
      'username': instance.username,
      'device_code': instance.deviceCode,
      'fleet_no': instance.fleetNo,
      'fleet_type': instance.fleetType,
      'ref_code': instance.refCode,
    };
