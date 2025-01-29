import 'package:json_annotation/json_annotation.dart';

import 'only_org_form.dart';

part 'list_payment_form.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class ListPaymentForm extends OnlyOrgForm {
  ListPaymentForm({
    required this.username,
    required this.qrCodeConnector,
    required this.deviceCode,
    required super.orgCode,
  });
  @JsonKey(name: 'username')
  final String username;
  @JsonKey(name: 'qr_code_connector')
  final String qrCodeConnector;
  @JsonKey(name: 'device_code')
  final String deviceCode;

  factory ListPaymentForm.fromJson(Map<String, dynamic> json) =>
      _$ListPaymentFormFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$ListPaymentFormToJson(this);
}
