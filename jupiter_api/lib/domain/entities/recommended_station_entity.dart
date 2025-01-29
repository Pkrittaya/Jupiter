import 'package:json_annotation/json_annotation.dart';

import 'connect_type_power_entity.dart';

class RecommendedStationEntity {
  RecommendedStationEntity(
      {required this.stationId,
      required this.stationName,
      required this.position,
      required this.connectorType,
      required this.images});

  @JsonKey(name: 'station_id')
  final String stationId;
  @JsonKey(name: 'station_name')
  final String stationName;
  @JsonKey(name: 'position')
  final List<double> position;
  @JsonKey(name: 'connector_type')
  final List<ConnectorTypeAndPowerEntity> connectorType;
  @JsonKey(name: 'images')
  final String images;
}
