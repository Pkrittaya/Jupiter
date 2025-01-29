import 'package:json_annotation/json_annotation.dart';

import 'favorite_station_list_entily.dart';

class FavoriteStationEntity {
  FavoriteStationEntity({
    required this.totalStation,
    required this.stationList,
  });
  @JsonKey(name: 'total_station')
  final int totalStation;
  @JsonKey(name: 'station_list')
  final List<FavoriteStationListEntity> stationList;
}
