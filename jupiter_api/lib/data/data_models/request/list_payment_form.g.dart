// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_payment_form.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListPaymentForm _$ListPaymentFormFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'ListPaymentForm',
      json,
      ($checkedConvert) {
        final val = ListPaymentForm(
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

Map<String, dynamic> _$ListPaymentFormToJson(ListPaymentForm instance) =>
    <String, dynamic>{
      'org_code': instance.orgCode,
      'username': instance.username,
      'qr_code_connector': instance.qrCodeConnector,
      'device_code': instance.deviceCode,
    };
