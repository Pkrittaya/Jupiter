// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coupon_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CouponDetailModel _$CouponDetailModelFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'CouponDetailModel',
      json,
      ($checkedConvert) {
        final val = CouponDetailModel(
          couponCode: $checkedConvert('coupon_code', (v) => v as String),
          couponImage: $checkedConvert('coupon_image', (v) => v as String),
          couponName: $checkedConvert('coupon_name', (v) => v as String),
          description:
              $checkedConvert('coupon_description', (v) => v as String),
          dateEnd: $checkedConvert('date_end', (v) => v as String),
          dateAdd: $checkedConvert('date_add', (v) => v as String),
          usedCouponDate:
              $checkedConvert('used_coupon_date', (v) => v as String),
          typeCoupon: $checkedConvert('type_coupon', (v) => v as String),
          statusUsedCoupon:
              $checkedConvert('status_used_coupon', (v) => v as bool),
          expiredDate: $checkedConvert('expired_date', (v) => v as int?),
        );
        return val;
      },
      fieldKeyMap: const {
        'couponCode': 'coupon_code',
        'couponImage': 'coupon_image',
        'couponName': 'coupon_name',
        'description': 'coupon_description',
        'dateEnd': 'date_end',
        'dateAdd': 'date_add',
        'usedCouponDate': 'used_coupon_date',
        'typeCoupon': 'type_coupon',
        'statusUsedCoupon': 'status_used_coupon',
        'expiredDate': 'expired_date'
      },
    );

Map<String, dynamic> _$CouponDetailModelToJson(CouponDetailModel instance) =>
    <String, dynamic>{
      'coupon_code': instance.couponCode,
      'coupon_image': instance.couponImage,
      'coupon_name': instance.couponName,
      'coupon_description': instance.description,
      'date_end': instance.dateEnd,
      'date_add': instance.dateAdd,
      'used_coupon_date': instance.usedCouponDate,
      'expired_date': instance.expiredDate,
      'status_used_coupon': instance.statusUsedCoupon,
      'type_coupon': instance.typeCoupon,
    };
