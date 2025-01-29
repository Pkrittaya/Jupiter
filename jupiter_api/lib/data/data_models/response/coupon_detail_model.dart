import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entities/coupon_detail_entity.dart';

part 'coupon_detail_model.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class CouponDetailModel extends CouponDetailEntity {
  CouponDetailModel(
      {required super.couponCode,
      required super.couponImage,
      required super.couponName,
      required super.description,
      required super.dateEnd,
      required super.dateAdd,
      required super.usedCouponDate,
      required super.typeCoupon,
      required super.statusUsedCoupon,
      super.expiredDate});

  factory CouponDetailModel.fromJson(Map<String, dynamic> json) =>
      _$CouponDetailModelFromJson(json);
  Map<String, dynamic> toJson() => _$CouponDetailModelToJson(this);
}
