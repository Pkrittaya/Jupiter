// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_station_fleet_card_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListStationFleetCardModel _$ListStationFleetCardModelFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      'ListStationFleetCardModel',
      json,
      ($checkedConvert) {
        final val = ListStationFleetCardModel(
          station: $checkedConvert(
              'station',
              (v) => (v as List<dynamic>)
                  .map((e) => FleetCardStationItemModel.fromJson(
                      e as Map<String, dynamic>))
                  .toList()),
        );
        return val;
      },
    );

Map<String, dynamic> _$ListStationFleetCardModelToJson(
        ListStationFleetCardModel instance) =>
    <String, dynamic>{
      'station': instance.station.map((e) => e.toJson()).toList(),
    };
