import 'package:json_annotation/json_annotation.dart';

import 'car_select_entity.dart';
import 'charging_mode_entity.dart';
import 'connector_information_entity.dart';
import 'facility_entity.dart';
import 'optional_detail_entity.dart';
import 'payment_type_has_defalut_entity.dart';

class ChargerRealtimeEntity {
  ChargerRealtimeEntity({
    required this.stationId,
    required this.stationName,
    required this.chargerName,
    required this.chargerSerialNo,
    required this.chargerBrand,
    required this.pricePerUnit,
    required this.totalConnector,
    required this.chargerType,
    required this.connector,
    required this.chargingMode,
    required this.optionalCharging,
    required this.facilityName,
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
  @JsonKey(name: 'price_per_unit')
  final String? pricePerUnit;
  @JsonKey(name: 'total_connector')
  final int? totalConnector;
  @JsonKey(name: 'charger_type')
  final String? chargerType;
  @JsonKey(name: 'connector')
  final ConnectorInformationEntity? connector;
  @JsonKey(name: 'charging_mode')
  final ChargingModeEntity? chargingMode;
  @JsonKey(name: 'optional_charging')
  final OptionalDetailEntity? optionalCharging;
  @JsonKey(name: 'facility_name')
  final List<FacilityEntity>? facilityName;
  @JsonKey(name: 'car_select')
  final CarSelectEntity? carSelect;
  @JsonKey(name: 'payment_type')
  final List<PaymentTypeHasDefalutEntity>? paymentType;
  @JsonKey(name: 'low_priority_tariff')
  final bool? lowPriorityTariff;
}
