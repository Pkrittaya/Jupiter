import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entities/station_entity.dart';
import 'connector_type_power_model.dart';

part 'station_model.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class StationModel extends StationEntity {
  StationModel(
      {required super.stationId,
      required super.stationName,
      required super.statusMarker,
      required super.position,
      required super.connectorAvailable,
      required super.connectorTotal,
      required this.connectorType,
      required super.distance})
      : super(connectorType: connectorType);

  @override
  @JsonKey(name: 'connector_type')
  final List<ConnectorTypeAndPowerModel> connectorType;

  factory StationModel.fromJson(Map<String, dynamic> json) =>
      _$StationModelFromJson(json);
  Map<String, dynamic> toJson() => _$StationModelToJson(this);
}
