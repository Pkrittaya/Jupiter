import 'package:json_annotation/json_annotation.dart';

part 'car_select_fleet_form.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class CarSelectFleetForm {
  CarSelectFleetForm({
    required this.vehicleNo,
    required this.licensePlate,
    required this.province,
  });

  @JsonKey(name: 'vehicle_no')
  final int vehicleNo;
  @JsonKey(name: 'license_plate')
  final String licensePlate;
  @JsonKey(name: 'province')
  final String province;

  factory CarSelectFleetForm.fromJson(Map<String, dynamic> json) =>
      _$CarSelectFleetFormFromJson(json);
  Map<String, dynamic> toJson() => _$CarSelectFleetFormToJson(this);
}
