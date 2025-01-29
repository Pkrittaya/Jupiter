// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_coupon__for_used_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchCouponForUsedModel _$SearchCouponForUsedModelFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      'SearchCouponForUsedModel',
      json,
      ($checkedConvert) {
        final val = SearchCouponForUsedModel(
          couponNo: $checkedConvert('coupon_no', (v) => v as int),
          couponCode: $checkedConvert('coupon_code', (v) => v as String),
          couponImage: $checkedConvert('coupon_image', (v) => v as String),
          couponName: $checkedConvert('coupon_name', (v) => v as String),
          dateEnd: $checkedConvert('date_end', (v) => v as String),
          dateAdd: $checkedConvert('date_add', (v) => v as String),
          usedCouponDate:
              $checkedConvert('used_coupon_date', (v) => v as String),
          statusUsedCoupon:
              $checkedConvert('status_used_coupon', (v) => v as bool),
          expiredDate: $checkedConvert('expired_date', (v) => v as int?),
          typeCoupon: $checkedConvert('type_coupon', (v) => v as String),
          discountType: $checkedConvert('discount_type', (v) => v as String),
          discountValue: $checkedConvert('discount_value', (v) => v as int),
          minimumPrice: $checkedConvert('minimum_price', (v) => v as int),
          maximumDiscountEnable:
              $checkedConvert('maximum_discount_enable', (v) => v as bool),
          maximumDiscount: $checkedConvert('maximum_discount', (v) => v as int),
          statusCanUse: $checkedConvert('status_can_use', (v) => v as bool),
        );
        return val;
      },
      fieldKeyMap: const {
        'couponNo': 'coupon_no',
        'couponCode': 'coupon_code',
        'couponImage': 'coupon_image',
        'couponName': 'coupon_name',
        'dateEnd': 'date_end',
        'dateAdd': 'date_add',
        'usedCouponDate': 'used_coupon_date',
        'statusUsedCoupon': 'status_used_coupon',
        'expiredDate': 'expired_date',
        'typeCoupon': 'type_coupon',
        'discountType': 'discount_type',
        'discountValue': 'discount_value',
        'minimumPrice': 'minimum_price',
        'maximumDiscountEnable': 'maximum_discount_enable',
        'maximumDiscount': 'maximum_discount',
        'statusCanUse': 'status_can_use'
      },
    );

Map<String, dynamic> _$SearchCouponForUsedModelToJson(
        SearchCouponForUsedModel instance) =>
    <String, dynamic>{
      'coupon_no': instance.couponNo,
      'coupon_code': instance.couponCode,
      'coupon_image': instance.couponImage,
      'coupon_name': instance.couponName,
      'date_end': instance.dateEnd,
      'date_add': instance.dateAdd,
      'used_coupon_date': instance.usedCouponDate,
      'status_used_coupon': instance.statusUsedCoupon,
      'expired_date': instance.expiredDate,
      'type_coupon': instance.typeCoupon,
      'discount_type': instance.discountType,
      'discount_value': instance.discountValue,
      'minimum_price': instance.minimumPrice,
      'maximum_discount_enable': instance.maximumDiscountEnable,
      'maximum_discount': instance.maximumDiscount,
      'status_can_use': instance.statusCanUse,
    };
