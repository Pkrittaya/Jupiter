import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entities/fleet_card_connector_item_entity.dart';

part 'fleet_card_connector_item_model.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class FleetCardConnectorItemModel extends FleetCardConnectorItemEntity {
  FleetCardConnectorItemModel({
    required super.connectorType,
    required super.connectorPowerType,
    required super.connectorPosition,
    required super.connectorStatus,
    required super.connectorCode,
  });

  factory FleetCardConnectorItemModel.fromJson(Map<String, dynamic> json) =>
      _$FleetCardConnectorItemModelFromJson(json);
  Map<String, dynamic> toJson() => _$FleetCardConnectorItemModelToJson(this);
}
