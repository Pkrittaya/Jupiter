// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'route_planning_latlng_form.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RoutePlanningLatLngForm _$RoutePlanningLatLngFormFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      'RoutePlanningLatLngForm',
      json,
      ($checkedConvert) {
        final val = RoutePlanningLatLngForm(
          latLng: $checkedConvert(
              'latLng',
              (v) => RoutePlanningLatLngDataForm.fromJson(
                  v as Map<String, dynamic>)),
        );
        return val;
      },
    );

Map<String, dynamic> _$RoutePlanningLatLngFormToJson(
        RoutePlanningLatLngForm instance) =>
    <String, dynamic>{
      'latLng': instance.latLng.toJson(),
    };
