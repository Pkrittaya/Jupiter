import 'package:json_annotation/json_annotation.dart';

import 'only_org_form.dart';

part 'remote_stop_fleet_form.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class RemoteStopFleetForm extends OnlyOrgForm {
  RemoteStopFleetForm({
    required super.orgCode,
    required this.username,
    required this.qrCodeConnector,
    required this.chargerId,
    required this.connectorId,
    required this.connectorIndex,
    required this.deviceCode,
    required this.fleetNo,
    required this.fleetType,
  });
  @JsonKey(name: 'username')
  final String username;
  @JsonKey(name: 'qr_code_connector')
  final String qrCodeConnector;
  @JsonKey(name: 'charger_id')
  final String chargerId;
  @JsonKey(name: 'connector_id')
  final String connectorId;
  @JsonKey(name: 'connector_index')
  final int connectorIndex;
  @JsonKey(name: 'device_code')
  final String deviceCode;
  @JsonKey(name: 'fleet_no')
  final int fleetNo;
  @JsonKey(name: 'fleet_type')
  final String fleetType;

  factory RemoteStopFleetForm.fromJson(Map<String, dynamic> json) =>
      _$RemoteStopFleetFormFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$RemoteStopFleetFormToJson(this);
}
