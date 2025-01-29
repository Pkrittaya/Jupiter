// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_type_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentTypeModel _$PaymentTypeModelFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'PaymentTypeModel',
      json,
      ($checkedConvert) {
        final val = PaymentTypeModel(
          type: $checkedConvert('type', (v) => v as String?),
          display: $checkedConvert('display', (v) => v as String?),
          token: $checkedConvert('token', (v) => v as String?),
          brand: $checkedConvert('brand', (v) => v as String?),
          defalut: $checkedConvert('defalut', (v) => v as bool?),
          name: $checkedConvert('name', (v) => v as String?),
        );
        return val;
      },
    );

Map<String, dynamic> _$PaymentTypeModelToJson(PaymentTypeModel instance) =>
    <String, dynamic>{
      'type': instance.type,
      'display': instance.display,
      'token': instance.token,
      'brand': instance.brand,
      'defalut': instance.defalut,
      'name': instance.name,
    };
