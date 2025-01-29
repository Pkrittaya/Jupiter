// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'route_legs_points_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RoutesLegsPointsModel _$RoutesLegsPointsModelFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      'RoutesLegsPointsModel',
      json,
      ($checkedConvert) {
        final val = RoutesLegsPointsModel(
          encodedPolyline:
              $checkedConvert('encodedPolyline', (v) => v as String),
        );
        return val;
      },
    );

Map<String, dynamic> _$RoutesLegsPointsModelToJson(
        RoutesLegsPointsModel instance) =>
    <String, dynamic>{
      'encodedPolyline': instance.encodedPolyline,
    };
