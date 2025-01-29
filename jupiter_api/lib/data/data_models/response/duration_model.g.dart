// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'duration_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DurationModel _$DurationModelFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'DurationModel',
      json,
      ($checkedConvert) {
        final val = DurationModel(
          index: $checkedConvert('index', (v) => v as int),
          day: $checkedConvert('day', (v) => v as String),
          status: $checkedConvert('status', (v) => v as bool),
          start: $checkedConvert('start', (v) => v as String),
          end: $checkedConvert('end', (v) => v as String),
          duration: $checkedConvert('duration', (v) => v as String),
        );
        return val;
      },
    );

Map<String, dynamic> _$DurationModelToJson(DurationModel instance) =>
    <String, dynamic>{
      'index': instance.index,
      'day': instance.day,
      'status': instance.status,
      'start': instance.start,
      'end': instance.end,
      'duration': instance.duration,
    };
