// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'charging_info_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChargingInfoDataModel _$ChargingInfoDataModelFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      'ChargingInfoDataModel',
      json,
      ($checkedConvert) {
        final val = ChargingInfoDataModel(
          startTimeCharging:
              $checkedConvert('start_time_charging', (v) => v as String?),
          estimateDistance: $checkedConvert(
              'estimate_distance',
              (v) => v == null
                  ? null
                  : DataValueUnitModel.fromJson(v as Map<String, dynamic>)),
          powerRealtime: $checkedConvert(
              'power_realtime',
              (v) => v == null
                  ? null
                  : DataValueUnitModel.fromJson(v as Map<String, dynamic>)),
          voltage: $checkedConvert(
              'voltage',
              (v) => v == null
                  ? null
                  : DataValueUnitModel.fromJson(v as Map<String, dynamic>)),
          current: $checkedConvert(
              'current',
              (v) => v == null
                  ? null
                  : DataValueUnitModel.fromJson(v as Map<String, dynamic>)),
          power: $checkedConvert(
              'power',
              (v) => v == null
                  ? null
                  : DataValueUnitModel.fromJson(v as Map<String, dynamic>)),
          percent: $checkedConvert(
              'percent',
              (v) => v == null
                  ? null
                  : DataValueUnitModel.fromJson(v as Map<String, dynamic>)),
          totalPrice: $checkedConvert(
              'total_price',
              (v) => v == null
                  ? null
                  : DataValueUnitModel.fromJson(v as Map<String, dynamic>)),
        );
        return val;
      },
      fieldKeyMap: const {
        'startTimeCharging': 'start_time_charging',
        'estimateDistance': 'estimate_distance',
        'powerRealtime': 'power_realtime',
        'totalPrice': 'total_price'
      },
    );

Map<String, dynamic> _$ChargingInfoDataModelToJson(
        ChargingInfoDataModel instance) =>
    <String, dynamic>{
      'start_time_charging': instance.startTimeCharging,
      'estimate_distance': instance.estimateDistance?.toJson(),
      'power_realtime': instance.powerRealtime?.toJson(),
      'voltage': instance.voltage?.toJson(),
      'current': instance.current?.toJson(),
      'power': instance.power?.toJson(),
      'percent': instance.percent?.toJson(),
      'total_price': instance.totalPrice?.toJson(),
    };
