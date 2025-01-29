// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_station_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FavoriteStationModel _$FavoriteStationModelFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      'FavoriteStationModel',
      json,
      ($checkedConvert) {
        final val = FavoriteStationModel(
          totalStation: $checkedConvert('total_station', (v) => v as int),
          stationList: $checkedConvert(
              'station_list',
              (v) => (v as List<dynamic>)
                  .map((e) => FavoriteStationListModel.fromJson(
                      e as Map<String, dynamic>))
                  .toList()),
        );
        return val;
      },
      fieldKeyMap: const {
        'totalStation': 'total_station',
        'stationList': 'station_list'
      },
    );

Map<String, dynamic> _$FavoriteStationModelToJson(
        FavoriteStationModel instance) =>
    <String, dynamic>{
      'total_station': instance.totalStation,
      'station_list': instance.stationList.map((e) => e.toJson()).toList(),
    };
