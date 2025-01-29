import 'package:json_annotation/json_annotation.dart';

part 'history_fleet_card_form.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class HistoryFleetCardForm {
  HistoryFleetCardForm({
    required this.fleetNo,
    required this.refCode,
  });
  @JsonKey(name: 'fleet_no')
  final int fleetNo;
  @JsonKey(name: 'ref_code')
  final String refCode;

  factory HistoryFleetCardForm.fromJson(Map<String, dynamic> json) =>
      _$HistoryFleetCardFormFromJson(json);
  Map<String, dynamic> toJson() => _$HistoryFleetCardFormToJson(this);
}
