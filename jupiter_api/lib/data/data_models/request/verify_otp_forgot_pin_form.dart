import 'package:json_annotation/json_annotation.dart';

import 'username_and_orgcode_form.dart';

part 'verify_otp_forgot_pin_form.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class VerifyOtpForgotPinForm extends UsernameAndOrgCodeForm {
  VerifyOtpForgotPinForm(
      {required super.username,
      required super.orgCode,
      required this.telphoneNumber,
      required this.otpCode,
      required this.otpRefNumber,
      required this.language});
  @JsonKey(name: 'telphonenumber')
  final String telphoneNumber;
  @JsonKey(name: 'otpcode')
  final String otpCode;
  @JsonKey(name: 'otp_ref_number')
  final String otpRefNumber;
  @JsonKey(name: 'language')
  final String language;

  factory VerifyOtpForgotPinForm.fromJson(Map<String, dynamic> json) =>
      _$VerifyOtpForgotPinFormFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$VerifyOtpForgotPinFormToJson(this);
}
