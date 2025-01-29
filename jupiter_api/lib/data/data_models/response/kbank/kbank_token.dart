import 'package:json_annotation/json_annotation.dart';

part 'kbank_token.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class KBankToken {
  KBankToken({required this.token, required this.saveCard, required this.mid});
  @JsonKey(name: 'token')
  final String token;
  @JsonKey(name: 'saveCard')
  final bool? saveCard;
  @JsonKey(name: 'mid')
  final String? mid;
  factory KBankToken.fromJson(Map<String, dynamic> json) =>
      _$KBankTokenFromJson(json);
  Map<String, dynamic> toJson() => _$KBankTokenToJson(this);
}
