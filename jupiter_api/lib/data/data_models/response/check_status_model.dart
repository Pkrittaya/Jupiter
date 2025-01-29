import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entities/check_status_entity.dart';
import 'charger_realtime_model.dart';
import 'charging_socket/charging_info_model.dart';

part 'check_status_model.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class CheckStatusModel extends CheckStatusEntity {
  CheckStatusModel({
    required super.chargingStatus,
    required this.data,
    required this.informationCharger,
  }) : super(data: data, informationCharger: informationCharger);

  @override
  @JsonKey(name: 'data')
  final ChargingInfoModel? data;
  @override
  @JsonKey(name: 'information_charger')
  final ChargerRealtimeModel? informationCharger;

  factory CheckStatusModel.fromJson(Map<String, dynamic> json) =>
      _$CheckStatusModelFromJson(json);
  Map<String, dynamic> toJson() => _$CheckStatusModelToJson(this);
}
