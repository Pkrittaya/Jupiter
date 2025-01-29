import 'package:json_annotation/json_annotation.dart';
import 'package:jupiter_api/data/data_models/request/username_and_orgcode_form.dart';

part 'verify_email_form.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class VerifyEmailForm extends UsernameAndOrgCodeForm {
  VerifyEmailForm({
    required this.language,
    required super.username,
    required super.orgCode,
  });
  @JsonKey(name: 'language')
  final String language;

  factory VerifyEmailForm.fromJson(Map<String, dynamic> json) =>
      _$VerifyEmailFormFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$VerifyEmailFormToJson(this);
}
