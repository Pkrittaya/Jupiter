import 'package:json_annotation/json_annotation.dart';

part 'verify_fleet_card_form.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class VerifyFleetCardForm {
  VerifyFleetCardForm({required this.cardNo, required this.expiredDate});
  @JsonKey(name: 'card_no')
  final String cardNo;
  @JsonKey(name: 'expired_date')
  final String expiredDate;

  factory VerifyFleetCardForm.fromJson(Map<String, dynamic> json) =>
      _$VerifyFleetCardFormFromJson(json);
  Map<String, dynamic> toJson() => _$VerifyFleetCardFormToJson(this);
}
