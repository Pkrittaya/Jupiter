// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'station_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StationDetailModel _$StationDetailModelFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'StationDetailModel',
      json,
      ($checkedConvert) {
        final val = StationDetailModel(
          stationId: $checkedConvert('station_id', (v) => v as String),
          stationName: $checkedConvert('station_name', (v) => v as String),
          facility: $checkedConvert(
              'facility',
              (v) => (v as List<dynamic>?)
                  ?.map(
                      (e) => FacilityModel.fromJson(e as Map<String, dynamic>))
                  .toList()),
          position: $checkedConvert(
              'position',
              (v) => (v as List<dynamic>)
                  .map((e) => (e as num).toDouble())
                  .toList()),
          address: $checkedConvert('address', (v) => v as String),
          eta: $checkedConvert('eta', (v) => v as String),
          distance: $checkedConvert('distance', (v) => v as String),
          openingHours: $checkedConvert(
              'opening_hours',
              (v) => (v as List<dynamic>)
                  .map((e) => DurationModel.fromJson(e as Map<String, dynamic>))
                  .toList()),
          images: $checkedConvert('images',
              (v) => (v as List<dynamic>?)?.map((e) => e as String).toList()),
          statusOpening: $checkedConvert('status_opening', (v) => v as bool),
          totalConnector: $checkedConvert('total_connector', (v) => v as int?),
          connectorAvailable:
              $checkedConvert('connector_available', (v) => v as int),
          connectorType: $checkedConvert(
              'connector_type',
              (v) => (v as List<dynamic>)
                  .map((e) => ConnectorTypeAndPowerModel.fromJson(
                      e as Map<String, dynamic>))
                  .toList()),
          statusMarker: $checkedConvert('status_marker', (v) => v as String),
          charger: $checkedConvert(
              'charger',
              (v) => (v as List<dynamic>)
                  .map((e) => ChargerModel.fromJson(e as Map<String, dynamic>))
                  .toList()),
          favorite: $checkedConvert('favorite', (v) => v as bool),
          lowPriorityTariff:
              $checkedConvert('low_priority_tariff', (v) => v as bool),
        );
        return val;
      },
      fieldKeyMap: const {
        'stationId': 'station_id',
        'stationName': 'station_name',
        'openingHours': 'opening_hours',
        'statusOpening': 'status_opening',
        'totalConnector': 'total_connector',
        'connectorAvailable': 'connector_available',
        'connectorType': 'connector_type',
        'statusMarker': 'status_marker',
        'lowPriorityTariff': 'low_priority_tariff'
      },
    );

Map<String, dynamic> _$StationDetailModelToJson(StationDetailModel instance) =>
    <String, dynamic>{
      'station_id': instance.stationId,
      'station_name': instance.stationName,
      'position': instance.position,
      'address': instance.address,
      'eta': instance.eta,
      'distance': instance.distance,
      'images': instance.images,
      'status_opening': instance.statusOpening,
      'total_connector': instance.totalConnector,
      'connector_available': instance.connectorAvailable,
      'status_marker': instance.statusMarker,
      'favorite': instance.favorite,
      'low_priority_tariff': instance.lowPriorityTariff,
      'charger': instance.charger.map((e) => e.toJson()).toList(),
      'facility': instance.facility?.map((e) => e.toJson()).toList(),
      'connector_type': instance.connectorType.map((e) => e.toJson()).toList(),
      'opening_hours': instance.openingHours.map((e) => e.toJson()).toList(),
    };
