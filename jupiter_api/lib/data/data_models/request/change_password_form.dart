import 'package:json_annotation/json_annotation.dart';

part 'change_password_form.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class ChangePasswordForm {
  ChangePasswordForm({
    required this.token,
    required this.passwordCurrent,
    required this.passwordNew,
  });
  @JsonKey(name: 'token')
  final String token;
  @JsonKey(name: 'password_current')
  final String passwordCurrent;
  @JsonKey(name: 'password_new')
  final String passwordNew;

  factory ChangePasswordForm.fromJson(Map<String, dynamic> json) =>
      _$ChangePasswordFormFromJson(json);
  Map<String, dynamic> toJson() => _$ChangePasswordFormToJson(this);
}
