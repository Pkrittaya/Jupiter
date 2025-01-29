// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fleet_charger_form.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FleetChargerForm _$FleetChargerFormFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'FleetChargerForm',
      json,
      ($checkedConvert) {
        final val = FleetChargerForm(
          fleetNo: $checkedConvert('fleet_no', (v) => v as int),
          stationId: $checkedConvert('station_id', (v) => v as String),
        );
        return val;
      },
      fieldKeyMap: const {'fleetNo': 'fleet_no', 'stationId': 'station_id'},
    );

Map<String, dynamic> _$FleetChargerFormToJson(FleetChargerForm instance) =>
    <String, dynamic>{
      'fleet_no': instance.fleetNo,
      'station_id': instance.stationId,
    };
