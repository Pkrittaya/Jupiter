// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delete_ev_car_image_form.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeleteEvCarImageForm _$DeleteEvCarImageFormFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      'DeleteEvCarImageForm',
      json,
      ($checkedConvert) {
        final val = DeleteEvCarImageForm(
          username: $checkedConvert('username', (v) => v as String),
          orgCode: $checkedConvert('org_code', (v) => v as String),
          brand: $checkedConvert('brand', (v) => v as String),
          model: $checkedConvert('model', (v) => v as String),
          licensePlate: $checkedConvert('license_plate', (v) => v as String),
        );
        return val;
      },
      fieldKeyMap: const {
        'orgCode': 'org_code',
        'licensePlate': 'license_plate'
      },
    );

Map<String, dynamic> _$DeleteEvCarImageFormToJson(
        DeleteEvCarImageForm instance) =>
    <String, dynamic>{
      'org_code': instance.orgCode,
      'username': instance.username,
      'brand': instance.brand,
      'model': instance.model,
      'license_plate': instance.licensePlate,
    };
