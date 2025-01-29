import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entities/car_fleet_info_entity.dart';

part 'car_fleet_info_model.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class CarFleetInfoModel extends CarFleetInfoEntity {
  CarFleetInfoModel(
      {required super.brand,
      required super.licensePlate,
      required super.model,
      required super.orgCode,
      required super.defalut,
      required super.province,
      required super.vehicleNo,
      required super.image});

  factory CarFleetInfoModel.fromJson(Map<String, dynamic> json) =>
      _$CarFleetInfoModelFromJson(json);
  Map<String, dynamic> toJson() => _$CarFleetInfoModelToJson(this);
}
