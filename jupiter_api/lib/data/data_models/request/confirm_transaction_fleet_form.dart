import 'package:json_annotation/json_annotation.dart';

part 'confirm_transaction_fleet_form.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class ConfirmTransactionFleetForm {
  ConfirmTransactionFleetForm({
    required this.fleetNo,
    required this.fleetType,
    required this.qrCodeConnector,
    required this.chargerId,
    required this.connectorId,
    required this.connectorIndex,
    required this.deviceCode,
    required this.orgCode,
  });
  @JsonKey(name: 'fleet_no')
  final int fleetNo;
  @JsonKey(name: 'fleet_type')
  final String fleetType;
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
  @JsonKey(name: 'org_code')
  final String orgCode;

  factory ConfirmTransactionFleetForm.fromJson(Map<String, dynamic> json) =>
      _$ConfirmTransactionFleetFormFromJson(json);
  Map<String, dynamic> toJson() => _$ConfirmTransactionFleetFormToJson(this);
}
