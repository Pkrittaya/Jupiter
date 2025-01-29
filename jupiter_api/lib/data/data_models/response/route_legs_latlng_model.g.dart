// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'route_legs_latlng_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RoutesLegsLatLngModel _$RoutesLegsLatLngModelFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      'RoutesLegsLatLngModel',
      json,
      ($checkedConvert) {
        final val = RoutesLegsLatLngModel(
          latLng: $checkedConvert(
              'latLng',
              (v) =>
                  RoutesLegsLocationModel.fromJson(v as Map<String, dynamic>)),
        );
        return val;
      },
    );

Map<String, dynamic> _$RoutesLegsLatLngModelToJson(
        RoutesLegsLatLngModel instance) =>
    <String, dynamic>{
      'latLng': instance.latLng.toJson(),
    };
