// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delete_tax_invoice_form.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeleteTaxInvoiceForm _$DeleteTaxInvoiceFormFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      'DeleteTaxInvoiceForm',
      json,
      ($checkedConvert) {
        final val = DeleteTaxInvoiceForm(
          username: $checkedConvert('username', (v) => v as String),
          orgCode: $checkedConvert('org_code', (v) => v as String),
          billingName: $checkedConvert('billing_name', (v) => v as String),
          billingId: $checkedConvert('billing_id', (v) => v as String),
        );
        return val;
      },
      fieldKeyMap: const {
        'orgCode': 'org_code',
        'billingName': 'billing_name',
        'billingId': 'billing_id'
      },
    );

Map<String, dynamic> _$DeleteTaxInvoiceFormToJson(
        DeleteTaxInvoiceForm instance) =>
    <String, dynamic>{
      'org_code': instance.orgCode,
      'username': instance.username,
      'billing_name': instance.billingName,
      'billing_id': instance.billingId,
    };
