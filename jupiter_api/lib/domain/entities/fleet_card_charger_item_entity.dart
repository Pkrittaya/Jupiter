import 'package:json_annotation/json_annotation.dart';

import 'fleet_card_connector_item_entity.dart';

class FleetCardChargerItemEntity {
  FleetCardChargerItemEntity({
    required this.chargerId,
    required this.chargerName,
    required this.connectorAvailable,
    required this.connectorTotal,
    required this.connector,
  });

  @JsonKey(name: 'charger_id')
  final String chargerId;
  @JsonKey(name: 'charger_name')
  final String chargerName;
  @JsonKey(name: 'connector_available')
  final int connectorAvailable;
  @JsonKey(name: 'connector_total')
  final int connectorTotal;
  @JsonKey(name: 'connector')
  final List<FleetCardConnectorItemEntity> connector;
}
