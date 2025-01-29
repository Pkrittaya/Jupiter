import 'package:json_annotation/json_annotation.dart';
import 'package:jupiter_api/domain/entities/car_select_fleet_entity.dart';

part 'car_select_fleet_model.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class CarSelectFleetModel extends CarSelectFleetEntity {
  CarSelectFleetModel(
      {required super.brand,
      required super.licensePlate,
      required super.model,
      required super.province,
      required super.image,
      required super.vehicleNo});

  factory CarSelectFleetModel.fromJson(Map<String, dynamic> json) =>
      _$CarSelectFleetModelFromJson(json);
  Map<String, dynamic> toJson() => _$CarSelectFleetModelToJson(this);
}
