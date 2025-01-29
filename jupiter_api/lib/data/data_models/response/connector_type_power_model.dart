import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entities/connect_type_power_entity.dart';

part 'connector_type_power_model.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class ConnectorTypeAndPowerModel extends ConnectorTypeAndPowerEntity {
  ConnectorTypeAndPowerModel(
      {required super.connectorType, required super.connectorPowerType});

  factory ConnectorTypeAndPowerModel.fromJson(Map<String, dynamic> json) =>
      _$ConnectorTypeAndPowerModelFromJson(json);
  Map<String, dynamic> toJson() => _$ConnectorTypeAndPowerModelToJson(this);
}
