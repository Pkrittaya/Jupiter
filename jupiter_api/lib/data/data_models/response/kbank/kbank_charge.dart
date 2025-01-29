import 'package:json_annotation/json_annotation.dart';

part 'kbank_charge.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class KBankCharge {
  KBankCharge({
    required this.token,
    required this.saveCard,
    required this.status,
    required this.objectId,
    required this.message,
  });
  @JsonKey(name: 'token')
  final String token;
  @JsonKey(name: 'saveCard')
  final String? saveCard;
  @JsonKey(name: 'status')
  final String? status;
  @JsonKey(name: 'objectId')
  final String objectId;
  @JsonKey(name: 'message')
  final String? message;

  factory KBankCharge.fromJson(Map<String, dynamic> json) =>
      _$KBankChargeFromJson(json);
  Map<String, dynamic> toJson() => _$KBankChargeToJson(this);
}
