// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verify_card_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VerifyCardModel _$VerifyCardModelFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'VerifyCardModel',
      json,
      ($checkedConvert) {
        final val = VerifyCardModel(
          message: $checkedConvert('message', (v) => v as String),
          url: $checkedConvert('url', (v) => v as String),
        );
        return val;
      },
    );

Map<String, dynamic> _$VerifyCardModelToJson(VerifyCardModel instance) =>
    <String, dynamic>{
      'message': instance.message,
      'url': instance.url,
    };
