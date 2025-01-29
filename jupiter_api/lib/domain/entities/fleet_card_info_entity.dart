import 'package:json_annotation/json_annotation.dart';

import 'car_fleet_info_entity.dart';

class FleetCardInfoEntity {
  FleetCardInfoEntity({
    required this.fleetCardNo,
    required this.creditMax,
    required this.creditUsage,
    required this.totalEnergyCharging,
    required this.billDate,
    required this.image,
    required this.fleetCar,
  });
  @JsonKey(name: 'fleet_card_no')
  final String fleetCardNo;
  @JsonKey(name: 'credit_max')
  final double creditMax;
  @JsonKey(name: 'credit_usage')
  final double creditUsage;
  @JsonKey(name: 'total_energy_charging')
  final double totalEnergyCharging;
  @JsonKey(name: 'bill_date')
  final String billDate;
  @JsonKey(name: 'image')
  final String image;
  @JsonKey(name: 'fleet_car')
  final CarFleetInfoEntity fleetCar;
}
