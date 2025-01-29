// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'collect_coupon_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CollectCouponModel _$CollectCouponModelFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'CollectCouponModel',
      json,
      ($checkedConvert) {
        final val = CollectCouponModel(
          message: $checkedConvert('message', (v) => v as String),
          status: $checkedConvert('status', (v) => v as String),
        );
        return val;
      },
    );

Map<String, dynamic> _$CollectCouponModelToJson(CollectCouponModel instance) =>
    <String, dynamic>{
      'message': instance.message,
      'status': instance.status,
    };
