import 'package:json_annotation/json_annotation.dart';

part 'coupon_list_form.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class CouponListForm {
  CouponListForm({
    required this.username,
    // required this.listType,
  });
  @JsonKey(name: 'username')
  final String username;
  // @JsonKey(name: 'list_type')
  // final String listType;

  factory CouponListForm.fromJson(Map<String, dynamic> json) =>
      _$CouponListFormFromJson(json);
  Map<String, dynamic> toJson() => _$CouponListFormToJson(this);
}
