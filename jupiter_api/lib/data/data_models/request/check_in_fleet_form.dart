import 'package:json_annotation/json_annotation.dart';

import 'only_org_form.dart';

part 'check_in_fleet_form.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class CheckInFleetForm extends OnlyOrgForm {
  CheckInFleetForm({
    required this.username,
    required this.qrCodeConnector,
    required this.deviceCode,
    required this.fleetNo,
    required super.orgCode,
  });
  @JsonKey(name: 'username')
  final String username;
  @JsonKey(name: 'qr_code_connector')
  final String qrCodeConnector;
  @JsonKey(name: 'device_code')
  final String deviceCode;
  @JsonKey(name: 'fleet_no')
  final int fleetNo;

  factory CheckInFleetForm.fromJson(Map<String, dynamic> json) =>
      _$CheckInFleetFormFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$CheckInFleetFormToJson(this);
}
