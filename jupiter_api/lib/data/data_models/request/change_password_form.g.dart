// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'change_password_form.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChangePasswordForm _$ChangePasswordFormFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'ChangePasswordForm',
      json,
      ($checkedConvert) {
        final val = ChangePasswordForm(
          token: $checkedConvert('token', (v) => v as String),
          passwordCurrent:
              $checkedConvert('password_current', (v) => v as String),
          passwordNew: $checkedConvert('password_new', (v) => v as String),
        );
        return val;
      },
      fieldKeyMap: const {
        'passwordCurrent': 'password_current',
        'passwordNew': 'password_new'
      },
    );

Map<String, dynamic> _$ChangePasswordFormToJson(ChangePasswordForm instance) =>
    <String, dynamic>{
      'token': instance.token,
      'password_current': instance.passwordCurrent,
      'password_new': instance.passwordNew,
    };
