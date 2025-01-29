// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fleet_detail_card_form.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FleetDetailCardForm _$FleetDetailCardFormFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'FleetDetailCardForm',
      json,
      ($checkedConvert) {
        final val = FleetDetailCardForm(
          fleetNo: $checkedConvert('fleet_no', (v) => v as int),
          fleetCardNo: $checkedConvert('fleet_card_no', (v) => v as String),
        );
        return val;
      },
      fieldKeyMap: const {
        'fleetNo': 'fleet_no',
        'fleetCardNo': 'fleet_card_no'
      },
    );

Map<String, dynamic> _$FleetDetailCardFormToJson(
        FleetDetailCardForm instance) =>
    <String, dynamic>{
      'fleet_no': instance.fleetNo,
      'fleet_card_no': instance.fleetCardNo,
    };
