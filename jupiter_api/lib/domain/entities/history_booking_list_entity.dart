import 'package:json_annotation/json_annotation.dart';

import 'history_booking_entity.dart';

class HistoryBookingListEntity {
  HistoryBookingListEntity({
    required this.data,
  });
  @JsonKey(name: 'data')
  final List<HistoryBookingEntity> data;
}
