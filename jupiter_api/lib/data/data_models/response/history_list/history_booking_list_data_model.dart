import 'package:json_annotation/json_annotation.dart';

import '../../../../domain/entities/history_booking_entity.dart';

part 'history_booking_list_data_model.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class HistoryBookingListDataModel extends HistoryBookingEntity {
  HistoryBookingListDataModel({
    required super.reserveOn,
    required super.stationId,
    required super.stationName,
    required super.totalPrice,
    required super.totalPriceUnit,
    required super.timeStamp,
  });

  factory HistoryBookingListDataModel.fromJson(Map<String, dynamic> json) =>
      _$HistoryBookingListDataModelFromJson(json);
  Map<String, dynamic> toJson() => _$HistoryBookingListDataModelToJson(this);
}
