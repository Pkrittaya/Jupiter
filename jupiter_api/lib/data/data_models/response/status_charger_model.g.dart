// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'status_charger_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StatusChargerModel _$StatusChargerModelFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'StatusChargerModel',
      json,
      ($checkedConvert) {
        final val = StatusChargerModel(
          chargingStatus: $checkedConvert('charging_status', (v) => v as bool?),
          data: $checkedConvert(
              'data',
              (v) => v == null
                  ? null
                  : ChargingInfoModel.fromJson(v as Map<String, dynamic>)),
          informationCharger: $checkedConvert(
              'information_charger',
              (v) => v == null
                  ? null
                  : ChargerInformationModel.fromJson(
                      v as Map<String, dynamic>)),
          chargingMode: $checkedConvert(
              'charging_mode',
              (v) => v == null
                  ? null
                  : ChargingModeModel.fromJson(v as Map<String, dynamic>)),
          optionalCharging: $checkedConvert(
              'optional_charging',
              (v) => v == null
                  ? null
                  : OptionalDetailModel.fromJson(v as Map<String, dynamic>)),
          facilityName: $checkedConvert(
              'facility_name',
              (v) => (v as List<dynamic>?)
                  ?.map(
                      (e) => FacilityModel.fromJson(e as Map<String, dynamic>))
                  .toList()),
          carSelect: $checkedConvert(
              'car_select',
              (v) => v == null
                  ? null
                  : CarSelectModel.fromJson(v as Map<String, dynamic>)),
          paymentType: $checkedConvert(
              'payment_type',
              (v) => v == null
                  ? null
                  : PaymentTypeModel.fromJson(v as Map<String, dynamic>)),
        );
        return val;
      },
      fieldKeyMap: const {
        'chargingStatus': 'charging_status',
        'informationCharger': 'information_charger',
        'chargingMode': 'charging_mode',
        'optionalCharging': 'optional_charging',
        'facilityName': 'facility_name',
        'carSelect': 'car_select',
        'paymentType': 'payment_type'
      },
    );

Map<String, dynamic> _$StatusChargerModelToJson(StatusChargerModel instance) =>
    <String, dynamic>{
      'charging_status': instance.chargingStatus,
      'data': instance.data?.toJson(),
      'information_charger': instance.informationCharger?.toJson(),
      'charging_mode': instance.chargingMode?.toJson(),
      'optional_charging': instance.optionalCharging?.toJson(),
      'facility_name': instance.facilityName?.map((e) => e.toJson()).toList(),
      'car_select': instance.carSelect?.toJson(),
      'payment_type': instance.paymentType?.toJson(),
    };
