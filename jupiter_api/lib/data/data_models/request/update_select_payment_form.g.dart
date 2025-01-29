// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_select_payment_form.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateSelectPaymentForm _$UpdateSelectPaymentFormFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      'UpdateSelectPaymentForm',
      json,
      ($checkedConvert) {
        final val = UpdateSelectPaymentForm(
          username: $checkedConvert('username', (v) => v as String),
          qrCodeConnector:
              $checkedConvert('qr_code_connector', (v) => v as String),
          deviceCode: $checkedConvert('device_code', (v) => v as String),
          payment: $checkedConvert('payment',
              (v) => PaymentTypeForm.fromJson(v as Map<String, dynamic>)),
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

Map<String, dynamic> _$UpdateSelectPaymentFormToJson(
        UpdateSelectPaymentForm instance) =>
    <String, dynamic>{
      'org_code': instance.orgCode,
      'username': instance.username,
      'qr_code_connector': instance.qrCodeConnector,
      'device_code': instance.deviceCode,
      'payment': instance.payment.toJson(),
    };
