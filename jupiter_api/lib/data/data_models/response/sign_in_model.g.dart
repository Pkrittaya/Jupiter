// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_in_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignInModel _$SignInModelFromJson(Map<String, dynamic> json) => $checkedCreate(
      'SignInModel',
      json,
      ($checkedConvert) {
        final val = SignInModel(
          $checkedConvert(
              'token', (v) => TokenModel.fromJson(v as Map<String, dynamic>)),
          message: $checkedConvert('message', (v) => v as String),
        );
        return val;
      },
    );

Map<String, dynamic> _$SignInModelToJson(SignInModel instance) =>
    <String, dynamic>{
      'message': instance.message,
      'token': instance.token.toJson(),
    };
