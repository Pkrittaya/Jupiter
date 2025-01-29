// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileModel _$ProfileModelFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'ProfileModel',
      json,
      ($checkedConvert) {
        final val = ProfileModel(
          username: $checkedConvert('username', (v) => v as String),
          name: $checkedConvert('name', (v) => v as String),
          lastname: $checkedConvert('lastname', (v) => v as String),
          gender: $checkedConvert('gender', (v) => v as String),
          dateofbirth: $checkedConvert('dateofbirth', (v) => v as String),
          telphonenumber: $checkedConvert('telphonenumber', (v) => v as String),
          images: $checkedConvert('images', (v) => v as String),
        );
        return val;
      },
    );

Map<String, dynamic> _$ProfileModelToJson(ProfileModel instance) =>
    <String, dynamic>{
      'username': instance.username,
      'name': instance.name,
      'lastname': instance.lastname,
      'gender': instance.gender,
      'dateofbirth': instance.dateofbirth,
      'telphonenumber': instance.telphonenumber,
      'images': instance.images,
    };
