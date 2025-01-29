// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'default_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DefaultModel _$DefaultModelFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'DefaultModel',
      json,
      ($checkedConvert) {
        final val = DefaultModel(
          message: $checkedConvert('message', (v) => v as String),
        );
        return val;
      },
    );

Map<String, dynamic> _$DefaultModelToJson(DefaultModel instance) =>
    <String, dynamic>{
      'message': instance.message,
    };
