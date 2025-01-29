// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'confirm_transaction_fleet_form.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConfirmTransactionFleetForm _$ConfirmTransactionFleetFormFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      'ConfirmTransactionFleetForm',
      json,
      ($checkedConvert) {
        final val = ConfirmTransactionFleetForm(
          fleetNo: $checkedConvert('fleet_no', (v) => v as int),
          fleetType: $checkedConvert('fleet_type', (v) => v as String),
          qrCodeConnector:
              $checkedConvert('qr_code_connector', (v) => v as String),
          chargerId: $checkedConvert('charger_id', (v) => v as String),
          connectorId: $checkedConvert('connector_id', (v) => v as String),
          connectorIndex: $checkedConvert('connector_index', (v) => v as int),
          deviceCode: $checkedConvert('device_code', (v) => v as String),
          orgCode: $checkedConvert('org_code', (v) => v as String),
        );
        return val;
      },
      fieldKeyMap: const {
        'fleetNo': 'fleet_no',
        'fleetType': 'fleet_type',
        'qrCodeConnector': 'qr_code_connector',
        'chargerId': 'charger_id',
        'connectorId': 'connector_id',
        'connectorIndex': 'connector_index',
        'deviceCode': 'device_code',
        'orgCode': 'org_code'
      },
    );

Map<String, dynamic> _$ConfirmTransactionFleetFormToJson(
        ConfirmTransactionFleetForm instance) =>
    <String, dynamic>{
      'fleet_no': instance.fleetNo,
      'fleet_type': instance.fleetType,
      'qr_code_connector': instance.qrCodeConnector,
      'charger_id': instance.chargerId,
      'connector_id': instance.connectorId,
      'connector_index': instance.connectorIndex,
      'device_code': instance.deviceCode,
      'org_code': instance.orgCode,
    };
