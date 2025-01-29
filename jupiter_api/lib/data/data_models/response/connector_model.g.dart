// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'connector_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConnectorModel _$ConnectorModelFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'ConnectorModel',
      json,
      ($checkedConvert) {
        final val = ConnectorModel(
          connectorId: $checkedConvert('connector_id', (v) => v as String),
          connectorQrCode:
              $checkedConvert('connector_qr_code', (v) => v as String),
          connectorName: $checkedConvert('connector_name', (v) => v as String),
          connectorType: $checkedConvert('connector_type', (v) => v as String),
          connectorPowerType:
              $checkedConvert('connector_power_type', (v) => v as String),
          connectorPosition:
              $checkedConvert('connector_position', (v) => v as String),
          connectorStatus:
              $checkedConvert('connector_status', (v) => v as bool),
          connectorStatusActive:
              $checkedConvert('connector_status_active', (v) => v as String),
          connectorPower:
              $checkedConvert('connector_power', (v) => v as String),
          connectorPrice:
              $checkedConvert('connector_price', (v) => v as String),
          reserveStatus: $checkedConvert('reserve_status', (v) => v as bool),
          reservePrice:
              $checkedConvert('reserve_price', (v) => (v as num).toDouble()),
          reserveSlot: $checkedConvert(
              'reserve_slot',
              (v) => (v as List<dynamic>?)
                  ?.map((e) =>
                      ReserveSlotModel.fromJson(e as Map<String, dynamic>))
                  .toList()),
        );
        return val;
      },
      fieldKeyMap: const {
        'connectorId': 'connector_id',
        'connectorQrCode': 'connector_qr_code',
        'connectorName': 'connector_name',
        'connectorType': 'connector_type',
        'connectorPowerType': 'connector_power_type',
        'connectorPosition': 'connector_position',
        'connectorStatus': 'connector_status',
        'connectorStatusActive': 'connector_status_active',
        'connectorPower': 'connector_power',
        'connectorPrice': 'connector_price',
        'reserveStatus': 'reserve_status',
        'reservePrice': 'reserve_price',
        'reserveSlot': 'reserve_slot'
      },
    );

Map<String, dynamic> _$ConnectorModelToJson(ConnectorModel instance) =>
    <String, dynamic>{
      'connector_id': instance.connectorId,
      'connector_qr_code': instance.connectorQrCode,
      'connector_name': instance.connectorName,
      'connector_type': instance.connectorType,
      'connector_power': instance.connectorPower,
      'connector_position': instance.connectorPosition,
      'connector_status': instance.connectorStatus,
      'connector_status_active': instance.connectorStatusActive,
      'connector_power_type': instance.connectorPowerType,
      'connector_price': instance.connectorPrice,
      'reserve_status': instance.reserveStatus,
      'reserve_price': instance.reservePrice,
      'reserve_slot': instance.reserveSlot?.map((e) => e.toJson()).toList(),
    };
