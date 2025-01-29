// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'charger_realtime_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChargerRealtimeModel _$ChargerRealtimeModelFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      'ChargerRealtimeModel',
      json,
      ($checkedConvert) {
        final val = ChargerRealtimeModel(
          stationId: $checkedConvert('station_id', (v) => v as String?),
          stationName: $checkedConvert('station_name', (v) => v as String?),
          chargerName: $checkedConvert('charger_name', (v) => v as String?),
          chargerSerialNo:
              $checkedConvert('charger_serial_no', (v) => v as String?),
          chargerBrand: $checkedConvert('charger_brand', (v) => v as String?),
          pricePerUnit: $checkedConvert('price_per_unit', (v) => v as String?),
          totalConnector: $checkedConvert('total_connector', (v) => v as int?),
          chargerType: $checkedConvert('charger_type', (v) => v as String?),
          connector: $checkedConvert(
              'connector',
              (v) => v == null
                  ? null
                  : ConnectorInformationModel.fromJson(
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
              (v) => (v as List<dynamic>?)
                  ?.map((e) =>
                      PaymentTypeModel.fromJson(e as Map<String, dynamic>))
                  .toList()),
          lowPriorityTariff:
              $checkedConvert('low_priority_tariff', (v) => v as bool?),
        );
        return val;
      },
      fieldKeyMap: const {
        'stationId': 'station_id',
        'stationName': 'station_name',
        'chargerName': 'charger_name',
        'chargerSerialNo': 'charger_serial_no',
        'chargerBrand': 'charger_brand',
        'pricePerUnit': 'price_per_unit',
        'totalConnector': 'total_connector',
        'chargerType': 'charger_type',
        'chargingMode': 'charging_mode',
        'optionalCharging': 'optional_charging',
        'facilityName': 'facility_name',
        'carSelect': 'car_select',
        'paymentType': 'payment_type',
        'lowPriorityTariff': 'low_priority_tariff'
      },
    );

Map<String, dynamic> _$ChargerRealtimeModelToJson(
        ChargerRealtimeModel instance) =>
    <String, dynamic>{
      'station_id': instance.stationId,
      'station_name': instance.stationName,
      'charger_name': instance.chargerName,
      'charger_serial_no': instance.chargerSerialNo,
      'charger_brand': instance.chargerBrand,
      'price_per_unit': instance.pricePerUnit,
      'total_connector': instance.totalConnector,
      'charger_type': instance.chargerType,
      'low_priority_tariff': instance.lowPriorityTariff,
      'connector': instance.connector?.toJson(),
      'charging_mode': instance.chargingMode?.toJson(),
      'optional_charging': instance.optionalCharging?.toJson(),
      'facility_name': instance.facilityName?.map((e) => e.toJson()).toList(),
      'car_select': instance.carSelect?.toJson(),
      'payment_type': instance.paymentType?.map((e) => e.toJson()).toList(),
    };
