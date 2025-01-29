// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'route_planning_form.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RoutePlanningForm _$RoutePlanningFormFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'RoutePlanningForm',
      json,
      ($checkedConvert) {
        final val = RoutePlanningForm(
          data: $checkedConvert('data',
              (v) => RoutePlanningDataForm.fromJson(v as Map<String, dynamic>)),
        );
        return val;
      },
    );

Map<String, dynamic> _$RoutePlanningFormToJson(RoutePlanningForm instance) =>
    <String, dynamic>{
      'data': instance.data.toJson(),
    };
