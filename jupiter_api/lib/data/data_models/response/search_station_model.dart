import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entities/search_station_entity.dart';
import 'connector_type_power_model.dart';
import 'reserve_slot_model.dart';

part 'search_station_model.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class SearchStationModel extends SearchStationEntity {
  SearchStationModel({
    required super.stationId,
    required super.stationName,
    required super.position,
    required super.eta,
    required super.distance,
    required super.chargerStatus,
    required super.connectorAvailable,
    required super.totalConnector,
    required super.images,
    required this.openingHours,
    required super.statusOpening,
    required this.connectorType,
  }) : super(connectorType: connectorType, openingHours: openingHours);

  @override
  @JsonKey(name: 'connector_type')
  final List<ConnectorTypeAndPowerModel> connectorType;
  @override
  @JsonKey(name: 'opening_hours')
  final List<ReserveSlotModel> openingHours;

  factory SearchStationModel.fromJson(Map<String, dynamic> json) =>
      _$SearchStationModelFromJson(json);
  Map<String, dynamic> toJson() => _$SearchStationModelToJson(this);
}
