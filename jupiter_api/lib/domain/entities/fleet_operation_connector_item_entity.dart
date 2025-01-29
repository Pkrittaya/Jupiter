import 'package:json_annotation/json_annotation.dart';

class FleetOperationConnectorItemEntity {
  FleetOperationConnectorItemEntity({
    required this.connectorId,
    required this.connectorIndex,
    required this.connectorType,
    required this.connectorPowerType,
    required this.connectorPosition,
    required this.connectorStatus,
    required this.connectorCode,
    required this.statusCharging,
    required this.statusReceipt,
  });
  @JsonKey(name: 'connector_id')
  final String connectorId;
  @JsonKey(name: 'connector_index')
  final int connectorIndex;
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
  @JsonKey(name: 'status_charging')
  final String statusCharging;
  @JsonKey(name: 'status_receipt')
  final bool statusReceipt;
}
