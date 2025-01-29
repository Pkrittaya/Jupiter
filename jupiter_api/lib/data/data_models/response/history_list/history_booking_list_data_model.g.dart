// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_booking_list_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HistoryBookingListDataModel _$HistoryBookingListDataModelFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      'HistoryBookingListDataModel',
      json,
      ($checkedConvert) {
        final val = HistoryBookingListDataModel(
          reserveOn:
              $checkedConvert('reserve_on', (v) => (v as num).toDouble()),
          stationId: $checkedConvert('station_id', (v) => v as String),
          stationName: $checkedConvert('station_name', (v) => v as String),
          totalPrice: $checkedConvert('total_price', (v) => v as String),
          totalPriceUnit:
              $checkedConvert('total_price_unit', (v) => v as String),
          timeStamp: $checkedConvert('time_stamp', (v) => v as String),
        );
        return val;
      },
      fieldKeyMap: const {
        'reserveOn': 'reserve_on',
        'stationId': 'station_id',
        'stationName': 'station_name',
        'totalPrice': 'total_price',
        'totalPriceUnit': 'total_price_unit',
        'timeStamp': 'time_stamp'
      },
    );

Map<String, dynamic> _$HistoryBookingListDataModelToJson(
        HistoryBookingListDataModel instance) =>
    <String, dynamic>{
      'reserve_on': instance.reserveOn,
      'station_id': instance.stationId,
      'station_name': instance.stationName,
      'total_price': instance.totalPrice,
      'total_price_unit': instance.totalPriceUnit,
      'time_stamp': instance.timeStamp,
    };
