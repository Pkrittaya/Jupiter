// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_car_select_fleet_form.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListCarSelectFleetForm _$ListCarSelectFleetFormFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      'ListCarSelectFleetForm',
      json,
      ($checkedConvert) {
        final val = ListCarSelectFleetForm(
          fleetNo: $checkedConvert('fleet_no', (v) => v as int),
        );
        return val;
      },
      fieldKeyMap: const {'fleetNo': 'fleet_no'},
    );

Map<String, dynamic> _$ListCarSelectFleetFormToJson(
        ListCarSelectFleetForm instance) =>
    <String, dynamic>{
      'fleet_no': instance.fleetNo,
    };
