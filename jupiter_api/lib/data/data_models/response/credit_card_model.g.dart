// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'credit_card_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreditCardModel _$CreditCardModelFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'CreditCardModel',
      json,
      ($checkedConvert) {
        final val = CreditCardModel(
          display: $checkedConvert('display', (v) => v as String),
          cardBrand: $checkedConvert('card_brand', (v) => v as String),
          cardExpired: $checkedConvert('card_expired', (v) => v as String),
          cardHashing: $checkedConvert('card_hashing', (v) => v as String),
          defalut: $checkedConvert('defalut', (v) => v as bool),
          type: $checkedConvert('type', (v) => v as String),
          name: $checkedConvert('name', (v) => v as String),
        );
        return val;
      },
      fieldKeyMap: const {
        'cardBrand': 'card_brand',
        'cardExpired': 'card_expired',
        'cardHashing': 'card_hashing'
      },
    );

Map<String, dynamic> _$CreditCardModelToJson(CreditCardModel instance) =>
    <String, dynamic>{
      'display': instance.display,
      'card_brand': instance.cardBrand,
      'card_expired': instance.cardExpired,
      'card_hashing': instance.cardHashing,
      'defalut': instance.defalut,
      'type': instance.type,
      'name': instance.name,
    };
