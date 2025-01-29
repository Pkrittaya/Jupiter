import 'package:json_annotation/json_annotation.dart';

class ConnectorTypeAndPowerEntity {
  ConnectorTypeAndPowerEntity(
      {required this.connectorType, required this.connectorPowerType});

  @JsonKey(name: 'connector_type')
  final String connectorType;
  @JsonKey(name: 'connector_power_type')
  final String connectorPowerType;
}
