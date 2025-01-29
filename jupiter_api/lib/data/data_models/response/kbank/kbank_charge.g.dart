// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kbank_charge.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KBankCharge _$KBankChargeFromJson(Map<String, dynamic> json) => $checkedCreate(
      'KBankCharge',
      json,
      ($checkedConvert) {
        final val = KBankCharge(
          token: $checkedConvert('token', (v) => v as String),
          saveCard: $checkedConvert('saveCard', (v) => v as String?),
          status: $checkedConvert('status', (v) => v as String?),
          objectId: $checkedConvert('objectId', (v) => v as String),
          message: $checkedConvert('message', (v) => v as String?),
        );
        return val;
      },
    );

Map<String, dynamic> _$KBankChargeToJson(KBankCharge instance) =>
    <String, dynamic>{
      'token': instance.token,
      'saveCard': instance.saveCard,
      'status': instance.status,
      'objectId': instance.objectId,
      'message': instance.message,
    };
