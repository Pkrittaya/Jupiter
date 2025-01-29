import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entities/car_master_entity.dart';
import 'car_model_master_model.dart';

part 'car_master_model.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class CarMasterModel extends CarMasterEntity {
  CarMasterModel({required super.brand, required this.model})
      : super(model: model);

  @override
  @JsonKey(name: 'model')
  final List<CarModelMasterModel> model;

  factory CarMasterModel.fromJson(Map<String, dynamic> json) =>
      _$CarMasterModelFromJson(json);
  Map<String, dynamic> toJson() => _$CarMasterModelToJson(this);
}
