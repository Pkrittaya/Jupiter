// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'car_model_master_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CarModelMasterModel _$CarModelMasterModelFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'CarModelMasterModel',
      json,
      ($checkedConvert) {
        final val = CarModelMasterModel(
          name: $checkedConvert('name', (v) => v as String),
          image: $checkedConvert('image', (v) => v as String),
          batteryCapacity:
              $checkedConvert('battery_capacity', (v) => v as String?),
          maximumChargingPowerAc:
              $checkedConvert('maximum_charging_power_ac', (v) => v as String?),
          maximumChargingPowerDc:
              $checkedConvert('maximum_charging_power_dc', (v) => v as String?),
          maxDistance: $checkedConvert('max_distance', (v) => v as String?),
          vehicleNo: $checkedConvert('vehicle_no', (v) => v as int?),
        );
        return val;
      },
      fieldKeyMap: const {
        'batteryCapacity': 'battery_capacity',
        'maximumChargingPowerAc': 'maximum_charging_power_ac',
        'maximumChargingPowerDc': 'maximum_charging_power_dc',
        'maxDistance': 'max_distance',
        'vehicleNo': 'vehicle_no'
      },
    );

Map<String, dynamic> _$CarModelMasterModelToJson(
        CarModelMasterModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'image': instance.image,
      'battery_capacity': instance.batteryCapacity,
      'maximum_charging_power_ac': instance.maximumChargingPowerAc,
      'maximum_charging_power_dc': instance.maximumChargingPowerDc,
      'max_distance': instance.maxDistance,
      'vehicle_no': instance.vehicleNo,
    };
