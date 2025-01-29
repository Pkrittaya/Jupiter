// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'route_planning_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RoutePlanningDataModel _$RoutePlanningDataModelFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      'RoutePlanningDataModel',
      json,
      ($checkedConvert) {
        final val = RoutePlanningDataModel(
          legs: $checkedConvert(
              'legs',
              (v) => (v as List<dynamic>)
                  .map((e) =>
                      RoutesLegsItemModel.fromJson(e as Map<String, dynamic>))
                  .toList()),
          polyline: $checkedConvert('polyline',
              (v) => RoutesLegsPointsModel.fromJson(v as Map<String, dynamic>)),
          distanceMeters: $checkedConvert('distanceMeters', (v) => v as int),
          duration: $checkedConvert('duration', (v) => v as String),
          staticDuration: $checkedConvert('staticDuration', (v) => v as String),
        );
        return val;
      },
    );

Map<String, dynamic> _$RoutePlanningDataModelToJson(
        RoutePlanningDataModel instance) =>
    <String, dynamic>{
      'distanceMeters': instance.distanceMeters,
      'duration': instance.duration,
      'staticDuration': instance.staticDuration,
      'legs': instance.legs.map((e) => e.toJson()).toList(),
      'polyline': instance.polyline.toJson(),
    };
