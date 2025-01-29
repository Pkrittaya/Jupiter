import 'package:json_annotation/json_annotation.dart';

import 'username_and_orgcode_form.dart';

part 'history_detail_form.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class HistoryDetailForm extends UsernameAndOrgCodeForm {
  HistoryDetailForm({
    required super.username,
    required super.orgCode,
    required this.transaction,
  });
  @JsonKey(name: 'transaction')
  final String transaction;

  factory HistoryDetailForm.fromJson(Map<String, dynamic> json) =>
      _$HistoryDetailFormFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$HistoryDetailFormToJson(this);
}
