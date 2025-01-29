import 'package:json_annotation/json_annotation.dart';

import '../../../../domain/entities/history_booking_list_entity.dart';
import 'history_booking_list_data_model.dart';

part 'history_booking_list_model.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class HistoryBookingListModel extends HistoryBookingListEntity {
  HistoryBookingListModel({
    required this.data,
  }) : super(data: data);

  @override
  @JsonKey(name: 'data')
  final List<HistoryBookingListDataModel> data;

  factory HistoryBookingListModel.fromJson(Map<String, dynamic> json) =>
      _$HistoryBookingListModelFromJson(json);
  Map<String, dynamic> toJson() => _$HistoryBookingListModelToJson(this);
}
