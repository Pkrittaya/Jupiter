// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_favorite_station_form.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateFavoriteStationForm _$UpdateFavoriteStationFormFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      'UpdateFavoriteStationForm',
      json,
      ($checkedConvert) {
        final val = UpdateFavoriteStationForm(
          username: $checkedConvert('username', (v) => v as String),
          orgCode: $checkedConvert('org_code', (v) => v as String),
          stationId: $checkedConvert('station_id', (v) => v as String),
          stationName: $checkedConvert('station_name', (v) => v as String),
        );
        return val;
      },
      fieldKeyMap: const {
        'orgCode': 'org_code',
        'stationId': 'station_id',
        'stationName': 'station_name'
      },
    );

Map<String, dynamic> _$UpdateFavoriteStationFormToJson(
        UpdateFavoriteStationForm instance) =>
    <String, dynamic>{
      'org_code': instance.orgCode,
      'username': instance.username,
      'station_id': instance.stationId,
      'station_name': instance.stationName,
    };
