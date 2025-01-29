// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_reserve_form.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateReserveForm _$CreateReserveFormFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'CreateReserveForm',
      json,
      ($checkedConvert) {
        final val = CreateReserveForm(
          orgCode: $checkedConvert('org_code', (v) => v as String),
          username: $checkedConvert('username', (v) => v as String),
          deviceCode: $checkedConvert('device_code', (v) => v as String),
          stationId: $checkedConvert('station_id', (v) => v as String),
          chargerId: $checkedConvert('charger_id', (v) => v as String),
          connectorId: $checkedConvert('connector_id', (v) => v as String),
          qrCodeConnector:
              $checkedConvert('qr_code_connector', (v) => v as String),
          startTimeReserve:
              $checkedConvert('start_time_reserve', (v) => v as String),
          endTimeReserve:
              $checkedConvert('end_time_reserve', (v) => v as String),
          reserveTimeMinute:
              $checkedConvert('reserve_time_minute', (v) => v as String),
          payment: $checkedConvert('payment',
              (v) => PaymentTypeForm.fromJson(v as Map<String, dynamic>)),
        );
        return val;
      },
      fieldKeyMap: const {
        'orgCode': 'org_code',
        'deviceCode': 'device_code',
        'stationId': 'station_id',
        'chargerId': 'charger_id',
        'connectorId': 'connector_id',
        'qrCodeConnector': 'qr_code_connector',
        'startTimeReserve': 'start_time_reserve',
        'endTimeReserve': 'end_time_reserve',
        'reserveTimeMinute': 'reserve_time_minute'
      },
    );

Map<String, dynamic> _$CreateReserveFormToJson(CreateReserveForm instance) =>
    <String, dynamic>{
      'org_code': instance.orgCode,
      'username': instance.username,
      'device_code': instance.deviceCode,
      'station_id': instance.stationId,
      'charger_id': instance.chargerId,
      'connector_id': instance.connectorId,
      'qr_code_connector': instance.qrCodeConnector,
      'start_time_reserve': instance.startTimeReserve,
      'end_time_reserve': instance.endTimeReserve,
      'reserve_time_minute': instance.reserveTimeMinute,
      'payment': instance.payment.toJson(),
    };
