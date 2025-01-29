// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reserve_receipt_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReserveReceiptModel _$ReserveReceiptModelFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'ReserveReceiptModel',
      json,
      ($checkedConvert) {
        final val = ReserveReceiptModel(
          stationName: $checkedConvert('station_name', (v) => v as String),
          chargeName: $checkedConvert('charger_name', (v) => v as String),
          connectorName: $checkedConvert('connector_name', (v) => v as String),
          startTimeReserve:
              $checkedConvert('start_time_reserve', (v) => v as String),
          endTimeReserve:
              $checkedConvert('end_time_reserve', (v) => v as String),
          reserveTimeCreate:
              $checkedConvert('reserve_time_create', (v) => v as String),
          reserveTimeExpired:
              $checkedConvert('reserve_time_expired', (v) => v as String),
          reserveTimeMinute:
              $checkedConvert('reserve_time_minute', (v) => v as String),
          reserveRate:
              $checkedConvert('reserve_rate', (v) => (v as num).toDouble()),
          reserveTax:
              $checkedConvert('reserve_tax', (v) => (v as num).toDouble()),
          reserveBeforeTax: $checkedConvert(
              'reserve_before_tax', (v) => (v as num).toDouble()),
          reservePrice:
              $checkedConvert('reserve_price', (v) => (v as num).toDouble()),
          paymentMethod: $checkedConvert('payment_method', (v) => v as String),
        );
        return val;
      },
      fieldKeyMap: const {
        'stationName': 'station_name',
        'chargeName': 'charger_name',
        'connectorName': 'connector_name',
        'startTimeReserve': 'start_time_reserve',
        'endTimeReserve': 'end_time_reserve',
        'reserveTimeCreate': 'reserve_time_create',
        'reserveTimeExpired': 'reserve_time_expired',
        'reserveTimeMinute': 'reserve_time_minute',
        'reserveRate': 'reserve_rate',
        'reserveTax': 'reserve_tax',
        'reserveBeforeTax': 'reserve_before_tax',
        'reservePrice': 'reserve_price',
        'paymentMethod': 'payment_method'
      },
    );

Map<String, dynamic> _$ReserveReceiptModelToJson(
        ReserveReceiptModel instance) =>
    <String, dynamic>{
      'station_name': instance.stationName,
      'charger_name': instance.chargeName,
      'connector_name': instance.connectorName,
      'start_time_reserve': instance.startTimeReserve,
      'end_time_reserve': instance.endTimeReserve,
      'reserve_time_create': instance.reserveTimeCreate,
      'reserve_time_expired': instance.reserveTimeExpired,
      'reserve_time_minute': instance.reserveTimeMinute,
      'reserve_rate': instance.reserveRate,
      'reserve_tax': instance.reserveTax,
      'reserve_before_tax': instance.reserveBeforeTax,
      'reserve_price': instance.reservePrice,
      'payment_method': instance.paymentMethod,
    };
