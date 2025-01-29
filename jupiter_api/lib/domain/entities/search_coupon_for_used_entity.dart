import 'package:json_annotation/json_annotation.dart';

class SearchCouponItemForUsedEntity {
  SearchCouponItemForUsedEntity(
      {required this.couponNo,
      required this.couponCode,
      required this.couponImage,
      required this.couponName,
      required this.dateEnd,
      required this.dateAdd,
      required this.usedCouponDate,
      required this.statusUsedCoupon,
      this.expiredDate,
      required this.typeCoupon,
      required this.discountType,
      required this.discountValue,
      required this.minimumPrice,
      required this.maximumDiscountEnable,
      required this.maximumDiscount,
      required this.statusCanUse});
  @JsonKey(name: 'coupon_no')
  final int couponNo;
  @JsonKey(name: 'coupon_code')
  final String couponCode;
  @JsonKey(name: 'coupon_image')
  final String couponImage;
  @JsonKey(name: 'coupon_name')
  final String couponName;
  @JsonKey(name: 'date_end')
  final String dateEnd;
  @JsonKey(name: 'date_add')
  final String dateAdd;
  @JsonKey(name: 'used_coupon_date')
  final String usedCouponDate;
  @JsonKey(name: 'status_used_coupon')
  final bool statusUsedCoupon;
  @JsonKey(name: 'expired_date')
  final int? expiredDate;
  @JsonKey(name: 'type_coupon')
  final String typeCoupon;
  @JsonKey(name: 'discount_type')
  final String discountType;
  @JsonKey(name: 'discount_value')
  final int discountValue;
  @JsonKey(name: 'minimum_price')
  final int minimumPrice;
  @JsonKey(name: 'maximum_discount_enable')
  final bool maximumDiscountEnable;
  @JsonKey(name: 'maximum_discount')
  final int maximumDiscount;
  @JsonKey(name: 'status_can_use')
  final bool statusCanUse;
}
