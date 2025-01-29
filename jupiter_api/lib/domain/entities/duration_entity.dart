import 'package:json_annotation/json_annotation.dart';

class DurationEntity {
  DurationEntity(
      {required this.index,
      required this.day,
      required this.status,
      required this.start,
      required this.end,
      required this.duration});

  @JsonKey(name: 'index')
  final int index;
  @JsonKey(name: 'day')
  final String day;
  @JsonKey(name: 'status')
  final bool status;
  @JsonKey(name: 'start')
  final String start;
  @JsonKey(name: 'end')
  final String end;
  @JsonKey(name: 'duration')
  final String duration;
}
