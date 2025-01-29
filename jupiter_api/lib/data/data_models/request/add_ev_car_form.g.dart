// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_ev_car_form.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddEvCarForm _$AddEvCarFormFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'AddEvCarForm',
      json,
      ($checkedConvert) {
        final val = AddEvCarForm(
          username: $checkedConvert('username', (v) => v as String),
          orgCode: $checkedConvert('org_code', (v) => v as String),
          licensePlate: $checkedConvert('license_plate', (v) => v as String),
          province: $checkedConvert('province', (v) => v as String),
          defalut: $checkedConvert('defalut', (v) => v as bool),
          vehicleNo: $checkedConvert('vehicle_no', (v) => v as int),
        );
        return val;
      },
      fieldKeyMap: const {
        'orgCode': 'org_code',
        'licensePlate': 'license_plate',
        'vehicleNo': 'vehicle_no'
      },
    );

Map<String, dynamic> _$AddEvCarFormToJson(AddEvCarForm instance) =>
    <String, dynamic>{
      'org_code': instance.orgCode,
      'username': instance.username,
      'license_plate': instance.licensePlate,
      'province': instance.province,
      'defalut': instance.defalut,
      'vehicle_no': instance.vehicleNo,
    };
