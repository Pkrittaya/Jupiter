// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'station_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StationModel _$StationModelFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'StationModel',
      json,
      ($checkedConvert) {
        final val = StationModel(
          stationId: $checkedConvert('station_id', (v) => v as String),
          stationName: $checkedConvert('station_name', (v) => v as String),
          statusMarker: $checkedConvert('status_marker', (v) => v as String),
          position: $checkedConvert(
              'position',
              (v) => (v as List<dynamic>)
                  .map((e) => (e as num).toDouble())
                  .toList()),
          connectorAvailable:
              $checkedConvert('connector_available', (v) => v as int),
          connectorTotal: $checkedConvert('connector_total', (v) => v as int),
          connectorType: $checkedConvert(
              'connector_type',
              (v) => (v as List<dynamic>)
                  .map((e) => ConnectorTypeAndPowerModel.fromJson(
                      e as Map<String, dynamic>))
                  .toList()),
          distance: $checkedConvert('distance', (v) => v as int),
        );
        return val;
      },
      fieldKeyMap: const {
        'stationId': 'station_id',
        'stationName': 'station_name',
        'statusMarker': 'status_marker',
        'connectorAvailable': 'connector_available',
        'connectorTotal': 'connector_total',
        'connectorType': 'connector_type'
      },
    );

Map<String, dynamic> _$StationModelToJson(StationModel instance) =>
    <String, dynamic>{
      'station_id': instance.stationId,
      'station_name': instance.stationName,
      'status_marker': instance.statusMarker,
      'position': instance.position,
      'connector_available': instance.connectorAvailable,
      'connector_total': instance.connectorTotal,
      'distance': instance.distance,
      'connector_type': instance.connectorType.map((e) => e.toJson()).toList(),
    };
