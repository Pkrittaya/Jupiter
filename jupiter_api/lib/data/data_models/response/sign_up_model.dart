import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entities/sign_up_entity.dart';

part 'sign_up_model.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class SignUpModel extends SignUpEntity {
  SignUpModel({required String message}) : super(message: message);

  factory SignUpModel.fromJson(Map<String, dynamic> json) =>
      _$SignUpModelFromJson(json);
  Map<String, dynamic> toJson() => _$SignUpModelToJson(this);

  // VerifyAccountEntity toEntity() => VerifyAccountEntity(
  //       message: message,
  //       otpRef: otpRef,
  //     );
}
