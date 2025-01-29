// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'billing_form.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BillingForm _$BillingFormFromJson(Map<String, dynamic> json) => $checkedCreate(
      'BillingForm',
      json,
      ($checkedConvert) {
        final val = BillingForm(
          billingType: $checkedConvert('billing_type', (v) => v as String),
          billingBranchName:
              $checkedConvert('billing_branch_name', (v) => v as String),
          billingBranchCode:
              $checkedConvert('billing_branch_code', (v) => v as String),
          billingName: $checkedConvert('billing_name', (v) => v as String),
          billingId: $checkedConvert('billing_id', (v) => v as String),
          billingAddress:
              $checkedConvert('billing_address', (v) => v as String),
          billingProvince:
              $checkedConvert('billing_province', (v) => v as String),
          billingDistrict:
              $checkedConvert('billing_district', (v) => v as String),
          billingSubdistrict:
              $checkedConvert('billing_subdistrict', (v) => v as String),
          billingPostalCode:
              $checkedConvert('billing_postal_code', (v) => v as String),
          billingDefault: $checkedConvert('billing_defalut', (v) => v as bool),
        );
        return val;
      },
      fieldKeyMap: const {
        'billingType': 'billing_type',
        'billingBranchName': 'billing_branch_name',
        'billingBranchCode': 'billing_branch_code',
        'billingName': 'billing_name',
        'billingId': 'billing_id',
        'billingAddress': 'billing_address',
        'billingProvince': 'billing_province',
        'billingDistrict': 'billing_district',
        'billingSubdistrict': 'billing_subdistrict',
        'billingPostalCode': 'billing_postal_code',
        'billingDefault': 'billing_defalut'
      },
    );

Map<String, dynamic> _$BillingFormToJson(BillingForm instance) =>
    <String, dynamic>{
      'billing_type': instance.billingType,
      'billing_branch_name': instance.billingBranchName,
      'billing_branch_code': instance.billingBranchCode,
      'billing_name': instance.billingName,
      'billing_id': instance.billingId,
      'billing_address': instance.billingAddress,
      'billing_province': instance.billingProvince,
      'billing_district': instance.billingDistrict,
      'billing_subdistrict': instance.billingSubdistrict,
      'billing_postal_code': instance.billingPostalCode,
      'billing_defalut': instance.billingDefault,
    };
