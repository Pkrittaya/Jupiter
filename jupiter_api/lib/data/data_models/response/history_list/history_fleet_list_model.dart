import 'package:json_annotation/json_annotation.dart';

import '../../../../domain/entities/history_fleet_entity.dart';

part 'history_fleet_list_model.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class HistoryFleetModel extends HistoryFleetDataEntity {
  HistoryFleetModel({
    required super.transactionId,
    required super.stationId,
    required super.stationName,
    required super.totalPrice,
    required super.totalPriceUnit,
    required super.timeStamp,
  });

  factory HistoryFleetModel.fromJson(Map<String, dynamic> json) =>
      _$HistoryFleetModelFromJson(json);
  Map<String, dynamic> toJson() => _$HistoryFleetModelToJson(this);
}
