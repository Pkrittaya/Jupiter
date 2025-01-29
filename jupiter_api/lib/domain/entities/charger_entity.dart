import 'package:json_annotation/json_annotation.dart';

import 'connector_entity.dart';

class ChargerEntity {
  ChargerEntity({
    required this.chargerId,
    required this.chargerName,
    required this.chargerBrand,
    required this.totalConnector,
    required this.connector,
  });
  @JsonKey(name: 'charger_id')
  final String chargerId;
  @JsonKey(name: 'charger_name')
  final String chargerName;
  @JsonKey(name: 'charger_brand')
  final String chargerBrand;
  @JsonKey(name: 'total_connector')
  final int totalConnector;
  @JsonKey(name: 'connector')
  final List<ConnectorEntity> connector;
}
