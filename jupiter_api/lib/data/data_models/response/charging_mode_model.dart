import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entities/charging_mode_entity.dart';

part 'charging_mode_model.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class ChargingModeModel extends ChargingModeEntity {
  ChargingModeModel({
    required super.mode,
    required super.power,
    required super.powerUnit,
    required super.price,
    required super.priceUnit,
  });
  factory ChargingModeModel.fromJson(Map<String, dynamic> json) =>
      _$ChargingModeModelFromJson(json);
  Map<String, dynamic> toJson() => _$ChargingModeModelToJson(this);
}
