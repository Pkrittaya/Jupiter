import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entities/car_select_entity.dart';

part 'car_select_model.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class CarSelectModel extends CarSelectEntity {
  CarSelectModel(
      {required super.brand,
      required super.licensePlate,
      required super.model,
      required super.defalut,
      required super.province,
      required super.maxDistance,
      required super.batteryCapacity,
      required super.maximumChargingPowerAc,
      required super.maximumChargingPowerDc,
      required super.image,
      required super.vehicleNo});

  factory CarSelectModel.fromJson(Map<String, dynamic> json) =>
      _$CarSelectModelFromJson(json);
  Map<String, dynamic> toJson() => _$CarSelectModelToJson(this);
}
