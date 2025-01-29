// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'charging_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChargingInfoModel _$ChargingInfoModelFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'ChargingInfoModel',
      json,
      ($checkedConvert) {
        final val = ChargingInfoModel(
          stationName: $checkedConvert('station_name', (v) => v as String?),
          chargerName: $checkedConvert('charger_name', (v) => v as String?),
          connectorStatus:
              $checkedConvert('connector_status', (v) => v as String?),
          statusCharger: $checkedConvert('status_charger', (v) => v as bool?),
          statusPayment: $checkedConvert('status_payment', (v) => v as bool?),
          statusReceipt: $checkedConvert('status_receipt', (v) => v as bool?),
          statusDebt: $checkedConvert('status_debt', (v) => v as bool?),
          data: $checkedConvert(
              'data',
              (v) => v == null
                  ? null
                  : ChargingInfoDataModel.fromJson(v as Map<String, dynamic>)),
          receiptData: $checkedConvert(
              'receipt_data',
              (v) => v == null
                  ? null
                  : ChargingInfoReceiptModel.fromJson(
                      v as Map<String, dynamic>)),
          lowPriorityTariff:
              $checkedConvert('low_priority_tariff', (v) => v as bool?),
        );
        return val;
      },
      fieldKeyMap: const {
        'stationName': 'station_name',
        'chargerName': 'charger_name',
        'connectorStatus': 'connector_status',
        'statusCharger': 'status_charger',
        'statusPayment': 'status_payment',
        'statusReceipt': 'status_receipt',
        'statusDebt': 'status_debt',
        'receiptData': 'receipt_data',
        'lowPriorityTariff': 'low_priority_tariff'
      },
    );

Map<String, dynamic> _$ChargingInfoModelToJson(ChargingInfoModel instance) =>
    <String, dynamic>{
      'station_name': instance.stationName,
      'charger_name': instance.chargerName,
      'connector_status': instance.connectorStatus,
      'status_charger': instance.statusCharger,
      'status_payment': instance.statusPayment,
      'status_receipt': instance.statusReceipt,
      'status_debt': instance.statusDebt,
      'data': instance.data?.toJson(),
      'receipt_data': instance.receiptData?.toJson(),
      'low_priority_tariff': instance.lowPriorityTariff,
    };
