// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_booking_detail_form.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HistoryBookingDetailForm _$HistoryBookingDetailFormFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      'HistoryBookingDetailForm',
      json,
      ($checkedConvert) {
        final val = HistoryBookingDetailForm(
          username: $checkedConvert('username', (v) => v as String),
          orgCode: $checkedConvert('org_code', (v) => v as String),
          reserveOn: $checkedConvert('reserve_on', (v) => v as int),
        );
        return val;
      },
      fieldKeyMap: const {'orgCode': 'org_code', 'reserveOn': 'reserve_on'},
    );

Map<String, dynamic> _$HistoryBookingDetailFormToJson(
        HistoryBookingDetailForm instance) =>
    <String, dynamic>{
      'org_code': instance.orgCode,
      'username': instance.username,
      'reserve_on': instance.reserveOn,
    };
