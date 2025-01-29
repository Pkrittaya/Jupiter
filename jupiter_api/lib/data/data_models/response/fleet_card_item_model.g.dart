// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fleet_card_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FleetCardItemModel _$FleetCardItemModelFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'FleetCardItemModel',
      json,
      ($checkedConvert) {
        final val = FleetCardItemModel(
          fleetNo: $checkedConvert('fleet_no', (v) => v as int),
          fleetCardNo: $checkedConvert('fleet_card_no', (v) => v as String),
          statusCharging: $checkedConvert('status_charging', (v) => v as bool),
          credit: $checkedConvert('credit', (v) => (v as num).toDouble()),
          available: $checkedConvert('available', (v) => (v as num).toDouble()),
          expired: $checkedConvert('expired', (v) => v as String),
          image: $checkedConvert('image', (v) => v as String),
          status: $checkedConvert('status', (v) => v as String),
          fleetCardType: $checkedConvert('fleet_card_type', (v) => v as String),
        );
        return val;
      },
      fieldKeyMap: const {
        'fleetNo': 'fleet_no',
        'fleetCardNo': 'fleet_card_no',
        'statusCharging': 'status_charging',
        'fleetCardType': 'fleet_card_type'
      },
    );

Map<String, dynamic> _$FleetCardItemModelToJson(FleetCardItemModel instance) =>
    <String, dynamic>{
      'fleet_no': instance.fleetNo,
      'fleet_card_no': instance.fleetCardNo,
      'status_charging': instance.statusCharging,
      'credit': instance.credit,
      'available': instance.available,
      'expired': instance.expired,
      'image': instance.image,
      'status': instance.status,
      'fleet_card_type': instance.fleetCardType,
    };
