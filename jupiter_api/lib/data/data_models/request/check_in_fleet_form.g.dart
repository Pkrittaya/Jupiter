// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_in_fleet_form.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckInFleetForm _$CheckInFleetFormFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'CheckInFleetForm',
      json,
      ($checkedConvert) {
        final val = CheckInFleetForm(
          username: $checkedConvert('username', (v) => v as String),
          qrCodeConnector:
              $checkedConvert('qr_code_connector', (v) => v as String),
          deviceCode: $checkedConvert('device_code', (v) => v as String),
          fleetNo: $checkedConvert('fleet_no', (v) => v as int),
          orgCode: $checkedConvert('org_code', (v) => v as String),
        );
        return val;
      },
      fieldKeyMap: const {
        'qrCodeConnector': 'qr_code_connector',
        'deviceCode': 'device_code',
        'fleetNo': 'fleet_no',
        'orgCode': 'org_code'
      },
    );

Map<String, dynamic> _$CheckInFleetFormToJson(CheckInFleetForm instance) =>
    <String, dynamic>{
      'org_code': instance.orgCode,
      'username': instance.username,
      'qr_code_connector': instance.qrCodeConnector,
      'device_code': instance.deviceCode,
      'fleet_no': instance.fleetNo,
    };
