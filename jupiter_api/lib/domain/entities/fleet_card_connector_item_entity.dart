import 'package:json_annotation/json_annotation.dart';

class FleetCardConnectorItemEntity {
  FleetCardConnectorItemEntity({
    required this.connectorType,
    required this.connectorPowerType,
    required this.connectorPosition,
    required this.connectorStatus,
    required this.connectorCode,
  });

  @JsonKey(name: 'connector_type')
  final String connectorType;
  @JsonKey(name: 'connector_power_type')
  final String connectorPowerType;
  @JsonKey(name: 'connector_position')
  final String connectorPosition;
  @JsonKey(name: 'connector_status')
  final String connectorStatus;
  @JsonKey(name: 'connector_code')
  final String connectorCode;
}
