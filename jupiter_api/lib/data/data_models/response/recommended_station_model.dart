import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entities/recommended_station_entity.dart';
import 'connector_type_power_model.dart';

part 'recommended_station_model.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class RecommendedStationModel extends RecommendedStationEntity {
  RecommendedStationModel(
      {required super.stationId,
      required super.stationName,
      required super.position,
      required this.connectorType,
      required super.images})
      : super(connectorType: connectorType);

  @override
  @JsonKey(name: 'connector_type')
  final List<ConnectorTypeAndPowerModel> connectorType;

  factory RecommendedStationModel.fromJson(Map<String, dynamic> json) =>
      _$RecommendedStationModelFromJson(json);
  Map<String, dynamic> toJson() => _$RecommendedStationModelToJson(this);
}
