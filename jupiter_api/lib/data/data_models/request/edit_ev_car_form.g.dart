// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edit_ev_car_form.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EditEvCarForm _$EditEvCarFormFromJson(Map<String, dynamic> json) =>
    EditEvCarForm(
      username: json['username'] as String,
      orgCode: json['org_code'] as String,
      licensePlateCurrent: json['license_plate_current'] as String,
      licensePlate: json['license_plate'] as String,
      provinceCurrent: json['province_current'] as String,
      province: json['province'] as String,
      defalut: json['defalut'] as bool,
      vehicleNoCurrent: json['vehicle_no_current'] as int,
      vehicleNo: json['vehicle_no'] as int,
    );

Map<String, dynamic> _$EditEvCarFormToJson(EditEvCarForm instance) =>
    <String, dynamic>{
      'org_code': instance.orgCode,
      'username': instance.username,
      'license_plate_current': instance.licensePlateCurrent,
      'license_plate': instance.licensePlate,
      'province_current': instance.provinceCurrent,
      'province': instance.province,
      'defalut': instance.defalut,
      'vehicle_no_current': instance.vehicleNoCurrent,
      'vehicle_no': instance.vehicleNo,
    };
