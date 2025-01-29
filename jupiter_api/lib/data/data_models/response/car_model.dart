import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entities/car_entity.dart';

part 'car_model.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class CarModel extends CarEntity {
  CarModel(
      {required super.brand,
      required super.licensePlate,
      required super.model,
      required super.orgCode,
      required super.username,
      required super.defalut,
      required super.province,
      required super.vehicleNo,
      super.image});

  factory CarModel.fromJson(Map<String, dynamic> json) =>
      _$CarModelFromJson(json);
  Map<String, dynamic> toJson() => _$CarModelToJson(this);
}
