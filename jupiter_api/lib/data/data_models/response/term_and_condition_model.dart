import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entities/term_and_condition_entity.dart';

part 'term_and_condition_model.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class TermAndConditionModel extends TermAndConditionEntity {
  TermAndConditionModel(
      {required String header, required String body, required String footer})
      : super(header: header, body: body, footer: footer);

  factory TermAndConditionModel.fromJson(Map<String, dynamic> json) =>
      _$TermAndConditionModelFromJson(json);
  Map<String, dynamic> toJson() => _$TermAndConditionModelToJson(this);

  // VerifyAccountEntity toEntity() => VerifyAccountEntity(
  //       message: message,
  //       otpRef: otpRef,
  //     );
}
