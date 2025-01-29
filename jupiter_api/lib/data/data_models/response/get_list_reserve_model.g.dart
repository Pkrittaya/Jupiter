// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_list_reserve_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetListReserveModel _$GetListReserveModelFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'GetListReserveModel',
      json,
      ($checkedConvert) {
        final val = GetListReserveModel(
          stationId: $checkedConvert('station_id', (v) => v as String),
          chargerId: $checkedConvert('charger_id', (v) => v as String),
          connectorId: $checkedConvert('connector_id', (v) => v as String),
          connectorQrCode:
              $checkedConvert('connector_qr_code', (v) => v as String),
          slotDate: $checkedConvert('slot_date', (v) => v as String),
          slot: $checkedConvert(
              'slot',
              (v) => (v as List<dynamic>)
                  .map((e) => ListReserveOfConnectorModel.fromJson(
                      e as Map<String, dynamic>))
                  .toList()),
        );
        return val;
      },
      fieldKeyMap: const {
        'stationId': 'station_id',
        'chargerId': 'charger_id',
        'connectorId': 'connector_id',
        'connectorQrCode': 'connector_qr_code',
        'slotDate': 'slot_date'
      },
    );

Map<String, dynamic> _$GetListReserveModelToJson(
        GetListReserveModel instance) =>
    <String, dynamic>{
      'station_id': instance.stationId,
      'charger_id': instance.chargerId,
      'connector_id': instance.connectorId,
      'connector_qr_code': instance.connectorQrCode,
      'slot_date': instance.slotDate,
      'slot': instance.slot.map((e) => e.toJson()).toList(),
    };
