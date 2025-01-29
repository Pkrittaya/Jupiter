import 'package:json_annotation/json_annotation.dart';

import 'username_and_orgcode_form.dart';

part 'delete_card_payment_form.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class DeleteCardPaymentForm extends UsernameAndOrgCodeForm {
  DeleteCardPaymentForm({
    required super.username,
    required super.orgCode,
    required this.cardHashing,
  });
  @JsonKey(name: 'card_hashing')
  final String cardHashing;

  factory DeleteCardPaymentForm.fromJson(Map<String, dynamic> json) =>
      _$DeleteCardPaymentFormFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$DeleteCardPaymentFormToJson(this);
}
