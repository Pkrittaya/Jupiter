import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entities/fleet_operation_connector_item_entity.dart';

part 'fleet_operation_connector_item_model.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class FleetOperationConnectorItemModel
    extends FleetOperationConnectorItemEntity {
  FleetOperationConnectorItemModel({
    required super.connectorId,
    required super.connectorIndex,
    required super.connectorType,
    required super.connectorPowerType,
    required super.connectorPosition,
    required super.connectorStatus,
    required super.connectorCode,
    required super.statusCharging,
    required super.statusReceipt,
  });

  factory FleetOperationConnectorItemModel.fromJson(
          Map<String, dynamic> json) =>
      _$FleetOperationConnectorItemModelFromJson(json);
  Map<String, dynamic> toJson() =>
      _$FleetOperationConnectorItemModelToJson(this);
}
