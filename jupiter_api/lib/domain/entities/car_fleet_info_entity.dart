import 'package:json_annotation/json_annotation.dart';

class CarFleetInfoEntity {
  CarFleetInfoEntity(
      {required this.brand,
      required this.licensePlate,
      required this.model,
      required this.orgCode,
      required this.defalut,
      required this.province,
      required this.image,
      required this.vehicleNo});
  @JsonKey(name: 'brand')
  final String brand;
  @JsonKey(name: 'license_plate')
  final String licensePlate;
  @JsonKey(name: 'model')
  final String model;
  @JsonKey(name: 'org_code')
  final String orgCode;
  @JsonKey(name: 'defalut')
  final bool defalut;
  @JsonKey(name: 'province')
  final String province;
  @JsonKey(name: 'image')
  final String image;
  @JsonKey(name: 'vehicle_no')
  final int vehicleNo;
}
