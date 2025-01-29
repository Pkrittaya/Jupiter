// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TokenModel _$TokenModelFromJson(Map<String, dynamic> json) => $checkedCreate(
      'TokenModel',
      json,
      ($checkedConvert) {
        final val = TokenModel(
          refreshToken: $checkedConvert('refresh_token', (v) => v as String),
          accessToken: $checkedConvert('access_token', (v) => v as String),
        );
        return val;
      },
      fieldKeyMap: const {
        'refreshToken': 'refresh_token',
        'accessToken': 'access_token'
      },
    );

Map<String, dynamic> _$TokenModelToJson(TokenModel instance) =>
    <String, dynamic>{
      'refresh_token': instance.refreshToken,
      'access_token': instance.accessToken,
    };
