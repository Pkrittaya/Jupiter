// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'collect_coupon.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CollectCouponForm _$CollectCouponFormFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'CollectCouponForm',
      json,
      ($checkedConvert) {
        final val = CollectCouponForm(
          username: $checkedConvert('username', (v) => v as String),
          couponCode: $checkedConvert('coupon_code', (v) => v as String),
        );
        return val;
      },
      fieldKeyMap: const {'couponCode': 'coupon_code'},
    );

Map<String, dynamic> _$CollectCouponFormToJson(CollectCouponForm instance) =>
    <String, dynamic>{
      'username': instance.username,
      'coupon_code': instance.couponCode,
    };
