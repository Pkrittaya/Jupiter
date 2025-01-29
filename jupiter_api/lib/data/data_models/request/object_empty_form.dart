import 'package:json_annotation/json_annotation.dart';

part 'object_empty_form.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class ObjectEmptyForm {
  ObjectEmptyForm();

  factory ObjectEmptyForm.fromJson(Map<String, dynamic> json) =>
      _$ObjectEmptyFormFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$ObjectEmptyFormToJson(this);
}
