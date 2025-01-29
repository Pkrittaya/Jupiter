// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'optional_detail_form.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OptionalDetailForm _$OptionalDetailFormFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'OptionalDetailForm',
      json,
      ($checkedConvert) {
        final val = OptionalDetailForm(
          optionalType: $checkedConvert('optional_type', (v) => v as String),
          optionalValue:
              $checkedConvert('optional_value', (v) => (v as num).toDouble()),
          optionalUnit: $checkedConvert('optional_unit', (v) => v as String),
        );
        return val;
      },
      fieldKeyMap: const {
        'optionalType': 'optional_type',
        'optionalValue': 'optional_value',
        'optionalUnit': 'optional_unit'
      },
    );

Map<String, dynamic> _$OptionalDetailFormToJson(OptionalDetailForm instance) =>
    <String, dynamic>{
      'optional_type': instance.optionalType,
      'optional_value': instance.optionalValue,
      'optional_unit': instance.optionalUnit,
    };
