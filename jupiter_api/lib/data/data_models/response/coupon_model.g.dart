// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coupon_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CouponModel _$CouponModelFromJson(Map<String, dynamic> json) => $checkedCreate(
      'CouponModel',
      json,
      ($checkedConvert) {
        final val = CouponModel(
          couponCode: $checkedConvert('coupon_code', (v) => v as String),
          couponImage: $checkedConvert('coupon_image', (v) => v as String),
          couponName: $checkedConvert('coupon_name', (v) => v as String),
          dateEnd:
              $checkedConvert('date_end', (v) => DateTime.parse(v as String)),
        );
        return val;
      },
      fieldKeyMap: const {
        'couponCode': 'coupon_code',
        'couponImage': 'coupon_image',
        'couponName': 'coupon_name',
        'dateEnd': 'date_end'
      },
    );

Map<String, dynamic> _$CouponModelToJson(CouponModel instance) =>
    <String, dynamic>{
      'coupon_code': instance.couponCode,
      'coupon_image': instance.couponImage,
      'coupon_name': instance.couponName,
      'date_end': instance.dateEnd.toIso8601String(),
    };
