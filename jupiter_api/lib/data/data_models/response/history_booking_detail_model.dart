import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entities/history_booking_detail_entity.dart';

part 'history_booking_detail_model.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class HistoryBookingDetailModel extends HistoryBookingDetailEntity {
  HistoryBookingDetailModel({
    required super.reserveOn,
    required super.stationName,
    required super.chargeName,
    required super.connectorName,
    required super.startTimeReserve,
    required super.endTimeReserve,
    required super.reserveTimeCreate,
    required super.reserveTimeExpired,
    required super.reserveTimeMinute,
    required super.reserveRate,
    required super.reserveTax,
    required super.reserveBeforeTax,
    required super.reservePrice,
    required super.paymentMethod,
  });

  factory HistoryBookingDetailModel.fromJson(Map<String, dynamic> json) =>
      _$HistoryBookingDetailModelFromJson(json);
  Map<String, dynamic> toJson() => _$HistoryBookingDetailModelToJson(this);
}
