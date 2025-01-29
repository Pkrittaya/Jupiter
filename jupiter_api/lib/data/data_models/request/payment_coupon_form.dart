import 'package:json_annotation/json_annotation.dart';

part 'payment_coupon_form.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class PaymentCouponForm {
  PaymentCouponForm(
      {this.couponNo,
      this.couponCode,
      this.couponName,
      this.discountType,
      this.discountValue,
      this.minimumPrice,
      this.maximumDiscountEnable,
      this.maximumDiscount});
  @JsonKey(name: 'coupon_no')
  final int? couponNo;
  @JsonKey(name: 'coupon_code')
  final String? couponCode;
  @JsonKey(name: 'coupon_name')
  final String? couponName;
  @JsonKey(name: 'discount_type')
  final String? discountType;
  @JsonKey(name: 'discount_value')
  final int? discountValue;
  @JsonKey(name: 'minimum_price')
  final int? minimumPrice;
  @JsonKey(name: 'maximum_discount_enable')
  final bool? maximumDiscountEnable;
  @JsonKey(name: 'maximum_discount')
  final int? maximumDiscount;

  factory PaymentCouponForm.fromJson(Map<String, dynamic> json) =>
      _$PaymentCouponFormFromJson(json);
  Map<String, dynamic> toJson() => _$PaymentCouponFormToJson(this);
}
