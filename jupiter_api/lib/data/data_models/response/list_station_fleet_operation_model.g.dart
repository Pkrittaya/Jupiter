// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_station_fleet_operation_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListStationFleetOperationModel _$ListStationFleetOperationModelFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      'ListStationFleetOperationModel',
      json,
      ($checkedConvert) {
        final val = ListStationFleetOperationModel(
          station: $checkedConvert(
              'station',
              (v) => (v as List<dynamic>)
                  .map((e) => FleetOperationStationItemModel.fromJson(
                      e as Map<String, dynamic>))
                  .toList()),
        );
        return val;
      },
    );

Map<String, dynamic> _$ListStationFleetOperationModelToJson(
        ListStationFleetOperationModel instance) =>
    <String, dynamic>{
      'station': instance.station.map((e) => e.toJson()).toList(),
    };
