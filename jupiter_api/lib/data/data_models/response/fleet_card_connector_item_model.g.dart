// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fleet_card_connector_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FleetCardConnectorItemModel _$FleetCardConnectorItemModelFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      'FleetCardConnectorItemModel',
      json,
      ($checkedConvert) {
        final val = FleetCardConnectorItemModel(
          connectorType: $checkedConvert('connector_type', (v) => v as String),
          connectorPowerType:
              $checkedConvert('connector_power_type', (v) => v as String),
          connectorPosition:
              $checkedConvert('connector_position', (v) => v as String),
          connectorStatus:
              $checkedConvert('connector_status', (v) => v as String),
          connectorCode: $checkedConvert('connector_code', (v) => v as String),
        );
        return val;
      },
      fieldKeyMap: const {
        'connectorType': 'connector_type',
        'connectorPowerType': 'connector_power_type',
        'connectorPosition': 'connector_position',
        'connectorStatus': 'connector_status',
        'connectorCode': 'connector_code'
      },
    );

Map<String, dynamic> _$FleetCardConnectorItemModelToJson(
        FleetCardConnectorItemModel instance) =>
    <String, dynamic>{
      'connector_type': instance.connectorType,
      'connector_power_type': instance.connectorPowerType,
      'connector_position': instance.connectorPosition,
      'connector_status': instance.connectorStatus,
      'connector_code': instance.connectorCode,
    };
