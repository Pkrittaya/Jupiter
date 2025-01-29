import 'package:json_annotation/json_annotation.dart';

class CreditCardEntity {
  CreditCardEntity({
    required this.display,
    required this.cardBrand,
    required this.cardExpired,
    required this.cardHashing,
    required this.defalut,
    required this.type,
    required this.name,
  });
  @JsonKey(name: 'display')
  final String display;
  @JsonKey(name: 'card_brand')
  final String cardBrand;
  @JsonKey(name: 'card_expired')
  final String cardExpired;
  @JsonKey(name: 'card_hashing')
  final String cardHashing;
  @JsonKey(name: 'defalut')
  final bool defalut;
  @JsonKey(name: 'type')
  final String type;
  @JsonKey(name: 'name')
  final String name;
}
