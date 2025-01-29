import 'package:json_annotation/json_annotation.dart';

class CarModelMasterEntity {
  CarModelMasterEntity({
    required this.name,
    required this.image,
    this.batteryCapacity,
    this.maximumChargingPowerAc,
    this.maximumChargingPowerDc,
    this.maxDistance,
    this.vehicleNo,
  });
  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'image')
  final String image;
  @JsonKey(name: 'battery_capacity')
  final String? batteryCapacity;
  @JsonKey(name: 'maximum_charging_power_ac')
  final String? maximumChargingPowerAc;
  @JsonKey(name: 'maximum_charging_power_dc')
  final String? maximumChargingPowerDc;
  @JsonKey(name: 'max_distance')
  final String? maxDistance;
  @JsonKey(name: 'vehicle_no')
  final int? vehicleNo;
}
