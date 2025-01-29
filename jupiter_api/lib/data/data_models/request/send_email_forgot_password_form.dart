import 'package:json_annotation/json_annotation.dart';

import 'only_org_form.dart';

part 'send_email_forgot_password_form.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class SendEmailForgotPasswordForm extends OnlyOrgForm {
  SendEmailForgotPasswordForm(
      {required this.email, required this.language, required super.orgCode});
  @JsonKey(name: 'email')
  final String email;
  @JsonKey(name: 'language')
  final String language;

  factory SendEmailForgotPasswordForm.fromJson(Map<String, dynamic> json) =>
      _$SendEmailForgotPasswordFormFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$SendEmailForgotPasswordFormToJson(this);
}
