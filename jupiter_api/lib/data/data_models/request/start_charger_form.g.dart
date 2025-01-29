// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'start_charger_form.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StartChargerForm _$StartChargerFormFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'StartChargerForm',
      json,
      ($checkedConvert) {
        final val = StartChargerForm(
          orgCode: $checkedConvert('org_code', (v) => v as String),
          username: $checkedConvert('username', (v) => v as String),
          qrCodeConnector:
              $checkedConvert('qr_code_connector', (v) => v as String),
          chargerId: $checkedConvert('charger_id', (v) => v as String),
          connectorId: $checkedConvert('connector_id', (v) => v as String),
          connectorIndex: $checkedConvert('connector_index', (v) => v as int),
          deviceCode: $checkedConvert('device_code', (v) => v as String),
          chargingType: $checkedConvert('charging_type', (v) => v as String),
          chargerType: $checkedConvert('charger_type', (v) => v as String),
          optionalCharging: $checkedConvert('optional_charging',
              (v) => OptionalDetailForm.fromJson(v as Map<String, dynamic>)),
          carSelect: $checkedConvert(
              'car_select',
              (v) => v == null
                  ? null
                  : CarSelectForm.fromJson(v as Map<String, dynamic>)),
          paymentType: $checkedConvert('payment_type',
              (v) => PaymentTypeForm.fromJson(v as Map<String, dynamic>)),
          paymentCoupon: $checkedConvert(
              'payment_coupon',
              (v) => v == null
                  ? null
                  : PaymentCouponForm.fromJson(v as Map<String, dynamic>)),
        );
        return val;
      },
      fieldKeyMap: const {
        'orgCode': 'org_code',
        'qrCodeConnector': 'qr_code_connector',
        'chargerId': 'charger_id',
        'connectorId': 'connector_id',
        'connectorIndex': 'connector_index',
        'deviceCode': 'device_code',
        'chargingType': 'charging_type',
        'chargerType': 'charger_type',
        'optionalCharging': 'optional_charging',
        'carSelect': 'car_select',
        'paymentType': 'payment_type',
        'paymentCoupon': 'payment_coupon'
      },
    );

Map<String, dynamic> _$StartChargerFormToJson(StartChargerForm instance) =>
    <String, dynamic>{
      'org_code': instance.orgCode,
      'username': instance.username,
      'qr_code_connector': instance.qrCodeConnector,
      'charger_id': instance.chargerId,
      'connector_id': instance.connectorId,
      'connector_index': instance.connectorIndex,
      'device_code': instance.deviceCode,
      'optional_charging': instance.optionalCharging.toJson(),
      'charging_type': instance.chargingType,
      'charger_type': instance.chargerType,
      'car_select': instance.carSelect?.toJson(),
      'payment_type': instance.paymentType.toJson(),
      'payment_coupon': instance.paymentCoupon?.toJson(),
    };
