import 'package:json_annotation/json_annotation.dart';

import 'verify_account_form.dart';

part 'signup_account_form.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class SignupAccountForm extends VerifyAccountForm {
  const SignupAccountForm(
      {required String username,
      required String password,
      required String name,
      required String lastname,
      required String telphonenumber,
      required String gender,
      required DateTime dateofbirth,
      required String language,
      required this.otpCode,
      required this.orgCode})
      : super(
            username: username,
            password: password,
            name: name,
            lastname: lastname,
            telphonenumber: telphonenumber,
            gender: gender,
            dateofbirth: dateofbirth,
            orgCode: orgCode,
            language: language);
  @JsonKey(name: 'otp_code')
  final String otpCode;
  @override
  @JsonKey(name: 'org_code')
  final String orgCode;
  factory SignupAccountForm.fromJson(Map<String, dynamic> json) =>
      _$SignupAccountFormFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$SignupAccountFormToJson(this);
}
