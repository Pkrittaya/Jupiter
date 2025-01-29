// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_reserve_of_connector_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListReserveOfConnectorModel _$ListReserveOfConnectorModelFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      'ListReserveOfConnectorModel',
      json,
      ($checkedConvert) {
        final val = ListReserveOfConnectorModel(
          startTimeReserve:
              $checkedConvert('start_time_reserve', (v) => v as String),
          endTimeReserve:
              $checkedConvert('end_time_reserve', (v) => v as String),
        );
        return val;
      },
      fieldKeyMap: const {
        'startTimeReserve': 'start_time_reserve',
        'endTimeReserve': 'end_time_reserve'
      },
    );

Map<String, dynamic> _$ListReserveOfConnectorModelToJson(
        ListReserveOfConnectorModel instance) =>
    <String, dynamic>{
      'start_time_reserve': instance.startTimeReserve,
      'end_time_reserve': instance.endTimeReserve,
    };
