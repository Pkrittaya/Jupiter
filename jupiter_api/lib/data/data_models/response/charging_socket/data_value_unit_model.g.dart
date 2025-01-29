// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_value_unit_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataValueUnitModel _$DataValueUnitModelFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'DataValueUnitModel',
      json,
      ($checkedConvert) {
        final val = DataValueUnitModel(
          value: $checkedConvert('value', (v) => (v as num).toDouble()),
          unit: $checkedConvert('unit', (v) => v as String),
        );
        return val;
      },
    );

Map<String, dynamic> _$DataValueUnitModelToJson(DataValueUnitModel instance) =>
    <String, dynamic>{
      'value': instance.value,
      'unit': instance.unit,
    };
