import 'package:json_annotation/json_annotation.dart';

import 'username_and_orgcode_form.dart';

part 'set_default_card_form.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class SetDefaultCardForm extends UsernameAndOrgCodeForm {
  SetDefaultCardForm({
    required super.username,
    required super.orgCode,
    required this.cardHashing,
    required this.defalut,
  });
  @JsonKey(name: 'card_hashing')
  final String cardHashing;
  @JsonKey(name: 'defalut')
  final bool defalut;

  factory SetDefaultCardForm.fromJson(Map<String, dynamic> json) =>
      _$SetDefaultCardFormFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$SetDefaultCardFormToJson(this);
}
