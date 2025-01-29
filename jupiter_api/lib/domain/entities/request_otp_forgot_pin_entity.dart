import 'package:json_annotation/json_annotation.dart';

class RequestOtpForgotPinEntity {
  RequestOtpForgotPinEntity({
    required this.message,
    required this.otpRefNumber,
  });
  @JsonKey(name: 'message')
  final String message;
  @JsonKey(name: 'otp_ref_number')
  final String otpRefNumber;
}
