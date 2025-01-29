// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'charging_mode_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChargingModeModel _$ChargingModeModelFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'ChargingModeModel',
      json,
      ($checkedConvert) {
        final val = ChargingModeModel(
          mode: $checkedConvert('mode', (v) => v as String),
          power: $checkedConvert('power', (v) => (v as num).toDouble()),
          powerUnit: $checkedConvert('power_unit', (v) => v as String),
          price: $checkedConvert('price', (v) => (v as num).toDouble()),
          priceUnit: $checkedConvert('price_unit', (v) => v as String),
        );
        return val;
      },
      fieldKeyMap: const {'powerUnit': 'power_unit', 'priceUnit': 'price_unit'},
    );

Map<String, dynamic> _$ChargingModeModelToJson(ChargingModeModel instance) =>
    <String, dynamic>{
      'mode': instance.mode,
      'power': instance.power,
      'power_unit': instance.powerUnit,
      'price': instance.price,
      'price_unit': instance.priceUnit,
    };
