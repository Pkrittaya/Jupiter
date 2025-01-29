import 'package:json_annotation/json_annotation.dart';

class ConnectorInformationEntity {
  ConnectorInformationEntity(
      {required this.stationId,
      required this.chargerId,
      required this.owener,
      required this.connectorId,
      required this.connectorIndex,
      required this.connectorType,
      required this.connectorPosition,
      required this.connectorStatusActive,
      required this.premiumChargingStatus});

  @JsonKey(name: 'station_id')
  final String? stationId;
  @JsonKey(name: 'charger_id')
  final String? chargerId;
  @JsonKey(name: 'owener')
  final String? owener;
  @JsonKey(name: 'connector_id')
  final String? connectorId;
  @JsonKey(name: 'connector_index')
  final int? connectorIndex;
  @JsonKey(name: 'connector_type')
  final String? connectorType;
  @JsonKey(name: 'connector_position')
  final String? connectorPosition;
  @JsonKey(name: 'connector_status_active')
  final String? connectorStatusActive;
  @JsonKey(name: 'premium_charging_status')
  final bool? premiumChargingStatus;
}
