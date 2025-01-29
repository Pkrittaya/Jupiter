// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HistoryDetailModel _$HistoryDetailModelFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'HistoryDetailModel',
      json,
      ($checkedConvert) {
        final val = HistoryDetailModel(
          stationName: $checkedConvert('station_name', (v) => v as String),
          chargerId: $checkedConvert('charger_id', (v) => v as String),
          chargerName: $checkedConvert('charger_name', (v) => v as String),
          connectorId: $checkedConvert('connector_id', (v) => v as String),
          connectorType: $checkedConvert('connector_type', (v) => v as String),
          connectorPosition:
              $checkedConvert('connector_position', (v) => v as String),
          connectorStatusActive:
              $checkedConvert('connector_status_active', (v) => v as String),
          totalConnector: $checkedConvert('total_connector', (v) => v as int),
          startTime:
              $checkedConvert('start_time', (v) => DateTime.parse(v as String)),
          endTime:
              $checkedConvert('end_time', (v) => DateTime.parse(v as String)),
          energy: $checkedConvert('energy', (v) => (v as num).toDouble()),
          distance: $checkedConvert('distance', (v) => v as String),
          pricePerUnit:
              $checkedConvert('price_per_unit', (v) => (v as num).toDouble()),
          charingFee:
              $checkedConvert('charing_fee', (v) => (v as num).toDouble()),
          reserveStatus: $checkedConvert('reserve_status', (v) => v as bool),
          reserveDiscount:
              $checkedConvert('reserve_discount', (v) => (v as num).toDouble()),
          statusAddCoupon:
              $checkedConvert('status_add_coupon', (v) => v as bool),
          statusUseCoupon:
              $checkedConvert('status_use_coupon', (v) => v as bool),
          couponDiscount:
              $checkedConvert('coupon_discount', (v) => (v as num).toDouble()),
          tax: $checkedConvert('tax', (v) => (v as num).toDouble()),
          grandTotal:
              $checkedConvert('grand_total', (v) => (v as num).toDouble()),
          paymentMethod: $checkedConvert('payment_method', (v) => v as String),
          priceBeforeTax:
              $checkedConvert('price_before_tax', (v) => (v as num).toDouble()),
          carSelect: $checkedConvert(
              'car_select',
              (v) => v == null
                  ? null
                  : CarSelectModel.fromJson(v as Map<String, dynamic>)),
        );
        return val;
      },
      fieldKeyMap: const {
        'stationName': 'station_name',
        'chargerId': 'charger_id',
        'chargerName': 'charger_name',
        'connectorId': 'connector_id',
        'connectorType': 'connector_type',
        'connectorPosition': 'connector_position',
        'connectorStatusActive': 'connector_status_active',
        'totalConnector': 'total_connector',
        'startTime': 'start_time',
        'endTime': 'end_time',
        'pricePerUnit': 'price_per_unit',
        'charingFee': 'charing_fee',
        'reserveStatus': 'reserve_status',
        'reserveDiscount': 'reserve_discount',
        'statusAddCoupon': 'status_add_coupon',
        'statusUseCoupon': 'status_use_coupon',
        'couponDiscount': 'coupon_discount',
        'grandTotal': 'grand_total',
        'paymentMethod': 'payment_method',
        'priceBeforeTax': 'price_before_tax',
        'carSelect': 'car_select'
      },
    );

Map<String, dynamic> _$HistoryDetailModelToJson(HistoryDetailModel instance) =>
    <String, dynamic>{
      'station_name': instance.stationName,
      'charger_id': instance.chargerId,
      'charger_name': instance.chargerName,
      'connector_id': instance.connectorId,
      'connector_type': instance.connectorType,
      'connector_position': instance.connectorPosition,
      'connector_status_active': instance.connectorStatusActive,
      'total_connector': instance.totalConnector,
      'start_time': instance.startTime.toIso8601String(),
      'end_time': instance.endTime.toIso8601String(),
      'energy': instance.energy,
      'distance': instance.distance,
      'price_per_unit': instance.pricePerUnit,
      'charing_fee': instance.charingFee,
      'reserve_status': instance.reserveStatus,
      'reserve_discount': instance.reserveDiscount,
      'status_add_coupon': instance.statusAddCoupon,
      'status_use_coupon': instance.statusUseCoupon,
      'coupon_discount': instance.couponDiscount,
      'tax': instance.tax,
      'grand_total': instance.grandTotal,
      'payment_method': instance.paymentMethod,
      'price_before_tax': instance.priceBeforeTax,
      'car_select': instance.carSelect?.toJson(),
    };
