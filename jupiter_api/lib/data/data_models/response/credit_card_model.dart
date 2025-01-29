import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entities/credit_card_entity.dart';

part 'credit_card_model.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class CreditCardModel extends CreditCardEntity {
  CreditCardModel({
    required super.display,
    required super.cardBrand,
    required super.cardExpired,
    required super.cardHashing,
    required super.defalut,
    required super.type,
    required super.name,
  });

  factory CreditCardModel.fromJson(Map<String, dynamic> json) =>
      _$CreditCardModelFromJson(json);
  Map<String, dynamic> toJson() => _$CreditCardModelToJson(this);
}
