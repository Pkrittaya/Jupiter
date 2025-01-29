import 'package:json_annotation/json_annotation.dart';

import 'only_org_form.dart';
import 'payment_type_form.dart';

part 'update_select_payment_form.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class UpdateSelectPaymentForm extends OnlyOrgForm {
  UpdateSelectPaymentForm({
    required this.username,
    required this.qrCodeConnector,
    required this.deviceCode,
    required this.payment,
    required super.orgCode,
  });

  @JsonKey(name: 'username')
  final String username;
  @JsonKey(name: 'qr_code_connector')
  final String qrCodeConnector;
  @JsonKey(name: 'device_code')
  final String deviceCode;
  @JsonKey(name: 'payment')
  final PaymentTypeForm payment;

  factory UpdateSelectPaymentForm.fromJson(Map<String, dynamic> json) =>
      _$UpdateSelectPaymentFormFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$UpdateSelectPaymentFormToJson(this);
}
