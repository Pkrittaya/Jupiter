import 'package:json_annotation/json_annotation.dart';

import 'username_and_orgcode_form.dart';

part 'delete_tax_invoice_form.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class DeleteTaxInvoiceForm extends UsernameAndOrgCodeForm {
  DeleteTaxInvoiceForm({
    required super.username,
    required super.orgCode,
    required this.billingName,
    required this.billingId,
  });
  @JsonKey(name: 'billing_name')
  final String billingName;
  @JsonKey(name: 'billing_id')
  final String billingId;

  factory DeleteTaxInvoiceForm.fromJson(Map<String, dynamic> json) =>
      _$DeleteTaxInvoiceFormFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$DeleteTaxInvoiceFormToJson(this);
}
