// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'term_and_condition_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TermAndConditionModel _$TermAndConditionModelFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      'TermAndConditionModel',
      json,
      ($checkedConvert) {
        final val = TermAndConditionModel(
          header: $checkedConvert('header', (v) => v as String),
          body: $checkedConvert('body', (v) => v as String),
          footer: $checkedConvert('footer', (v) => v as String),
        );
        return val;
      },
    );

Map<String, dynamic> _$TermAndConditionModelToJson(
        TermAndConditionModel instance) =>
    <String, dynamic>{
      'header': instance.header,
      'body': instance.body,
      'footer': instance.footer,
    };
