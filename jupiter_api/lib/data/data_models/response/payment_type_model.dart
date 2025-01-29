import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entities/payment_type_has_defalut_entity.dart';

part 'payment_type_model.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class PaymentTypeModel extends PaymentTypeHasDefalutEntity {
  PaymentTypeModel({
    required super.type,
    required super.display,
    required super.token,
    required super.brand,
    required super.defalut,
    required super.name,
  });
  factory PaymentTypeModel.fromJson(Map<String, dynamic> json) =>
      _$PaymentTypeModelFromJson(json);
  Map<String, dynamic> toJson() => _$PaymentTypeModelToJson(this);
}
