import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entities/verify_account_entity.dart';

part 'verify_account_model.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class VerifyAccountModel extends VerifyAccountEntity {
  VerifyAccountModel({required String message, otpRefNumber})
      : super(message: message, otpRefNumber: otpRefNumber);

  factory VerifyAccountModel.fromJson(Map<String, dynamic> json) =>
      _$VerifyAccountModelFromJson(json);
  Map<String, dynamic> toJson() => _$VerifyAccountModelToJson(this);

  // VerifyAccountEntity toEntity() => VerifyAccountEntity(
  //       message: message,
  //       otpRef: otpRef,
  //     );
}
