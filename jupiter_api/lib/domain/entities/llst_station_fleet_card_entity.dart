import 'package:json_annotation/json_annotation.dart';

import 'fleet_card_station_item_entity.dart';

class ListStationFleetCardEntity {
  ListStationFleetCardEntity({
    required this.station,
  });

  @JsonKey(name: 'station')
  final List<FleetCardStationItemEntity> station;
}
