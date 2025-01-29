import 'package:json_annotation/json_annotation.dart';

part 'collect_coupon.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class CollectCouponForm {
  CollectCouponForm({
    required this.username,
    required this.couponCode,
  });
  @JsonKey(name: 'username')
  final String username;
  @JsonKey(name: 'coupon_code')
  final String couponCode;

  factory CollectCouponForm.fromJson(Map<String, dynamic> json) =>
      _$CollectCouponFormFromJson(json);
  Map<String, dynamic> toJson() => _$CollectCouponFormToJson(this);
}
