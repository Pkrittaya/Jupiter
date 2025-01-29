import 'package:json_annotation/json_annotation.dart';

import '../../../../domain/entities/charging_info_entity.dart';
import 'charging_info_data_model.dart';
import 'charging_info_receipt_model.dart';

part 'charging_info_model.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class ChargingInfoModel extends ChargingInfoEntity {
  ChargingInfoModel({
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
  }) : super(
          stationName: stationName,
          chargerName: chargerName,
          connectorStatus: connectorStatus,
          statusCharger: statusCharger,
          statusPayment: statusPayment,
          statusReceipt: statusReceipt,
          statusDebt: statusDebt,
          data: data,
          receiptData: receiptData,
          lowPriorityTariff: lowPriorityTariff,
        );

  @override
  @JsonKey(name: 'station_name')
  final String? stationName;
  @override
  @JsonKey(name: 'charger_name')
  final String? chargerName;
  @override
  @JsonKey(name: 'connector_status')
  final String? connectorStatus;
  @override
  @JsonKey(name: 'status_charger')
  final bool? statusCharger;
  @override
  @JsonKey(name: 'status_payment')
  final bool? statusPayment;
  @override
  @JsonKey(name: 'status_receipt')
  final bool? statusReceipt;
  @override
  @JsonKey(name: 'status_debt')
  final bool? statusDebt;
  @override
  @JsonKey(name: 'data')
  final ChargingInfoDataModel? data;
  @override
  @JsonKey(name: 'receipt_data')
  final ChargingInfoReceiptModel? receiptData;
  @JsonKey(name: 'low_priority_tariff')
  final bool? lowPriorityTariff;

  factory ChargingInfoModel.fromJson(Map<String, dynamic> json) =>
      _$ChargingInfoModelFromJson(json);
  Map<String, dynamic> toJson() => _$ChargingInfoModelToJson(this);
}
