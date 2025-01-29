// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_booking_list_form.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HistoryBookingListForm _$HistoryBookingListFormFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      'HistoryBookingListForm',
      json,
      ($checkedConvert) {
        final val = HistoryBookingListForm(
          username: $checkedConvert('username', (v) => v as String),
          orgCode: $checkedConvert('org_code', (v) => v as String),
        );
        return val;
      },
      fieldKeyMap: const {'orgCode': 'org_code'},
    );

Map<String, dynamic> _$HistoryBookingListFormToJson(
        HistoryBookingListForm instance) =>
    <String, dynamic>{
      'org_code': instance.orgCode,
      'username': instance.username,
    };
