import 'package:json_annotation/json_annotation.dart';

class HistoryBookingEntity {
  HistoryBookingEntity({
    required this.reserveOn,
    required this.stationId,
    required this.stationName,
    required this.totalPrice,
    required this.totalPriceUnit,
    required this.timeStamp,
  });
  @JsonKey(name: 'reserve_on')
  final double reserveOn;
  @JsonKey(name: 'station_id')
  final String stationId;
  @JsonKey(name: 'station_name')
  final String stationName;
  @JsonKey(name: 'total_price')
  final String totalPrice;
  @JsonKey(name: 'total_price_unit')
  final String totalPriceUnit;
  @JsonKey(name: 'time_stamp')
  final String timeStamp;
}
