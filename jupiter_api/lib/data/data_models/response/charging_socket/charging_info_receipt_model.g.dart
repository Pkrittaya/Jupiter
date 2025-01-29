// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'charging_info_receipt_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChargingInfoReceiptModel _$ChargingInfoReceiptModelFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      'ChargingInfoReceiptModel',
      json,
      ($checkedConvert) {
        final val = ChargingInfoReceiptModel(
          chargingStartTime:
              $checkedConvert('charging_start_time', (v) => v as String?),
          chargingEndTime:
              $checkedConvert('charging_end_time', (v) => v as String?),
          energyRate: $checkedConvert('energy_rate', (v) => v as String?),
          energyDelivered:
              $checkedConvert('energy_delivered', (v) => v as String?),
          priceBeforeTax:
              $checkedConvert('price_before_tax', (v) => v as String?),
          priceBeforeDiscount:
              $checkedConvert('price_before_discount', (v) => v as String?),
          reserveDiscount:
              $checkedConvert('reserve_discount', (v) => v as String?),
          couponDiscount:
              $checkedConvert('coupon_discount', (v) => v as String?),
          tax: $checkedConvert('tax', (v) => v as String?),
          totalPrice: $checkedConvert('total_price', (v) => v as String?),
          paymentMethod: $checkedConvert('payment_method', (v) => v as String?),
          couponMethod: $checkedConvert('coupon_method', (v) => v as String?),
          reserveStatus: $checkedConvert('reserve_status', (v) => v as bool?),
          statusAddCoupon:
              $checkedConvert('status_add_coupon', (v) => v as bool?),
          statusUseCoupon:
              $checkedConvert('status_use_coupon', (v) => v as bool?),
        );
        return val;
      },
      fieldKeyMap: const {
        'chargingStartTime': 'charging_start_time',
        'chargingEndTime': 'charging_end_time',
        'energyRate': 'energy_rate',
        'energyDelivered': 'energy_delivered',
        'priceBeforeTax': 'price_before_tax',
        'priceBeforeDiscount': 'price_before_discount',
        'reserveDiscount': 'reserve_discount',
        'couponDiscount': 'coupon_discount',
        'totalPrice': 'total_price',
        'paymentMethod': 'payment_method',
        'couponMethod': 'coupon_method',
        'reserveStatus': 'reserve_status',
        'statusAddCoupon': 'status_add_coupon',
        'statusUseCoupon': 'status_use_coupon'
      },
    );

Map<String, dynamic> _$ChargingInfoReceiptModelToJson(
        ChargingInfoReceiptModel instance) =>
    <String, dynamic>{
      'charging_start_time': instance.chargingStartTime,
      'charging_end_time': instance.chargingEndTime,
      'energy_rate': instance.energyRate,
      'energy_delivered': instance.energyDelivered,
      'price_before_tax': instance.priceBeforeTax,
      'price_before_discount': instance.priceBeforeDiscount,
      'reserve_discount': instance.reserveDiscount,
      'coupon_discount': instance.couponDiscount,
      'tax': instance.tax,
      'total_price': instance.totalPrice,
      'payment_method': instance.paymentMethod,
      'coupon_method': instance.couponMethod,
      'reserve_status': instance.reserveStatus,
      'status_add_coupon': instance.statusAddCoupon,
      'status_use_coupon': instance.statusUseCoupon,
    };
