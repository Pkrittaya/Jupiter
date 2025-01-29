// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_fovorite_route_point_form.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddFavoriteRoutePointForm _$AddFavoriteRoutePointFormFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      'AddFavoriteRoutePointForm',
      json,
      ($checkedConvert) {
        final val = AddFavoriteRoutePointForm(
          name: $checkedConvert('name', (v) => v as String),
          pointNo: $checkedConvert('point_no', (v) => v as int),
          latitude: $checkedConvert('latitude', (v) => (v as num).toDouble()),
          longitude: $checkedConvert('longitude', (v) => (v as num).toDouble()),
          stationId: $checkedConvert('station_id', (v) => v as String),
        );
        return val;
      },
      fieldKeyMap: const {'pointNo': 'point_no', 'stationId': 'station_id'},
    );

Map<String, dynamic> _$AddFavoriteRoutePointFormToJson(
        AddFavoriteRoutePointForm instance) =>
    <String, dynamic>{
      'name': instance.name,
      'point_no': instance.pointNo,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'station_id': instance.stationId,
    };
