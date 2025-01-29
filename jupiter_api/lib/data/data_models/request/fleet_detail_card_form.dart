import 'package:json_annotation/json_annotation.dart';

part 'fleet_detail_card_form.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class FleetDetailCardForm {
  FleetDetailCardForm({
    required this.fleetNo,
    required this.fleetCardNo,
  });
  @JsonKey(name: 'fleet_no')
  final int fleetNo;
  @JsonKey(name: 'fleet_card_no')
  final String fleetCardNo;

  factory FleetDetailCardForm.fromJson(Map<String, dynamic> json) =>
      _$FleetDetailCardFormFromJson(json);
  Map<String, dynamic> toJson() => _$FleetDetailCardFormToJson(this);
}
