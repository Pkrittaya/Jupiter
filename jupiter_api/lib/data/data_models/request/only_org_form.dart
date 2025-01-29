import 'package:json_annotation/json_annotation.dart';

part 'only_org_form.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class OnlyOrgForm {
  const OnlyOrgForm({required this.orgCode});
  @JsonKey(name: 'org_code')
  final String orgCode;

  factory OnlyOrgForm.fromJson(Map<String, dynamic> json) =>
      _$OnlyOrgFormFromJson(json);
  Map<String, dynamic> toJson() => _$OnlyOrgFormToJson(this);
}
