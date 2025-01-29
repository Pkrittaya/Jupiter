import 'package:json_annotation/json_annotation.dart';

import 'car_model_master_entity.dart';

class CarMasterEntity {
  CarMasterEntity({required this.brand, required this.model});
  @JsonKey(name: 'brand')
  final String brand;
  @JsonKey(name: 'model')
  final List<CarModelMasterEntity> model;
}
