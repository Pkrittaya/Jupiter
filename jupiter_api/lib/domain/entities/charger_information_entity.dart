import 'package:json_annotation/json_annotation.dart';

import 'car_select_entity.dart';
import 'connector_information_entity.dart';
import 'payment_type_has_defalut_entity.dart';

class ChargerInformationEntity {
  ChargerInformationEntity({
    required this.stationId,
    required this.stationName,
    required this.chargerName,
    required this.chargerSerialNo,
    required this.chargerBrand,
    required this.standardChargerPower,
    required this.standardChargerPrice,
    required this.standardChargerPowerUnit,
    required this.standardChargerPriceUnit,
    required this.hightspeedStatus,
    required this.hightspeedChargerPower,
    required this.hightspeedChargerPrice,
    required this.hightspeedChargerPowerUnit,
    required this.hightspeedChargerPriceUnit,
    required this.pricePerUnit,
    required this.totalConnector,
    required this.chargerType,
    required this.maxLimit,
    required this.maxLimitUnit,
    required this.connector,
    required this.carSelect,
    required this.paymentType,
    required this.lowPriorityTariff,
  });

  @JsonKey(name: 'station_id')
  final String? stationId;
  @JsonKey(name: 'station_name')
  final String? stationName;
  @JsonKey(name: 'charger_name')
  final String? chargerName;
  @JsonKey(name: 'charger_serial_no')
  final String? chargerSerialNo;
  @JsonKey(name: 'charger_brand')
  final String? chargerBrand;
  @JsonKey(name: 'standard_charger_power')
  final double? standardChargerPower;
  @JsonKey(name: 'standard_charger_price')
  final String? standardChargerPrice;
  @JsonKey(name: 'standard_charger_power_unit')
  final String? standardChargerPowerUnit;
  @JsonKey(name: 'standard_charger_price_unit')
  final String? standardChargerPriceUnit;
  @JsonKey(name: 'hightspeed_status')
  final bool? hightspeedStatus;
  @JsonKey(name: 'hightspeed_charger_power')
  final double? hightspeedChargerPower;
  @JsonKey(name: 'hightspeed_charger_price')
  final String? hightspeedChargerPrice;
  @JsonKey(name: 'hightspeed_charger_power_unit')
  final String? hightspeedChargerPowerUnit;
  @JsonKey(name: 'hightspeed_charger_price_unit')
  final String? hightspeedChargerPriceUnit;

  @JsonKey(name: 'price_per_unit')
  final String? pricePerUnit;
  @JsonKey(name: 'total_connector')
  final int? totalConnector;
  @JsonKey(name: 'charger_type')
  final String? chargerType;
  @JsonKey(name: 'max_limit')
  final double? maxLimit;
  @JsonKey(name: 'max_limit_unit')
  final String? maxLimitUnit;
  @JsonKey(name: 'connector')
  final ConnectorInformationEntity? connector;
  @JsonKey(name: 'car_select')
  final List<CarSelectEntity>? carSelect;
  @JsonKey(name: 'payment_type')
  final List<PaymentTypeHasDefalutEntity>? paymentType;
  @JsonKey(name: 'low_priority_tariff')
  final bool? lowPriorityTariff;
}
