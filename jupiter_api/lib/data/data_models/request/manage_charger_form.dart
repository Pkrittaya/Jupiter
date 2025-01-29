import 'package:json_annotation/json_annotation.dart';

import 'only_org_form.dart';

part 'manage_charger_form.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class ManageChargerForm extends OnlyOrgForm {
  ManageChargerForm({
    required super.orgCode,
    required this.username,
    required this.qrCodeConnector,
    required this.chargerId,
    required this.connectorId,
    required this.connectorIndex,
    required this.deviceCode,
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

  factory ManageChargerForm.fromJson(Map<String, dynamic> json) =>
      _$ManageChargerFormFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$ManageChargerFormToJson(this);
}
