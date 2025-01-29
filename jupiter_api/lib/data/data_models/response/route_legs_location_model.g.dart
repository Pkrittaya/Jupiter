// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'route_legs_location_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RoutesLegsLocationModel _$RoutesLegsLocationModelFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      'RoutesLegsLocationModel',
      json,
      ($checkedConvert) {
        final val = RoutesLegsLocationModel(
          lat: $checkedConvert('latitude', (v) => (v as num).toDouble()),
          lng: $checkedConvert('longitude', (v) => (v as num).toDouble()),
        );
        return val;
      },
      fieldKeyMap: const {'lat': 'latitude', 'lng': 'longitude'},
    );

Map<String, dynamic> _$RoutesLegsLocationModelToJson(
        RoutesLegsLocationModel instance) =>
    <String, dynamic>{
      'latitude': instance.lat,
      'longitude': instance.lng,
    };
