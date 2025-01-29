import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entities/connector_entity.dart';
import 'reserve_slot_model.dart';

part 'connector_model.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class ConnectorModel extends ConnectorEntity {
  ConnectorModel({
    required super.connectorId,
    required super.connectorQrCode,
    required super.connectorName,
    required super.connectorType,
    required super.connectorPowerType,
    required super.connectorPosition,
    required super.connectorStatus,
    required super.connectorStatusActive,
    required super.connectorPower,
    required super.connectorPrice,
    required super.reserveStatus,
    required super.reservePrice,
    required this.reserveSlot,
  }) : super(reserveSlot: reserveSlot);

  @override
  @JsonKey(name: 'reserve_slot')
  final List<ReserveSlotModel>? reserveSlot;

  factory ConnectorModel.fromJson(Map<String, dynamic> json) =>
      _$ConnectorModelFromJson(json);
  Map<String, dynamic> toJson() => _$ConnectorModelToJson(this);
}
