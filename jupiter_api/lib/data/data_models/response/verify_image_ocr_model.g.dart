// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verify_image_ocr_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VerifyImageOcrModel _$VerifyImageOcrModelFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'VerifyImageOcrModel',
      json,
      ($checkedConvert) {
        final val = VerifyImageOcrModel(
          status: $checkedConvert('status', (v) => v as bool),
          licensePlate: $checkedConvert('license_plate', (v) => v as String),
          refId: $checkedConvert('ref_id', (v) => v as String),
        );
        return val;
      },
      fieldKeyMap: const {'licensePlate': 'license_plate', 'refId': 'ref_id'},
    );

Map<String, dynamic> _$VerifyImageOcrModelToJson(
        VerifyImageOcrModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'license_plate': instance.licensePlate,
      'ref_id': instance.refId,
    };
