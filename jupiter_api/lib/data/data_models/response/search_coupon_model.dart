import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entities/search_coupon_entity.dart';

part 'search_coupon_model.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class SearchCouponModel extends SearchCouponItemEntity {
  SearchCouponModel(
      {required super.couponCode,
      required super.couponImage,
      required super.couponName,
      required super.dateEnd,
      required super.dateAdd,
      required super.usedCouponDate,
      required super.statusUsedCoupon,
      super.expiredDate,
      required super.typeCoupon});

  factory SearchCouponModel.fromJson(Map<String, dynamic> json) =>
      _$SearchCouponModelFromJson(json);
  Map<String, dynamic> toJson() => _$SearchCouponModelToJson(this);
}
