import 'package:json_annotation/json_annotation.dart';

import 'search_station_entity.dart';

class FindingStationEntity {
  FindingStationEntity({
    required this.totalStation,
    required this.stationList,
  });
  @JsonKey(name: 'total_station')
  final int totalStation;
  @JsonKey(name: 'station_list')
  final List<SearchStationEntity> stationList;
}
