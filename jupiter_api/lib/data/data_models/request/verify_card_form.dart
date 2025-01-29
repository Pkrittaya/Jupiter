import 'package:json_annotation/json_annotation.dart';

import 'username_and_orgcode_form.dart';

part 'verify_card_form.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class VerifyCardForm extends UsernameAndOrgCodeForm {
  VerifyCardForm({
    required this.token,
    required super.username,
    required super.orgCode,
  });
  @JsonKey(name: 'token')
  final String token;

  factory VerifyCardForm.fromJson(Map<String, dynamic> json) =>
      _$VerifyCardFormFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$VerifyCardFormToJson(this);
}
