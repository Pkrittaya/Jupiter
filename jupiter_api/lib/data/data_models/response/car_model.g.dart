// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'car_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CarModel _$CarModelFromJson(Map<String, dynamic> json) => $checkedCreate(
      'CarModel',
      json,
      ($checkedConvert) {
        final val = CarModel(
          brand: $checkedConvert('brand', (v) => v as String),
          licensePlate: $checkedConvert('license_plate', (v) => v as String),
          model: $checkedConvert('model', (v) => v as String),
          orgCode: $checkedConvert('org_code', (v) => v as String),
          username: $checkedConvert('username', (v) => v as String),
          defalut: $checkedConvert('defalut', (v) => v as bool),
          province: $checkedConvert('province', (v) => v as String),
          vehicleNo: $checkedConvert('vehicle_no', (v) => v as int),
          image: $checkedConvert('image', (v) => v as String?),
        );
        return val;
      },
      fieldKeyMap: const {
        'licensePlate': 'license_plate',
        'orgCode': 'org_code',
        'vehicleNo': 'vehicle_no'
      },
    );

Map<String, dynamic> _$CarModelToJson(CarModel instance) => <String, dynamic>{
      'brand': instance.brand,
      'license_plate': instance.licensePlate,
      'model': instance.model,
      'org_code': instance.orgCode,
      'username': instance.username,
      'defalut': instance.defalut,
      'province': instance.province,
      'image': instance.image,
      'vehicle_no': instance.vehicleNo,
    };
