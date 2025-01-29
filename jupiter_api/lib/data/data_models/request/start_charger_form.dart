import 'package:json_annotation/json_annotation.dart';

import 'car_select_form.dart';
import 'only_org_form.dart';
import 'optional_detail_form.dart';
import 'payment_coupon_form.dart';
import 'payment_type_form.dart';

part 'start_charger_form.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class StartChargerForm extends OnlyOrgForm {
  StartChargerForm(
      {required super.orgCode,
      required this.username,
      required this.qrCodeConnector,
      required this.chargerId,
      required this.connectorId,
      required this.connectorIndex,
      required this.deviceCode,
      required this.chargingType,
      required this.chargerType,
      required this.optionalCharging,
      required this.carSelect,
      required this.paymentType,
      required this.paymentCoupon});
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
  @JsonKey(name: 'optional_charging')
  final OptionalDetailForm optionalCharging;
  @JsonKey(name: 'charging_type')
  final String chargingType;
  @JsonKey(name: 'charger_type')
  final String chargerType;
  @JsonKey(name: 'car_select')
  final CarSelectForm? carSelect;
  @JsonKey(name: 'payment_type')
  final PaymentTypeForm paymentType;
  @JsonKey(name: 'payment_coupon')
  final PaymentCouponForm? paymentCoupon;

  factory StartChargerForm.fromJson(Map<String, dynamic> json) =>
      _$StartChargerFormFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$StartChargerFormToJson(this);
}
