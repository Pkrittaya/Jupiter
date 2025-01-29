// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'finding_station_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FindingStationModel _$FindingStationModelFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'FindingStationModel',
      json,
      ($checkedConvert) {
        final val = FindingStationModel(
          totalStation: $checkedConvert('total_station', (v) => v as int),
          stationList: $checkedConvert(
              'station_list',
              (v) => (v as List<dynamic>)
                  .map((e) =>
                      SearchStationModel.fromJson(e as Map<String, dynamic>))
                  .toList()),
        );
        return val;
      },
      fieldKeyMap: const {
        'totalStation': 'total_station',
        'stationList': 'station_list'
      },
    );

Map<String, dynamic> _$FindingStationModelToJson(
        FindingStationModel instance) =>
    <String, dynamic>{
      'total_station': instance.totalStation,
      'station_list': instance.stationList.map((e) => e.toJson()).toList(),
    };
