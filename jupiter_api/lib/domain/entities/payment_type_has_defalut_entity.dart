import 'package:json_annotation/json_annotation.dart';

class PaymentTypeHasDefalutEntity {
  PaymentTypeHasDefalutEntity({
    required this.type,
    required this.display,
    required this.token,
    required this.brand,
    required this.defalut,
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
  @JsonKey(name: 'defalut')
  final bool? defalut;
  @JsonKey(name: 'name')
  final String? name;

  factory PaymentTypeHasDefalutEntity.fromJson(Map<String, dynamic> json) {
    return PaymentTypeHasDefalutEntity(
      type: json['type'] as String,
      display: json['display'] as String,
      token: json['token'] as String,
      brand: json['brand'] as String,
      defalut: json['defalut'] as bool,
      name: json['name'] as String,
    );
  }
}
