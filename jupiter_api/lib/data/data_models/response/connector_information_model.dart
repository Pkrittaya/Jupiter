import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entities/connector_information_entity.dart';

part 'connector_information_model.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class ConnectorInformationModel extends ConnectorInformationEntity {
  ConnectorInformationModel(
      {required super.stationId,
      required super.chargerId,
      required super.owener,
      required super.connectorId,
      required super.connectorIndex,
      required super.connectorType,
      required super.connectorPosition,
      required super.connectorStatusActive,
      required super.premiumChargingStatus});

  factory ConnectorInformationModel.fromJson(Map<String, dynamic> json) =>
      _$ConnectorInformationModelFromJson(json);
  Map<String, dynamic> toJson() => _$ConnectorInformationModelToJson(this);
}
