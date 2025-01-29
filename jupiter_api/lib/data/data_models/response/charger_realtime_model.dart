import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entities/charger_realtime_entity.dart';
import 'car_select_model.dart';
import 'charging_mode_model.dart';
import 'connector_information_model.dart';
import 'facility_model.dart';
import 'optional_detail_model.dart';
import 'payment_type_model.dart';

part 'charger_realtime_model.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class ChargerRealtimeModel extends ChargerRealtimeEntity {
  ChargerRealtimeModel({
    required super.stationId,
    required super.stationName,
    required super.chargerName,
    required super.chargerSerialNo,
    required super.chargerBrand,
    required super.pricePerUnit,
    required super.totalConnector,
    required super.chargerType,
    required this.connector,
    required this.chargingMode,
    required this.optionalCharging,
    required this.facilityName,
    required this.carSelect,
    required this.paymentType,
    required super.lowPriorityTariff,
  }) : super(
            connector: connector,
            chargingMode: chargingMode,
            optionalCharging: optionalCharging,
            facilityName: facilityName,
            carSelect: carSelect,
            paymentType: paymentType);

  @override
  @JsonKey(name: 'connector')
  final ConnectorInformationModel? connector;
  @override
  @JsonKey(name: 'charging_mode')
  final ChargingModeModel? chargingMode;
  @override
  @JsonKey(name: 'optional_charging')
  final OptionalDetailModel? optionalCharging;
  @override
  @JsonKey(name: 'facility_name')
  final List<FacilityModel>? facilityName;
  @override
  @JsonKey(name: 'car_select')
  final CarSelectModel? carSelect;
  @override
  @JsonKey(name: 'payment_type')
  final List<PaymentTypeModel>? paymentType;

  factory ChargerRealtimeModel.fromJson(Map<String, dynamic> json) =>
      _$ChargerRealtimeModelFromJson(json);
  Map<String, dynamic> toJson() => _$ChargerRealtimeModelToJson(this);
}
