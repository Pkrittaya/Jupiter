import 'package:json_annotation/json_annotation.dart';

import 'username_and_orgcode_form.dart';

part 'request_otp_forgot_pin_form.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class RequestOtpForgotPinForm extends UsernameAndOrgCodeForm {
  RequestOtpForgotPinForm(
      {required super.username,
      required super.orgCode,
      required this.telphoneNumber,
      required this.language});
  @JsonKey(name: 'telphonenumber')
  final String telphoneNumber;
  @JsonKey(name: 'language')
  final String language;

  factory RequestOtpForgotPinForm.fromJson(Map<String, dynamic> json) =>
      _$RequestOtpForgotPinFormFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$RequestOtpForgotPinFormToJson(this);
}
