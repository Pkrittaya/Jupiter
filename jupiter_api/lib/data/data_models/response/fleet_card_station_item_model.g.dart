// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fleet_card_station_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FleetCardStationItemModel _$FleetCardStationItemModelFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      'FleetCardStationItemModel',
      json,
      ($checkedConvert) {
        final val = FleetCardStationItemModel(
          stationId: $checkedConvert('station_id', (v) => v as String),
          stationName: $checkedConvert('station_name', (v) => v as String),
          connectorAvailable:
              $checkedConvert('connector_available', (v) => v as int),
          connectorTotal: $checkedConvert('connector_total', (v) => v as int),
          image: $checkedConvert('image',
              (v) => (v as List<dynamic>).map((e) => e as String).toList()),
        );
        return val;
      },
      fieldKeyMap: const {
        'stationId': 'station_id',
        'stationName': 'station_name',
        'connectorAvailable': 'connector_available',
        'connectorTotal': 'connector_total'
      },
    );

Map<String, dynamic> _$FleetCardStationItemModelToJson(
        FleetCardStationItemModel instance) =>
    <String, dynamic>{
      'station_id': instance.stationId,
      'station_name': instance.stationName,
      'connector_available': instance.connectorAvailable,
      'connector_total': instance.connectorTotal,
      'image': instance.image,
    };
