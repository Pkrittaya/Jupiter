import 'package:json_annotation/json_annotation.dart';

import 'only_org_form.dart';

part 'update_current_battery_form.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class UpdateCurrentBatteryForm extends OnlyOrgForm {
  UpdateCurrentBatteryForm({
    required this.username,
    required this.qrCodeConnector,
    required this.deviceCode,
    required this.currentBattery,
    required this.fleetStatus,
    required this.fleetNo,
    required super.orgCode,
  });

  @JsonKey(name: 'username')
  final String username;
  @JsonKey(name: 'qr_code_connector')
  final String qrCodeConnector;
  @JsonKey(name: 'device_code')
  final String deviceCode;
  @JsonKey(name: 'current_battery')
  final int currentBattery;
  @JsonKey(name: 'fleet_status')
  final bool fleetStatus;
  @JsonKey(name: 'fleet_no')
  final int fleetNo;

  factory UpdateCurrentBatteryForm.fromJson(Map<String, dynamic> json) =>
      _$UpdateCurrentBatteryFormFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$UpdateCurrentBatteryFormToJson(this);
}
