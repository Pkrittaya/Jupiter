import 'package:json_annotation/json_annotation.dart';

part 'signout_account_form.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class SignOutAccountForm {
  const SignOutAccountForm(
      {required this.username,
      required this.deviceCode,
      required this.orgCode,
      required this.language});

  @JsonKey(name: 'org_code')
  final String orgCode;
  @JsonKey(name: 'username')
  final String username;
  @JsonKey(name: 'device_code')
  final String deviceCode;
  @JsonKey(name: 'language')
  final String language;

  factory SignOutAccountForm.fromJson(Map<String, dynamic> json) =>
      _$SignOutAccountFormFromJson(json);
  Map<String, dynamic> toJson() => _$SignOutAccountFormToJson(this);
}
