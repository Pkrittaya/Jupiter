// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'route_planning_data_form.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RoutePlanningDataForm _$RoutePlanningDataFormFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      'RoutePlanningDataForm',
      json,
      ($checkedConvert) {
        final val = RoutePlanningDataForm(
          origin: $checkedConvert(
              'origin',
              (v) => RoutePlanningLocationForm.fromJson(
                  v as Map<String, dynamic>)),
          destination: $checkedConvert(
              'destination',
              (v) => RoutePlanningLocationForm.fromJson(
                  v as Map<String, dynamic>)),
          intermediates: $checkedConvert(
              'intermediates',
              (v) => (v as List<dynamic>)
                  .map((e) => RoutePlanningLocationForm.fromJson(
                      e as Map<String, dynamic>))
                  .toList()),
          travelMode: $checkedConvert('travelMode', (v) => v as String),
          routingPreference:
              $checkedConvert('routingPreference', (v) => v as String),
          computeAlternativeRoutes:
              $checkedConvert('computeAlternativeRoutes', (v) => v as bool),
          routeModifiers: $checkedConvert(
              'routeModifiers',
              (v) => RoutePlanningModifiersForm.fromJson(
                  v as Map<String, dynamic>)),
          languageCode: $checkedConvert('languageCode', (v) => v as String),
        );
        return val;
      },
    );

Map<String, dynamic> _$RoutePlanningDataFormToJson(
        RoutePlanningDataForm instance) =>
    <String, dynamic>{
      'origin': instance.origin.toJson(),
      'destination': instance.destination.toJson(),
      'intermediates': instance.intermediates.map((e) => e.toJson()).toList(),
      'travelMode': instance.travelMode,
      'routingPreference': instance.routingPreference,
      'computeAlternativeRoutes': instance.computeAlternativeRoutes,
      'routeModifiers': instance.routeModifiers.toJson(),
      'languageCode': instance.languageCode,
    };
