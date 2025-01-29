import 'package:json_annotation/json_annotation.dart';

class RealtimeStatusCheckinEntity {
  RealtimeStatusCheckinEntity({
    required this.chargerName,
    required this.connectorStatus,
  });

  @JsonKey(name: 'charger_name')
  final String? chargerName;
  @JsonKey(name: 'connector_status')
  final String? connectorStatus;
}
