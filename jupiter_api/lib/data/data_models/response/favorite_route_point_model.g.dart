// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_route_point_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FavoriteRoutePointModel _$FavoriteRoutePointModelFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      'FavoriteRoutePointModel',
      json,
      ($checkedConvert) {
        final val = FavoriteRoutePointModel(
          name: $checkedConvert('name', (v) => v as String),
          pointNo: $checkedConvert('point_no', (v) => v as int),
          latitude: $checkedConvert('latitude', (v) => (v as num).toDouble()),
          longitude: $checkedConvert('longitude', (v) => (v as num).toDouble()),
          stationId: $checkedConvert('station_id', (v) => v as String),
          stationName: $checkedConvert('station_name', (v) => v as String),
        );
        return val;
      },
      fieldKeyMap: const {
        'pointNo': 'point_no',
        'stationId': 'station_id',
        'stationName': 'station_name'
      },
    );

Map<String, dynamic> _$FavoriteRoutePointModelToJson(
        FavoriteRoutePointModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'point_no': instance.pointNo,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'station_id': instance.stationId,
      'station_name': instance.stationName,
    };
