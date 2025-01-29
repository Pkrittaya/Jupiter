import 'package:json_annotation/json_annotation.dart';

part 'coupon_information_form.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class CouponInformationForm {
  CouponInformationForm({
    required this.username,
    required this.couponCode,
  });
  @JsonKey(name: 'username')
  final String username;
  @JsonKey(name: 'coupon_code')
  final String couponCode;

  factory CouponInformationForm.fromJson(Map<String, dynamic> json) =>
      _$CouponInformationFormFromJson(json);
  Map<String, dynamic> toJson() => _$CouponInformationFormToJson(this);
}
