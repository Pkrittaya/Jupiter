import 'package:json_annotation/json_annotation.dart';

class ChargingModeEntity {
  ChargingModeEntity({
    required this.mode,
    required this.power,
    required this.powerUnit,
    required this.price,
    required this.priceUnit,
  });
  @JsonKey(name: 'mode')
  final String mode;
  @JsonKey(name: 'power')
  final double power;
  @JsonKey(name: 'power_unit')
  final String powerUnit;
  @JsonKey(name: 'price')
  final double price;
  @JsonKey(name: 'price_unit')
  final String priceUnit;
}
