import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entities/fleet_card_item_entity.dart';

part 'fleet_card_item_model.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class FleetCardItemModel extends FleetCardItemEntity {
  FleetCardItemModel(
      {required super.fleetNo,
      required super.fleetCardNo,
      required super.statusCharging,
      required super.credit,
      required super.available,
      required super.expired,
      required super.image,
      required super.status,
      required super.fleetCardType});

  factory FleetCardItemModel.fromJson(Map<String, dynamic> json) =>
      _$FleetCardItemModelFromJson(json);
  Map<String, dynamic> toJson() => _$FleetCardItemModelToJson(this);
}
