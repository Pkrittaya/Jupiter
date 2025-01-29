import 'package:json_annotation/json_annotation.dart';

import 'username_and_orgcode_form.dart';
part 'edit_ev_car_form.g.dart';

@JsonSerializable()
class EditEvCarForm extends UsernameAndOrgCodeForm {
  EditEvCarForm({
    required super.username,
    required super.orgCode,
    // required this.brand,
    // required this.model,
    required this.licensePlateCurrent,
    required this.licensePlate,
    required this.provinceCurrent,
    required this.province,
    required this.defalut,
    required this.vehicleNoCurrent,
    required this.vehicleNo,
  });
  // @JsonKey(name: 'brand')
  // final String brand;
  // @JsonKey(name: 'model')
  // final String model;
  @JsonKey(name: 'license_plate_current')
  final String licensePlateCurrent;
  @JsonKey(name: 'license_plate')
  final String licensePlate;
  @JsonKey(name: 'province_current')
  final String provinceCurrent;
  @JsonKey(name: 'province')
  final String province;
  @JsonKey(name: 'defalut')
  final bool defalut;
  @JsonKey(name: 'vehicle_no_current')
  final int vehicleNoCurrent;
  @JsonKey(name: 'vehicle_no')
  final int vehicleNo;

  factory EditEvCarForm.fromJson(Map<String, dynamic> json) =>
      _$EditEvCarFormFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$EditEvCarFormToJson(this);
}
