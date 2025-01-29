// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'route_planning_modifiers_form.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RoutePlanningModifiersForm _$RoutePlanningModifiersFormFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      'RoutePlanningModifiersForm',
      json,
      ($checkedConvert) {
        final val = RoutePlanningModifiersForm(
          avoidHighways: $checkedConvert('avoidHighways', (v) => v as bool),
          avoidTolls: $checkedConvert('avoidTolls', (v) => v as bool),
          avoidFerries: $checkedConvert('avoidFerries', (v) => v as bool),
        );
        return val;
      },
    );

Map<String, dynamic> _$RoutePlanningModifiersFormToJson(
        RoutePlanningModifiersForm instance) =>
    <String, dynamic>{
      'avoidHighways': instance.avoidHighways,
      'avoidTolls': instance.avoidTolls,
      'avoidFerries': instance.avoidFerries,
    };
