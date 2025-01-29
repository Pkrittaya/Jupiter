import 'package:json_annotation/json_annotation.dart';

import '../../../../domain/entities/history_data_entity.dart';

part 'history_list_data_model.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class HistoryListDataModel extends HistoryDataEntity {
  HistoryListDataModel({
    required super.transactionId,
    required super.stationId,
    required super.stationName,
    required super.totalPrice,
    required super.totalPriceUnit,
    required super.timeStamp,
  });

  factory HistoryListDataModel.fromJson(Map<String, dynamic> json) =>
      _$HistoryListDataModelFromJson(json);
  Map<String, dynamic> toJson() => _$HistoryListDataModelToJson(this);
}
