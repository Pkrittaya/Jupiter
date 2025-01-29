// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fleet_operation_connector_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FleetOperationConnectorItemModel _$FleetOperationConnectorItemModelFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      'FleetOperationConnectorItemModel',
      json,
      ($checkedConvert) {
        final val = FleetOperationConnectorItemModel(
          connectorId: $checkedConvert('connector_id', (v) => v as String),
          connectorIndex: $checkedConvert('connector_index', (v) => v as int),
          connectorType: $checkedConvert('connector_type', (v) => v as String),
          connectorPowerType:
              $checkedConvert('connector_power_type', (v) => v as String),
          connectorPosition:
              $checkedConvert('connector_position', (v) => v as String),
          connectorStatus:
              $checkedConvert('connector_status', (v) => v as String),
          connectorCode: $checkedConvert('connector_code', (v) => v as String),
          statusCharging:
              $checkedConvert('status_charging', (v) => v as String),
          statusReceipt: $checkedConvert('status_receipt', (v) => v as bool),
        );
        return val;
      },
      fieldKeyMap: const {
        'connectorId': 'connector_id',
        'connectorIndex': 'connector_index',
        'connectorType': 'connector_type',
        'connectorPowerType': 'connector_power_type',
        'connectorPosition': 'connector_position',
        'connectorStatus': 'connector_status',
        'connectorCode': 'connector_code',
        'statusCharging': 'status_charging',
        'statusReceipt': 'status_receipt'
      },
    );

Map<String, dynamic> _$FleetOperationConnectorItemModelToJson(
        FleetOperationConnectorItemModel instance) =>
    <String, dynamic>{
      'connector_id': instance.connectorId,
      'connector_index': instance.connectorIndex,
      'connector_type': instance.connectorType,
      'connector_power_type': instance.connectorPowerType,
      'connector_position': instance.connectorPosition,
      'connector_status': instance.connectorStatus,
      'connector_code': instance.connectorCode,
      'status_charging': instance.statusCharging,
      'status_receipt': instance.statusReceipt,
    };
