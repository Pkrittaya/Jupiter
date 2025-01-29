import 'package:json_annotation/json_annotation.dart';

import 'connect_type_power_entity.dart';
import 'duration_entity.dart';

class FavoriteStationListEntity {
  FavoriteStationListEntity({
    required this.stationId,
    required this.stationName,
    required this.position,
    required this.eta,
    required this.distance,
    required this.openingHours,
    required this.statusOpening,
    required this.chargerStatus,
    required this.connectorAvailable,
    required this.totalConnector,
    required this.images,
    required this.connectorType,
  });

  @JsonKey(name: 'station_id')
  final String stationId;
  @JsonKey(name: 'station_name')
  final String stationName;
  @JsonKey(name: 'position')
  final List<double> position;
  @JsonKey(name: 'eta')
  final String eta;
  @JsonKey(name: 'distance')
  final String distance;
  @JsonKey(name: 'opening_hours')
  final List<DurationEntity> openingHours;
  @JsonKey(name: 'status_opening')
  final bool statusOpening;
  @JsonKey(name: 'charger_status')
  final String chargerStatus;
  @JsonKey(name: 'connector_available')
  final int connectorAvailable;
  @JsonKey(name: 'total_connector')
  final int totalConnector;
  @JsonKey(name: 'images')
  final String images;
  @JsonKey(name: 'connector_type')
  final List<ConnectorTypeAndPowerEntity> connectorType;
}
