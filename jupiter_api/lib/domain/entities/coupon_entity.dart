import 'package:json_annotation/json_annotation.dart';

class CouponItemEntity {
  CouponItemEntity({
    required this.couponCode,
    required this.couponImage,
    required this.couponName,
    required this.dateEnd,
  });
  @JsonKey(name: 'coupon_code')
  final String couponCode;
  @JsonKey(name: 'coupon_image')
  final String couponImage;
  @JsonKey(name: 'coupon_name')
  final String couponName;
  @JsonKey(name: 'date_end')
  final DateTime dateEnd;
}
