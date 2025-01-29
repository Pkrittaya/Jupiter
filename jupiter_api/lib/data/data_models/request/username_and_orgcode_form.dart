import 'package:json_annotation/json_annotation.dart';

import 'only_org_form.dart';

part 'username_and_orgcode_form.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class UsernameAndOrgCodeForm extends OnlyOrgForm {
  UsernameAndOrgCodeForm({
    required this.username,
    required super.orgCode,
  });
  @JsonKey(name: 'username')
  final String username;

  factory UsernameAndOrgCodeForm.fromJson(Map<String, dynamic> json) =>
      _$UsernameAndOrgCodeFormFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$UsernameAndOrgCodeFormToJson(this);
}
