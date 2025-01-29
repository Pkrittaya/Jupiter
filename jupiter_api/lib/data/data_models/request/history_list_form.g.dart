// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_list_form.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HistoryListForm _$HistoryListFormFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'HistoryListForm',
      json,
      ($checkedConvert) {
        final val = HistoryListForm(
          username: $checkedConvert('username', (v) => v as String),
          orgCode: $checkedConvert('org_code', (v) => v as String),
          startDate: $checkedConvert('start_date', (v) => v as String),
          endDate: $checkedConvert('end_date', (v) => v as String),
          stationId: $checkedConvert('station_id', (v) => v as String),
        );
        return val;
      },
      fieldKeyMap: const {
        'orgCode': 'org_code',
        'startDate': 'start_date',
        'endDate': 'end_date',
        'stationId': 'station_id'
      },
    );

Map<String, dynamic> _$HistoryListFormToJson(HistoryListForm instance) =>
    <String, dynamic>{
      'org_code': instance.orgCode,
      'username': instance.username,
      'start_date': instance.startDate,
      'end_date': instance.endDate,
      'station_id': instance.stationId,
    };
