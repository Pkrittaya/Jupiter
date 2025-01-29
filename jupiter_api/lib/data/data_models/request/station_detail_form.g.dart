// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'station_detail_form.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StationDetailForm _$StationDetailFormFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'StationDetailForm',
      json,
      ($checkedConvert) {
        final val = StationDetailForm(
          stationId: $checkedConvert('station_id', (v) => v as String),
          latitude: $checkedConvert('latitude', (v) => (v as num).toDouble()),
          longitude: $checkedConvert('longitude', (v) => (v as num).toDouble()),
          username: $checkedConvert('username', (v) => v as String),
          orgCode: $checkedConvert('org_code', (v) => v as String),
        );
        return val;
      },
      fieldKeyMap: const {'stationId': 'station_id', 'orgCode': 'org_code'},
    );

Map<String, dynamic> _$StationDetailFormToJson(StationDetailForm instance) =>
    <String, dynamic>{
      'org_code': instance.orgCode,
      'station_id': instance.stationId,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'username': instance.username,
    };
