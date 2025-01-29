import 'package:json_annotation/json_annotation.dart';

class ListReserveOfConnectorEntity {
  ListReserveOfConnectorEntity({
    required this.startTimeReserve,
    required this.endTimeReserve,
  });
  @JsonKey(name: 'start_time_reserve')
  final String startTimeReserve;
  @JsonKey(name: 'end_time_reserve')
  final String endTimeReserve;
}
