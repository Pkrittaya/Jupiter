// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'car_select_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CarSelectModel _$CarSelectModelFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'CarSelectModel',
      json,
      ($checkedConvert) {
        final val = CarSelectModel(
          brand: $checkedConvert('brand', (v) => v as String?),
          licensePlate: $checkedConvert('license_plate', (v) => v as String?),
          model: $checkedConvert('model', (v) => v as String?),
          defalut: $checkedConvert('defalut', (v) => v as bool?),
          province: $checkedConvert('province', (v) => v as String?),
          maxDistance:
              $checkedConvert('max_distance', (v) => (v as num?)?.toDouble()),
          batteryCapacity: $checkedConvert(
              'battery_capacity', (v) => (v as num?)?.toDouble()),
          maximumChargingPowerAc: $checkedConvert(
              'maximum_charging_power_ac', (v) => (v as num?)?.toDouble()),
          maximumChargingPowerDc: $checkedConvert(
              'maximum_charging_power_dc', (v) => (v as num?)?.toDouble()),
          image: $checkedConvert('image', (v) => v as String?),
          vehicleNo: $checkedConvert('vehicle_no', (v) => v as int),
        );
        return val;
      },
      fieldKeyMap: const {
        'licensePlate': 'license_plate',
        'maxDistance': 'max_distance',
        'batteryCapacity': 'battery_capacity',
        'maximumChargingPowerAc': 'maximum_charging_power_ac',
        'maximumChargingPowerDc': 'maximum_charging_power_dc',
        'vehicleNo': 'vehicle_no'
      },
    );

Map<String, dynamic> _$CarSelectModelToJson(CarSelectModel instance) =>
    <String, dynamic>{
      'brand': instance.brand,
      'license_plate': instance.licensePlate,
      'model': instance.model,
      'defalut': instance.defalut,
      'battery_capacity': instance.batteryCapacity,
      'max_distance': instance.maxDistance,
      'maximum_charging_power_ac': instance.maximumChargingPowerAc,
      'maximum_charging_power_dc': instance.maximumChargingPowerDc,
      'image': instance.image,
      'province': instance.province,
      'vehicle_no': instance.vehicleNo,
    };
