import 'package:json_annotation/json_annotation.dart';

class CollectCouponEntity {
  CollectCouponEntity({required this.message, required this.status});
  @JsonKey(name: 'message')
  final String message;
  @JsonKey(name: 'status')
  final String status;
}

/** Data Dic status **/
/** 
 * Parameter  =Incorrect Parameter
 * NOCoupon = Don't have coupon
 * Limit = Coupon limit reached
 * OverPublish = Coupon can't be added because the date is out of the publishing range
 * Already = You already have this coupon
 * Inactive = Coupon status is not active
 * OnlyMember = You don't have this coupon because this coupon is for members only
 * Success = Add Coupon Success!
 * Failed message = Add coupon failed
 * **/
