import 'package:json_annotation/json_annotation.dart';

class HistoryBookingDetailEntity {
  HistoryBookingDetailEntity({
    required this.reserveOn,
    required this.stationName,
    required this.chargeName,
    required this.connectorName,
    required this.startTimeReserve,
    required this.endTimeReserve,
    required this.reserveTimeCreate,
    required this.reserveTimeExpired,
    required this.reserveTimeMinute,
    required this.reserveRate,
    required this.reserveTax,
    required this.reserveBeforeTax,
    required this.reservePrice,
    required this.paymentMethod,
  });
  @JsonKey(name: 'reserve_on')
  final int reserveOn;
  @JsonKey(name: 'station_name')
  final String stationName;
  @JsonKey(name: 'charger_name')
  final String chargeName;
  @JsonKey(name: 'connector_name')
  final String connectorName;
  @JsonKey(name: 'start_time_reserve')
  final String startTimeReserve;
  @JsonKey(name: 'end_time_reserve')
  final String endTimeReserve;
  @JsonKey(name: 'reserve_time_create')
  final String reserveTimeCreate;
  @JsonKey(name: 'reserve_time_expired')
  final String reserveTimeExpired;
  @JsonKey(name: 'reserve_time_minute')
  final String reserveTimeMinute;
  @JsonKey(name: 'reserve_rate')
  final double reserveRate;
  @JsonKey(name: 'reserve_tax')
  final double reserveTax;
  @JsonKey(name: 'reserve_before_tax')
  final double reserveBeforeTax;
  @JsonKey(name: 'reserve_price')
  final double reservePrice;
  @JsonKey(name: 'payment_method')
  final String paymentMethod;
}
