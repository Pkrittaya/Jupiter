import 'package:json_annotation/json_annotation.dart';
import '../../../domain/entities/fleet_card_station_item_entity.dart';

part 'fleet_card_station_item_model.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class FleetCardStationItemModel extends FleetCardStationItemEntity {
  FleetCardStationItemModel({
    required super.stationId,
    required super.stationName,
    required super.connectorAvailable,
    required super.connectorTotal,
    required super.image,
  });

  factory FleetCardStationItemModel.fromJson(Map<String, dynamic> json) =>
      _$FleetCardStationItemModelFromJson(json);
  Map<String, dynamic> toJson() => _$FleetCardStationItemModelToJson(this);
}
