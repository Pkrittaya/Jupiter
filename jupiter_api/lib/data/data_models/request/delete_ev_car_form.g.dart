// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delete_ev_car_form.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeleteEvCarForm _$DeleteEvCarFormFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'DeleteEvCarForm',
      json,
      ($checkedConvert) {
        final val = DeleteEvCarForm(
          username: $checkedConvert('username', (v) => v as String),
          orgCode: $checkedConvert('org_code', (v) => v as String),
          licensePlate: $checkedConvert('license_plate', (v) => v as String),
          province: $checkedConvert('province', (v) => v as String),
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

Map<String, dynamic> _$DeleteEvCarFormToJson(DeleteEvCarForm instance) =>
    <String, dynamic>{
      'org_code': instance.orgCode,
      'username': instance.username,
      'license_plate': instance.licensePlate,
      'province': instance.province,
      'vehicle_no': instance.vehicleNo,
    };
