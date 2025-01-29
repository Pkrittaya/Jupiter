// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_ev_car_charging_form.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddCarChargingForm _$AddCarChargingFormFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'AddCarChargingForm',
      json,
      ($checkedConvert) {
        final val = AddCarChargingForm(
          fleetNo: $checkedConvert('fleet_no', (v) => v as int),
          qrCodeConnector:
              $checkedConvert('qr_code_connector', (v) => v as String),
          carSelect: $checkedConvert('car_select',
              (v) => CarSelectFleetForm.fromJson(v as Map<String, dynamic>)),
        );
        return val;
      },
      fieldKeyMap: const {
        'fleetNo': 'fleet_no',
        'qrCodeConnector': 'qr_code_connector',
        'carSelect': 'car_select'
      },
    );

Map<String, dynamic> _$AddCarChargingFormToJson(AddCarChargingForm instance) =>
    <String, dynamic>{
      'fleet_no': instance.fleetNo,
      'qr_code_connector': instance.qrCodeConnector,
      'car_select': instance.carSelect.toJson(),
    };
