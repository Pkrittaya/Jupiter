// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'facility_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FacilityModel _$FacilityModelFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'FacilityModel',
      json,
      ($checkedConvert) {
        final val = FacilityModel(
          facilityName: $checkedConvert('facility_name', (v) => v as String),
          image: $checkedConvert('image', (v) => v as String),
        );
        return val;
      },
      fieldKeyMap: const {'facilityName': 'facility_name'},
    );

Map<String, dynamic> _$FacilityModelToJson(FacilityModel instance) =>
    <String, dynamic>{
      'facility_name': instance.facilityName,
      'image': instance.image,
    };
