// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_station_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FavoriteStationListModel _$FavoriteStationListModelFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      'FavoriteStationListModel',
      json,
      ($checkedConvert) {
        final val = FavoriteStationListModel(
          stationId: $checkedConvert('station_id', (v) => v as String),
          stationName: $checkedConvert('station_name', (v) => v as String),
          position: $checkedConvert(
              'position',
              (v) => (v as List<dynamic>)
                  .map((e) => (e as num).toDouble())
                  .toList()),
          eta: $checkedConvert('eta', (v) => v as String),
          distance: $checkedConvert('distance', (v) => v as String),
          openingHours: $checkedConvert(
              'opening_hours',
              (v) => (v as List<dynamic>)
                  .map((e) => DurationModel.fromJson(e as Map<String, dynamic>))
                  .toList()),
          statusOpening: $checkedConvert('status_opening', (v) => v as bool),
          chargerStatus: $checkedConvert('charger_status', (v) => v as String),
          connectorAvailable:
              $checkedConvert('connector_available', (v) => v as int),
          totalConnector: $checkedConvert('total_connector', (v) => v as int),
          images: $checkedConvert('images', (v) => v as String),
          connectorType: $checkedConvert(
              'connector_type',
              (v) => (v as List<dynamic>)
                  .map((e) => ConnectorTypeAndPowerModel.fromJson(
                      e as Map<String, dynamic>))
                  .toList()),
        );
        return val;
      },
      fieldKeyMap: const {
        'stationId': 'station_id',
        'stationName': 'station_name',
        'openingHours': 'opening_hours',
        'statusOpening': 'status_opening',
        'chargerStatus': 'charger_status',
        'connectorAvailable': 'connector_available',
        'totalConnector': 'total_connector',
        'connectorType': 'connector_type'
      },
    );

Map<String, dynamic> _$FavoriteStationListModelToJson(
        FavoriteStationListModel instance) =>
    <String, dynamic>{
      'station_id': instance.stationId,
      'station_name': instance.stationName,
      'position': instance.position,
      'eta': instance.eta,
      'distance': instance.distance,
      'status_opening': instance.statusOpening,
      'charger_status': instance.chargerStatus,
      'connector_available': instance.connectorAvailable,
      'total_connector': instance.totalConnector,
      'images': instance.images,
      'connector_type': instance.connectorType.map((e) => e.toJson()).toList(),
      'opening_hours': instance.openingHours.map((e) => e.toJson()).toList(),
    };
