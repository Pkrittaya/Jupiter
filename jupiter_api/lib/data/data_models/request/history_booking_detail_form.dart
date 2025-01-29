import 'package:json_annotation/json_annotation.dart';

import 'username_and_orgcode_form.dart';

part 'history_booking_detail_form.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class HistoryBookingDetailForm extends UsernameAndOrgCodeForm {
  HistoryBookingDetailForm(
      {required super.username,
      required super.orgCode,
      required this.reserveOn});
  @JsonKey(name: 'reserve_on')
  final int reserveOn;

  factory HistoryBookingDetailForm.fromJson(Map<String, dynamic> json) =>
      _$HistoryBookingDetailFormFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$HistoryBookingDetailFormToJson(this);
}
