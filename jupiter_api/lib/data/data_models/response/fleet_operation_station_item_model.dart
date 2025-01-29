import 'package:json_annotation/json_annotation.dart';
import '../../../domain/entities/fleet_operation_station_item_entity.dart';

part 'fleet_operation_station_item_model.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class FleetOperationStationItemModel extends FleetOperationStationItemEntity {
  FleetOperationStationItemModel({
    required super.stationId,
    required super.stationName,
    required super.connectorAvailable,
    required super.connectorTotal,
    required super.statusCharging,
    required super.image,
  });

  factory FleetOperationStationItemModel.fromJson(Map<String, dynamic> json) =>
      _$FleetOperationStationItemModelFromJson(json);
  Map<String, dynamic> toJson() => _$FleetOperationStationItemModelToJson(this);
}
