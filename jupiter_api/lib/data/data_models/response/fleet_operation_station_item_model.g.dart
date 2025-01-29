// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fleet_operation_station_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FleetOperationStationItemModel _$FleetOperationStationItemModelFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      'FleetOperationStationItemModel',
      json,
      ($checkedConvert) {
        final val = FleetOperationStationItemModel(
          stationId: $checkedConvert('station_id', (v) => v as String),
          stationName: $checkedConvert('station_name', (v) => v as String),
          connectorAvailable:
              $checkedConvert('connector_available', (v) => v as int),
          connectorTotal: $checkedConvert('connector_total', (v) => v as int),
          statusCharging:
              $checkedConvert('status_charging', (v) => v as String),
          image: $checkedConvert('image',
              (v) => (v as List<dynamic>).map((e) => e as String).toList()),
        );
        return val;
      },
      fieldKeyMap: const {
        'stationId': 'station_id',
        'stationName': 'station_name',
        'connectorAvailable': 'connector_available',
        'connectorTotal': 'connector_total',
        'statusCharging': 'status_charging'
      },
    );

Map<String, dynamic> _$FleetOperationStationItemModelToJson(
        FleetOperationStationItemModel instance) =>
    <String, dynamic>{
      'station_id': instance.stationId,
      'station_name': instance.stationName,
      'connector_available': instance.connectorAvailable,
      'connector_total': instance.connectorTotal,
      'status_charging': instance.statusCharging,
      'image': instance.image,
    };
