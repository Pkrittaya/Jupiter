// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_stop_fleet_form.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteStopFleetForm _$RemoteStopFleetFormFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'RemoteStopFleetForm',
      json,
      ($checkedConvert) {
        final val = RemoteStopFleetForm(
          orgCode: $checkedConvert('org_code', (v) => v as String),
          username: $checkedConvert('username', (v) => v as String),
          qrCodeConnector:
              $checkedConvert('qr_code_connector', (v) => v as String),
          chargerId: $checkedConvert('charger_id', (v) => v as String),
          connectorId: $checkedConvert('connector_id', (v) => v as String),
          connectorIndex: $checkedConvert('connector_index', (v) => v as int),
          deviceCode: $checkedConvert('device_code', (v) => v as String),
          fleetNo: $checkedConvert('fleet_no', (v) => v as int),
          fleetType: $checkedConvert('fleet_type', (v) => v as String),
        );
        return val;
      },
      fieldKeyMap: const {
        'orgCode': 'org_code',
        'qrCodeConnector': 'qr_code_connector',
        'chargerId': 'charger_id',
        'connectorId': 'connector_id',
        'connectorIndex': 'connector_index',
        'deviceCode': 'device_code',
        'fleetNo': 'fleet_no',
        'fleetType': 'fleet_type'
      },
    );

Map<String, dynamic> _$RemoteStopFleetFormToJson(
        RemoteStopFleetForm instance) =>
    <String, dynamic>{
      'org_code': instance.orgCode,
      'username': instance.username,
      'qr_code_connector': instance.qrCodeConnector,
      'charger_id': instance.chargerId,
      'connector_id': instance.connectorId,
      'connector_index': instance.connectorIndex,
      'device_code': instance.deviceCode,
      'fleet_no': instance.fleetNo,
      'fleet_type': instance.fleetType,
    };
