import 'package:json_annotation/json_annotation.dart';

class PaymentSelectedEntity {
  PaymentSelectedEntity({
    required this.type,
    required this.display,
    required this.token,
    required this.brand,
    required this.defalut,
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

  factory PaymentSelectedEntity.fromJson(Map<String, dynamic> json) {
    return PaymentSelectedEntity(
      type: json['type'] as String,
      display: json['display'] as String,
      token: json['token'] as String,
      brand: json['brand'] as String,
      defalut: json['defalut'] as bool,
    );
  }
}
