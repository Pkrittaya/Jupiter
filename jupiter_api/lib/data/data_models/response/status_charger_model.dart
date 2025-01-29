import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entities/status_charger_entity.dart';
import 'car_select_model.dart';
import 'charger_information_model.dart';
import 'charging_mode_model.dart';
import 'charging_socket/charging_info_model.dart';
import 'facility_model.dart';
import 'optional_detail_model.dart';
import 'payment_type_model.dart';

part 'status_charger_model.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class StatusChargerModel extends StatusChargerEntity {
  StatusChargerModel({
    required this.chargingStatus,
    required this.data,
    required this.informationCharger,
    required this.chargingMode,
    required this.optionalCharging,
    required this.facilityName,
    required this.carSelect,
    required this.paymentType,
  }) : super(
            chargingStatus: chargingStatus,
            data: data,
            informationCharger: informationCharger,
            chargingMode: chargingMode,
            optionalCharging: optionalCharging,
            facilityName: facilityName,
            carSelect: carSelect,
            paymentType: paymentType);

  @override
  @JsonKey(name: 'charging_status')
  final bool? chargingStatus;
  @override
  @JsonKey(name: 'data')
  final ChargingInfoModel? data;
  @override
  @JsonKey(name: 'information_charger')
  final ChargerInformationModel? informationCharger;
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
  final PaymentTypeModel? paymentType;

  factory StatusChargerModel.fromJson(Map<String, dynamic> json) =>
      _$StatusChargerModelFromJson(json);
  Map<String, dynamic> toJson() => _$StatusChargerModelToJson(this);
}
