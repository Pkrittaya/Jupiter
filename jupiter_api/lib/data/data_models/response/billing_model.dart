import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entities/billing_entity.dart';

part 'billing_model.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class BillingModel extends BillingEntity {
  BillingModel({
    required super.billingType,
    required super.billingBranchName,
    required super.billingBranchCode,
    required super.billingName,
    required super.billingId,
    required super.billingAddress,
    required super.billingProvince,
    required super.billingDistrict,
    required super.billingSubdistrict,
    required super.billingPostalCode,
    required super.billingDefault,
  });

  factory BillingModel.fromJson(Map<String, dynamic> json) =>
      _$BillingModelFromJson(json);
  Map<String, dynamic> toJson() => _$BillingModelToJson(this);
}
