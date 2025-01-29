// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'route_planning_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RoutePlanningModel _$RoutePlanningModelFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'RoutePlanningModel',
      json,
      ($checkedConvert) {
        final val = RoutePlanningModel(
          routes: $checkedConvert(
              'routes',
              (v) => (v as List<dynamic>)
                  .map((e) => RoutePlanningDataModel.fromJson(
                      e as Map<String, dynamic>))
                  .toList()),
        );
        return val;
      },
    );

Map<String, dynamic> _$RoutePlanningModelToJson(RoutePlanningModel instance) =>
    <String, dynamic>{
      'routes': instance.routes.map((e) => e.toJson()).toList(),
    };
