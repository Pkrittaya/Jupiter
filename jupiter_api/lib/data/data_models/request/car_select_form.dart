import 'package:json_annotation/json_annotation.dart';

part 'car_select_form.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class CarSelectForm {
  CarSelectForm({
    required this.vehicleNo,
    required this.brand,
    required this.licensePlate,
    required this.model,
    // required this.defalut,
    required this.province,
    required this.batteryCapacity,
    required this.currentPercentBattery,
    required this.maximumChargingPowerAc,
    required this.maximumChargingPowerDc,
    required this.image,
    required this.maxDistance,
  });

  @JsonKey(name: 'vehicle_no')
  final int vehicleNo;
  @JsonKey(name: 'brand')
  final String brand;
  @JsonKey(name: 'license_plate')
  final String licensePlate;
  @JsonKey(name: 'model')
  final String model;
  // final bool defalut;
  @JsonKey(name: 'battery_capacity')
  final double batteryCapacity;
  @JsonKey(name: 'current_percent_battery')
  final double currentPercentBattery;
  @JsonKey(name: 'maximum_charging_power_ac')
  final double maximumChargingPowerAc;
  @JsonKey(name: 'maximum_charging_power_dc')
  final double maximumChargingPowerDc;
  @JsonKey(name: 'image')
  final String image;
  @JsonKey(name: 'province')
  final String province;
  @JsonKey(name: 'max_distance')
  final double maxDistance;

  factory CarSelectForm.fromJson(Map<String, dynamic> json) =>
      _$CarSelectFormFromJson(json);
  Map<String, dynamic> toJson() => _$CarSelectFormToJson(this);
}
