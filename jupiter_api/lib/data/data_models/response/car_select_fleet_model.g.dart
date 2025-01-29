// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'car_select_fleet_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CarSelectFleetModel _$CarSelectFleetModelFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'CarSelectFleetModel',
      json,
      ($checkedConvert) {
        final val = CarSelectFleetModel(
          brand: $checkedConvert('brand', (v) => v as String?),
          licensePlate: $checkedConvert('license_plate', (v) => v as String?),
          model: $checkedConvert('model', (v) => v as String?),
          province: $checkedConvert('province', (v) => v as String?),
          image: $checkedConvert('image', (v) => v as String?),
          vehicleNo: $checkedConvert('vehicle_no', (v) => v as int),
        );
        return val;
      },
      fieldKeyMap: const {
        'licensePlate': 'license_plate',
        'vehicleNo': 'vehicle_no'
      },
    );

Map<String, dynamic> _$CarSelectFleetModelToJson(
        CarSelectFleetModel instance) =>
    <String, dynamic>{
      'brand': instance.brand,
      'license_plate': instance.licensePlate,
      'model': instance.model,
      'image': instance.image,
      'province': instance.province,
      'vehicle_no': instance.vehicleNo,
    };
