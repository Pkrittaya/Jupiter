// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_coupon_form.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentCouponForm _$PaymentCouponFormFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'PaymentCouponForm',
      json,
      ($checkedConvert) {
        final val = PaymentCouponForm(
          couponNo: $checkedConvert('coupon_no', (v) => v as int?),
          couponCode: $checkedConvert('coupon_code', (v) => v as String?),
          couponName: $checkedConvert('coupon_name', (v) => v as String?),
          discountType: $checkedConvert('discount_type', (v) => v as String?),
          discountValue: $checkedConvert('discount_value', (v) => v as int?),
          minimumPrice: $checkedConvert('minimum_price', (v) => v as int?),
          maximumDiscountEnable:
              $checkedConvert('maximum_discount_enable', (v) => v as bool?),
          maximumDiscount:
              $checkedConvert('maximum_discount', (v) => v as int?),
        );
        return val;
      },
      fieldKeyMap: const {
        'couponNo': 'coupon_no',
        'couponCode': 'coupon_code',
        'couponName': 'coupon_name',
        'discountType': 'discount_type',
        'discountValue': 'discount_value',
        'minimumPrice': 'minimum_price',
        'maximumDiscountEnable': 'maximum_discount_enable',
        'maximumDiscount': 'maximum_discount'
      },
    );

Map<String, dynamic> _$PaymentCouponFormToJson(PaymentCouponForm instance) =>
    <String, dynamic>{
      'coupon_no': instance.couponNo,
      'coupon_code': instance.couponCode,
      'coupon_name': instance.couponName,
      'discount_type': instance.discountType,
      'discount_value': instance.discountValue,
      'minimum_price': instance.minimumPrice,
      'maximum_discount_enable': instance.maximumDiscountEnable,
      'maximum_discount': instance.maximumDiscount,
    };
