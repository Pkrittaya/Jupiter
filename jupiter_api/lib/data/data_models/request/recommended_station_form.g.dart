// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recommended_station_form.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecommendedStationForm _$RecommendedStationFormFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      'RecommendedStationForm',
      json,
      ($checkedConvert) {
        final val = RecommendedStationForm(
          filterOpenService:
              $checkedConvert('filter_openService', (v) => v as bool),
          filterDistance: $checkedConvert('filter_distance', (v) => v as bool),
          filterConnectorDC: $checkedConvert('filter_connector_dc',
              (v) => (v as List<dynamic>).map((e) => e as String?).toList()),
          latitude: $checkedConvert('latitude', (v) => (v as num).toDouble()),
          longitude: $checkedConvert('longitude', (v) => (v as num).toDouble()),
          orgCode: $checkedConvert('org_code', (v) => v as String),
        );
        return val;
      },
      fieldKeyMap: const {
        'filterOpenService': 'filter_openService',
        'filterDistance': 'filter_distance',
        'filterConnectorDC': 'filter_connector_dc',
        'orgCode': 'org_code'
      },
    );

Map<String, dynamic> _$RecommendedStationFormToJson(
        RecommendedStationForm instance) =>
    <String, dynamic>{
      'org_code': instance.orgCode,
      'filter_openService': instance.filterOpenService,
      'filter_distance': instance.filterDistance,
      'filter_connector_dc': instance.filterConnectorDC,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };
