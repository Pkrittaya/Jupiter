import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entities/search_coupon_for_used_entity.dart';

part 'search_coupon__for_used_model.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class SearchCouponForUsedModel extends SearchCouponItemForUsedEntity {
  SearchCouponForUsedModel(
      {required super.couponNo,
      required super.couponCode,
      required super.couponImage,
      required super.couponName,
      required super.dateEnd,
      required super.dateAdd,
      required super.usedCouponDate,
      required super.statusUsedCoupon,
      super.expiredDate,
      required super.typeCoupon,
      required super.discountType,
      required super.discountValue,
      required super.minimumPrice,
      required super.maximumDiscountEnable,
      required super.maximumDiscount,
      required super.statusCanUse});

  factory SearchCouponForUsedModel.fromJson(Map<String, dynamic> json) =>
      _$SearchCouponForUsedModelFromJson(json);
  Map<String, dynamic> toJson() => _$SearchCouponForUsedModelToJson(this);
}
