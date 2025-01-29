import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entities/has_charging_fleet_card_entity.dart';

part 'has_charging_fleet_card_model.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class HasChargingFleetModel extends HasChargingFleetEntity {
  HasChargingFleetModel({required super.chargingStatus});

  factory HasChargingFleetModel.fromJson(Map<String, dynamic> json) =>
      _$HasChargingFleetModelFromJson(json);
  Map<String, dynamic> toJson() => _$HasChargingFleetModelToJson(this);
}
