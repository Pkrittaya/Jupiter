import 'package:json_annotation/json_annotation.dart';

import 'fleet_operation_station_item_entity.dart';

class ListStationFleetOperationEntity {
  ListStationFleetOperationEntity({
    required this.station,
  });

  @JsonKey(name: 'station')
  final List<FleetOperationStationItemEntity> station;
}
