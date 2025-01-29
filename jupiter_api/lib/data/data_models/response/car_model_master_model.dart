import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entities/car_model_master_entity.dart';

part 'car_model_master_model.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class CarModelMasterModel extends CarModelMasterEntity {
  CarModelMasterModel({
    required super.name,
    required super.image,
    super.batteryCapacity,
    super.maximumChargingPowerAc,
    super.maximumChargingPowerDc,
    super.maxDistance,
    super.vehicleNo,
  });

  factory CarModelMasterModel.fromJson(Map<String, dynamic> json) =>
      _$CarModelMasterModelFromJson(json);
  Map<String, dynamic> toJson() => _$CarModelMasterModelToJson(this);
}
