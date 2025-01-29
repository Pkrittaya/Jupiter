import 'package:json_annotation/json_annotation.dart';
import 'package:jupiter_api/data/data_models/request/car_select_fleet_form.dart';

part 'add_ev_car_charging_form.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class AddCarChargingForm {
  AddCarChargingForm(
      {required this.fleetNo,
      required this.qrCodeConnector,
      required this.carSelect});
  @JsonKey(name: 'fleet_no')
  final int fleetNo;
  @JsonKey(name: 'qr_code_connector')
  final String qrCodeConnector;
  @JsonKey(name: 'car_select')
  final CarSelectFleetForm carSelect;

  factory AddCarChargingForm.fromJson(Map<String, dynamic> json) =>
      _$AddCarChargingFormFromJson(json);
  Map<String, dynamic> toJson() => _$AddCarChargingFormToJson(this);
}
