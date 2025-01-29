import 'package:json_annotation/json_annotation.dart';

import 'charging_info_data_entity.dart';
import 'charging_info_receipt_entity.dart';

class ChargingInfoEntity {
  ChargingInfoEntity({
    required this.stationName,
    required this.chargerName,
    required this.connectorStatus,
    required this.statusCharger,
    required this.statusPayment,
    required this.statusReceipt,
    required this.statusDebt,
    required this.data,
    required this.receiptData,
    required this.lowPriorityTariff,
  });
  @JsonKey(name: 'station_name')
  final String? stationName;
  @JsonKey(name: 'charger_name')
  final String? chargerName;
  @JsonKey(name: 'connector_status')
  final String? connectorStatus;
  @JsonKey(name: 'status_charger')
  final bool? statusCharger;
  @JsonKey(name: 'status_payment')
  final bool? statusPayment;
  @JsonKey(name: 'status_receipt')
  final bool? statusReceipt;
  @JsonKey(name: 'status_debt')
  final bool? statusDebt;
  @JsonKey(name: 'data')
  final ChargingInfoDataEntity? data;
  @JsonKey(name: 'receipt_data')
  final ChargingInfoReceiptEntity? receiptData;
  @JsonKey(name: 'low_priority_tariff')
  final bool? lowPriorityTariff;
}
