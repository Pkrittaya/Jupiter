import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entities/request_otp_forgot_pin_entity.dart';

part 'request_otp_forgot_pin_model.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class RequestOtpForgotPinModel extends RequestOtpForgotPinEntity {
  RequestOtpForgotPinModel({
    required super.message,
    required super.otpRefNumber,
  });

  factory RequestOtpForgotPinModel.fromJson(Map<String, dynamic> json) =>
      _$RequestOtpForgotPinModelFromJson(json);
  Map<String, dynamic> toJson() => _$RequestOtpForgotPinModelToJson(this);
}
