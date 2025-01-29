// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'car_select_fleet_form.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CarSelectFleetForm _$CarSelectFleetFormFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'CarSelectFleetForm',
      json,
      ($checkedConvert) {
        final val = CarSelectFleetForm(
          vehicleNo: $checkedConvert('vehicle_no', (v) => v as int),
          licensePlate: $checkedConvert('license_plate', (v) => v as String),
          province: $checkedConvert('province', (v) => v as String),
        );
        return val;
      },
      fieldKeyMap: const {
        'vehicleNo': 'vehicle_no',
        'licensePlate': 'license_plate'
      },
    );

Map<String, dynamic> _$CarSelectFleetFormToJson(CarSelectFleetForm instance) =>
    <String, dynamic>{
      'vehicle_no': instance.vehicleNo,
      'license_plate': instance.licensePlate,
      'province': instance.province,
    };
