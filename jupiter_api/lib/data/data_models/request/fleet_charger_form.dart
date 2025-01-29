import 'package:json_annotation/json_annotation.dart';

part 'fleet_charger_form.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class FleetChargerForm {
  FleetChargerForm({
    required this.fleetNo,
    required this.stationId,
  });
  @JsonKey(name: 'fleet_no')
  final int fleetNo;
  @JsonKey(name: 'station_id')
  final String stationId;

  factory FleetChargerForm.fromJson(Map<String, dynamic> json) =>
      _$FleetChargerFormFromJson(json);
  Map<String, dynamic> toJson() => _$FleetChargerFormToJson(this);
}
