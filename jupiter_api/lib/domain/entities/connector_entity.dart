import 'package:json_annotation/json_annotation.dart';
import 'package:jupiter_api/domain/entities/reserve_slot_entity.dart';

class ConnectorEntity {
  ConnectorEntity({
    required this.connectorId,
    required this.connectorQrCode,
    required this.connectorName,
    required this.connectorType,
    required this.connectorPowerType,
    required this.connectorPosition,
    required this.connectorStatus,
    required this.connectorStatusActive,
    required this.connectorPower,
    required this.connectorPrice,
    required this.reserveStatus,
    required this.reservePrice,
    required this.reserveSlot,
  });

  @JsonKey(name: 'connector_id')
  final String connectorId;
  @JsonKey(name: 'connector_qr_code')
  final String connectorQrCode;
  @JsonKey(name: 'connector_name')
  final String connectorName;
  @JsonKey(name: 'connector_type')
  final String connectorType;
  @JsonKey(name: 'connector_power')
  final String connectorPower;
  @JsonKey(name: 'connector_position')
  final String connectorPosition;
  @JsonKey(name: 'connector_status')
  final bool connectorStatus;
  @JsonKey(name: 'connector_status_active')
  final String connectorStatusActive;
  @JsonKey(name: 'connector_power_type')
  final String connectorPowerType;
  @JsonKey(name: 'connector_price')
  final String connectorPrice;
  @JsonKey(name: 'reserve_status')
  final bool reserveStatus;
  @JsonKey(name: 'reserve_price')
  final double reservePrice;
  @JsonKey(name: 'reserve_slot')
  final List<ReserveSlotEntity>? reserveSlot;
}
