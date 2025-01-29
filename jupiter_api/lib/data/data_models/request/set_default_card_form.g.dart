// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'set_default_card_form.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SetDefaultCardForm _$SetDefaultCardFormFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'SetDefaultCardForm',
      json,
      ($checkedConvert) {
        final val = SetDefaultCardForm(
          username: $checkedConvert('username', (v) => v as String),
          orgCode: $checkedConvert('org_code', (v) => v as String),
          cardHashing: $checkedConvert('card_hashing', (v) => v as String),
          defalut: $checkedConvert('defalut', (v) => v as bool),
        );
        return val;
      },
      fieldKeyMap: const {'orgCode': 'org_code', 'cardHashing': 'card_hashing'},
    );

Map<String, dynamic> _$SetDefaultCardFormToJson(SetDefaultCardForm instance) =>
    <String, dynamic>{
      'org_code': instance.orgCode,
      'username': instance.username,
      'card_hashing': instance.cardHashing,
      'defalut': instance.defalut,
    };
