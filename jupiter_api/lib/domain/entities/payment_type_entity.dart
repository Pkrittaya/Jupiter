import 'package:json_annotation/json_annotation.dart';

class PaymentTypeEntity {
  PaymentTypeEntity({
    required this.type,
    required this.display,
    required this.token,
    required this.brand,
  });
  @JsonKey(name: 'type')
  final String? type;
  @JsonKey(name: 'display')
  final String? display;
  @JsonKey(name: 'token')
  final String? token;
  @JsonKey(name: 'brand')
  final String? brand;
}
