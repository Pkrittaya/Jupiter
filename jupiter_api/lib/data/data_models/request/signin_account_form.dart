import 'package:json_annotation/json_annotation.dart';

part 'signin_account_form.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class SignInAccountForm {
  const SignInAccountForm({
    required this.username,
    required this.password,
    required this.deviceCode,
    required this.notificationToken,
    required this.language,
    required this.orgCode,
  });

  @JsonKey(name: 'org_code')
  final String orgCode;
  @JsonKey(name: 'username')
  final String username;
  @JsonKey(name: 'password')
  final String password;
  @JsonKey(name: 'device_code')
  final String deviceCode;
  @JsonKey(name: 'notification_token')
  final String notificationToken;
  @JsonKey(name: 'language')
  final String language;
  factory SignInAccountForm.fromJson(Map<String, dynamic> json) =>
      _$SignInAccountFormFromJson(json);
  Map<String, dynamic> toJson() => _$SignInAccountFormToJson(this);
}
