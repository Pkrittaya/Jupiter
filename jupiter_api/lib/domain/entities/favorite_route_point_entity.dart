import 'package:json_annotation/json_annotation.dart';

class FavoriteRoutePointEntity {
  FavoriteRoutePointEntity({
    required this.name,
    required this.pointNo,
    required this.latitude,
    required this.longitude,
    required this.stationId,
    required this.stationName,
  });

  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'point_no')
  final int pointNo;
  @JsonKey(name: 'latitude')
  final double latitude;
  @JsonKey(name: 'longitude')
  final double longitude;
  @JsonKey(name: 'station_id')
  final String stationId;
  @JsonKey(name: 'station_name')
  final String stationName;
}
