// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'has_charging_fleet_card_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HasChargingFleetModel _$HasChargingFleetModelFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      'HasChargingFleetModel',
      json,
      ($checkedConvert) {
        final val = HasChargingFleetModel(
          chargingStatus: $checkedConvert('charging_status', (v) => v as bool),
        );
        return val;
      },
      fieldKeyMap: const {'chargingStatus': 'charging_status'},
    );

Map<String, dynamic> _$HasChargingFleetModelToJson(
        HasChargingFleetModel instance) =>
    <String, dynamic>{
      'charging_status': instance.chargingStatus,
    };
