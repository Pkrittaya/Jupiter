import 'package:json_annotation/json_annotation.dart';

part 'optional_detail_form.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class OptionalDetailForm {
  OptionalDetailForm({
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

  factory OptionalDetailForm.fromJson(Map<String, dynamic> json) =>
      _$OptionalDetailFormFromJson(json);
  Map<String, dynamic> toJson() => _$OptionalDetailFormToJson(this);
}
