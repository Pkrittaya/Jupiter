import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entities/fleet_card_info_entity.dart';
import 'car_fleet_info_model.dart';

part 'fleet_card_info_model.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class FleetCardInfoModel extends FleetCardInfoEntity {
  FleetCardInfoModel({
    required super.fleetCardNo,
    required super.creditMax,
    required super.creditUsage,
    required super.totalEnergyCharging,
    required super.billDate,
    required super.image,
    required this.fleetCar,
  }) : super(fleetCar: fleetCar);

  @override
  @JsonKey(name: 'fleet_car')
  final CarFleetInfoModel fleetCar;

  factory FleetCardInfoModel.fromJson(Map<String, dynamic> json) =>
      _$FleetCardInfoModelFromJson(json);
  Map<String, dynamic> toJson() => _$FleetCardInfoModelToJson(this);
}
