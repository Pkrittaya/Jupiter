// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delete_card_payment_form.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeleteCardPaymentForm _$DeleteCardPaymentFormFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      'DeleteCardPaymentForm',
      json,
      ($checkedConvert) {
        final val = DeleteCardPaymentForm(
          username: $checkedConvert('username', (v) => v as String),
          orgCode: $checkedConvert('org_code', (v) => v as String),
          cardHashing: $checkedConvert('card_hashing', (v) => v as String),
        );
        return val;
      },
      fieldKeyMap: const {'orgCode': 'org_code', 'cardHashing': 'card_hashing'},
    );

Map<String, dynamic> _$DeleteCardPaymentFormToJson(
        DeleteCardPaymentForm instance) =>
    <String, dynamic>{
      'org_code': instance.orgCode,
      'username': instance.username,
      'card_hashing': instance.cardHashing,
    };
