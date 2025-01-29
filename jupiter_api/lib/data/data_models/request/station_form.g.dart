// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'station_form.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StationForm _$StationFormFromJson(Map<String, dynamic> json) => $checkedCreate(
      'StationForm',
      json,
      ($checkedConvert) {
        final val = StationForm(
          filterOpenService:
              $checkedConvert('filter_openService', (v) => v as bool),
          filterChargerAvailble:
              $checkedConvert('filter_charger_availble', (v) => v as bool),
          filterDistance: $checkedConvert('filter_distance', (v) => v as bool),
          filterConnectorAC: $checkedConvert('filter_connector_ac',
              (v) => (v as List<dynamic>).map((e) => e as String?).toList()),
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
        'filterChargerAvailble': 'filter_charger_availble',
        'filterDistance': 'filter_distance',
        'filterConnectorAC': 'filter_connector_ac',
        'filterConnectorDC': 'filter_connector_dc',
        'orgCode': 'org_code'
      },
    );

Map<String, dynamic> _$StationFormToJson(StationForm instance) =>
    <String, dynamic>{
      'org_code': instance.orgCode,
      'filter_openService': instance.filterOpenService,
      'filter_charger_availble': instance.filterChargerAvailble,
      'filter_distance': instance.filterDistance,
      'filter_connector_ac': instance.filterConnectorAC,
      'filter_connector_dc': instance.filterConnectorDC,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };
