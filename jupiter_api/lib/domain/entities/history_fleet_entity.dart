import 'package:json_annotation/json_annotation.dart';

class HistoryFleetDataEntity {
  HistoryFleetDataEntity({
    required this.transactionId,
    required this.stationId,
    required this.stationName,
    required this.totalPrice,
    required this.totalPriceUnit,
    required this.timeStamp,
  });
  @JsonKey(name: 'transaction_id')
  final int transactionId;
  @JsonKey(name: 'station_id')
  final String stationId;
  @JsonKey(name: 'station_name')
  final String stationName;
  @JsonKey(name: 'total_price')
  final double totalPrice;
  @JsonKey(name: 'total_price_unit')
  final String totalPriceUnit;
  @JsonKey(name: 'time_stamp')
  final String timeStamp;
}
