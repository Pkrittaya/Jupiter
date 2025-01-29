// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fleet_no_form.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FleetNoForm _$FleetNoFormFromJson(Map<String, dynamic> json) => $checkedCreate(
      'FleetNoForm',
      json,
      ($checkedConvert) {
        final val = FleetNoForm(
          fleetNo: $checkedConvert('fleet_no', (v) => v as int),
        );
        return val;
      },
      fieldKeyMap: const {'fleetNo': 'fleet_no'},
    );

Map<String, dynamic> _$FleetNoFormToJson(FleetNoForm instance) =>
    <String, dynamic>{
      'fleet_no': instance.fleetNo,
    };
