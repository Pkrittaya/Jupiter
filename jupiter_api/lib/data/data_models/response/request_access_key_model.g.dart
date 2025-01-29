// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_access_key_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestAccessKeyModel _$RequestAccessKeyModelFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      'RequestAccessKeyModel',
      json,
      ($checkedConvert) {
        final val = RequestAccessKeyModel(
          $checkedConvert('token',
              (v) => AccessTokenModel.fromJson(v as Map<String, dynamic>)),
          message: $checkedConvert('message', (v) => v as String),
        );
        return val;
      },
    );

Map<String, dynamic> _$RequestAccessKeyModelToJson(
        RequestAccessKeyModel instance) =>
    <String, dynamic>{
      'message': instance.message,
      'token': instance.token.toJson(),
    };
