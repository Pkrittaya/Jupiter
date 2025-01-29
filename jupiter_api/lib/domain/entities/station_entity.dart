import 'package:json_annotation/json_annotation.dart';

import 'connect_type_power_entity.dart';

class StationEntity {
  StationEntity(
      {required this.stationId,
      required this.stationName,
      required this.statusMarker,
      required this.position,
      required this.connectorAvailable,
      required this.connectorTotal,
      required this.connectorType,
      required this.distance});

  @JsonKey(name: 'station_id')
  final String stationId;
  @JsonKey(name: 'station_name')
  final String stationName;
  @JsonKey(name: 'status_marker')
  final String statusMarker;
  @JsonKey(name: 'position')
  final List<double> position;
  @JsonKey(name: 'connector_available')
  final int connectorAvailable;
  @JsonKey(name: 'connector_total')
  final int connectorTotal;
  @JsonKey(name: 'connector_type')
  final List<ConnectorTypeAndPowerEntity> connectorType;
  @JsonKey(name: 'distance')
  final int distance;
}
