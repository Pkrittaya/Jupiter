// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_booking_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HistoryBookingListModel _$HistoryBookingListModelFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      'HistoryBookingListModel',
      json,
      ($checkedConvert) {
        final val = HistoryBookingListModel(
          data: $checkedConvert(
              'data',
              (v) => (v as List<dynamic>)
                  .map((e) => HistoryBookingListDataModel.fromJson(
                      e as Map<String, dynamic>))
                  .toList()),
        );
        return val;
      },
    );

Map<String, dynamic> _$HistoryBookingListModelToJson(
        HistoryBookingListModel instance) =>
    <String, dynamic>{
      'data': instance.data.map((e) => e.toJson()).toList(),
    };
