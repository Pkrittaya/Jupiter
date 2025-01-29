import 'package:json_annotation/json_annotation.dart';

import '../../../../domain/entities/data_value_unit_entity.dart';

part 'data_value_unit_model.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class DataValueUnitModel extends DataValueUnitEntity {
  DataValueUnitModel({
    required this.value,
    required this.unit,
  }) : super(value: value, unit: unit);

  @override
  @JsonKey(name: 'value')
  final double value;
  @override
  @JsonKey(name: 'unit')
  final String unit;

  factory DataValueUnitModel.fromJson(Map<String, dynamic> json) =>
      _$DataValueUnitModelFromJson(json);
  Map<String, dynamic> toJson() => _$DataValueUnitModelToJson(this);
}
