// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_coupon_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchCouponModel _$SearchCouponModelFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'SearchCouponModel',
      json,
      ($checkedConvert) {
        final val = SearchCouponModel(
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
        );
        return val;
      },
      fieldKeyMap: const {
        'couponCode': 'coupon_code',
        'couponImage': 'coupon_image',
        'couponName': 'coupon_name',
        'dateEnd': 'date_end',
        'dateAdd': 'date_add',
        'usedCouponDate': 'used_coupon_date',
        'statusUsedCoupon': 'status_used_coupon',
        'expiredDate': 'expired_date',
        'typeCoupon': 'type_coupon'
      },
    );

Map<String, dynamic> _$SearchCouponModelToJson(SearchCouponModel instance) =>
    <String, dynamic>{
      'coupon_code': instance.couponCode,
      'coupon_image': instance.couponImage,
      'coupon_name': instance.couponName,
      'date_end': instance.dateEnd,
      'date_add': instance.dateAdd,
      'used_coupon_date': instance.usedCouponDate,
      'status_used_coupon': instance.statusUsedCoupon,
      'expired_date': instance.expiredDate,
      'type_coupon': instance.typeCoupon,
    };
