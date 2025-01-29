import 'package:json_annotation/json_annotation.dart';

import 'billing_form.dart';
import 'username_and_orgcode_form.dart';

part 'add_tax_invoice_form.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class AddTaxInvoiceForm extends UsernameAndOrgCodeForm {
  AddTaxInvoiceForm({
    required super.username,
    required super.orgCode,
    required this.billing,
  });
  @JsonKey(name: 'billing')
  final BillingForm billing;

  factory AddTaxInvoiceForm.fromJson(Map<String, dynamic> json) =>
      _$AddTaxInvoiceFormFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$AddTaxInvoiceFormToJson(this);
}
