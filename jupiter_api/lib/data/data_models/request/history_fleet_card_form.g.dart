// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_fleet_card_form.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HistoryFleetCardForm _$HistoryFleetCardFormFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      'HistoryFleetCardForm',
      json,
      ($checkedConvert) {
        final val = HistoryFleetCardForm(
          fleetNo: $checkedConvert('fleet_no', (v) => v as int),
          refCode: $checkedConvert('ref_code', (v) => v as String),
        );
        return val;
      },
      fieldKeyMap: const {'fleetNo': 'fleet_no', 'refCode': 'ref_code'},
    );

Map<String, dynamic> _$HistoryFleetCardFormToJson(
        HistoryFleetCardForm instance) =>
    <String, dynamic>{
      'fleet_no': instance.fleetNo,
      'ref_code': instance.refCode,
    };
