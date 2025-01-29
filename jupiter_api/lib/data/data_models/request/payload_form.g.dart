// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payload_form.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PayloadForm _$PayloadFormFromJson(Map<String, dynamic> json) => $checkedCreate(
      'PayloadForm',
      json,
      ($checkedConvert) {
        final val = PayloadForm(
          payload: $checkedConvert('payload', (v) => v as String),
        );
        return val;
      },
    );

Map<String, dynamic> _$PayloadFormToJson(PayloadForm instance) =>
    <String, dynamic>{
      'payload': instance.payload,
    };
