// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kbank_token.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KBankToken _$KBankTokenFromJson(Map<String, dynamic> json) => $checkedCreate(
      'KBankToken',
      json,
      ($checkedConvert) {
        final val = KBankToken(
          token: $checkedConvert('token', (v) => v as String),
          saveCard: $checkedConvert('saveCard', (v) => v as bool?),
          mid: $checkedConvert('mid', (v) => v as String?),
        );
        return val;
      },
    );

Map<String, dynamic> _$KBankTokenToJson(KBankToken instance) =>
    <String, dynamic>{
      'token': instance.token,
      'saveCard': instance.saveCard,
      'mid': instance.mid,
    };
