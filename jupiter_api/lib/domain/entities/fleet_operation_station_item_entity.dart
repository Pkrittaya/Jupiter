import 'package:json_annotation/json_annotation.dart';

class FleetOperationStationItemEntity {
  FleetOperationStationItemEntity({
    required this.stationId,
    required this.stationName,
    required this.connectorAvailable,
    required this.connectorTotal,
    required this.statusCharging,
    required this.image,
  });

  @JsonKey(name: 'station_id')
  final String stationId;
  @JsonKey(name: 'station_name')
  final String stationName;
  @JsonKey(name: 'connector_available')
  final int connectorAvailable;
  @JsonKey(name: 'connector_total')
  final int connectorTotal;
  @JsonKey(name: 'status_charging')
  final String statusCharging;
  @JsonKey(name: 'image')
  final List<String> image;
}
