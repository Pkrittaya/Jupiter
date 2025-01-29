import 'package:json_annotation/json_annotation.dart';

import 'data_value_unit_entity.dart';

class ChargingInfoDataEntity {
  ChargingInfoDataEntity({
    required this.startTimeCharging,
    required this.estimateDistance,
    required this.powerRealtime,
    required this.voltage,
    required this.current,
    required this.power,
    required this.percent,
    required this.totalPrice,
  });
  @JsonKey(name: 'start_time_charging')
  final String? startTimeCharging;
  @JsonKey(name: 'estimate_distance')
  final DataValueUnitEntity? estimateDistance;
  @JsonKey(name: 'power_realtime')
  final DataValueUnitEntity? powerRealtime;
  @JsonKey(name: 'voltage')
  final DataValueUnitEntity? voltage;
  @JsonKey(name: 'current')
  final DataValueUnitEntity? current;
  @JsonKey(name: 'power')
  final DataValueUnitEntity? power;
  @JsonKey(name: 'percent')
  final DataValueUnitEntity? percent;
  @JsonKey(name: 'total_price')
  final DataValueUnitEntity? totalPrice;
}
