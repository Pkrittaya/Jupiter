// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'connector_type_power_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConnectorTypeAndPowerModel _$ConnectorTypeAndPowerModelFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      'ConnectorTypeAndPowerModel',
      json,
      ($checkedConvert) {
        final val = ConnectorTypeAndPowerModel(
          connectorType: $checkedConvert('connector_type', (v) => v as String),
          connectorPowerType:
              $checkedConvert('connector_power_type', (v) => v as String),
        );
        return val;
      },
      fieldKeyMap: const {
        'connectorType': 'connector_type',
        'connectorPowerType': 'connector_power_type'
      },
    );

Map<String, dynamic> _$ConnectorTypeAndPowerModelToJson(
        ConnectorTypeAndPowerModel instance) =>
    <String, dynamic>{
      'connector_type': instance.connectorType,
      'connector_power_type': instance.connectorPowerType,
    };
