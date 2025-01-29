// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'connector_information_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConnectorInformationModel _$ConnectorInformationModelFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      'ConnectorInformationModel',
      json,
      ($checkedConvert) {
        final val = ConnectorInformationModel(
          stationId: $checkedConvert('station_id', (v) => v as String?),
          chargerId: $checkedConvert('charger_id', (v) => v as String?),
          owener: $checkedConvert('owener', (v) => v as String?),
          connectorId: $checkedConvert('connector_id', (v) => v as String?),
          connectorIndex: $checkedConvert('connector_index', (v) => v as int?),
          connectorType: $checkedConvert('connector_type', (v) => v as String?),
          connectorPosition:
              $checkedConvert('connector_position', (v) => v as String?),
          connectorStatusActive:
              $checkedConvert('connector_status_active', (v) => v as String?),
          premiumChargingStatus:
              $checkedConvert('premium_charging_status', (v) => v as bool?),
        );
        return val;
      },
      fieldKeyMap: const {
        'stationId': 'station_id',
        'chargerId': 'charger_id',
        'connectorId': 'connector_id',
        'connectorIndex': 'connector_index',
        'connectorType': 'connector_type',
        'connectorPosition': 'connector_position',
        'connectorStatusActive': 'connector_status_active',
        'premiumChargingStatus': 'premium_charging_status'
      },
    );

Map<String, dynamic> _$ConnectorInformationModelToJson(
        ConnectorInformationModel instance) =>
    <String, dynamic>{
      'station_id': instance.stationId,
      'charger_id': instance.chargerId,
      'owener': instance.owener,
      'connector_id': instance.connectorId,
      'connector_index': instance.connectorIndex,
      'connector_type': instance.connectorType,
      'connector_position': instance.connectorPosition,
      'connector_status_active': instance.connectorStatusActive,
      'premium_charging_status': instance.premiumChargingStatus,
    };
