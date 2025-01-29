// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delete_account_form.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeleteAccountForm _$DeleteAccountFormFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'DeleteAccountForm',
      json,
      ($checkedConvert) {
        final val = DeleteAccountForm(
          password: $checkedConvert('password', (v) => v as String),
        );
        return val;
      },
    );

Map<String, dynamic> _$DeleteAccountFormToJson(DeleteAccountForm instance) =>
    <String, dynamic>{
      'password': instance.password,
    };
