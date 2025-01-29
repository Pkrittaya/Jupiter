// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reserve_slot_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReserveSlotModel _$ReserveSlotModelFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'ReserveSlotModel',
      json,
      ($checkedConvert) {
        final val = ReserveSlotModel(
          index: $checkedConvert('index', (v) => v as int),
          day: $checkedConvert('day', (v) => v as String),
          start: $checkedConvert('start', (v) => v as String),
          end: $checkedConvert('end', (v) => v as String),
          duration: $checkedConvert('duration', (v) => v as String),
          status: $checkedConvert('status', (v) => v as bool),
        );
        return val;
      },
    );

Map<String, dynamic> _$ReserveSlotModelToJson(ReserveSlotModel instance) =>
    <String, dynamic>{
      'index': instance.index,
      'day': instance.day,
      'start': instance.start,
      'end': instance.end,
      'duration': instance.duration,
      'status': instance.status,
    };
