import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entities/collect_coupon_entity.dart';

part 'collect_coupon_model.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class CollectCouponModel extends CollectCouponEntity {
  CollectCouponModel({required super.message, required super.status});

  factory CollectCouponModel.fromJson(Map<String, dynamic> json) =>
      _$CollectCouponModelFromJson(json);
  Map<String, dynamic> toJson() => _$CollectCouponModelToJson(this);
}
