import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entities/fleet_operation_item_entity.dart';

part 'fleet_operation_item_model.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class FleetOperationItemModel extends FleetOperationItemEntity {
  FleetOperationItemModel({
    required super.fleetNo,
    required super.fleetName,
    required super.images,
    required super.statusCharging,
    required super.connectorTotal,
    required super.connectorAvailable,
    required super.fleetVehicle,
    required super.status,
  });

  factory FleetOperationItemModel.fromJson(Map<String, dynamic> json) =>
      _$FleetOperationItemModelFromJson(json);
  Map<String, dynamic> toJson() => _$FleetOperationItemModelToJson(this);
}
