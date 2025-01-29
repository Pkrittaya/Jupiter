// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'validated_pin_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ValidatedPinModel _$ValidatedPinModelFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'ValidatedPinModel',
      json,
      ($checkedConvert) {
        final val = ValidatedPinModel(
          validated: $checkedConvert('validated', (v) => v as bool),
          destination: $checkedConvert('destination', (v) => v as String),
        );
        return val;
      },
    );

Map<String, dynamic> _$ValidatedPinModelToJson(ValidatedPinModel instance) =>
    <String, dynamic>{
      'validated': instance.validated,
      'destination': instance.destination,
    };
