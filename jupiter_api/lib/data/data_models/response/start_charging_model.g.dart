// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'start_charging_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StartChargingModel _$StartChargingModelFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'StartChargingModel',
      json,
      ($checkedConvert) {
        final val = StartChargingModel(
          connector: $checkedConvert(
              'connector',
              (v) => v == null
                  ? null
                  : ConnectorInformationModel.fromJson(
                      v as Map<String, dynamic>)),
          payment_type: $checkedConvert(
              'payment_type',
              (v) => (v as List<dynamic>?)
                  ?.map((e) =>
                      PaymentTypeModel.fromJson(e as Map<String, dynamic>))
                  .toList()),
          optionalType: $checkedConvert('optional_type', (v) => v as String),
          optionalValue:
              $checkedConvert('optional_value', (v) => (v as num).toDouble()),
          carSelect: $checkedConvert(
              'car_select',
              (v) => (v as List<dynamic>)
                  .map(
                      (e) => CarSelectModel.fromJson(e as Map<String, dynamic>))
                  .toList()),
        );
        return val;
      },
      fieldKeyMap: const {
        'optionalType': 'optional_type',
        'optionalValue': 'optional_value',
        'carSelect': 'car_select'
      },
    );

Map<String, dynamic> _$StartChargingModelToJson(StartChargingModel instance) =>
    <String, dynamic>{
      'optional_type': instance.optionalType,
      'optional_value': instance.optionalValue,
      'car_select': instance.carSelect.map((e) => e.toJson()).toList(),
      'connector': instance.connector?.toJson(),
      'payment_type': instance.payment_type?.map((e) => e.toJson()).toList(),
    };
