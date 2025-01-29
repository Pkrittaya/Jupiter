// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verify_fleet_card_form.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VerifyFleetCardForm _$VerifyFleetCardFormFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'VerifyFleetCardForm',
      json,
      ($checkedConvert) {
        final val = VerifyFleetCardForm(
          cardNo: $checkedConvert('card_no', (v) => v as String),
          expiredDate: $checkedConvert('expired_date', (v) => v as String),
        );
        return val;
      },
      fieldKeyMap: const {'cardNo': 'card_no', 'expiredDate': 'expired_date'},
    );

Map<String, dynamic> _$VerifyFleetCardFormToJson(
        VerifyFleetCardForm instance) =>
    <String, dynamic>{
      'card_no': instance.cardNo,
      'expired_date': instance.expiredDate,
    };
