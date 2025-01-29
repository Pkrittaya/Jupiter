// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_type_form.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentTypeForm _$PaymentTypeFormFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'PaymentTypeForm',
      json,
      ($checkedConvert) {
        final val = PaymentTypeForm(
          type: $checkedConvert('type', (v) => v as String?),
          display: $checkedConvert('display', (v) => v as String?),
          token: $checkedConvert('token', (v) => v as String?),
          brand: $checkedConvert('brand', (v) => v as String?),
          name: $checkedConvert('name', (v) => v as String?),
        );
        return val;
      },
    );

Map<String, dynamic> _$PaymentTypeFormToJson(PaymentTypeForm instance) =>
    <String, dynamic>{
      'type': instance.type,
      'display': instance.display,
      'token': instance.token,
      'brand': instance.brand,
      'name': instance.name,
    };
