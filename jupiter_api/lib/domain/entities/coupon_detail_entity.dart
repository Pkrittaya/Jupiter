import 'package:json_annotation/json_annotation.dart';

class CouponDetailEntity {
  CouponDetailEntity(
      {required this.couponCode,
      required this.couponImage,
      required this.couponName,
      required this.description,
      required this.dateEnd,
      required this.dateAdd,
      required this.usedCouponDate,
      this.expiredDate,
      required this.statusUsedCoupon,
      required this.typeCoupon});
  @JsonKey(name: 'coupon_code')
  final String couponCode;
  @JsonKey(name: 'coupon_image')
  final String couponImage;
  @JsonKey(name: 'coupon_name')
  final String couponName;
  @JsonKey(name: 'coupon_description')
  final String description;
  @JsonKey(name: 'date_end')
  final String dateEnd;
  @JsonKey(name: 'date_add')
  final String dateAdd;
  @JsonKey(name: 'used_coupon_date')
  final String usedCouponDate;
  @JsonKey(name: 'expired_date')
  final int? expiredDate;
  @JsonKey(name: 'status_used_coupon')
  final bool statusUsedCoupon;
  @JsonKey(name: 'type_coupon')
  final String typeCoupon;
}
