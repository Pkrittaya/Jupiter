// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'route_planning_location_form.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RoutePlanningLocationForm _$RoutePlanningLocationFormFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      'RoutePlanningLocationForm',
      json,
      ($checkedConvert) {
        final val = RoutePlanningLocationForm(
          location: $checkedConvert(
              'location',
              (v) =>
                  RoutePlanningLatLngForm.fromJson(v as Map<String, dynamic>)),
        );
        return val;
      },
    );

Map<String, dynamic> _$RoutePlanningLocationFormToJson(
        RoutePlanningLocationForm instance) =>
    <String, dynamic>{
      'location': instance.location.toJson(),
    };
