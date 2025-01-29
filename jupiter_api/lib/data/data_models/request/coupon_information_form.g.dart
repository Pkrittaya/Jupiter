// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coupon_information_form.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CouponInformationForm _$CouponInformationFormFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      'CouponInformationForm',
      json,
      ($checkedConvert) {
        final val = CouponInformationForm(
          username: $checkedConvert('username', (v) => v as String),
          couponCode: $checkedConvert('coupon_code', (v) => v as String),
        );
        return val;
      },
      fieldKeyMap: const {'couponCode': 'coupon_code'},
    );

Map<String, dynamic> _$CouponInformationFormToJson(
        CouponInformationForm instance) =>
    <String, dynamic>{
      'username': instance.username,
      'coupon_code': instance.couponCode,
    };
