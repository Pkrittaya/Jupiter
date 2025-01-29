import 'package:json_annotation/json_annotation.dart';

import 'username_and_orgcode_form.dart';

part 'delete_ev_car_image_form.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class DeleteEvCarImageForm extends UsernameAndOrgCodeForm {
  DeleteEvCarImageForm({
    required super.username,
    required super.orgCode,
    required this.brand,
    required this.model,
    required this.licensePlate,
  });
  @JsonKey(name: 'brand')
  final String brand;
  @JsonKey(name: 'model')
  final String model;
  @JsonKey(name: 'license_plate')
  final String licensePlate;

  factory DeleteEvCarImageForm.fromJson(Map<String, dynamic> json) =>
      _$DeleteEvCarImageFormFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$DeleteEvCarImageFormToJson(this);
}
