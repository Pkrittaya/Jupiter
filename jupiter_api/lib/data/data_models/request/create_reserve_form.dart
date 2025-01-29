import 'package:json_annotation/json_annotation.dart';

import 'payment_type_form.dart';
import 'username_and_orgcode_form.dart';

part 'create_reserve_form.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class CreateReserveForm extends UsernameAndOrgCodeForm {
  CreateReserveForm({
    required super.orgCode,
    required super.username,
    required this.deviceCode,
    required this.stationId,
    required this.chargerId,
    required this.connectorId,
    required this.qrCodeConnector,
    required this.startTimeReserve,
    required this.endTimeReserve,
    required this.reserveTimeMinute,
    required this.payment,
  });
  @JsonKey(name: 'device_code')
  final String deviceCode;
  @JsonKey(name: 'station_id')
  final String stationId;
  @JsonKey(name: 'charger_id')
  final String chargerId;
  @JsonKey(name: 'connector_id')
  final String connectorId;
  @JsonKey(name: 'qr_code_connector')
  final String qrCodeConnector;
  @JsonKey(name: 'start_time_reserve')
  final String startTimeReserve;
  @JsonKey(name: 'end_time_reserve')
  final String endTimeReserve;
  @JsonKey(name: 'reserve_time_minute')
  final String reserveTimeMinute;
  @JsonKey(name: 'payment')
  final PaymentTypeForm payment;

  factory CreateReserveForm.fromJson(Map<String, dynamic> json) =>
      _$CreateReserveFormFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$CreateReserveFormToJson(this);
}
