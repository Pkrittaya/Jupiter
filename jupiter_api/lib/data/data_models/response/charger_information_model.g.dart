// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'charger_information_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChargerInformationModel _$ChargerInformationModelFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      'ChargerInformationModel',
      json,
      ($checkedConvert) {
        final val = ChargerInformationModel(
          stationId: $checkedConvert('station_id', (v) => v as String?),
          stationName: $checkedConvert('station_name', (v) => v as String?),
          chargerName: $checkedConvert('charger_name', (v) => v as String?),
          chargerSerialNo:
              $checkedConvert('charger_serial_no', (v) => v as String?),
          chargerBrand: $checkedConvert('charger_brand', (v) => v as String?),
          standardChargerPower: $checkedConvert(
              'standard_charger_power', (v) => (v as num?)?.toDouble()),
          standardChargerPrice:
              $checkedConvert('standard_charger_price', (v) => v as String?),
          standardChargerPowerUnit: $checkedConvert(
              'standard_charger_power_unit', (v) => v as String?),
          standardChargerPriceUnit: $checkedConvert(
              'standard_charger_price_unit', (v) => v as String?),
          hightspeedStatus:
              $checkedConvert('hightspeed_status', (v) => v as bool?),
          hightspeedChargerPower: $checkedConvert(
              'hightspeed_charger_power', (v) => (v as num?)?.toDouble()),
          hightspeedChargerPrice:
              $checkedConvert('hightspeed_charger_price', (v) => v as String?),
          hightspeedChargerPowerUnit: $checkedConvert(
              'hightspeed_charger_power_unit', (v) => v as String?),
          hightspeedChargerPriceUnit: $checkedConvert(
              'hightspeed_charger_price_unit', (v) => v as String?),
          pricePerUnit: $checkedConvert('price_per_unit', (v) => v as String?),
          totalConnector: $checkedConvert('total_connector', (v) => v as int?),
          chargerType: $checkedConvert('charger_type', (v) => v as String?),
          maxLimit:
              $checkedConvert('max_limit', (v) => (v as num?)?.toDouble()),
          maxLimitUnit: $checkedConvert('max_limit_unit', (v) => v as String?),
          connector: $checkedConvert(
              'connector',
              (v) => v == null
                  ? null
                  : ConnectorInformationModel.fromJson(
                      v as Map<String, dynamic>)),
          carSelect: $checkedConvert(
              'car_select',
              (v) => (v as List<dynamic>?)
                  ?.map(
                      (e) => CarSelectModel.fromJson(e as Map<String, dynamic>))
                  .toList()),
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
        'standardChargerPower': 'standard_charger_power',
        'standardChargerPrice': 'standard_charger_price',
        'standardChargerPowerUnit': 'standard_charger_power_unit',
        'standardChargerPriceUnit': 'standard_charger_price_unit',
        'hightspeedStatus': 'hightspeed_status',
        'hightspeedChargerPower': 'hightspeed_charger_power',
        'hightspeedChargerPrice': 'hightspeed_charger_price',
        'hightspeedChargerPowerUnit': 'hightspeed_charger_power_unit',
        'hightspeedChargerPriceUnit': 'hightspeed_charger_price_unit',
        'pricePerUnit': 'price_per_unit',
        'totalConnector': 'total_connector',
        'chargerType': 'charger_type',
        'maxLimit': 'max_limit',
        'maxLimitUnit': 'max_limit_unit',
        'carSelect': 'car_select',
        'paymentType': 'payment_type',
        'lowPriorityTariff': 'low_priority_tariff'
      },
    );

Map<String, dynamic> _$ChargerInformationModelToJson(
        ChargerInformationModel instance) =>
    <String, dynamic>{
      'station_id': instance.stationId,
      'station_name': instance.stationName,
      'charger_name': instance.chargerName,
      'charger_serial_no': instance.chargerSerialNo,
      'charger_brand': instance.chargerBrand,
      'standard_charger_power': instance.standardChargerPower,
      'standard_charger_price': instance.standardChargerPrice,
      'standard_charger_power_unit': instance.standardChargerPowerUnit,
      'standard_charger_price_unit': instance.standardChargerPriceUnit,
      'hightspeed_status': instance.hightspeedStatus,
      'hightspeed_charger_power': instance.hightspeedChargerPower,
      'hightspeed_charger_price': instance.hightspeedChargerPrice,
      'hightspeed_charger_power_unit': instance.hightspeedChargerPowerUnit,
      'hightspeed_charger_price_unit': instance.hightspeedChargerPriceUnit,
      'price_per_unit': instance.pricePerUnit,
      'total_connector': instance.totalConnector,
      'charger_type': instance.chargerType,
      'max_limit': instance.maxLimit,
      'max_limit_unit': instance.maxLimitUnit,
      'low_priority_tariff': instance.lowPriorityTariff,
      'connector': instance.connector?.toJson(),
      'car_select': instance.carSelect?.map((e) => e.toJson()).toList(),
      'payment_type': instance.paymentType?.map((e) => e.toJson()).toList(),
    };
