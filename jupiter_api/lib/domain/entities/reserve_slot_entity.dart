import 'package:json_annotation/json_annotation.dart';

class ReserveSlotEntity {
  ReserveSlotEntity({
    required this.index,
    required this.day,
    required this.start,
    required this.end,
    required this.duration,
    required this.status,
  });
  @JsonKey(name: 'index')
  final int index;
  @JsonKey(name: 'day')
  final String day;
  @JsonKey(name: 'start')
  final String start;
  @JsonKey(name: 'end')
  final String end;
  @JsonKey(name: 'duration')
  final String duration;
  @JsonKey(name: 'status')
  final bool status;
}
