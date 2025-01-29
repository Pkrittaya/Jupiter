import 'package:json_annotation/json_annotation.dart';

import 'default_entity.dart';

class VerifyAccountEntity extends DefaultEntity {
  VerifyAccountEntity({required super.message, required this.otpRefNumber});
  @JsonKey(name: 'otp_ref_number')
  final String otpRefNumber;
}
