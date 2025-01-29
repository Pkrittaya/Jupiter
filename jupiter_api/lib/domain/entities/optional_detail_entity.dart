import 'package:json_annotation/json_annotation.dart';

class OptionalDetailEntity {
  OptionalDetailEntity({
    required this.optionalType,
    required this.optionalValue,
    required this.optionalUnit,
  });

  @JsonKey(name: 'optional_type')
  final String optionalType;
  @JsonKey(name: 'optional_value')
  final double optionalValue;
  @JsonKey(name: 'optional_unit')
  final String optionalUnit;
}
