// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'charger_information_form.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChargerInformationForm _$ChargerInformationFormFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      'ChargerInformationForm',
      json,
      ($checkedConvert) {
        final val = ChargerInformationForm(
          username: $checkedConvert('username', (v) => v as String),
          qrCodeConnector:
              $checkedConvert('qr_code_connector', (v) => v as String),
          deviceCode: $checkedConvert('device_code', (v) => v as String),
          orgCode: $checkedConvert('org_code', (v) => v as String),
        );
        return val;
      },
      fieldKeyMap: const {
        'qrCodeConnector': 'qr_code_connector',
        'deviceCode': 'device_code',
        'orgCode': 'org_code'
      },
    );

Map<String, dynamic> _$ChargerInformationFormToJson(
        ChargerInformationForm instance) =>
    <String, dynamic>{
      'org_code': instance.orgCode,
      'username': instance.username,
      'qr_code_connector': instance.qrCodeConnector,
      'device_code': instance.deviceCode,
    };
