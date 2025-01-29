import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entities/charger_information_entity.dart';
import 'car_select_model.dart';
import 'connector_information_model.dart';
import 'payment_type_model.dart';

part 'charger_information_model.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class ChargerInformationModel extends ChargerInformationEntity {
  ChargerInformationModel({
    required super.stationId,
    required super.stationName,
    required super.chargerName,
    required super.chargerSerialNo,
    required super.chargerBrand,
    required super.standardChargerPower,
    required super.standardChargerPrice,
    required super.standardChargerPowerUnit,
    required super.standardChargerPriceUnit,
    required super.hightspeedStatus,
    required super.hightspeedChargerPower,
    required super.hightspeedChargerPrice,
    required super.hightspeedChargerPowerUnit,
    required super.hightspeedChargerPriceUnit,
    required super.pricePerUnit,
    required super.totalConnector,
    required super.chargerType,
    required super.maxLimit,
    required super.maxLimitUnit,
    required this.connector,
    required this.carSelect,
    required this.paymentType,
    required super.lowPriorityTariff,
  }) : super(
            connector: connector,
            carSelect: carSelect,
            paymentType: paymentType);

  @override
  @JsonKey(name: 'connector')
  final ConnectorInformationModel? connector;
  @override
  @JsonKey(name: 'car_select')
  final List<CarSelectModel>? carSelect;
  @override
  @JsonKey(name: 'payment_type')
  final List<PaymentTypeModel>? paymentType;

  factory ChargerInformationModel.fromJson(Map<String, dynamic> json) =>
      _$ChargerInformationModelFromJson(json);
  Map<String, dynamic> toJson() => _$ChargerInformationModelToJson(this);
}
