// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_fleet_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HistoryFleetModel _$HistoryFleetModelFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'HistoryFleetModel',
      json,
      ($checkedConvert) {
        final val = HistoryFleetModel(
          transactionId: $checkedConvert('transaction_id', (v) => v as int),
          stationId: $checkedConvert('station_id', (v) => v as String),
          stationName: $checkedConvert('station_name', (v) => v as String),
          totalPrice:
              $checkedConvert('total_price', (v) => (v as num).toDouble()),
          totalPriceUnit:
              $checkedConvert('total_price_unit', (v) => v as String),
          timeStamp: $checkedConvert('time_stamp', (v) => v as String),
        );
        return val;
      },
      fieldKeyMap: const {
        'transactionId': 'transaction_id',
        'stationId': 'station_id',
        'stationName': 'station_name',
        'totalPrice': 'total_price',
        'totalPriceUnit': 'total_price_unit',
        'timeStamp': 'time_stamp'
      },
    );

Map<String, dynamic> _$HistoryFleetModelToJson(HistoryFleetModel instance) =>
    <String, dynamic>{
      'transaction_id': instance.transactionId,
      'station_id': instance.stationId,
      'station_name': instance.stationName,
      'total_price': instance.totalPrice,
      'total_price_unit': instance.totalPriceUnit,
      'time_stamp': instance.timeStamp,
    };
