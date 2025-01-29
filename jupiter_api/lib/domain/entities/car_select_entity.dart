import 'package:json_annotation/json_annotation.dart';

class CarSelectEntity {
  CarSelectEntity(
      {required this.brand,
      required this.licensePlate,
      required this.model,
      required this.defalut,
      required this.province,
      required this.maxDistance,
      required this.batteryCapacity,
      required this.maximumChargingPowerAc,
      required this.maximumChargingPowerDc,
      required this.image,
      required this.vehicleNo});
  @JsonKey(name: 'brand')
  final String? brand;
  @JsonKey(name: 'license_plate')
  final String? licensePlate;
  @JsonKey(name: 'model')
  final String? model;
  @JsonKey(name: 'defalut')
  final bool? defalut;
  @JsonKey(name: 'battery_capacity')
  final double? batteryCapacity;
  @JsonKey(name: 'max_distance')
  final double? maxDistance;
  @JsonKey(name: 'maximum_charging_power_ac')
  final double? maximumChargingPowerAc;
  @JsonKey(name: 'maximum_charging_power_dc')
  final double? maximumChargingPowerDc;
  @JsonKey(name: 'image')
  final String? image;
  @JsonKey(name: 'province')
  final String? province;
  @JsonKey(name: 'vehicle_no')
  final int vehicleNo;
}
