import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entities/favorite_station_list_entily.dart';
import 'connector_type_power_model.dart';
import 'duration_model.dart';

part 'favorite_station_list_model.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class FavoriteStationListModel extends FavoriteStationListEntity {
  FavoriteStationListModel({
    required super.stationId,
    required super.stationName,
    required super.position,
    required super.eta,
    required super.distance,
    required this.openingHours,
    required super.statusOpening,
    required super.chargerStatus,
    required super.connectorAvailable,
    required super.totalConnector,
    required super.images,
    required this.connectorType,
  }) : super(connectorType: connectorType, openingHours: openingHours);

  @override
  @JsonKey(name: 'connector_type')
  final List<ConnectorTypeAndPowerModel> connectorType;
  @override
  @JsonKey(name: 'opening_hours')
  final List<DurationModel> openingHours;

  factory FavoriteStationListModel.fromJson(Map<String, dynamic> json) =>
      _$FavoriteStationListModelFromJson(json);
  Map<String, dynamic> toJson() => _$FavoriteStationListModelToJson(this);
}
