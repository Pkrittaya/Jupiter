import 'package:json_annotation/json_annotation.dart';

part 'search_coupon_form.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class SearchCouponForm {
  SearchCouponForm({
    required this.username,
  });
  @JsonKey(name: 'username')
  final String username;

  factory SearchCouponForm.fromJson(Map<String, dynamic> json) =>
      _$SearchCouponFormFromJson(json);
  Map<String, dynamic> toJson() => _$SearchCouponFormToJson(this);
}
