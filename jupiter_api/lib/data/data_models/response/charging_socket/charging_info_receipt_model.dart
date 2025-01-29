import 'package:json_annotation/json_annotation.dart';

import '../../../../domain/entities/charging_info_receipt_entity.dart';

part 'charging_info_receipt_model.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class ChargingInfoReceiptModel extends ChargingInfoReceiptEntity {
  ChargingInfoReceiptModel(
      {required super.chargingStartTime,
      required super.chargingEndTime,
      required super.energyRate,
      required super.energyDelivered,
      required super.priceBeforeTax,
      required super.priceBeforeDiscount,
      required super.reserveDiscount,
      required super.couponDiscount,
      required super.tax,
      required super.totalPrice,
      required super.paymentMethod,
      required super.couponMethod,
      required super.reserveStatus,
      required super.statusAddCoupon,
      required super.statusUseCoupon});

  factory ChargingInfoReceiptModel.fromJson(Map<String, dynamic> json) =>
      _$ChargingInfoReceiptModelFromJson(json);
  Map<String, dynamic> toJson() => _$ChargingInfoReceiptModelToJson(this);
}
