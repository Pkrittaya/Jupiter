import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entities/fleet_operation_charger_item_entity.dart';
import 'fleet_operation_connector_item_model.dart';

part 'fleet_operation_charger_item_model.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class FleetOperationChargerItemModel extends FleetOperationChargerItemEntity {
  FleetOperationChargerItemModel({
    required super.chargerId,
    required super.chargerName,
    required super.connectorAvailable,
    required super.connectorTotal,
    required this.connector,
  }) : super(connector: connector);

  @override
  @JsonKey(name: 'connector')
  final List<FleetOperationConnectorItemModel> connector;

  factory FleetOperationChargerItemModel.fromJson(Map<String, dynamic> json) =>
      _$FleetOperationChargerItemModelFromJson(json);
  Map<String, dynamic> toJson() => _$FleetOperationChargerItemModelToJson(this);
}
