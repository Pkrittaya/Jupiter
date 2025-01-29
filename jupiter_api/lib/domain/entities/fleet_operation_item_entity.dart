import 'package:json_annotation/json_annotation.dart';

class FleetOperationItemEntity {
  FleetOperationItemEntity({
    required this.fleetNo,
    required this.fleetName,
    required this.images,
    required this.statusCharging,
    required this.connectorTotal,
    required this.connectorAvailable,
    required this.fleetVehicle,
    required this.status,
  });
  @JsonKey(name: 'fleet_no')
  final int fleetNo;
  @JsonKey(name: 'fleet_name')
  final String fleetName;
  @JsonKey(name: 'images')
  final String images;
  @JsonKey(name: 'status_charging')
  final String statusCharging;
  @JsonKey(name: 'connector_total')
  final int connectorTotal;
  @JsonKey(name: 'connector_available')
  final int connectorAvailable;
  @JsonKey(name: 'fleet_vehicle')
  final int fleetVehicle;
  @JsonKey(name: 'status')
  final String status;
}
