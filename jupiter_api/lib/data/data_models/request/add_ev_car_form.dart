import 'package:json_annotation/json_annotation.dart';

import 'username_and_orgcode_form.dart';

part 'add_ev_car_form.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class AddEvCarForm extends UsernameAndOrgCodeForm {
  AddEvCarForm({
    required super.username,
    required super.orgCode,
    // required this.brand,
    // required this.model,
    required this.licensePlate,
    required this.province,
    required this.defalut,
    required this.vehicleNo,
  });
  // @JsonKey(name: 'brand')
  // final String brand;
  // @JsonKey(name: 'model')
  // final String model;
  @JsonKey(name: 'license_plate')
  final String licensePlate;
  @JsonKey(name: 'province')
  final String province;
  @JsonKey(name: 'defalut')
  final bool defalut;
  @JsonKey(name: 'vehicle_no')
  final int vehicleNo;

  factory AddEvCarForm.fromJson(Map<String, dynamic> json) =>
      _$AddEvCarFormFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$AddEvCarFormToJson(this);
}
