import 'package:json_annotation/json_annotation.dart';

import 'only_org_form.dart';

part 'check_status_fleet_form.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class CheckStatusFleetForm extends OnlyOrgForm {
  CheckStatusFleetForm({
    required super.orgCode,
    required this.username,
    required this.deviceCode,
    required this.fleetNo,
    required this.fleetType,
    required this.refCode,
  });
  @JsonKey(name: 'username')
  final String username;
  @JsonKey(name: 'device_code')
  final String deviceCode;
  @JsonKey(name: 'fleet_no')
  final int fleetNo;
  @JsonKey(name: 'fleet_type')
  final String fleetType;
  @JsonKey(name: 'ref_code')
  final String refCode;

  factory CheckStatusFleetForm.fromJson(Map<String, dynamic> json) =>
      _$CheckStatusFleetFormFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$CheckStatusFleetFormToJson(this);
}
