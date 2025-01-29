// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'set_language_form.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SetLanguageForm _$SetLanguageFormFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'SetLanguageForm',
      json,
      ($checkedConvert) {
        final val = SetLanguageForm(
          deviceCode: $checkedConvert('device_code', (v) => v as String),
          language: $checkedConvert('language', (v) => v as String),
        );
        return val;
      },
      fieldKeyMap: const {'deviceCode': 'device_code'},
    );

Map<String, dynamic> _$SetLanguageFormToJson(SetLanguageForm instance) =>
    <String, dynamic>{
      'device_code': instance.deviceCode,
      'language': instance.language,
    };
