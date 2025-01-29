// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recommended_station_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecommendedStationModel _$RecommendedStationModelFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      'RecommendedStationModel',
      json,
      ($checkedConvert) {
        final val = RecommendedStationModel(
          stationId: $checkedConvert('station_id', (v) => v as String),
          stationName: $checkedConvert('station_name', (v) => v as String),
          position: $checkedConvert(
              'position',
              (v) => (v as List<dynamic>)
                  .map((e) => (e as num).toDouble())
                  .toList()),
          connectorType: $checkedConvert(
              'connector_type',
              (v) => (v as List<dynamic>)
                  .map((e) => ConnectorTypeAndPowerModel.fromJson(
                      e as Map<String, dynamic>))
                  .toList()),
          images: $checkedConvert('images', (v) => v as String),
        );
        return val;
      },
      fieldKeyMap: const {
        'stationId': 'station_id',
        'stationName': 'station_name',
        'connectorType': 'connector_type'
      },
    );

Map<String, dynamic> _$RecommendedStationModelToJson(
        RecommendedStationModel instance) =>
    <String, dynamic>{
      'station_id': instance.stationId,
      'station_name': instance.stationName,
      'position': instance.position,
      'images': instance.images,
      'connector_type': instance.connectorType.map((e) => e.toJson()).toList(),
    };
