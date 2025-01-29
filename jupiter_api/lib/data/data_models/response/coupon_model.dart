import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entities/coupon_entity.dart';

part 'coupon_model.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class CouponModel extends CouponItemEntity {
  CouponModel({
    required super.couponCode,
    required super.couponImage,
    required super.couponName,
    required super.dateEnd,
  });

  factory CouponModel.fromJson(Map<String, dynamic> json) =>
      _$CouponModelFromJson(json);
  Map<String, dynamic> toJson() => _$CouponModelToJson(this);
}
