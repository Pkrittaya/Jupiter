// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'finding_station_form.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FindingStationForm _$FindingStationFormFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'FindingStationForm',
      json,
      ($checkedConvert) {
        final val = FindingStationForm(
          latitude: $checkedConvert('latitude', (v) => (v as num).toDouble()),
          longitude: $checkedConvert('longitude', (v) => (v as num).toDouble()),
          orgCode: $checkedConvert('org_code', (v) => v as String),
        );
        return val;
      },
      fieldKeyMap: const {'orgCode': 'org_code'},
    );

Map<String, dynamic> _$FindingStationFormToJson(FindingStationForm instance) =>
    <String, dynamic>{
      'org_code': instance.orgCode,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };
