import 'package:json_annotation/json_annotation.dart';

import 'charger_realtime_entity.dart';
import 'charging_info_entity.dart';

class CheckStatusEntity {
  CheckStatusEntity({
    required this.chargingStatus,
    required this.data,
    required this.informationCharger,
  });
  @JsonKey(name: 'charging_status')
  final bool? chargingStatus;
  @JsonKey(name: 'data')
  final ChargingInfoEntity? data;
  @JsonKey(name: 'information_charger')
  final ChargerRealtimeEntity? informationCharger;

  get charging_mode => null;
}
