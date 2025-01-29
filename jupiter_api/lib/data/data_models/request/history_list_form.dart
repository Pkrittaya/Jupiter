import 'package:json_annotation/json_annotation.dart';

import 'username_and_orgcode_form.dart';

part 'history_list_form.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class HistoryListForm extends UsernameAndOrgCodeForm {
  HistoryListForm({
    required super.username,
    required super.orgCode,
    required this.startDate,
    required this.endDate,
    required this.stationId,
  });
  @JsonKey(name: 'start_date')
  final String startDate;
  @JsonKey(name: 'end_date')
  final String endDate;
  @JsonKey(name: 'station_id')
  final String stationId;

  factory HistoryListForm.fromJson(Map<String, dynamic> json) =>
      _$HistoryListFormFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$HistoryListFormToJson(this);
}
