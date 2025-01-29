import 'package:json_annotation/json_annotation.dart';

import '../../../../domain/entities/charging_info_data_entity.dart';
import 'data_value_unit_model.dart';

part 'charging_info_data_model.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class ChargingInfoDataModel extends ChargingInfoDataEntity {
  ChargingInfoDataModel({
    required super.startTimeCharging,
    required this.estimateDistance,
    required this.powerRealtime,
    required this.voltage,
    required this.current,
    required this.power,
    required this.percent,
    required this.totalPrice,
  }) : super(
            estimateDistance: estimateDistance,
            powerRealtime: powerRealtime,
            voltage: voltage,
            current: current,
            power: power,
            percent: percent,
            totalPrice: totalPrice);

  @override
  @JsonKey(name: 'estimate_distance')
  final DataValueUnitModel? estimateDistance;
  @override
  @JsonKey(name: 'power_realtime')
  final DataValueUnitModel? powerRealtime;
  @override
  @JsonKey(name: 'voltage')
  final DataValueUnitModel? voltage;
  @override
  @JsonKey(name: 'current')
  final DataValueUnitModel? current;
  @override
  @JsonKey(name: 'power')
  final DataValueUnitModel? power;
  @override
  @JsonKey(name: 'percent')
  final DataValueUnitModel? percent;
  @override
  @JsonKey(name: 'total_price')
  final DataValueUnitModel? totalPrice;

  factory ChargingInfoDataModel.fromJson(Map<String, dynamic> json) =>
      _$ChargingInfoDataModelFromJson(json);
  Map<String, dynamic> toJson() => _$ChargingInfoDataModelToJson(this);
}
