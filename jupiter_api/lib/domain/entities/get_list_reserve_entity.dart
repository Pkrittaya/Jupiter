import 'package:json_annotation/json_annotation.dart';

import 'list_reserve_of_connector_entity.dart';

class GetListReserveEntity {
  GetListReserveEntity({
    required this.stationId,
    required this.chargerId,
    required this.connectorId,
    required this.connectorQrCode,
    required this.slotDate,
    required this.slot,
  });
  @JsonKey(name: 'station_id')
  final String stationId;
  @JsonKey(name: 'charger_id')
  final String chargerId;
  @JsonKey(name: 'connector_id')
  final String connectorId;
  @JsonKey(name: 'connector_qr_code')
  final String connectorQrCode;
  @JsonKey(name: 'slot_date')
  final String slotDate;
  @JsonKey(name: 'slot')
  final List<ListReserveOfConnectorEntity>? slot;
}
