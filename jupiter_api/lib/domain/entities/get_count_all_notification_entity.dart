import 'package:json_annotation/json_annotation.dart';

class CountAllNotificationEntity {
  CountAllNotificationEntity({required this.numberReadStatus});
  @JsonKey(name: 'number_read_status')
  final int numberReadStatus;
}
