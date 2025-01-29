import 'package:json_annotation/json_annotation.dart';

class SearchCouponItemEntity {
  SearchCouponItemEntity(
      {required this.couponCode,
      required this.couponImage,
      required this.couponName,
      required this.dateEnd,
      required this.dateAdd,
      required this.usedCouponDate,
      required this.statusUsedCoupon,
      this.expiredDate,
      required this.typeCoupon});
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
}
