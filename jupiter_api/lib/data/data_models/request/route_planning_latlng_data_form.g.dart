// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'route_planning_latlng_data_form.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RoutePlanningLatLngDataForm _$RoutePlanningLatLngDataFormFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      'RoutePlanningLatLngDataForm',
      json,
      ($checkedConvert) {
        final val = RoutePlanningLatLngDataForm(
          latitude: $checkedConvert('latitude', (v) => (v as num).toDouble()),
          longitude: $checkedConvert('longitude', (v) => (v as num).toDouble()),
        );
        return val;
      },
    );

Map<String, dynamic> _$RoutePlanningLatLngDataFormToJson(
        RoutePlanningLatLngDataForm instance) =>
    <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };
