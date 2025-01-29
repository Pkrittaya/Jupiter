import 'package:json_annotation/json_annotation.dart';

import 'username_and_orgcode_form.dart';

part 'history_booking_list_form.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class HistoryBookingListForm extends UsernameAndOrgCodeForm {
  HistoryBookingListForm({
    required super.username,
    required super.orgCode,
  });

  factory HistoryBookingListForm.fromJson(Map<String, dynamic> json) =>
      _$HistoryBookingListFormFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$HistoryBookingListFormToJson(this);
}
