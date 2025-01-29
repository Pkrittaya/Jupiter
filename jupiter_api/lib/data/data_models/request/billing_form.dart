import 'package:json_annotation/json_annotation.dart';

part 'billing_form.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class BillingForm {
  BillingForm({
    required this.billingType,
    required this.billingBranchName,
    required this.billingBranchCode,
    required this.billingName,
    required this.billingId,
    required this.billingAddress,
    required this.billingProvince,
    required this.billingDistrict,
    required this.billingSubdistrict,
    required this.billingPostalCode,
    required this.billingDefault,
  });
  @JsonKey(name: 'billing_type')
  final String billingType;
  @JsonKey(name: 'billing_branch_name')
  final String billingBranchName;
  @JsonKey(name: 'billing_branch_code')
  final String billingBranchCode;
  @JsonKey(name: 'billing_name')
  final String billingName;
  @JsonKey(name: 'billing_id')
  final String billingId;
  @JsonKey(name: 'billing_address')
  final String billingAddress;
  @JsonKey(name: 'billing_province')
  final String billingProvince;
  @JsonKey(name: 'billing_district')
  final String billingDistrict;
  @JsonKey(name: 'billing_subdistrict')
  final String billingSubdistrict;
  @JsonKey(name: 'billing_postal_code')
  final String billingPostalCode;
  @JsonKey(name: 'billing_defalut')
  final bool billingDefault;

  factory BillingForm.fromJson(Map<String, dynamic> json) =>
      _$BillingFormFromJson(json);
  Map<String, dynamic> toJson() => _$BillingFormToJson(this);
}
