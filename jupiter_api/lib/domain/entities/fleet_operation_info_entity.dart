import 'package:json_annotation/json_annotation.dart';

import 'car_fleet_info_entity.dart';

class FleetOperationInfoEntity {
  FleetOperationInfoEntity({
    required this.fleetName,
    required this.fleetOperationNo,
    required this.creditMax,
    required this.creditUsage,
    required this.totalEnergyCharging,
    required this.billDate,
    required this.totalCarOperation,
    required this.image,
    required this.fleetCar,
  });
  @JsonKey(name: 'fleet_name')
  final String fleetName;
  @JsonKey(name: 'fleet_operation_no')
  final int fleetOperationNo;
  @JsonKey(name: 'credit_max')
  final double creditMax;
  @JsonKey(name: 'credit_usage')
  final double creditUsage;
  @JsonKey(name: 'total_energy_charging')
  final double totalEnergyCharging;
  @JsonKey(name: 'bill_date')
  final String billDate;
  @JsonKey(name: 'total_car_operation')
  final int totalCarOperation;
  @JsonKey(name: 'image')
  final String image;
  @JsonKey(name: 'fleet_car')
  final List<CarFleetInfoEntity> fleetCar;
}
