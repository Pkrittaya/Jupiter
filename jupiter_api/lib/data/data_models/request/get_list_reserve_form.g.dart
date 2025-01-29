// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_list_reserve_form.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetListReserveForm _$GetListReserveFormFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'GetListReserveForm',
      json,
      ($checkedConvert) {
        final val = GetListReserveForm(
          orgCode: $checkedConvert('org_code', (v) => v as String),
          stationId: $checkedConvert('station_id', (v) => v as String),
          chargerId: $checkedConvert('charger_id', (v) => v as String),
          connectorId: $checkedConvert('connector_id', (v) => v as String),
          qrCodeConnector:
              $checkedConvert('qr_code_connector', (v) => v as String),
          date: $checkedConvert('date', (v) => v as String),
        );
        return val;
      },
      fieldKeyMap: const {
        'orgCode': 'org_code',
        'stationId': 'station_id',
        'chargerId': 'charger_id',
        'connectorId': 'connector_id',
        'qrCodeConnector': 'qr_code_connector'
      },
    );

Map<String, dynamic> _$GetListReserveFormToJson(GetListReserveForm instance) =>
    <String, dynamic>{
      'org_code': instance.orgCode,
      'station_id': instance.stationId,
      'charger_id': instance.chargerId,
      'connector_id': instance.connectorId,
      'qr_code_connector': instance.qrCodeConnector,
      'date': instance.date,
    };
