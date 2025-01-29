import 'package:json_annotation/json_annotation.dart';

import '../../../../domain/entities/realtime_status_checkin_entity.dart';

part 'realtime_status_checkin_model.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class RealtimeStatusCheckinModel extends RealtimeStatusCheckinEntity {
  RealtimeStatusCheckinModel({
    required super.chargerName,
    required super.connectorStatus,
  });

  factory RealtimeStatusCheckinModel.fromJson(Map<String, dynamic> json) =>
      _$RealtimeStatusCheckinModelFromJson(json);
  Map<String, dynamic> toJson() => _$RealtimeStatusCheckinModelToJson(this);
}
