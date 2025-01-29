// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coupon_list_form.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CouponListForm _$CouponListFormFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'CouponListForm',
      json,
      ($checkedConvert) {
        final val = CouponListForm(
          username: $checkedConvert('username', (v) => v as String),
        );
        return val;
      },
    );

Map<String, dynamic> _$CouponListFormToJson(CouponListForm instance) =>
    <String, dynamic>{
      'username': instance.username,
    };
