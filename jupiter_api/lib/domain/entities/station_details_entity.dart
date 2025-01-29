import 'package:json_annotation/json_annotation.dart';

import 'charger_entity.dart';
import 'connect_type_power_entity.dart';
import 'duration_entity.dart';
import 'facility_entity.dart';

class StationDetailEntity {
  StationDetailEntity({
    required this.stationId,
    required this.stationName,
    required this.facility,
    required this.position,
    required this.address,
    required this.eta,
    required this.distance,
    required this.openingHours,
    required this.images,
    required this.statusOpening,
    required this.totalConnector,
    required this.connectorAvailable,
    required this.connectorType,
    required this.statusMarker,
    required this.charger,
    required this.favorite,
    required this.lowPriorityTariff,
  });

  @JsonKey(name: 'station_id')
  final String stationId;
  @JsonKey(name: 'station_name')
  final String stationName;
  @JsonKey(name: 'facility')
  final List<FacilityEntity>? facility;
  @JsonKey(name: 'position')
  final List<double> position;
  @JsonKey(name: 'address')
  final String address;
  @JsonKey(name: 'eta')
  final String eta;
  @JsonKey(name: 'distance')
  final String distance;
  @JsonKey(name: 'opening_hours')
  final List<DurationEntity> openingHours;
  @JsonKey(name: 'images')
  final List<String>? images;
  @JsonKey(name: 'status_opening')
  final bool statusOpening;
  @JsonKey(name: 'total_connector')
  final int? totalConnector;
  @JsonKey(name: 'connector_available')
  final int connectorAvailable;
  @JsonKey(name: 'connector_type')
  final List<ConnectorTypeAndPowerEntity> connectorType;
  @JsonKey(name: 'status_marker')
  final String statusMarker;
  @JsonKey(name: 'charger')
  final List<ChargerEntity> charger;
  @JsonKey(name: 'favorite')
  final bool favorite;
  @JsonKey(name: 'low_priority_tariff')
  final bool lowPriorityTariff;
}
