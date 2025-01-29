// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_current_battery_form.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateCurrentBatteryForm _$UpdateCurrentBatteryFormFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      'UpdateCurrentBatteryForm',
      json,
      ($checkedConvert) {
        final val = UpdateCurrentBatteryForm(
          username: $checkedConvert('username', (v) => v as String),
          qrCodeConnector:
              $checkedConvert('qr_code_connector', (v) => v as String),
          deviceCode: $checkedConvert('device_code', (v) => v as String),
          currentBattery: $checkedConvert('current_battery', (v) => v as int),
          fleetStatus: $checkedConvert('fleet_status', (v) => v as bool),
          fleetNo: $checkedConvert('fleet_no', (v) => v as int),
          orgCode: $checkedConvert('org_code', (v) => v as String),
        );
        return val;
      },
      fieldKeyMap: const {
        'qrCodeConnector': 'qr_code_connector',
        'deviceCode': 'device_code',
        'currentBattery': 'current_battery',
        'fleetStatus': 'fleet_status',
        'fleetNo': 'fleet_no',
        'orgCode': 'org_code'
      },
    );

Map<String, dynamic> _$UpdateCurrentBatteryFormToJson(
        UpdateCurrentBatteryForm instance) =>
    <String, dynamic>{
      'org_code': instance.orgCode,
      'username': instance.username,
      'qr_code_connector': instance.qrCodeConnector,
      'device_code': instance.deviceCode,
      'current_battery': instance.currentBattery,
      'fleet_status': instance.fleetStatus,
      'fleet_no': instance.fleetNo,
    };
