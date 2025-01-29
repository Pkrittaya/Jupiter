import 'package:json_annotation/json_annotation.dart';

class DataValueUnitEntity {
  DataValueUnitEntity({
    required this.value,
    required this.unit,
  });
  @JsonKey(name: 'value')
  final double value;
  @JsonKey(name: 'unit')
  final String unit;
}
