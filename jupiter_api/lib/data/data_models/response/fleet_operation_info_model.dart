import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entities/fleet_operation_info_entity.dart';
import 'car_fleet_info_model.dart';

part 'fleet_operation_info_model.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class FleetOperationInfoModel extends FleetOperationInfoEntity {
  FleetOperationInfoModel({
    required super.fleetName,
    required super.fleetOperationNo,
    required super.creditMax,
    required super.creditUsage,
    required super.totalEnergyCharging,
    required super.billDate,
    required super.totalCarOperation,
    required super.image,
    required this.fleetCar,
  }) : super(fleetCar: fleetCar);

  @override
  @JsonKey(name: 'fleet_car')
  final List<CarFleetInfoModel> fleetCar;

  factory FleetOperationInfoModel.fromJson(Map<String, dynamic> json) =>
      _$FleetOperationInfoModelFromJson(json);
  Map<String, dynamic> toJson() => _$FleetOperationInfoModelToJson(this);
}
