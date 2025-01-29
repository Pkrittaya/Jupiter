// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'car_select_form.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CarSelectForm _$CarSelectFormFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'CarSelectForm',
      json,
      ($checkedConvert) {
        final val = CarSelectForm(
          vehicleNo: $checkedConvert('vehicle_no', (v) => v as int),
          brand: $checkedConvert('brand', (v) => v as String),
          licensePlate: $checkedConvert('license_plate', (v) => v as String),
          model: $checkedConvert('model', (v) => v as String),
          province: $checkedConvert('province', (v) => v as String),
          batteryCapacity:
              $checkedConvert('battery_capacity', (v) => (v as num).toDouble()),
          currentPercentBattery: $checkedConvert(
              'current_percent_battery', (v) => (v as num).toDouble()),
          maximumChargingPowerAc: $checkedConvert(
              'maximum_charging_power_ac', (v) => (v as num).toDouble()),
          maximumChargingPowerDc: $checkedConvert(
              'maximum_charging_power_dc', (v) => (v as num).toDouble()),
          image: $checkedConvert('image', (v) => v as String),
          maxDistance:
              $checkedConvert('max_distance', (v) => (v as num).toDouble()),
        );
        return val;
      },
      fieldKeyMap: const {
        'vehicleNo': 'vehicle_no',
        'licensePlate': 'license_plate',
        'batteryCapacity': 'battery_capacity',
        'currentPercentBattery': 'current_percent_battery',
        'maximumChargingPowerAc': 'maximum_charging_power_ac',
        'maximumChargingPowerDc': 'maximum_charging_power_dc',
        'maxDistance': 'max_distance'
      },
    );

Map<String, dynamic> _$CarSelectFormToJson(CarSelectForm instance) =>
    <String, dynamic>{
      'vehicle_no': instance.vehicleNo,
      'brand': instance.brand,
      'license_plate': instance.licensePlate,
      'model': instance.model,
      'battery_capacity': instance.batteryCapacity,
      'current_percent_battery': instance.currentPercentBattery,
      'maximum_charging_power_ac': instance.maximumChargingPowerAc,
      'maximum_charging_power_dc': instance.maximumChargingPowerDc,
      'image': instance.image,
      'province': instance.province,
      'max_distance': instance.maxDistance,
    };
