// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_coupon_form.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchCouponForm _$SearchCouponFormFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'SearchCouponForm',
      json,
      ($checkedConvert) {
        final val = SearchCouponForm(
          username: $checkedConvert('username', (v) => v as String),
        );
        return val;
      },
    );

Map<String, dynamic> _$SearchCouponFormToJson(SearchCouponForm instance) =>
    <String, dynamic>{
      'username': instance.username,
    };
