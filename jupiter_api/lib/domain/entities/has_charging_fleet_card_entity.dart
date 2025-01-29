import 'package:json_annotation/json_annotation.dart';

class HasChargingFleetEntity {
  @JsonKey(name: 'charging_status')
  final bool chargingStatus;
  HasChargingFleetEntity({required this.chargingStatus});
}
