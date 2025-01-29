import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entities/fleet_card_charger_item_entity.dart';
import 'fleet_card_connector_item_model.dart';

part 'fleet_card_charger_item_model.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class FleetCardChargerItemModel extends FleetCardChargerItemEntity {
  FleetCardChargerItemModel({
    required super.chargerId,
    required super.chargerName,
    required super.connectorAvailable,
    required super.connectorTotal,
    required this.connector,
  }) : super(connector: connector);

  @override
  @JsonKey(name: 'connector')
  final List<FleetCardConnectorItemModel> connector;

  factory FleetCardChargerItemModel.fromJson(Map<String, dynamic> json) =>
      _$FleetCardChargerItemModelFromJson(json);
  Map<String, dynamic> toJson() => _$FleetCardChargerItemModelToJson(this);
}
