import 'package:json_annotation/json_annotation.dart';

part 'payment_type_form.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class PaymentTypeForm {
  PaymentTypeForm({
    required this.type,
    required this.display,
    required this.token,
    required this.brand,
    required this.name,
  });
  @JsonKey(name: 'type')
  final String? type;
  @JsonKey(name: 'display')
  final String? display;
  @JsonKey(name: 'token')
  final String? token;
  @JsonKey(name: 'brand')
  final String? brand;
  @JsonKey(name: 'name')
  final String? name;

  factory PaymentTypeForm.fromJson(Map<String, dynamic> json) =>
      _$PaymentTypeFormFromJson(json);
  Map<String, dynamic> toJson() => _$PaymentTypeFormToJson(this);
}
