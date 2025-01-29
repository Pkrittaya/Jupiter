import 'package:json_annotation/json_annotation.dart';

import 'car_select_entity.dart';
import 'charger_information_entity.dart';
import 'charging_info_entity.dart';
import 'charging_mode_entity.dart';
import 'facility_entity.dart';
import 'optional_detail_entity.dart';
import 'payment_type_has_defalut_entity.dart';

class StatusChargerEntity {
  StatusChargerEntity({
    required this.chargingStatus,
    required this.data,
    required this.informationCharger,
    required this.chargingMode,
    required this.optionalCharging,
    required this.facilityName,
    required this.carSelect,
    required this.paymentType,
  });
  @JsonKey(name: 'charging_status')
  final bool? chargingStatus;
  @JsonKey(name: 'data')
  final ChargingInfoEntity? data;
  @JsonKey(name: 'information_charger')
  final ChargerInformationEntity? informationCharger;
  @JsonKey(name: 'charging_mode')
  final ChargingModeEntity? chargingMode;
  @JsonKey(name: 'optional_charging')
  final OptionalDetailEntity? optionalCharging;
  @JsonKey(name: 'facility_name')
  final List<FacilityEntity>? facilityName;
  @JsonKey(name: 'car_select')
  final CarSelectEntity? carSelect;
  @JsonKey(name: 'payment_type')
  final PaymentTypeHasDefalutEntity? paymentType;
}
