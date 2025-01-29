// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_tax_invoice_form.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddTaxInvoiceForm _$AddTaxInvoiceFormFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'AddTaxInvoiceForm',
      json,
      ($checkedConvert) {
        final val = AddTaxInvoiceForm(
          username: $checkedConvert('username', (v) => v as String),
          orgCode: $checkedConvert('org_code', (v) => v as String),
          billing: $checkedConvert('billing',
              (v) => BillingForm.fromJson(v as Map<String, dynamic>)),
        );
        return val;
      },
      fieldKeyMap: const {'orgCode': 'org_code'},
    );

Map<String, dynamic> _$AddTaxInvoiceFormToJson(AddTaxInvoiceForm instance) =>
    <String, dynamic>{
      'org_code': instance.orgCode,
      'username': instance.username,
      'billing': instance.billing.toJson(),
    };
