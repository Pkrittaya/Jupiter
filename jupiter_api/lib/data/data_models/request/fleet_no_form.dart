import 'package:json_annotation/json_annotation.dart';

part 'fleet_no_form.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class FleetNoForm {
  FleetNoForm({
    required this.fleetNo,
  });
  @JsonKey(name: 'fleet_no')
  final int fleetNo;

  factory FleetNoForm.fromJson(Map<String, dynamic> json) =>
      _$FleetNoFormFromJson(json);
  Map<String, dynamic> toJson() => _$FleetNoFormToJson(this);
}
