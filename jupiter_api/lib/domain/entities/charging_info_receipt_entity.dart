import 'package:json_annotation/json_annotation.dart';

class ChargingInfoReceiptEntity {
  ChargingInfoReceiptEntity(
      {required this.chargingStartTime,
      required this.chargingEndTime,
      required this.energyRate,
      required this.energyDelivered,
      required this.priceBeforeTax,
      required this.priceBeforeDiscount,
      required this.reserveDiscount,
      required this.couponDiscount,
      required this.tax,
      required this.totalPrice,
      required this.paymentMethod,
      required this.couponMethod,
      required this.reserveStatus,
      required this.statusAddCoupon,
      required this.statusUseCoupon});

  @JsonKey(name: 'charging_start_time')
  final String? chargingStartTime;
  @JsonKey(name: 'charging_end_time')
  final String? chargingEndTime;
  @JsonKey(name: 'energy_rate')
  final String? energyRate;
  @JsonKey(name: 'energy_delivered')
  final String? energyDelivered;
  @JsonKey(name: 'price_before_tax')
  final String? priceBeforeTax;
  @JsonKey(name: 'price_before_discount')
  final String? priceBeforeDiscount;
  @JsonKey(name: 'reserve_discount')
  final String? reserveDiscount;
  @JsonKey(name: 'coupon_discount')
  final String? couponDiscount;
  @JsonKey(name: 'tax')
  final String? tax;
  @JsonKey(name: 'total_price')
  final String? totalPrice;
  @JsonKey(name: 'payment_method')
  final String? paymentMethod;
  @JsonKey(name: 'coupon_method')
  final String? couponMethod;
  @JsonKey(name: 'reserve_status')
  final bool? reserveStatus;
  @JsonKey(name: 'status_add_coupon')
  final bool? statusAddCoupon;
  @JsonKey(name: 'status_use_coupon')
  final bool? statusUseCoupon;
}
