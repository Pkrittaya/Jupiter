// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'route_legs_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RoutesLegsItemModel _$RoutesLegsItemModelFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'RoutesLegsItemModel',
      json,
      ($checkedConvert) {
        final val = RoutesLegsItemModel(
          distanceMeters: $checkedConvert('distanceMeters', (v) => v as int),
          duration: $checkedConvert('duration', (v) => v as String),
          staticDuration: $checkedConvert('staticDuration', (v) => v as String),
          polyline: $checkedConvert('polyline',
              (v) => RoutesLegsPointsModel.fromJson(v as Map<String, dynamic>)),
          startLocation: $checkedConvert('startLocation',
              (v) => RoutesLegsLatLngModel.fromJson(v as Map<String, dynamic>)),
          endLocation: $checkedConvert('endLocation',
              (v) => RoutesLegsLatLngModel.fromJson(v as Map<String, dynamic>)),
        );
        return val;
      },
    );

Map<String, dynamic> _$RoutesLegsItemModelToJson(
        RoutesLegsItemModel instance) =>
    <String, dynamic>{
      'distanceMeters': instance.distanceMeters,
      'duration': instance.duration,
      'staticDuration': instance.staticDuration,
      'polyline': instance.polyline.toJson(),
      'startLocation': instance.startLocation.toJson(),
      'endLocation': instance.endLocation.toJson(),
    };
